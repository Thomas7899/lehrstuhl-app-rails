# app/models/chat_message.rb
class ChatMessage < ApplicationRecord
  belongs_to :user, class_name: "Student", foreign_key: "user_id"

  ROLES = %w[user assistant system].freeze

  validates :content, presence: true, length: { maximum: 5000 }
  validates :role, inclusion: { in: ROLES }

  before_validation :set_default_role, on: :create

  scope :recent, -> { order(created_at: :desc).limit(50) }
  scope :by_user, ->(user) { where(user: user) }
  scope :conversation_history, ->(user) { by_user(user).order(:created_at) }

  def formatted_timestamp
    created_at.strftime("%H:%M")
  end

  def from_user?
    role == "user"
  end

  def from_assistant?
    role == "assistant"
  end

  private

  def set_default_role
    # 🔐 Rolle wird IMMER serverseitig gesetzt
    self.role ||= "user"
  end
end
