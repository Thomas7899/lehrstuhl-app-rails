# app/controllers/chat_messages_controller.rb
class ChatMessagesController < ApplicationController
  protect_from_forgery with: :null_session

  before_action :set_student
  before_action :set_chat_message, only: [:show]

  def index
    messages = ChatMessage.conversation_history(@student)
    render json: messages
  end

  def create
    message = ChatMessage.new(chat_message_params)
    message.user = @student
    message.role = "user" # 🔐 explizit & eindeutig

    if message.save
      render json: message, status: :created
    else
      render json: message.errors, status: :unprocessable_content
    end
  end

  def show
    render json: @message
  end

  private

  def set_student
    student_id = params[:user_id] || params[:student_id]
    @student = Student.find(student_id)
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Student not found" }, status: :not_found
  end

  def set_chat_message
    @message = ChatMessage.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Message not found" }, status: :not_found
  end

  def chat_message_params
    if params[:chat_message].present?
      params.require(:chat_message).permit(:content)
    elsif params[:content].present?
      { content: params[:content] }
    else
      render json: {
        error: "Invalid or missing parameters",
        expected_format: {
          chat_message: {
            content: "Your message content"
          }
        }
      }, status: :bad_request and return
    end
  end
end
