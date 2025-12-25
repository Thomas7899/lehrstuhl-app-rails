import { defineStore } from 'pinia'
import { ref } from 'vue'
import api from '@/services/api'

export interface ChatMessage {
  id: number | null
  content: string
  role: 'user' | 'assistant'
  timestamp: string
  formatted_time: string
}

export const useChatStore = defineStore('chat', () => {
  const messages = ref<ChatMessage[]>([])
  const isLoading = ref(false)
  const error = ref<string | null>(null)

  async function fetchMessages() {
    try {
      isLoading.value = true
      error.value = null
      const response = await api.get('/chatbot/messages')
      messages.value = response.data.data || []
    } catch (e: any) {
      error.value = e.response?.data?.error || 'Fehler beim Laden der Nachrichten'
      console.error('Chat fetch error:', e)
    } finally {
      isLoading.value = false
    }
  }

  async function sendMessage(messageText: string) {
    if (!messageText.trim()) return

    // Optimistisch die Benutzer-Nachricht hinzufügen
    const tempUserMessage: ChatMessage = {
      id: null,
      content: messageText,
      role: 'user',
      timestamp: new Date().toISOString(),
      formatted_time: new Date().toLocaleTimeString('de-DE', { hour: '2-digit', minute: '2-digit' })
    }
    messages.value.push(tempUserMessage)

    try {
      isLoading.value = true
      error.value = null
      
      const response = await api.post('/chatbot', { message: messageText })
      
      if (response.data.success) {
        // Temporäre Nachricht durch echte ersetzen
        const lastIndex = messages.value.length - 1
        if (response.data.user_message) {
          messages.value[lastIndex] = response.data.user_message
        }
        // Bot-Antwort hinzufügen
        if (response.data.bot_message) {
          messages.value.push(response.data.bot_message)
        }
      } else {
        error.value = response.data.error || 'Fehler bei der Verarbeitung'
        // Trotzdem Bot-Nachricht anzeigen (Fehlermeldung)
        if (response.data.bot_message) {
          messages.value.push(response.data.bot_message)
        }
      }
    } catch (e: any) {
      error.value = e.response?.data?.error || 'Netzwerkfehler'
      // Fehler-Nachricht als Bot-Antwort
      messages.value.push({
        id: null,
        content: 'Entschuldigung, es gab einen Fehler bei der Verarbeitung Ihrer Anfrage.',
        role: 'assistant',
        timestamp: new Date().toISOString(),
        formatted_time: new Date().toLocaleTimeString('de-DE', { hour: '2-digit', minute: '2-digit' })
      })
    } finally {
      isLoading.value = false
    }
  }

  async function clearHistory() {
    try {
      await api.delete('/chatbot/clear')
      messages.value = []
      error.value = null
    } catch (e: any) {
      error.value = 'Fehler beim Löschen des Verlaufs'
    }
  }

  return {
    messages,
    isLoading,
    error,
    fetchMessages,
    sendMessage,
    clearHistory
  }
})
