module Api
  module V1
    class ChatbotController < BaseController
      # GET /api/v1/chatbot/messages
      def messages
        user = Current.user || User.first
        return render json: { error: "Kein Benutzer gefunden." }, status: :unauthorized unless user

        messages = user.chat_messages.order(:created_at).last(50)
        
        render json: {
          data: messages.map { |m| message_json(m) }
        }
      end

      # POST /api/v1/chatbot
      def create
        user = Current.user || User.first
        return render json: { error: "Kein Benutzer gefunden." }, status: :unauthorized unless user

        message_text = params[:message].to_s.strip
        return render json: { error: "Nachricht darf nicht leer sein." }, status: :bad_request if message_text.blank?

        Rails.logger.info "[API Chatbot] User #{user.id} sent: '#{message_text[0, 60]}...'"

        # Benutzer-Nachricht speichern
        user_message = user.chat_messages.create!(role: "user", content: message_text)
        
        # KI-Antwort generieren
        ai_response = ChatbotService.new.generate_response(message_text, user)
        bot_message = user.chat_messages.create!(role: "assistant", content: ai_response)

        Rails.logger.info "✅ [API Chatbot] Anfrage verarbeitet"

        render json: {
          success: true,
          user_message: message_json(user_message),
          bot_message: message_json(bot_message)
        }
      rescue => e
        Rails.logger.error "[API Chatbot] ERROR: #{e.message}"
        render json: {
          success: false,
          error: e.message,
          bot_message: {
            id: nil,
            content: "Entschuldigung, ich kann im Moment nicht antworten. Bitte versuchen Sie es später erneut.",
            role: "assistant",
            timestamp: Time.current.iso8601
          }
        }, status: :internal_server_error
      end

      # DELETE /api/v1/chatbot/clear
      def clear
        user = Current.user || User.first
        count = user&.chat_messages&.delete_all || 0
        render json: { success: true, deleted_count: count }
      end

      private

      def message_json(message)
        {
          id: message.id,
          content: message.content,
          role: message.role,
          timestamp: message.created_at.iso8601,
          formatted_time: message.created_at.strftime("%H:%M")
        }
      end
    end
  end
end
