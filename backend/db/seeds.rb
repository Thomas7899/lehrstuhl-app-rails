# This file ensures the existence of records required to run the application in every environment
# It can be executed safely multiple times (idempotent).
# Realistic dataset for a university department management system

puts "🌱 Seeding database with realistic data..."
puts "=" * 60

# Helper methods
def random_date(from, to)
  Time.at(rand(from.to_time.to_f..to.to_time.to_f)).to_date
end

def random_geburtsdatum
  random_date(28.years.ago, 19.years.ago)
end

# ============================================================
# SECTION 1: Users (Admin accounts)
# ============================================================
puts "\n📌 Section 1: Users"

users_data = [
  { email: "admin@uni-musterstadt.de", password: "admin123!" },
  { email: "sekretariat@uni-musterstadt.de", password: "sekretariat123!" },
  { email: "dekanat@uni-musterstadt.de", password: "dekanat123!" }
]

users_data.each do |data|
  User.find_or_create_by!(email_address: data[:email]) do |user|
    user.password = data[:password]
  end
end
puts "-> #{User.count} users in database."

# ============================================================
# SECTION 2: Mitarbeiter (Staff) - 25 members
# ============================================================
puts "\n📌 Section 2: Mitarbeiter (25 staff members)"

mitarbeiter_data = [
  # Professoren (6)
  { vorname: "Hans", nachname: "Müller", email: "hans.mueller@uni-musterstadt.de", titel: "Prof. Dr." },
  { vorname: "Maria", nachname: "Schmidt", email: "maria.schmidt@uni-musterstadt.de", titel: "Prof. Dr." },
  { vorname: "Klaus", nachname: "Weber", email: "klaus.weber@uni-musterstadt.de", titel: "Prof. Dr." },
  { vorname: "Susanne", nachname: "Fischer", email: "susanne.fischer@uni-musterstadt.de", titel: "Prof. Dr." },
  { vorname: "Thomas", nachname: "Wagner", email: "thomas.wagner@uni-musterstadt.de", titel: "Prof. Dr." },
  { vorname: "Andrea", nachname: "Becker", email: "andrea.becker@uni-musterstadt.de", titel: "Prof. Dr." },
  
  # Post-Docs / Habilitanden (4)
  { vorname: "Michael", nachname: "Hoffmann", email: "michael.hoffmann@uni-musterstadt.de", titel: "Dr. habil." },
  { vorname: "Sandra", nachname: "Klein", email: "sandra.klein@uni-musterstadt.de", titel: "Dr." },
  { vorname: "Markus", nachname: "Schröder", email: "markus.schroeder@uni-musterstadt.de", titel: "Dr." },
  { vorname: "Christina", nachname: "Wolf", email: "christina.wolf@uni-musterstadt.de", titel: "Dr." },
  
  # Wissenschaftliche Mitarbeiter (10)
  { vorname: "Daniel", nachname: "Braun", email: "daniel.braun@uni-musterstadt.de", titel: "M.Sc." },
  { vorname: "Julia", nachname: "Zimmermann", email: "julia.zimmermann@uni-musterstadt.de", titel: "M.Sc." },
  { vorname: "Florian", nachname: "Krüger", email: "florian.krueger@uni-musterstadt.de", titel: "M.Sc." },
  { vorname: "Lisa", nachname: "Hartmann", email: "lisa.hartmann@uni-musterstadt.de", titel: "M.Sc." },
  { vorname: "Patrick", nachname: "Lange", email: "patrick.lange@uni-musterstadt.de", titel: "M.Sc." },
  { vorname: "Anna", nachname: "Schulz", email: "anna.schulz@uni-musterstadt.de", titel: "M.Sc." },
  { vorname: "Sebastian", nachname: "Koch", email: "sebastian.koch@uni-musterstadt.de", titel: "M.Sc." },
  { vorname: "Katharina", nachname: "Richter", email: "katharina.richter@uni-musterstadt.de", titel: "M.Sc." },
  { vorname: "Tobias", nachname: "Neumann", email: "tobias.neumann@uni-musterstadt.de", titel: "M.Sc." },
  { vorname: "Nicole", nachname: "Schwarz", email: "nicole.schwarz@uni-musterstadt.de", titel: "M.Sc." },
  
  # Studentische Hilfskräfte (3)
  { vorname: "Kevin", nachname: "Lehmann", email: "kevin.lehmann@uni-musterstadt.de", titel: "" },
  { vorname: "Sarah", nachname: "König", email: "sarah.koenig@uni-musterstadt.de", titel: "" },
  { vorname: "Tim", nachname: "Huber", email: "tim.huber@uni-musterstadt.de", titel: "" },
  
  # Sekretariat/Verwaltung (2)
  { vorname: "Petra", nachname: "Mayer", email: "petra.mayer@uni-musterstadt.de", titel: "" },
  { vorname: "Ingrid", nachname: "Schneider", email: "ingrid.schneider@uni-musterstadt.de", titel: "" }
]

mitarbeiter_data.each do |data|
  Mitarbeiter.find_or_create_by!(email: data[:email]) do |m|
    m.vorname = data[:vorname]
    m.nachname = data[:nachname]
    m.titel = data[:titel]
  end
end
puts "-> #{Mitarbeiter.count} mitarbeiter in database."

# ============================================================
# SECTION 3: Students - 200 students
# ============================================================
puts "\n📌 Section 3: Students (200 students)"

# Named students (keep for consistency)
named_students = [
  { matrikelnummer: "7947810", email: "thomas.osterlehner@stud.uni-musterstadt.de", vorname: "Thomas", nachname: "Osterlehner", geburtsdatum: Date.new(1990, 5, 2) },
  { matrikelnummer: "1234567", email: "sabine.musterfrau@stud.uni-musterstadt.de", vorname: "Sabine", nachname: "Musterfrau", geburtsdatum: Date.new(2000, 9, 14) },
  { matrikelnummer: "1234568", email: "max.mustermann@stud.uni-musterstadt.de", vorname: "Max", nachname: "Mustermann", geburtsdatum: Date.new(1999, 5, 12) },
  { matrikelnummer: "2345678", email: "lena.meier@stud.uni-musterstadt.de", vorname: "Lena", nachname: "Meier", geburtsdatum: Date.new(1998, 12, 5) },
  { matrikelnummer: "3456789", email: "paul.bauer@stud.uni-musterstadt.de", vorname: "Paul", nachname: "Bauer", geburtsdatum: Date.new(1997, 7, 18) },
  { matrikelnummer: "4567890", email: "anna.fischer@stud.uni-musterstadt.de", vorname: "Anna", nachname: "Fischer", geburtsdatum: Date.new(2002, 1, 30) },
  { matrikelnummer: "5678901", email: "benjamin.keller@stud.uni-musterstadt.de", vorname: "Benjamin", nachname: "Keller", geburtsdatum: Date.new(2000, 11, 22) },
  { matrikelnummer: "6789012", email: "sophie.huber@stud.uni-musterstadt.de", vorname: "Sophie", nachname: "Huber", geburtsdatum: Date.new(1999, 4, 17) },
  { matrikelnummer: "7890123", email: "lucas.braun@stud.uni-musterstadt.de", vorname: "Lucas", nachname: "Braun", geburtsdatum: Date.new(2001, 6, 9) },
  { matrikelnummer: "8901234", email: "emma.wagner@stud.uni-musterstadt.de", vorname: "Emma", nachname: "Wagner", geburtsdatum: Date.new(2000, 8, 21) }
]

named_students.each do |data|
  Student.find_or_create_by!(matrikelnummer: data[:matrikelnummer]) do |s|
    s.assign_attributes(data.except(:matrikelnummer))
  end
end

# Generate remaining students
first_names_m = %w[Lukas Leon Finn Jonas Felix Elias Noah Ben Luca Tim Niklas Julian Moritz David Alexander Maximilian Philipp Simon Fabian Jan Erik Lars Tobias Stefan Florian]
first_names_f = %w[Mia Emma Hannah Sophia Marie Lina Lea Amelie Emily Johanna Laura Clara Katharina Lisa Sarah Nina Victoria Charlotte Lara Elena Alina Jana Nele Maja]
last_names = %w[Müller Schmidt Schneider Fischer Weber Meyer Wagner Becker Schulz Hoffmann Schäfer Koch Bauer Richter Klein Wolf Schröder Neumann Schwarz Zimmermann Braun Krüger Hartmann Lange Werner Schmitt Schmitz Krause Meier Lehmann Köhler Walter]

target_students = 200
current_count = Student.count

if current_count < target_students
  (target_students - current_count).times do |i|
    is_female = i.even?
    vorname = is_female ? first_names_f.sample : first_names_m.sample
    nachname = last_names.sample
    
    loop do
      matrikelnummer = (1000000 + rand(8999999)).to_s
      unless Student.exists?(matrikelnummer: matrikelnummer)
        Student.create!(
          matrikelnummer: matrikelnummer,
          email: "#{vorname.downcase}.#{nachname.downcase}#{rand(1000)}@stud.uni-musterstadt.de",
          vorname: vorname,
          nachname: nachname,
          geburtsdatum: random_geburtsdatum
        )
        break
      end
    end
  end
end
puts "-> #{Student.count} students in database."

# ============================================================
# SECTION 4: Abstrakte Seminare - 15 seminar topics
# ============================================================
puts "\n📌 Section 4: Abstrakte Seminare (15 topics)"

# Get mitarbeiter for assignments
profs = Mitarbeiter.where("titel LIKE ?", "Prof.%").to_a
docs = Mitarbeiter.where("titel LIKE ?", "Dr.%").to_a
all_betreuer = (profs + docs).uniq

abstrakte_seminare_data = [
  { thema: "Grundlagen der Künstlichen Intelligenz", beschreibung: "Einführung in Machine Learning, Deep Learning und neuronale Netze. Behandelt werden Supervised und Unsupervised Learning, CNNs, RNNs und Transformers." },
  { thema: "Moderne Web-Technologien", beschreibung: "Aktuelle Frameworks und Architekturen im Web-Development: React, Vue.js, Angular, Node.js, REST APIs und GraphQL." },
  { thema: "Datenbanksysteme für Big Data", beschreibung: "Vergleich und Anwendung von SQL- und NoSQL-Datenbanken. Fokus auf MongoDB, Cassandra, Redis und verteilte Systeme." },
  { thema: "IT-Sicherheit in der Praxis", beschreibung: "Analyse von Sicherheitslücken, Penetration Testing, Kryptographie und Entwicklung von Schutzmaßnahmen." },
  { thema: "Ethik in der Informatik", beschreibung: "Diskussion ethischer Fragestellungen: KI-Bias, Datenschutz, Überwachung, digitale Verantwortung und nachhaltige IT." },
  { thema: "Cloud Computing und DevOps", beschreibung: "AWS, Azure, GCP Grundlagen. Container mit Docker und Kubernetes. CI/CD Pipelines und Infrastructure as Code." },
  { thema: "Software Engineering Best Practices", beschreibung: "Agile Methoden, Clean Code, Design Patterns, Test-Driven Development und Code Reviews." },
  { thema: "Mobile App Development", beschreibung: "Native und Cross-Platform Entwicklung mit Swift, Kotlin, React Native und Flutter." },
  { thema: "Natural Language Processing", beschreibung: "Textverarbeitung, Sentiment Analysis, Named Entity Recognition, Chatbots und Large Language Models." },
  { thema: "Computer Vision", beschreibung: "Bildverarbeitung, Objekterkennung, Segmentierung und Anwendungen in der Praxis." },
  { thema: "Blockchain und Distributed Ledger", beschreibung: "Grundlagen von Blockchain, Smart Contracts, Ethereum, Consensus-Mechanismen und Use Cases." },
  { thema: "Robotik und Autonome Systeme", beschreibung: "Grundlagen der Robotik, Sensorfusion, Pfadplanung und autonomes Fahren." },
  { thema: "Quantencomputing Einführung", beschreibung: "Grundlagen der Quantenmechanik für Informatiker, Qubits, Quantenalgorithmen und aktuelle Hardware." },
  { thema: "Human-Computer Interaction", beschreibung: "UX Design, Usability Testing, Accessibility und Mensch-Maschine-Schnittstellen." },
  { thema: "Data Engineering und Analytics", beschreibung: "ETL-Prozesse, Data Warehousing, Apache Spark, Kafka und Business Intelligence." },
  { thema: "IT-Recht und Datenschutz", beschreibung: "Rechtliche Grundlagen der Informatik: DSGVO, Urheberrecht, Softwarelizenzen, Haftung und Vertragsrecht im IT-Bereich." },
  { thema: "Digitales Recht und Compliance", beschreibung: "EU AI Act, NIS2-Richtlinie, ePrivacy, Cybercrime-Gesetze und regulatorische Anforderungen an IT-Systeme." }
]

abstrakte_seminare_data.each do |data|
  AbstraktesSeminar.find_or_create_by!(thema: data[:thema]) do |as|
    as.beschreibung = data[:beschreibung]
    as.mitarbeiter = all_betreuer.sample if all_betreuer.any?
  end
end
puts "-> #{AbstraktesSeminar.count} abstrakte seminare in database."

# ============================================================
# SECTION 5: Konkrete Seminare - 40 seminar instances
# ============================================================
puts "\n📌 Section 5: Konkrete Seminare (40 instances)"

raeume = ["Raum A101", "Raum A201", "Raum B102", "Raum B203", "Raum C110", "Raum D007", "Hörsaal 1", "Hörsaal 2", "PC-Pool 1", "PC-Pool 2"]
semester_list = ["WiSe 22/23", "SoSe 23", "WiSe 23/24", "SoSe 24", "WiSe 24/25", "SoSe 25"]

AbstraktesSeminar.all.each do |abstrakt|
  rand(2..3).times do |i|
    sem = semester_list.sample
    Seminar.find_or_create_by!(
      abstraktes_seminar: abstrakt,
      semester: sem,
      titel: abstrakt.thema.split.first(3).join(" ")
    ) do |s|
      s.aufnahmekapazitaet = [15, 20, 25, 30].sample
      s.praesenzdatum = random_date(2.years.ago, 6.months.from_now)
      s.ort = raeume.sample
      s.mitarbeiter = abstrakt.mitarbeiter
    end
  end
end
puts "-> #{Seminar.count} seminare in database."

# ============================================================
# SECTION 6: Abstrakte Abschlussarbeiten - 50 thesis topics
# ============================================================
puts "\n📌 Section 6: Abstrakte Abschlussarbeiten (50 topics)"

abstrakte_thesen_data = [
  # KI in der Medizin (8)
  { thema: "KI-gestützte Diagnose von Hautkrebs mittels Deep Learning", forschungsprojekt: "KI in der Medizin", themenskizze: "CNN, Transfer Learning, Dermatologie, Bildklassifikation" },
  { thema: "Predictive Analytics für Krankenhausauslastung", forschungsprojekt: "KI in der Medizin", themenskizze: "Zeitreihenanalyse, LSTM, Ressourcenplanung" },
  { thema: "Federated Learning für medizinische Bilddaten", forschungsprojekt: "KI in der Medizin", themenskizze: "Privacy-Preserving ML, Verteilte Systeme, DICOM" },
  { thema: "NLP für medizinische Dokumentation", forschungsprojekt: "KI in der Medizin", themenskizze: "Named Entity Recognition, Klinische Texte, BERT" },
  { thema: "Reinforcement Learning für personalisierte Therapie", forschungsprojekt: "KI in der Medizin", themenskizze: "RL, Markov Decision Process, Behandlungsoptimierung" },
  { thema: "Explainable AI in der klinischen Entscheidungsunterstützung", forschungsprojekt: "KI in der Medizin", themenskizze: "XAI, LIME, SHAP, Interpretierbarkeit" },
  { thema: "Multimodale Fusion für Diagnosesysteme", forschungsprojekt: "KI in der Medizin", themenskizze: "Bilddaten, Labordaten, Attention Mechanisms" },
  { thema: "Generative AI für synthetische medizinische Daten", forschungsprojekt: "KI in der Medizin", themenskizze: "GANs, Datenschutz, Datenaugmentation" },
  
  # Blockchain (6)
  { thema: "Blockchain-basierte Patientenakte", forschungsprojekt: "Blockchain in Healthcare", themenskizze: "Smart Contracts, GDPR, Zugriffskontrolle" },
  { thema: "Dezentrale Identität für Gesundheitsdaten", forschungsprojekt: "Blockchain in Healthcare", themenskizze: "DID, Verifiable Credentials, Self-Sovereign Identity" },
  { thema: "Supply Chain Tracking für Medikamente", forschungsprojekt: "Blockchain in Healthcare", themenskizze: "Hyperledger, Fälschungssicherheit, IoT" },
  { thema: "Consent Management auf der Blockchain", forschungsprojekt: "Blockchain in Healthcare", themenskizze: "Einwilligungsverwaltung, DSGVO, Audit Trail" },
  { thema: "Tokenisierung von Gesundheitsdaten", forschungsprojekt: "Blockchain in Healthcare", themenskizze: "NFTs, Data Marketplace, Anreizmodelle" },
  { thema: "Cross-Chain Interoperabilität im Gesundheitswesen", forschungsprojekt: "Blockchain in Healthcare", themenskizze: "Polkadot, Cosmos, Standards" },
  
  # Wearables (5)
  { thema: "Smartwatch-basierte Sturzerkennung", forschungsprojekt: "Wearable Health Devices", themenskizze: "Accelerometer, ML, Echtzeitanalyse" },
  { thema: "Kontinuierliches Stress-Monitoring", forschungsprojekt: "Wearable Health Devices", themenskizze: "HRV-Analyse, Photoplethysmographie, Biofeedback" },
  { thema: "Gamification für Gesundheits-Apps", forschungsprojekt: "Wearable Health Devices", themenskizze: "Verhaltensänderung, Motivation, UX" },
  { thema: "Edge Computing für Wearables", forschungsprojekt: "Wearable Health Devices", themenskizze: "On-Device ML, Batterieeffizienz, TinyML" },
  { thema: "Schlafqualitätsanalyse mit Wearables", forschungsprojekt: "Wearable Health Devices", themenskizze: "Polysomnographie, Schlafphasen, ML" },
  
  # Ethik (5)
  { thema: "Bias in medizinischen KI-Systemen", forschungsprojekt: "Ethik der KI", themenskizze: "Fairness, Diskriminierung, Bias Detection" },
  { thema: "Transparenz in algorithmischen Entscheidungen", forschungsprojekt: "Ethik der KI", themenskizze: "Erklärbarkeit, Rechenschaftspflicht, EU AI Act" },
  { thema: "Ethische Frameworks für autonome Systeme", forschungsprojekt: "Ethik der KI", themenskizze: "Trolley-Problem, Maschinenethik, Guidelines" },
  { thema: "Privacy by Design in KI-Anwendungen", forschungsprojekt: "Ethik der KI", themenskizze: "Differential Privacy, Anonymisierung, DSGVO" },
  { thema: "KI und Arbeitsmarkt - Soziale Implikationen", forschungsprojekt: "Ethik der KI", themenskizze: "Automatisierung, Jobverlust, Umschulung" },
  
  # Autonome Systeme (5)
  { thema: "Sensorfusion für autonomes Fahren", forschungsprojekt: "Autonome Systeme", themenskizze: "LiDAR, Kamera, Radar, Kalman-Filter" },
  { thema: "Pfadplanung in dynamischen Umgebungen", forschungsprojekt: "Autonome Systeme", themenskizze: "A*, RRT, Motion Planning" },
  { thema: "V2X Kommunikation für Connected Cars", forschungsprojekt: "Autonome Systeme", themenskizze: "5G, DSRC, Cooperative Driving" },
  { thema: "Simulation für autonome Fahrzeuge", forschungsprojekt: "Autonome Systeme", themenskizze: "CARLA, Synthetic Data, Testing" },
  { thema: "Drohnennavigation in GPS-denied Environments", forschungsprojekt: "Autonome Systeme", themenskizze: "Visual SLAM, IMU, Indoor Navigation" },
  
  # Smart City (5)
  { thema: "Intelligentes Verkehrsmanagement", forschungsprojekt: "Smart City", themenskizze: "Ampelsteuerung, Verkehrsfluss, RL" },
  { thema: "Energieoptimierung in Smart Buildings", forschungsprojekt: "Smart City", themenskizze: "HVAC, Predictive Control, IoT" },
  { thema: "Luftqualitätsmonitoring mit IoT-Sensoren", forschungsprojekt: "Smart City", themenskizze: "Sensornetzwerke, Datenvisualisierung, Alerts" },
  { thema: "Digitaler Zwilling einer Stadt", forschungsprojekt: "Smart City", themenskizze: "3D-Modellierung, Simulation, GIS" },
  { thema: "Smart Waste Management", forschungsprojekt: "Smart City", themenskizze: "Routenoptimierung, Füllstandssensoren, ML" },
  
  # Industrie 4.0 (5)
  { thema: "Predictive Maintenance mit ML", forschungsprojekt: "Industrie 4.0", themenskizze: "Anomalieerkennung, Zeitreihen, Sensordaten" },
  { thema: "Digital Twin für Produktionsanlagen", forschungsprojekt: "Industrie 4.0", themenskizze: "Echtzeit-Synchronisation, Simulation, OPC UA" },
  { thema: "Kollaborative Robotik (Cobots)", forschungsprojekt: "Industrie 4.0", themenskizze: "Mensch-Roboter-Interaktion, Sicherheit, ROS" },
  { thema: "Edge Computing in der Fertigung", forschungsprojekt: "Industrie 4.0", themenskizze: "Latenz, Echtzeitverarbeitung, 5G" },
  { thema: "Computer Vision für Qualitätskontrolle", forschungsprojekt: "Industrie 4.0", themenskizze: "Defekterkennung, CNN, Produktionsintegration" },
  
  # Cybersecurity (6)
  { thema: "Intrusion Detection mit Deep Learning", forschungsprojekt: "Cybersecurity", themenskizze: "Netzwerkverkehr, Autoencoder, Anomalien" },
  { thema: "Zero Trust Architecture Implementation", forschungsprojekt: "Cybersecurity", themenskizze: "Mikrosegmentierung, Identity Management, Policies" },
  { thema: "Phishing-Erkennung mit NLP", forschungsprojekt: "Cybersecurity", themenskizze: "E-Mail-Analyse, URL-Features, Klassifikation" },
  { thema: "Sichere Multi-Party Computation", forschungsprojekt: "Cybersecurity", themenskizze: "Homomorphe Verschlüsselung, Secret Sharing" },
  { thema: "Post-Quantum Kryptographie", forschungsprojekt: "Cybersecurity", themenskizze: "Lattice-based, NIST Standards, Migration" },
  { thema: "Security by Design für IoT", forschungsprojekt: "Cybersecurity", themenskizze: "Firmware, Secure Boot, Update-Mechanismen" },
  
  # Nachhaltige IT (3)
  { thema: "Green Computing in Rechenzentren", forschungsprojekt: "Nachhaltige IT", themenskizze: "Energieeffizienz, Kühlung, Erneuerbare Energien" },
  { thema: "Carbon Footprint von ML-Training", forschungsprojekt: "Nachhaltige IT", themenskizze: "CO2-Bilanz, Efficient Training, Model Compression" },
  { thema: "Sustainable Software Engineering", forschungsprojekt: "Nachhaltige IT", themenskizze: "Code-Effizienz, Ressourcenverbrauch, Best Practices" },
  
  # Digital Twins (2)
  { thema: "Digital Twin für Lieferketten", forschungsprojekt: "Digital Twins", themenskizze: "Supply Chain, Echtzeittracking, Simulation" },
  { thema: "Virtueller Patient für Therapieplanung", forschungsprojekt: "Digital Twins", themenskizze: "Organsimulation, Personalisierte Medizin, FEM" }
]

abstrakte_thesen_data.each_with_index do |data, index|
  AbstrakteAbschlussarbeit.find_or_create_by!(
    thema: data[:thema],
    forschungsprojekt: data[:forschungsprojekt]
  ) do |arbeit|
    betreuer = all_betreuer.sample
    arbeit.betreuer = betreuer ? "#{betreuer.titel} #{betreuer.nachname}".strip : "Prof. Dr. Müller"
    arbeit.semester = semester_list.sample
    arbeit.themenskizze = data[:themenskizze]
    arbeit.projekt_id = index + 1
  end
end
puts "-> #{AbstrakteAbschlussarbeit.count} abstrakte abschlussarbeiten in database."

# ============================================================
# SECTION 7: Konkrete Abschlussarbeiten - 80 active theses
# ============================================================
puts "\n📌 Section 7: Konkrete Abschlussarbeiten (80 theses)"

studienniveaus = ["bachelor", "master"]

students_without_thesis = Student.where.not(id: KonkreteAbschlussarbeit.select(:student_id)).to_a.shuffle
abstrakte_arbeiten = AbstrakteAbschlussarbeit.all.to_a

target_theses = 80
current_theses = KonkreteAbschlussarbeit.count

if current_theses < target_theses && students_without_thesis.any?
  (target_theses - current_theses).times do |i|
    break if students_without_thesis.empty?
    
    student = students_without_thesis.pop
    abstrakt = abstrakte_arbeiten.sample
    next unless abstrakt
    
    anmeldung = random_date(2.years.ago, 1.month.ago)
    studienniveau = studienniveaus.sample
    bearbeitungszeit = studienniveau == "bachelor" ? 3.months : 6.months
    
    KonkreteAbschlussarbeit.find_or_create_by!(
      student: student,
      angepasste_themenskizze: "#{abstrakt.thema} - Individuelle Bearbeitung"
    ) do |arbeit|
      arbeit.betreuer = abstrakt.betreuer
      arbeit.forschungsprojekt = abstrakt.forschungsprojekt
      arbeit.semester = semester_list.sample
      arbeit.matrikelnummer = student.matrikelnummer
      arbeit.gesetzte_schwerpunkte = abstrakt.themenskizze
      arbeit.anmeldung_pruefungsamt = anmeldung
      arbeit.abgabedatum = anmeldung + bearbeitungszeit
      arbeit.studienniveau = studienniveau
      arbeit.projekt_id = abstrakt.projekt_id
    end
  end
end
puts "-> #{KonkreteAbschlussarbeit.count} konkrete abschlussarbeiten in database."

# ============================================================
# SECTION 8: Klausuren - 25 exams
# ============================================================
puts "\n📌 Section 8: Klausuren (25 exams)"

klausuren_data = [
  { titel: "Einführung in die Informatik I", modul: "INF-B-110" },
  { titel: "Einführung in die Informatik II", modul: "INF-B-120" },
  { titel: "Algorithmen und Datenstrukturen", modul: "INF-B-210" },
  { titel: "Theoretische Informatik", modul: "INF-B-310" },
  { titel: "Datenbanksysteme", modul: "INF-B-320" },
  { titel: "Softwaretechnik", modul: "INF-B-330" },
  { titel: "Rechnernetze", modul: "INF-B-410" },
  { titel: "Betriebssysteme", modul: "INF-B-420" },
  { titel: "Programmierung I", modul: "INF-B-130" },
  { titel: "Programmierung II", modul: "INF-B-140" },
  { titel: "Mathematik für Informatiker I", modul: "INF-B-150" },
  { titel: "Mathematik für Informatiker II", modul: "INF-B-160" },
  { titel: "Statistik", modul: "INF-B-250" },
  { titel: "IT-Sicherheit", modul: "INF-B-510" },
  { titel: "Web-Technologien", modul: "INF-B-520" },
  { titel: "Verteilte Systeme", modul: "INF-M-110" },
  { titel: "Machine Learning", modul: "INF-M-210" },
  { titel: "Deep Learning", modul: "INF-M-220" },
  { titel: "Natural Language Processing", modul: "INF-M-230" },
  { titel: "Computer Vision", modul: "INF-M-240" },
  { titel: "Cloud Computing", modul: "INF-M-310" },
  { titel: "Big Data Analytics", modul: "INF-M-320" },
  { titel: "Software Architecture", modul: "INF-M-410" },
  { titel: "Projekt Management", modul: "INF-M-420" },
  { titel: "IT-Recht", modul: "INF-M-510" }
]

klausuren_data.each do |data|
  ["WiSe 23/24", "SoSe 24", "WiSe 24/25"].each do |sem|
    Klausur.find_or_create_by!(titel: data[:titel], semester: sem) do |k|
      k.modul = data[:modul]
    end
  end
end
puts "-> #{Klausur.count} klausuren in database."

# ============================================================
# SECTION 9: Seminarergebnisse - 150 results
# ============================================================
puts "\n📌 Section 9: Seminarergebnisse (150 results)"

noten = [1.0, 1.3, 1.7, 2.0, 2.3, 2.7, 3.0, 3.3, 3.7, 4.0, 5.0]

target_seminar_results = 150
current_seminar_results = Seminarergebnis.count

if current_seminar_results < target_seminar_results
  seminare = Seminar.all.to_a
  studenten = Student.all.to_a
  
  (target_seminar_results - current_seminar_results).times do
    student = studenten.sample
    seminar = seminare.sample
    next unless student && seminar
    next if Seminarergebnis.exists?(student: student, seminar: seminar)
    
    muendlich = noten.sample
    schriftlich = noten.sample
    
    Seminarergebnis.create!(
      student: student,
      seminar: seminar,
      muendlich_note: muendlich,
      schriftlich_note: schriftlich,
      gesamt: ((muendlich + schriftlich) / 2).round(1),
      versuche: rand(1..2)
    )
  end
end
puts "-> #{Seminarergebnis.count} seminarergebnisse in database."

# ============================================================
# SECTION 10: Klausurergebnisse - 500 results
# ============================================================
puts "\n📌 Section 10: Klausurergebnisse (500 results)"

target_klausur_results = 500
current_klausur_results = Klausurergebnis.count

if current_klausur_results < target_klausur_results
  klausuren = Klausur.all.to_a
  studenten = Student.all.to_a
  
  (target_klausur_results - current_klausur_results).times do
    student = studenten.sample
    klausur = klausuren.sample
    next unless student && klausur
    next if Klausurergebnis.exists?(student: student, klausur: klausur)
    
    punkte = rand(20..100)
    note = case punkte
           when 95..100 then 1.0
           when 90..94 then 1.3
           when 85..89 then 1.7
           when 80..84 then 2.0
           when 75..79 then 2.3
           when 70..74 then 2.7
           when 65..69 then 3.0
           when 60..64 then 3.3
           when 55..59 then 3.7
           when 50..54 then 4.0
           else 5.0
           end
    
    Klausurergebnis.create!(
      student: student,
      klausur: klausur,
      punkte: punkte,
      note: note,
      status: note <= 4.0 ? "Bestanden" : "Nicht bestanden",
      pruefungsdatum: random_date(2.years.ago, Date.today),
      versuche: note <= 4.0 ? rand(1..2) : rand(1..3)
    )
  end
end
puts "-> #{Klausurergebnis.count} klausurergebnisse in database."

# ============================================================
# SECTION 11: Knowledge Base for Chatbot
# ============================================================
puts "\n📌 Section 11: Knowledge Base (Chatbot)"

knowledge_seed_file = Rails.root.join('db', 'seeds', 'knowledge_entries.rb')
if File.exist?(knowledge_seed_file)
  load knowledge_seed_file
else
  puts "⚠️  Knowledge entries seed file not found"
end

# ============================================================
# SUMMARY
# ============================================================
puts "\n" + "=" * 60
puts "✅ SEEDING COMPLETED!"
puts "=" * 60
puts "📊 Database Statistics:"
puts "   • Users:                    #{User.count}"
puts "   • Mitarbeiter:              #{Mitarbeiter.count}"
puts "   • Students:                 #{Student.count}"
puts "   • Abstrakte Seminare:       #{AbstraktesSeminar.count}"
puts "   • Konkrete Seminare:        #{Seminar.count}"
puts "   • Abstrakte Arbeiten:       #{AbstrakteAbschlussarbeit.count}"
puts "   • Konkrete Arbeiten:        #{KonkreteAbschlussarbeit.count}"
puts "   • Klausuren:                #{Klausur.count}"
puts "   • Seminarergebnisse:        #{Seminarergebnis.count}"
puts "   • Klausurergebnisse:        #{Klausurergebnis.count}"
puts "   • Knowledge Entries:        #{KnowledgeEntry.count rescue 'N/A'}"
puts "=" * 60
