require "openai"

Rails.logger.info "[AI] Initialisiere KI-Clients ..."

# 🔹 OpenAI prüfen
if ENV["OPENAI_API_KEY"].present?
  if ENV["OPENAI_API_KEY"].start_with?("sk-")
    Rails.logger.info "[AI] OpenAI-API-Key erkannt ✅"
  else
    Rails.logger.warn "[AI] OpenAI-API-Key scheint ungültig (kein 'sk-...')"
  end
else
  Rails.logger.info "[AI] Kein OpenAI-API-Key vorhanden – wird ignoriert"
end

# 🔹 Gemini prüfen
if ENV["GEMINI_API_KEY"].present?
  Rails.logger.info "[AI] Gemini-API-Key erkannt ✅"
else
  Rails.logger.info "[AI] Kein Gemini-API-Key gesetzt – Chatbot nutzt ggf. OpenAI oder Fallback"
end

# 🔹 Optional: Standardwerte setzen
ENV["DAILY_LIMIT"] ||= "20"
ENV["OPENAI_MAX_TOKENS"] ||= "200"
ENV["OPENAI_CHAT_MODEL"] ||= "gpt-4o-mini"

Rails.logger.info "[AI] Tageslimit: #{ENV["DAILY_LIMIT"]}, Modell: #{ENV["OPENAI_CHAT_MODEL"]}"
