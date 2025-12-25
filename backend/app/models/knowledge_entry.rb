class KnowledgeEntry < ApplicationRecord
  # Kategorien für die Wissensbasis
  CATEGORIES = %w[faq prozess anleitung info kontakt].freeze

  validates :category, presence: true, inclusion: { in: CATEGORIES }
  validates :title, presence: true
  validates :content, presence: true

  # Callback: Embedding automatisch generieren
  after_save :generate_embedding, if: -> { saved_change_to_content? || saved_change_to_title? || embedding.nil? }

  # Scopes
  scope :by_category, ->(cat) { where(category: cat) }
  scope :with_embedding, -> { where.not(embedding: nil) }

  # Text für Embedding erstellen
  def embedding_text
    "#{title}\n#{content}\n#{keywords}"
  end

  private

  def generate_embedding
    GenerateEmbeddingJob.perform_later(self.class.name, id)
  end
end
