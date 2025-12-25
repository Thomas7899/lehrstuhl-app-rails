require "openai"
require "ostruct"

class RagContextService
  VECTOR_DIM = 1536

  def initialize
    @client = OpenAI::Client.new(access_token: ENV["OPENAI_API_KEY"])
  end
  
  def gather_targeted_context(query:, intent:)
    return "Keine Anfrage gestellt." if query.blank?

    embedding = embed_with_openai(query)
    return "Embedding konnte nicht erstellt werden." unless embedding

    results = []

    # Immer zuerst die Wissensbasis durchsuchen (FAQs, Anleitungen, etc.)
    knowledge_results = fetch_similar(KnowledgeEntry, embedding, "knowledge")

    case intent
    when "abschlussarbeit"
      results = fetch_similar(AbstrakteAbschlussarbeit, embedding, "abstrakt") +
                fetch_similar(KonkreteAbschlussarbeit, embedding, "konkret") +
                knowledge_results
    when "seminar"
      results = fetch_similar(Seminar, embedding, "seminar") +
                fetch_similar(AbstraktesSeminar, embedding, "abstraktes_seminar") +
                knowledge_results
    when "klausur"
      results = fetch_similar(Klausur, embedding, "klausur") +
                fetch_similar(Klausurergebnis, embedding, "klausurergebnis") +
                knowledge_results
    when "faq"
      # Bei FAQ-Intent: Wissensbasis priorisieren
      results = knowledge_results +
                fetch_similar(AbstrakteAbschlussarbeit, embedding, "abstrakt") +
                fetch_similar(AbstraktesSeminar, embedding, "abstraktes_seminar")
    when "allgemein"
      # Allgemein: Alle Quellen durchsuchen
      results = knowledge_results +
                fetch_similar(AbstrakteAbschlussarbeit, embedding, "abstrakt") +
                fetch_similar(KonkreteAbschlussarbeit, embedding, "konkret") +
                fetch_similar(AbstraktesSeminar, embedding, "abstraktes_seminar")
    else
      # Unbekannter Intent - alle Quellen
      results = knowledge_results +
                fetch_similar(AbstrakteAbschlussarbeit, embedding, "abstrakt") +
                fetch_similar(KonkreteAbschlussarbeit, embedding, "konkret")
    end

    Rails.logger.info "[RAG] Intent: #{intent}, Ergebnisse: #{results.size}"
    
    sorted_results = results.uniq.sort_by { |r| r["distance"].to_f }.take(12)
    
    context = formatted_context(sorted_results)
    Rails.logger.info "[RAG] Kontext-Länge: #{context.length} Zeichen"
    
    context
  end

  def fetch_similar(model, embedding, label)
    sql = <<~SQL
      SELECT #{model.table_name}.*,
             (embedding <-> '#{embedding_to_pgvector(embedding)}') AS distance,
             '#{label}' AS typ
      FROM #{model.table_name}
      WHERE embedding IS NOT NULL
      ORDER BY distance ASC
      LIMIT 5
    SQL

    results = ActiveRecord::Base.connection.select_all(sql).to_a
    Rails.logger.info "[RAG] #{model.name}: #{results.size} Treffer gefunden"
    results
  rescue => e
    Rails.logger.error "[RAG] Fehler bei #{model.name}: #{e.message}"
    []
  end

  def formatted_context(results)
    return "Keine passenden Datensätze gefunden." if results.empty?

    results.map do |r|
      case r["typ"]
      when "abstrakt"
        <<~TEXT
          [ABSTRAKTE ABSCHLUSSARBEIT]
          Thema: #{r["thema"]}
          Forschungsprojekt: #{r["forschungsprojekt"]}
          Betreuer: #{r["betreuer"]}
          Semester: #{r["semester"]}
          Distanz: #{format("%.3f", r["distance"].to_f)}
        TEXT

      when "konkret"
        <<~TEXT
          [KONKRETE ABSCHLUSSARBEIT]
          Matrikelnummer: #{r["matrikelnummer"]}
          Forschungsprojekt: #{r["forschungsprojekt"]}
          Betreuer: #{r["betreuer"]}
          Themenskizze: #{r["angepasste_themenskizze"]}
          Semester: #{r["semester"]}
          Distanz: #{format("%.3f", r["distance"].to_f)}
        TEXT

      when "seminar"
        <<~TEXT
          [SEMINAR]
          Titel: #{r["titel"]}
          Semester: #{r["semester"]}
          Ort: #{r["ort"]}
          Präsenzdatum: #{r["praesenzdatum"]}
          Distanz: #{format("%.3f", r["distance"].to_f)}
        TEXT

      when "abstraktes_seminar"
        <<~TEXT
          [ABSTRAKTES SEMINAR]
          Thema: #{r["thema"]}
          Beschreibung: #{r["beschreibung"] || 'N/A'}
          Distanz: #{format("%.3f", r["distance"].to_f)}
        TEXT

      when "klausur"
        <<~TEXT
          [KLAUSUR]
          Titel: #{r["titel"]}
          Modul: #{r["modul"]}
          Semester: #{r["semester"]}
          Distanz: #{format("%.3f", r["distance"].to_f)}
        TEXT

      when "klausurergebnis"
        <<~TEXT
          [KLAURERGEBNIS]
          Matrikelnummer: #{r["matrikelnummer"]}
          Note: #{r["note"]}
          Status: #{r["status"]}
          Versuche: #{r["versuche"]}
          Prüfungsdatum: #{r["pruefungsdatum"]}
          Distanz: #{format("%.3f", r["distance"].to_f)}
        TEXT

      when "knowledge"
        category_label = case r["category"]
                         when "faq" then "FAQ"
                         when "prozess" then "PROZESS"
                         when "anleitung" then "ANLEITUNG"
                         when "info" then "INFORMATION"
                         when "kontakt" then "KONTAKT"
                         else r["category"].upcase
                         end
        <<~TEXT
          [#{category_label}]
          Titel: #{r["title"]}
          Inhalt: #{r["content"]}
          Distanz: #{format("%.3f", r["distance"].to_f)}
        TEXT

      else
        "[UNBEKANNTER TYP] #{r.inspect}"
      end
    end.join("\n")
  end

  private

  def embed_with_openai(text)
    response = @client.embeddings(
      parameters: { model: "text-embedding-3-small", input: text }
    )
    response.dig("data", 0, "embedding")
  rescue => e
    Rails.logger.error "[RAG] OpenAI Embedding Error: #{e.message}"
    nil
  end

  def embedding_to_pgvector(arr)
    "[" + arr.map { |v| v.round(6) }.join(",") + "]"
  end
end