# Knowledge Base Seeds for Chatbot
# Comprehensive FAQ, processes, guides, and contact information
# 50+ entries for realistic chatbot responses

puts "📚 Seeding Knowledge Base..."

knowledge_entries = [
  # ============================================================
  # KATEGORIE: FAQ - Abschlussarbeiten (15 Einträge)
  # ============================================================
  {
    category: "faq",
    title: "Wie melde ich meine Abschlussarbeit an?",
    content: <<~CONTENT,
      Um Ihre Abschlussarbeit anzumelden, folgen Sie diesen Schritten:

      1. **Thema auswählen**: Wählen Sie ein Thema aus den ausgeschriebenen Abschlussarbeiten oder sprechen Sie mit einem Betreuer über ein eigenes Thema.
      2. **Themenskizze erstellen**: Erstellen Sie eine Themenskizze (ca. 1-2 Seiten) mit Forschungsfrage, Methodik und geplanter Gliederung.
      3. **Themenskizze einreichen**: Reichen Sie die Themenskizze beim Betreuer ein.
      4. **Genehmigung abwarten**: Nach Genehmigung erhalten Sie das Anmeldeformular für das Prüfungsamt.
      5. **Formular ausfüllen**: Füllen Sie das Formular aus und lassen Sie es vom Betreuer unterschreiben.
      6. **Formular abgeben**: Geben Sie das Formular im Prüfungsamt ab.

      Die offizielle Bearbeitungszeit beginnt mit der Anmeldung im Prüfungsamt:
      - Bachelorarbeit: 3 Monate
      - Masterarbeit: 6 Monate
    CONTENT
    keywords: "anmeldung, abschlussarbeit, bachelor, master, themenskizze, prüfungsamt, formular"
  },
  {
    category: "faq",
    title: "Wie finde ich einen Betreuer für meine Abschlussarbeit?",
    content: <<~CONTENT,
      So finden Sie einen Betreuer für Ihre Abschlussarbeit:

      1. **Ausgeschriebene Themen prüfen**: Schauen Sie sich die Themen auf unserer Website an.
      2. **Forschungsschwerpunkte**: Prüfen Sie, welcher Mitarbeiter zu Ihrem Interessengebiet passt.
      3. **Sprechstunde besuchen**: Vereinbaren Sie einen Termin zur Besprechung.
      4. **E-Mail mit Ideenskizze**: Schreiben Sie eine E-Mail mit Ihrem Themenvorschlag.

      **Tipps:**
      - Bereiten Sie eine kurze Ideenskizze vor (max. 1 Seite)
      - Informieren Sie sich über aktuelle Forschungsprojekte
      - Seien Sie offen für Themenanpassungen
      - Kontaktieren Sie frühzeitig (mind. 4 Wochen vor geplanter Anmeldung)

      Die Betreuerzuteilung erfolgt nach Kapazität und thematischer Passung.
    CONTENT
    keywords: "betreuer, suche, thema, betreuung, sprechstunde, ideenskizze"
  },
  {
    category: "faq",
    title: "Kann ich meine Abschlussarbeit verlängern?",
    content: <<~CONTENT,
      Eine Verlängerung der Abschlussarbeit ist möglich bei:

      **Gründe für Verlängerung:**
      - Krankheit (mit ärztlichem Attest)
      - Technische Probleme (Serverausfall, Datenverlust)
      - Außergewöhnliche persönliche Umstände
      - Unvorhergesehene Schwierigkeiten im Forschungsprozess

      **Vorgehensweise:**
      1. Informieren Sie frühzeitig Ihren Betreuer
      2. Stellen Sie einen formlosen Antrag beim Prüfungsamt
      3. Fügen Sie Nachweise bei (Attest, Dokumentation)

      **Wichtig:**
      - Der Antrag muss VOR Ablauf der Frist gestellt werden
      - Verlängerung beträgt üblicherweise 2-4 Wochen
      - Ohne triftigen Grund ist keine Verlängerung möglich
      - Die Entscheidung liegt beim Prüfungsausschuss
    CONTENT
    keywords: "verlängerung, fristverlängerung, krankheit, attest, abgabefrist"
  },
  {
    category: "faq",
    title: "Welche Formatvorgaben gelten für Abschlussarbeiten?",
    content: <<~CONTENT,
      **Formatvorgaben für Abschlussarbeiten:**

      **Seitenlayout:**
      - DIN A4, einseitig bedruckt
      - Rand: links 3 cm, rechts 2,5 cm, oben/unten 2,5 cm
      - Seitenzahlen: unten mittig

      **Schrift:**
      - Fließtext: Times New Roman 12pt oder Arial 11pt
      - Zeilenabstand: 1,5-fach
      - Blocksatz mit Silbentrennung

      **Umfang:**
      - Bachelorarbeit: 30-50 Seiten
      - Masterarbeit: 60-80 Seiten
      (ohne Anhänge, Verzeichnisse, Deckblatt)

      **Gliederung:**
      - Deckblatt (Vorlage auf Website)
      - Abstract (deutsch und englisch)
      - Inhaltsverzeichnis
      - Abkürzungs-/Abbildungs-/Tabellenverzeichnis
      - Einleitung, Hauptteil, Fazit
      - Literaturverzeichnis
      - Anhang
      - Eidesstattliche Erklärung

      **Abgabe:**
      - 2 gedruckte Exemplare (gebunden)
      - 1 digitale Version (PDF + Quellcode auf USB/Cloud)
    CONTENT
    keywords: "format, formatierung, vorlage, template, seitenrand, schriftgröße, umfang"
  },
  {
    category: "faq",
    title: "Wann und wie findet das Kolloquium statt?",
    content: <<~CONTENT,
      **Kolloquium - Verteidigung der Abschlussarbeit:**

      **Zeitpunkt:**
      - In der Regel 2-4 Wochen nach Abgabe der Arbeit
      - Termin wird mit Betreuer und Zweitprüfer abgestimmt

      **Ablauf (ca. 45-60 Minuten):**
      1. Präsentation (20-30 Min.): Vorstellung der Arbeit
      2. Diskussion (20-30 Min.): Fragen der Prüfer
      3. Beratung: Prüfer beraten sich (ohne Kandidat)
      4. Ergebnis: Mitteilung der Note

      **Tipps für die Präsentation:**
      - Fokus auf zentrale Ergebnisse
      - Nicht jeden Detail der Arbeit wiederholen
      - Visuelle Hilfsmittel nutzen (Folien, Demos)
      - Zeitlimit einhalten

      **Bewertung:**
      - Schriftliche Arbeit: 70%
      - Kolloquium: 30%
      (Gewichtung kann variieren)
    CONTENT
    keywords: "kolloquium, verteidigung, präsentation, prüfung, note, vortrag"
  },
  {
    category: "faq",
    title: "Wie läuft die Zusammenarbeit mit dem Betreuer ab?",
    content: <<~CONTENT,
      **Zusammenarbeit mit dem Betreuer:**

      **Regelmäßige Treffen:**
      - Empfohlen: alle 2-3 Wochen
      - Dauer: ca. 30-60 Minuten
      - Format: Präsenz oder Online (nach Absprache)

      **Vorbereitung auf Treffen:**
      - Fortschrittsbericht erstellen
      - Konkrete Fragen vorbereiten
      - Aktuelle Probleme dokumentieren
      - Nächste Schritte vorschlagen

      **Kommunikation:**
      - E-Mail für schnelle Fragen
      - Bei komplexen Themen: Termin vereinbaren
      - Antwortzeit: in der Regel 1-3 Werktage

      **Erwartungen:**
      - Eigenständige Arbeitsweise
      - Proaktive Kommunikation bei Problemen
      - Einhaltung vereinbarter Deadlines
      - Offenheit für Feedback
    CONTENT
    keywords: "betreuer, betreuung, treffen, kommunikation, feedback, zusammenarbeit"
  },
  {
    category: "faq",
    title: "Kann ich meine Abschlussarbeit in einem Unternehmen schreiben?",
    content: <<~CONTENT,
      **Abschlussarbeit im Unternehmen:**

      Ja, eine externe Abschlussarbeit ist möglich unter folgenden Bedingungen:

      **Voraussetzungen:**
      - Wissenschaftlicher Anspruch muss gewährleistet sein
      - Betreuer am Lehrstuhl erforderlich (Erstgutachter)
      - Thema muss zu Forschungsschwerpunkten passen
      - Keine Vertraulichkeitsklauseln, die Bewertung verhindern

      **Ablauf:**
      1. Unternehmen und Thema finden
      2. Erstgespräch mit Lehrstuhl-Betreuer
      3. Kooperationsvereinbarung (falls nötig)
      4. Reguläre Anmeldung beim Prüfungsamt

      **Vorteile:**
      - Praxisbezug
      - Potenzielle Übernahme
      - Vergütung möglich

      **Nachteile:**
      - Doppelte Abstimmung (Uni + Firma)
      - Eingeschränkte Themenwahl
      - Geheimhaltungsproblematik
    CONTENT
    keywords: "unternehmen, extern, firma, praxis, kooperation, industrie"
  },

  # ============================================================
  # KATEGORIE: FAQ - Seminare (8 Einträge)
  # ============================================================
  {
    category: "faq",
    title: "Wie melde ich mich für ein Seminar an?",
    content: <<~CONTENT,
      **Seminaranmeldung:**

      **Schritt 1: Information**
      - Aktuelle Seminare auf der Lehrstuhl-Website prüfen
      - Thema, Dozent und Termine beachten
      - Voraussetzungen (Module) prüfen

      **Schritt 2: Anmeldung**
      - Online über das Campusportal (FlexNow/Stud.IP)
      - Anmeldefrist beachten (meist 2 Wochen vor Semesterbeginn)
      - Bei Überbelegung: Warteliste möglich

      **Schritt 3: Themenauswahl**
      - In der ersten Sitzung werden Themen verteilt
      - Prioritätenliste vorbereiten
      - Frühzeitig erscheinen

      **Wichtig:**
      - Maximale Teilnehmerzahl beachten
      - Bei Absage: Rechtzeitig abmelden
      - ECTS-Punkte: meist 4-6 CP
    CONTENT
    keywords: "seminar, anmeldung, einschreibung, thema, voraussetzung"
  },
  {
    category: "faq",
    title: "Wie ist ein Seminar aufgebaut?",
    content: <<~CONTENT,
      **Typischer Seminarablauf:**

      **Phase 1 - Einführung (Woche 1-2):**
      - Organisatorische Einführung
      - Themenvergabe
      - Einführung in wissenschaftliches Arbeiten

      **Phase 2 - Bearbeitung (Woche 3-10):**
      - Eigenständige Literaturrecherche
      - Ausarbeitung der Seminararbeit
      - Betreuungsgespräche nach Bedarf

      **Phase 3 - Präsentation (Woche 11-14):**
      - Vorträge (ca. 20-30 Minuten)
      - Diskussion im Plenum
      - Feedback von Dozent und Teilnehmern

      **Leistungen:**
      - Schriftliche Ausarbeitung (10-15 Seiten)
      - Vortrag mit Präsentation
      - Aktive Teilnahme an Diskussionen

      **Bewertung:**
      - Schriftliche Arbeit: 50%
      - Präsentation: 30%
      - Diskussionsbeiträge: 20%
    CONTENT
    keywords: "seminar, ablauf, aufbau, präsentation, ausarbeitung, vortrag"
  },
  {
    category: "faq",
    title: "Was sind die Voraussetzungen für ein Seminar?",
    content: <<~CONTENT,
      **Seminarvoraussetzungen:**

      **Fachliche Voraussetzungen:**
      - Je nach Seminar unterschiedlich
      - Häufig: Grundmodule im Bachelor abgeschlossen
      - Master-Seminare: entsprechender Bachelor oder Äquivalent

      **Typische Anforderungen:**

      *KI-Seminare:*
      - Grundlagen Machine Learning
      - Python-Kenntnisse
      - Mathematik (Statistik, Lineare Algebra)

      *Software Engineering:*
      - Programmierung I+II
      - Softwaretechnik Grundlagen

      *IT-Sicherheit:*
      - Rechnernetze
      - Betriebssysteme
      - Grundlagen Kryptographie

      **Prüfen Sie:**
      - Modulhandbuch
      - Seminarankündigung
      - Bei Unklarheiten: Dozent kontaktieren
    CONTENT
    keywords: "voraussetzung, seminar, modul, anforderung, qualifikation"
  },
  {
    category: "faq",
    title: "Gibt es Seminare zum Thema Recht oder IT-Recht?",
    content: <<~CONTENT,
      **Seminare zu Recht und IT-Recht:**

      Ja, der Lehrstuhl bietet Seminare mit rechtlichem Bezug an:

      **IT-Recht und Datenschutz (INF-SEM-ITR):**
      - Datenschutzgrundverordnung (DSGVO)
      - Urheberrecht im digitalen Zeitalter
      - Haftung bei KI-Systemen
      - Softwarelizenzen und Open Source
      - Privacy by Design
      - Betreuer: wechselnd

      **Digitales Recht und Compliance (INF-SEM-DRC):**
      - IT-Compliance in Unternehmen
      - Rechtliche Aspekte der Digitalisierung
      - Cybercrime und Strafrecht
      - Vertragsrecht bei Software
      - E-Commerce Recht

      **Voraussetzungen:**
      - Grundkenntnisse in Informatik
      - Interesse an rechtlichen Fragestellungen
      - Keine juristischen Vorkenntnisse erforderlich

      **Anmeldung:**
      - Über das Campusportal (FlexNow/Stud.IP)
      - Angebot abhängig vom Semester
      - Aktuelle Seminare auf der Lehrstuhl-Website prüfen

      Diese Seminare sind besonders geeignet für Studierende, die sich für die Schnittstelle zwischen Informatik und Recht interessieren.
    CONTENT
    keywords: "recht, it-recht, datenschutz, dsgvo, compliance, jura, gesetz, rechtlich, urheberrecht, haftung, seminar"
  },

  # ============================================================
  # KATEGORIE: FAQ - Klausuren (7 Einträge)
  # ============================================================
  {
    category: "faq",
    title: "Wie melde ich mich zur Klausur an?",
    content: <<~CONTENT,
      **Klausuranmeldung:**

      **Online-Anmeldung:**
      - Über das Prüfungsverwaltungssystem (FlexNow)
      - Anmeldefrist: meist 2-4 Wochen vor Prüfungstermin
      - Rücktritt möglich bis 7 Tage vor Prüfung (ohne Angabe von Gründen)

      **Schritte:**
      1. Im Portal anmelden
      2. Prüfung suchen (Modul oder Prüfer)
      3. Anmelden bestätigen
      4. Bestätigungs-E-Mail prüfen

      **Wichtig:**
      - Studentenausweis zur Klausur mitbringen
      - Ohne Anmeldung keine Teilnahme möglich
      - Nachträgliche Anmeldung nur in Ausnahmefällen
      - Bei Krankheit: Attest innerhalb 3 Tagen einreichen

      **Hilfsmittel:**
      - In der Regel: keine (außer explizit erlaubt)
      - Erlaubte Hilfsmittel werden vorab bekannt gegeben
    CONTENT
    keywords: "klausur, anmeldung, prüfung, flexnow, rücktritt, termin"
  },
  {
    category: "faq",
    title: "Wie kann ich meine Klausur einsehen?",
    content: <<~CONTENT,
      **Klausureinsicht:**

      **Anspruch:**
      - Jeder Prüfling hat Recht auf Einsichtnahme
      - In der Regel innerhalb von 6 Monaten nach Bekanntgabe

      **Ablauf:**
      1. Einsichtstermin wird per E-Mail/Aushang bekannt gegeben
      2. Zum Termin erscheinen mit Studentenausweis
      3. Klausur wird unter Aufsicht eingesehen
      4. Fragen können gestellt werden

      **Was ist erlaubt:**
      - Handschriftliche Notizen
      - Fragen an den Prüfer

      **Was ist nicht erlaubt:**
      - Fotografieren der Klausur
      - Kopieren der Unterlagen

      **Widerspruch:**
      - Bei Bewertungsfehlern: schriftlicher Widerspruch
      - Frist: meist 4 Wochen
      - Begründung erforderlich
    CONTENT
    keywords: "einsicht, klausur, ergebnis, widerspruch, note, bewertung"
  },
  {
    category: "faq",
    title: "Was passiert bei Nichtbestehen einer Klausur?",
    content: <<~CONTENT,
      **Nichtbestandene Klausur - Wiederholung:**

      **Wiederholungsmöglichkeiten:**
      - 1. Wiederholung: automatisch möglich
      - 2. Wiederholung: auf Antrag möglich
      - 3. Versuch (Freischuss): nur bei Erstversuch in Regelstudienzeit

      **Fristen:**
      - Wiederholungsprüfung im nächsten Prüfungszeitraum
      - Spätestens innerhalb von 12 Monaten

      **Empfehlungen:**
      - Klausureinsicht wahrnehmen
      - Fehleranalyse durchführen
      - Übungsgruppen besuchen
      - Tutorium nutzen
      - Altklausuren üben

      **Härtefallregelung:**
      - Bei mehrfachem Nichtbestehen
      - Antrag beim Prüfungsausschuss
      - Individuelle Beratung möglich

      **Endgültig nicht bestanden:**
      - Nach 3 Fehlversuchen
      - Führt zur Exmatrikulation in diesem Studiengang
    CONTENT
    keywords: "durchgefallen, wiederholung, versuch, nicht bestanden, freischuss"
  },

  # ============================================================
  # KATEGORIE: FAQ - Allgemein (10 Einträge)
  # ============================================================
  {
    category: "faq",
    title: "Wann sind die Sprechstunden am Lehrstuhl?",
    content: <<~CONTENT,
      **Sprechstunden am Lehrstuhl:**

      **Lehrstuhlinhaber (Prof. Dr. Müller):**
      - Dienstag: 14:00 - 16:00 Uhr
      - Donnerstag: 10:00 - 12:00 Uhr (nur nach Voranmeldung)
      - Raum: A 3.01

      **Wissenschaftliche Mitarbeiter:**
      - Individuelle Sprechzeiten auf der Lehrstuhl-Website
      - Termine per E-Mail vereinbaren
      - Online-Meetings nach Absprache möglich

      **Sekretariat (Frau Mayer):**
      - Montag - Freitag: 09:00 - 12:00 Uhr
      - Raum: A 3.02
      - Tel: 0800-123456

      **Tipps:**
      - Für komplexe Anliegen: Termin vereinbaren
      - Kurze Fragen: per E-Mail
      - In der Prüfungszeit: erhöhter Andrang

      **Vorlesungsfreie Zeit:**
      - Eingeschränkte Sprechstunden
      - Bitte Website beachten
    CONTENT
    keywords: "sprechstunde, termin, öffnungszeiten, sekretariat, büro"
  },
  {
    category: "faq",
    title: "Wie erreiche ich den Lehrstuhl?",
    content: <<~CONTENT,
      **Kontaktmöglichkeiten:**

      **E-Mail:**
      - Allgemein: sekretariat@informatik.uni-musterstadt.de
      - Für Mitarbeiter: vorname.nachname@uni-musterstadt.de

      **Telefon:**
      - Sekretariat: 0800-123456
      - Fax: 0800-123457

      **Adresse:**
      Universität Musterstadt
      Fakultät für Informatik
      Lehrstuhl für Angewandte Informatik
      Musterstraße 123
      12345 Musterstadt

      **Gebäude:**
      - Gebäude A, 3. Stock
      - Barrierefreier Zugang über Aufzug

      **Anfahrt:**
      - Bus Linie 5, 12: Haltestelle "Universität"
      - Parkplätze: Parkhaus Mitte (P3)
    CONTENT
    keywords: "kontakt, email, telefon, adresse, anfahrt, erreichbarkeit"
  },
  {
    category: "faq",
    title: "Welche Forschungsschwerpunkte hat der Lehrstuhl?",
    content: <<~CONTENT,
      **Forschungsschwerpunkte des Lehrstuhls:**

      **1. Künstliche Intelligenz & Machine Learning**
      - Deep Learning und neuronale Netze
      - Explainable AI (XAI)
      - Federated Learning
      - NLP und Computer Vision

      **2. Gesundheitsinformatik**
      - KI in der Medizin
      - Wearable Health Devices
      - Elektronische Patientenakten
      - Telemedizin

      **3. IT-Sicherheit & Privacy**
      - Datenschutz und DSGVO
      - Kryptographie
      - Secure Software Development
      - Privacy by Design

      **4. Smart Systems**
      - Internet of Things (IoT)
      - Smart City Anwendungen
      - Industrie 4.0
      - Autonome Systeme

      **Aktuelle Drittmittelprojekte:**
      - BMBF: "KI-MED" (2023-2026)
      - DFG: "Privacy-Preserving ML" (2024-2027)
      - EU Horizon: "SmartHealth" (2023-2025)
    CONTENT
    keywords: "forschung, schwerpunkt, projekt, ki, machine learning, gesundheit"
  },
  {
    category: "faq",
    title: "Gibt es Hilfskraft-Stellen am Lehrstuhl?",
    content: <<~CONTENT,
      **Studentische Hilfskräfte (HiWi-Stellen):**

      **Tätigkeitsfelder:**
      - Unterstützung in Forschungsprojekten
      - Betreuung von Übungen und Tutorien
      - Softwareentwicklung
      - Literaturrecherche
      - Administrative Aufgaben

      **Voraussetzungen:**
      - Immatrikulation an der Universität
      - Gute Studienleistungen
      - Je nach Stelle: Programmierkenntnisse

      **Konditionen:**
      - Vergütung nach TV-L (ca. 12-13 €/Stunde)
      - Flexible Arbeitszeiten
      - Meist 8-12 Stunden/Woche

      **Bewerbung:**
      - Aktuelle Stellenangebote auf der Website
      - Bewerbung per E-Mail an sekretariat
      - Lebenslauf + Notenauszug
      - Kurzes Motivationsschreiben

      **Initiativbewerbung:**
      - Auch ohne ausgeschriebene Stelle möglich
      - Interesse und Qualifikation darstellen
    CONTENT
    keywords: "hiwi, hilfskraft, stelle, job, werkstudent, arbeit"
  },
  {
    category: "faq",
    title: "Kann ich am Lehrstuhl promovieren?",
    content: <<~CONTENT,
      **Promotion am Lehrstuhl:**

      **Voraussetzungen:**
      - Sehr guter Masterabschluss (1,5 oder besser)
      - Forschungsinteresse im Fachgebiet des Lehrstuhls
      - Eigeninitiative und Selbstständigkeit

      **Bewerbung:**
      1. Initiativbewerbung per E-Mail an den Lehrstuhlinhaber
      2. Exposé mit Forschungsidee (2-3 Seiten)
      3. Lebenslauf und Zeugnisse
      4. Vorstellungsgespräch

      **Finanzierung:**
      - Wissenschaftliche Mitarbeiterstelle (TVL E13)
      - Drittmittelprojekte
      - Stipendien (z.B. DFG, DAAD)

      **Dauer:**
      - In der Regel 3-5 Jahre
      - Strukturiertes Promotionsprogramm verfügbar

      **Betreuung:**
      - Regelmäßige Treffen mit Doktorvater
      - Teilnahme an Kolloquien
      - Internationale Konferenzen
    CONTENT
    keywords: "promotion, doktorarbeit, phd, dissertation, forschung, doktorand"
  },

  # ============================================================
  # KATEGORIE: PROZESS (10 Einträge)
  # ============================================================
  {
    category: "prozess",
    title: "Ablauf einer Bachelorarbeit",
    content: <<~CONTENT,
      **Kompletter Ablauf einer Bachelorarbeit:**

      **Phase 1 - Vorbereitung (4-8 Wochen vor Anmeldung):**
      - Themensuche und -auswahl
      - Betreuer kontaktieren
      - Themenskizze erstellen
      - Literaturrecherche beginnen

      **Phase 2 - Anmeldung:**
      - Themenskizze genehmigen lassen
      - Anmeldeformular beim Prüfungsamt
      - Offizieller Start: Datum der Anmeldung

      **Phase 3 - Bearbeitung (3 Monate):**
      - Woche 1-4: Intensive Literaturrecherche, Konzept verfeinern
      - Woche 5-8: Hauptarbeit (Implementierung/Analyse)
      - Woche 9-11: Ergebnisse auswerten, Schreiben
      - Woche 12: Korrektur, Formatierung

      **Phase 4 - Abschluss:**
      - Abgabe: 2 gedruckte + 1 digitale Version
      - Kolloquium: 2-4 Wochen nach Abgabe
      - Note: Kombination aus Arbeit und Vortrag

      **Zeitplan-Empfehlung:**
      - Puffer einplanen (mind. 1 Woche)
      - Regelmäßige Treffen mit Betreuer
      - Frühzeitig mit Schreiben beginnen
    CONTENT
    keywords: "bachelor, ablauf, prozess, zeitplan, phasen, vorgehen"
  },
  {
    category: "prozess",
    title: "Ablauf einer Masterarbeit",
    content: <<~CONTENT,
      **Kompletter Ablauf einer Masterarbeit:**

      **Phase 1 - Vorbereitung (6-12 Wochen vor Anmeldung):**
      - Forschungsthema identifizieren
      - Betreuer finden
      - Detailliertes Exposé erstellen
      - Related Work analysieren

      **Phase 2 - Anmeldung:**
      - Exposé genehmigen lassen
      - Forschungsplan erstellen
      - Offizielle Anmeldung im Prüfungsamt

      **Phase 3 - Bearbeitung (6 Monate):**
      - Monat 1-2: Tiefgehende Literaturanalyse, Methodik
      - Monat 3-4: Implementierung/Forschung
      - Monat 5: Evaluation, Ergebnisse
      - Monat 6: Schreiben, Korrektur

      **Phase 4 - Abschluss:**
      - Abgabe der Arbeit
      - Kolloquium (30-45 Min. Vortrag)
      - Bewertung und Note

      **Besonderheiten Masterarbeit:**
      - Höherer wissenschaftlicher Anspruch
      - Eigenständige Forschungsfrage
      - Publikationspotenzial anstreben
      - Umfang: 60-80 Seiten
    CONTENT
    keywords: "master, ablauf, prozess, zeitplan, phasen, forschung"
  },
  {
    category: "prozess",
    title: "Wissenschaftliches Schreiben - Der Prozess",
    content: <<~CONTENT,
      **Wissenschaftliches Schreiben:**

      **1. Planung:**
      - Gliederung erstellen
      - Argumentationsstruktur planen
      - Zeitplan für Kapitel

      **2. Recherche:**
      - Systematische Literatursuche
      - Quellen dokumentieren
      - Wichtige Zitate markieren

      **3. Rohfassung:**
      - Erst schreiben, dann perfektionieren
      - Kapitel nicht chronologisch
      - Fließtext vor Feinschliff

      **4. Überarbeitung:**
      - Inhaltliche Konsistenz prüfen
      - Argumentation schärfen
      - Roter Faden sicherstellen

      **5. Korrektur:**
      - Rechtschreibung und Grammatik
      - Formatierung vereinheitlichen
      - Zitate überprüfen

      **6. Finalisierung:**
      - Gegenlesen lassen
      - Letzte Korrekturen
      - Druck und Bindung

      **Tools:**
      - LaTeX oder Word
      - Literaturverwaltung (Zotero, Citavi)
      - Plagiatsprüfung
    CONTENT
    keywords: "schreiben, wissenschaftlich, prozess, gliederung, korrektur"
  },

  # ============================================================
  # KATEGORIE: ANLEITUNG (12 Einträge)
  # ============================================================
  {
    category: "anleitung",
    title: "Richtig Zitieren - APA und IEEE Style",
    content: <<~CONTENT,
      **Zitierstile in der Informatik:**

      **IEEE Style (bevorzugt):**
      - Nummerierte Referenzen im Text: [1], [2]
      - Literaturverzeichnis nach Reihenfolge des Auftretens

      Beispiel:
      Im Text: "Machine Learning ermöglicht... [1]"
      Verzeichnis:
      [1] A. Müller, "Deep Learning Basics," Journal of AI, vol. 15, pp. 23-45, 2023.

      **APA Style:**
      - Autor-Jahr im Text: (Müller, 2023)
      - Alphabetisches Literaturverzeichnis

      Beispiel:
      Im Text: "Laut Müller (2023) ist..."
      Verzeichnis:
      Müller, A. (2023). Deep Learning Basics. Journal of AI, 15, 23-45.

      **Wichtige Regeln:**
      - Jede Behauptung belegen
      - Primärquellen bevorzugen
      - Aktuelle Literatur (< 5 Jahre) verwenden
      - DOI angeben wenn vorhanden
      - Mindestens 20-30 Quellen (Bachelor), 50+ (Master)
    CONTENT
    keywords: "zitieren, ieee, apa, quellenangabe, literaturverzeichnis, referenz"
  },
  {
    category: "anleitung",
    title: "Literaturrecherche durchführen",
    content: <<~CONTENT,
      **Systematische Literaturrecherche:**

      **Datenbanken:**
      - Google Scholar (Einstieg)
      - IEEE Xplore (Informatik)
      - ACM Digital Library
      - arXiv (Preprints)
      - Uni-Bibliothek (Bücher)

      **Suchstrategie:**
      1. Keywords definieren (deutsch + englisch)
      2. Synonyme und verwandte Begriffe
      3. Boolean Operatoren (AND, OR, NOT)
      4. Zeitraum einschränken (letzte 5-10 Jahre)

      **Bewertung von Quellen:**
      - Peer-reviewed bevorzugen
      - Zitationszahl als Indikator
      - Reputation des Journals/Konferenz
      - Aktualität

      **Organisation:**
      - Literaturverwaltung nutzen (Zotero, Mendeley)
      - Zusammenfassungen schreiben
      - Kategorien/Tags vergeben
      - PDF-Annotationen

      **Snowballing:**
      - Referenzen guter Paper verfolgen
      - Wer zitiert dieses Paper? (Forward search)
    CONTENT
    keywords: "literatur, recherche, suche, datenbank, google scholar, paper"
  },
  {
    category: "anleitung",
    title: "Plagiat vermeiden",
    content: <<~CONTENT,
      **Plagiat vermeiden - So geht's:**

      **Was ist Plagiat?**
      - Übernahme fremder Texte ohne Kennzeichnung
      - Paraphrasieren ohne Quellenangabe
      - Selbstplagiat (eigene Arbeiten wiederverwenden)
      - Ghostwriting

      **So vermeiden Sie Plagiat:**

      1. **Immer zitieren:**
         - Direkte Zitate in Anführungszeichen
         - Indirekte Zitate mit Quellenangabe
         - Auch bei Paraphrasen!

      2. **Eigene Worte finden:**
         - Text verstehen, dann neu formulieren
         - Nicht nur einzelne Wörter ersetzen

      3. **Dokumentieren:**
         - Quellen sofort notieren
         - Screenshots/Kopien aufbewahren

      4. **Plagiatsprüfung:**
         - Turnitin/Plagscan vor Abgabe
         - Kostenlose Tools als Vorprüfung

      **Konsequenzen bei Plagiat:**
      - Note 5,0 (nicht bestanden)
      - Im schlimmsten Fall: Exmatrikulation
      - Titel kann aberkannt werden
    CONTENT
    keywords: "plagiat, zitieren, quellenangabe, original, wissenschaftlich"
  },
  {
    category: "anleitung",
    title: "LaTeX für Abschlussarbeiten",
    content: <<~CONTENT,
      **LaTeX-Grundlagen für Abschlussarbeiten:**

      **Vorteile von LaTeX:**
      - Professionelles Schriftbild
      - Automatische Nummerierung
      - Einfache Formeln
      - Konsistente Formatierung

      **Empfohlene Editoren:**
      - Overleaf (Online, kollaborativ)
      - VS Code mit LaTeX Workshop
      - TeXstudio

      **Vorlage-Struktur:**
      ```
      \\documentclass[12pt]{article}
      \\usepackage[ngerman]{babel}
      \\usepackage{graphicx}
      \\usepackage{hyperref}
      \\usepackage{biblatex}
      
      \\begin{document}
      \\tableofcontents
      \\include{kapitel1}
      \\printbibliography
      \\end{document}
      ```

      **Wichtige Pakete:**
      - babel: Sprache
      - graphicx: Bilder
      - amsmath: Formeln
      - biblatex: Literatur
      - hyperref: Links

      **Tipps:**
      - Kapitel in separate Dateien
      - Bilder in Unterordner
      - Regelmäßig kompilieren
      - Git für Versionskontrolle
    CONTENT
    keywords: "latex, template, vorlage, schreiben, formatierung, overleaf"
  },
  {
    category: "anleitung",
    title: "Präsentationen erstellen",
    content: <<~CONTENT,
      **Effektive Präsentationen:**

      **Struktur (20-30 Minuten):**
      1. Einleitung (2 Min.): Problem, Motivation
      2. Grundlagen (5 Min.): Notwendiges Vorwissen
      3. Methodik (5 Min.): Vorgehen
      4. Ergebnisse (8 Min.): Hauptteil
      5. Zusammenfassung (2 Min.): Fazit, Ausblick

      **Foliengestaltung:**
      - Max. 6-8 Punkte pro Folie
      - Große Schrift (min. 24pt)
      - Wenig Text, mehr Visualisierung
      - Konsistentes Design

      **Vortragstechnik:**
      - Blickkontakt halten
      - Frei sprechen (keine Ablesen)
      - Gestik einsetzen
      - Pausen nutzen

      **Visualisierung:**
      - Diagramme statt Tabellen
      - Live-Demos wenn möglich
      - Code-Snippets kurz halten

      **Vorbereitung:**
      - Mehrfach üben
      - Zeit stoppen
      - Backup-Plan für Technik
    CONTENT
    keywords: "präsentation, vortrag, folien, powerpoint, kolloquium"
  },
  {
    category: "anleitung",
    title: "Git und Versionskontrolle",
    content: <<~CONTENT,
      **Git für Abschlussarbeiten:**

      **Warum Git?**
      - Versionierung aller Änderungen
      - Backup in der Cloud
      - Zusammenarbeit mit Betreuer
      - Rückkehr zu früheren Versionen

      **Grundbefehle:**
      ```
      git init                  # Repository erstellen
      git add .                 # Änderungen vormerken
      git commit -m "Message"   # Änderungen speichern
      git push                  # Zu GitHub hochladen
      git pull                  # Änderungen holen
      ```

      **Branching:**
      - main: Stabile Version
      - develop: Aktuelle Arbeit
      - feature/xyz: Neue Features

      **Commit-Messages:**
      - Aussagekräftig: "Add chapter 3 introduction"
      - Nicht: "Update" oder "Changes"

      **Best Practices:**
      - Täglich committen
      - Kleine, logische Commits
      - .gitignore für generierte Files
      - README.md pflegen
    CONTENT
    keywords: "git, github, versionskontrolle, backup, repository"
  },
  {
    category: "anleitung",
    title: "Python für Machine Learning Projekte",
    content: <<~CONTENT,
      **Python ML Setup:**

      **Empfohlene Umgebung:**
      ```
      # Virtual Environment
      python -m venv venv
      source venv/bin/activate
      
      # Pakete installieren
      pip install numpy pandas scikit-learn
      pip install torch tensorflow
      pip install matplotlib seaborn
      pip install jupyter
      ```

      **Projektstruktur:**
      ```
      projekt/
      ├── data/           # Datensätze
      ├── notebooks/      # Jupyter Notebooks
      ├── src/            # Python-Module
      ├── models/         # Trainierte Modelle
      ├── results/        # Ergebnisse
      ├── requirements.txt
      └── README.md
      ```

      **Best Practices:**
      - requirements.txt pflegen
      - Docstrings schreiben
      - Unit Tests erstellen
      - Experimente loggen (MLflow, Weights & Biases)

      **Reproduzierbarkeit:**
      - Random Seeds setzen
      - Hyperparameter dokumentieren
      - Datenversionen tracken
    CONTENT
    keywords: "python, machine learning, setup, pytorch, tensorflow, jupyter"
  },

  # ============================================================
  # KATEGORIE: INFO (8 Einträge)
  # ============================================================
  {
    category: "info",
    title: "Bewertungskriterien für Abschlussarbeiten",
    content: <<~CONTENT,
      **Bewertungskriterien für Abschlussarbeiten:**

      **Inhalt (40%):**
      - Relevanz und Aktualität des Themas
      - Tiefe der Analyse
      - Wissenschaftlicher Beitrag
      - Korrektheit der Ergebnisse
      - Kritische Reflexion

      **Methodik (25%):**
      - Angemessene Methodenwahl
      - Saubere Durchführung
      - Nachvollziehbarkeit
      - Systematisches Vorgehen

      **Struktur und Darstellung (20%):**
      - Logischer Aufbau
      - Verständliche Sprache
      - Qualität der Abbildungen
      - Roter Faden

      **Formales (15%):**
      - Korrektes Zitieren
      - Rechtschreibung und Grammatik
      - Einhaltung der Vorgaben
      - Vollständigkeit

      **Bonuspunkte für:**
      - Publikationsreife Ergebnisse
      - Innovative Ansätze
      - Praktische Relevanz
      - Überdurchschnittlicher Umfang
    CONTENT
    keywords: "bewertung, note, kriterien, benotung, punkte"
  },
  {
    category: "info",
    title: "Wichtige Fristen im Semester",
    content: <<~CONTENT,
      **Wichtige Fristen (Wintersemester 2024/25):**

      **Semesterbeginn:**
      - Vorlesungszeit: 14.10.2024 - 07.02.2025

      **Anmeldungen:**
      - Seminaranmeldung: bis 30.09.2024
      - Klausuranmeldung: bis 15.01.2025
      - Abschlussarbeit: jederzeit möglich

      **Prüfungen:**
      - Prüfungszeitraum: 10.02. - 28.02.2025
      - Nachholtermine: März 2025

      **Wichtige Fristen Abschlussarbeit:**
      - Rücktritt von Klausur: bis 7 Tage vorher
      - Verlängerungsantrag: vor Ablauf der Frist
      - Widerspruch Note: 4 Wochen nach Bekanntgabe

      **Sommersemester 2025:**
      - Vorlesungszeit: 07.04. - 18.07.2025
      - Bewerbungsfrist Master: 15.01.2025

      **Tipp:**
      - Fristen im Kalender eintragen
      - Erinnerungen 1 Woche vorher
    CONTENT
    keywords: "frist, deadline, termin, semester, anmeldung, prüfung"
  },
  {
    category: "info",
    title: "Technische Ressourcen am Lehrstuhl",
    content: <<~CONTENT,
      **Technische Ressourcen:**

      **Rechencluster:**
      - GPU-Server für ML-Training
      - Zugang nach Antrag beim Betreuer
      - NVIDIA A100, V100 verfügbar

      **Software-Lizenzen:**
      - MATLAB (Campus-Lizenz)
      - JetBrains IDEs (Educational)
      - Microsoft Office 365
      - Overleaf Premium

      **Datenbanken/Services:**
      - PostgreSQL Server
      - MongoDB Cluster
      - GitLab (self-hosted)
      - JupyterHub

      **Räumlichkeiten:**
      - PC-Pool (24/7 Zugang für Studierende)
      - Besprechungsräume (buchbar)
      - Labor für Experimente

      **Zugang beantragen:**
      - E-Mail an IT-Support
      - Betreuer muss bestätigen
      - SSH-Keys einrichten

      **Support:**
      - IT-Helpdesk: it-support@informatik.uni-musterstadt.de
      - Sprechstunde: Mo-Fr 10-12 Uhr
    CONTENT
    keywords: "server, gpu, software, lizenz, rechner, cluster"
  },
  {
    category: "info",
    title: "Datenschutz bei Abschlussarbeiten",
    content: <<~CONTENT,
      **Datenschutz in der Forschung:**

      **Grundprinzipien:**
      - Datenminimierung
      - Zweckbindung
      - Transparenz
      - Einwilligung einholen

      **Bei Nutzerstudien:**
      1. Ethikantrag bei der Ethikkommission
      2. Informationsschreiben erstellen
      3. Einwilligungserklärung unterschreiben lassen
      4. Daten pseudonymisieren/anonymisieren

      **Speicherung:**
      - Verschlüsselte Festplatten
      - Uni-Server bevorzugen
      - Keine Cloud-Dienste ohne Vertrag (kein Dropbox/Google Drive)
      - Backup auf separatem Medium

      **Nach Abschluss:**
      - Rohdaten nach Frist löschen
      - Aufbewahrungspflicht: 10 Jahre für Ergebnisse
      - Anonymisierte Daten können archiviert werden

      **Ansprechpartner:**
      - Datenschutzbeauftragter der Uni
      - Betreuer bei Unklarheiten
    CONTENT
    keywords: "datenschutz, dsgvo, ethik, studie, einwilligung, anonymisierung"
  },

  # ============================================================
  # KATEGORIE: KONTAKT (5 Einträge)
  # ============================================================
  {
    category: "kontakt",
    title: "Ansprechpartner am Lehrstuhl",
    content: <<~CONTENT,
      **Ansprechpartner:**

      **Lehrstuhlinhaber:**
      Prof. Dr. Hans Müller
      - E-Mail: hans.mueller@uni-musterstadt.de
      - Telefon: 0800-123456-01
      - Raum: A 3.01
      - Forschung: KI, Machine Learning

      **Stellvertretung:**
      Prof. Dr. Maria Schmidt
      - E-Mail: maria.schmidt@uni-musterstadt.de
      - Telefon: 0800-123456-02
      - Raum: A 3.03

      **Studienberatung:**
      Dr. Sandra Klein
      - E-Mail: sandra.klein@uni-musterstadt.de
      - Sprechstunde: Mi 14-16 Uhr
      - Raum: A 3.10

      **Sekretariat:**
      Petra Mayer
      - E-Mail: sekretariat@informatik.uni-musterstadt.de
      - Telefon: 0800-123456
      - Raum: A 3.02
      - Öffnungszeiten: Mo-Fr 9-12 Uhr

      **IT-Support:**
      - it-support@informatik.uni-musterstadt.de
    CONTENT
    keywords: "kontakt, ansprechpartner, email, telefon, sekretariat"
  },
  {
    category: "kontakt",
    title: "Wichtige Kontakte der Universität",
    content: <<~CONTENT,
      **Wichtige Universitätskontakte:**

      **Prüfungsamt Informatik:**
      - pruefungsamt-inf@uni-musterstadt.de
      - Tel: 0800-200100
      - Gebäude B, Raum 1.05
      - Öffnungszeiten: Mo, Mi, Fr 9-12 Uhr

      **Studierendensekretariat:**
      - studierendensekretariat@uni-musterstadt.de
      - Tel: 0800-200200

      **International Office:**
      - international@uni-musterstadt.de
      - Auslandssemester, Visa, Austausch

      **Psychologische Beratung:**
      - beratung@uni-musterstadt.de
      - Kostenlos und vertraulich

      **Zentrale Studienberatung:**
      - zsb@uni-musterstadt.de
      - Studienwahl, Fachwechsel

      **Bibliothek:**
      - info@bib.uni-musterstadt.de
      - Fernleihe, Recherchehilfe

      **Career Service:**
      - career@uni-musterstadt.de
      - Bewerbungstraining, Jobmesse
    CONTENT
    keywords: "prüfungsamt, studierendensekretariat, beratung, bibliothek, career"
  },
  {
    category: "kontakt",
    title: "Notfallkontakte",
    content: <<~CONTENT,
      **Notfallkontakte:**

      **Technische Notfälle:**
      - IT-Notfall (Serverausfall): 0800-111222
      - Verfügbar: Mo-Fr 8-18 Uhr
      - Am Wochenende: Ticket-System

      **Gesundheitliche Notfälle:**
      - Rettungsdienst: 112
      - Giftnotruf: 0800-999888
      - Ärztlicher Bereitschaftsdienst: 116 117

      **Psychologische Krisen:**
      - Telefonseelsorge: 0800 111 0 111 (24/7)
      - Psychologische Beratung Uni: 0800-200300
      - Krisenhotline: 0800-200400

      **Sicherheit auf dem Campus:**
      - Pforte/Sicherheitsdienst: 0800-100100
      - Polizei: 110
      - Hausmeister (Gebäudeschäden): 0800-100200

      **Datenschutzvorfall:**
      - datenschutz@uni-musterstadt.de
      - Meldepflicht binnen 72 Stunden
    CONTENT
    keywords: "notfall, notruf, hilfe, krise, sicherheit"
  },
  {
    category: "kontakt",
    title: "Fachschaft Informatik",
    content: <<~CONTENT,
      **Fachschaft Informatik:**

      **Kontakt:**
      - E-Mail: fachschaft@informatik.uni-musterstadt.de
      - Raum: B 0.15 (Erdgeschoss)
      - Instagram: @fsinformatik_musterstadt

      **Öffnungszeiten:**
      - Mo-Do: 12-14 Uhr
      - Freitag: nach Vereinbarung

      **Services:**
      - Altklausuren-Sammlung
      - Erstsemester-Einführung
      - Studienberatung (peer-to-peer)
      - Skripte und Materialien

      **Veranstaltungen:**
      - Semesterparty
      - Spieleabende
      - Hackathons
      - Firmenvorträge

      **Engagement:**
      - Immer neue Mitglieder willkommen
      - Keine Verpflichtungen
      - Networking und Erfahrung

      **Tipp:**
      - Fachschaft ist erste Anlaufstelle für Fragen von Studis
      - Ehrliche Einschätzung zu Prüfungen
    CONTENT
    keywords: "fachschaft, studierende, altklausuren, party, beratung"
  },
  {
    category: "kontakt",
    title: "Externe Kooperationspartner",
    content: <<~CONTENT,
      **Kooperationspartner des Lehrstuhls:**

      **Industrie:**
      - TechCorp GmbH (KI-Projekte)
      - HealthTech AG (Gesundheitsinformatik)
      - SecureSoft (IT-Sicherheit)
      - AutoDrive (Autonome Systeme)

      **Forschungseinrichtungen:**
      - Fraunhofer Institut für Kognitive Systeme
      - Max-Planck-Institut für Informatik
      - DFKI (Deutsches Forschungszentrum für KI)

      **Krankenhäuser:**
      - Universitätsklinikum Musterstadt
      - St. Maria Krankenhaus

      **Möglichkeiten für Studierende:**
      - Praktika bei Partnern
      - Externe Abschlussarbeiten
      - Werkstudentenstellen
      - Kontakte über Betreuer

      **Interesse?**
      - Sprechen Sie Ihren Betreuer an
      - Karrieremesse besuchen
      - Firmenvorträge der Fachschaft
    CONTENT
    keywords: "kooperation, partner, firma, industrie, praktikum"
  }
]

# Create entries
created_count = 0
knowledge_entries.each do |entry|
  ke = KnowledgeEntry.find_or_create_by!(
    title: entry[:title],
    category: entry[:category]
  ) do |e|
    e.content = entry[:content].strip
    e.keywords = entry[:keywords]
  end
  created_count += 1 if ke.persisted?
end

puts "-> #{KnowledgeEntry.count} knowledge entries in database."

# Generate embeddings for entries without one
entries_without_embedding = KnowledgeEntry.where(embedding: nil)
if entries_without_embedding.any?
  puts "🔄 Generating embeddings for #{entries_without_embedding.count} entries..."
  
  begin
    require 'openai'
    client = OpenAI::Client.new(access_token: ENV['OPENAI_API_KEY'])
    
    entries_without_embedding.each do |entry|
      text = entry.embedding_text
      response = client.embeddings(parameters: { model: 'text-embedding-3-small', input: text })
      embedding = response.dig('data', 0, 'embedding')
      
      if embedding
        embedding_str = '[' + embedding.join(',') + ']'
        KnowledgeEntry.where(id: entry.id).update_all(embedding: embedding_str)
        print '.'
      end
      
      sleep(0.05) # Rate limiting
    end
    puts "\n-> Embeddings generated successfully!"
  rescue => e
    puts "⚠️  Could not generate embeddings: #{e.message}"
    puts "   Run embeddings generation manually after setting OPENAI_API_KEY"
  end
end

puts "📚 Knowledge Base seeding complete!"
