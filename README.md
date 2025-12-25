# Lehrstuhl-App

Ein vollständiges Universitäts-Lehrstuhl-Verwaltungssystem mit Rails Backend und Vue.js Frontend.

## 📁 Projektstruktur

```
├── backend/          # Rails 8 API Backend
│   ├── app/          # Controllers, Models, Services
│   ├── db/           # Migrations, Seeds
│   └── config/       # Rails Konfiguration
│
├── frontend/         # Vue 3 Frontend
│   ├── src/          # Vue Components, Views, Stores
│   └── public/       # Statische Assets
│
└── README.md
```

## 🚀 Features

### Backend (Rails 8)
- **RESTful API** für alle Entitäten
- **OpenAI-Chatbot** mit RAG (Retrieval Augmented Generation)
- **pgvector** für semantische Suche
- **JWT-basierte Authentifizierung**

### Frontend (Vue 3)
- **Vue 3** mit Composition API
- **Pinia** State Management
- **Vue Router** für Navigation
- **Axios** für API-Kommunikation
- **Responsive Design**

## 🛠️ Installation

### Backend
```bash
cd backend
bundle install
rails db:create db:migrate db:seed
rails server -p 3000
```

### Frontend
```bash
cd frontend
npm install
npm run dev
```

## 📊 Datenmodelle

- **Students** - Studentenverwaltung
- **Mitarbeiter** - Mitarbeiterverwaltung
- **Seminare** - Seminar- und Kursverwaltung
- **Abschlussarbeiten** - Bachelor- und Masterarbeiten
- **Klausuren** - Prüfungsverwaltung
- **KnowledgeEntry** - Wissensbasis für Chatbot

## 🤖 Chatbot

Der integrierte KI-Chatbot nutzt:
- OpenAI GPT-4o-mini für Antwortgenerierung
- text-embedding-3-small für Embeddings
- pgvector für Vektorsuche
- RAG für kontextbasierte Antworten

## 📝 Lizenz

MIT
