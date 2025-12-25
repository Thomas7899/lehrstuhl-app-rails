class GenerateEmbeddingJob < ApplicationJob
  queue_as :default

  def perform(model_name, record_id)
    record = model_name.constantize.find_by(id: record_id)
    return unless record

    # Text für Embedding erstellen
    text = if record.respond_to?(:embedding_text)
             record.embedding_text
           else
             record.attributes.values.compact.join(" ")
           end

    return if text.blank?

    # OpenAI Embedding generieren
    client = OpenAI::Client.new(access_token: ENV["OPENAI_API_KEY"])
    response = client.embeddings(
      parameters: { model: "text-embedding-3-small", input: text }
    )

    embedding = response.dig("data", 0, "embedding")
    return unless embedding

    # Embedding speichern (ohne Callbacks auszulösen)
    record.update_column(:embedding, embedding)
    Rails.logger.info "[Embedding] Generated for #{model_name}##{record_id}"
  rescue => e
    Rails.logger.error "[Embedding] Error for #{model_name}##{record_id}: #{e.message}"
  end
end
