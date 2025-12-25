<script setup lang="ts">
import { ref, onMounted, nextTick, watch } from 'vue'
import { useChatStore } from '@/stores/chat'

const chatStore = useChatStore()
const newMessage = ref('')
const messagesContainer = ref<HTMLElement | null>(null)

onMounted(() => {
  chatStore.fetchMessages()
})

// Auto-scroll when new messages arrive
watch(() => chatStore.messages.length, () => {
  nextTick(() => {
    scrollToBottom()
  })
})

function scrollToBottom() {
  if (messagesContainer.value) {
    messagesContainer.value.scrollTop = messagesContainer.value.scrollHeight
  }
}

async function handleSend() {
  const message = newMessage.value.trim()
  if (!message || chatStore.isLoading) return
  
  newMessage.value = ''
  await chatStore.sendMessage(message)
}

function handleKeydown(e: KeyboardEvent) {
  if (e.key === 'Enter' && !e.shiftKey) {
    e.preventDefault()
    handleSend()
  }
}

function formatMessageContent(content: string): string {
  // Basic markdown-like formatting
  return content
    .replace(/\*\*(.*?)\*\*/g, '<strong>$1</strong>')
    .replace(/\*(.*?)\*/g, '<em>$1</em>')
    .replace(/`(.*?)`/g, '<code>$1</code>')
    .replace(/\n/g, '<br>')
}
</script>

<template>
  <div class="chat-view">
    <div class="page-header">
      <div class="header-content">
        <h1>KI-Assistent</h1>
        <p class="subtitle">Stellen Sie Fragen zu Seminaren, Abschlussarbeiten und mehr</p>
      </div>
      <div class="header-actions">
        <button 
          class="btn btn-secondary"
          @click="chatStore.clearHistory"
          :disabled="chatStore.messages.length === 0"
        >
          <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <polyline points="3 6 5 6 21 6"></polyline>
            <path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"></path>
          </svg>
          Verlauf löschen
        </button>
      </div>
    </div>

    <div class="chat-container">
      <div class="messages-area" ref="messagesContainer">
        <!-- Welcome message when no messages -->
        <div v-if="chatStore.messages.length === 0 && !chatStore.isLoading" class="welcome-message">
          <div class="welcome-icon">
            <svg xmlns="http://www.w3.org/2000/svg" width="48" height="48" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round">
              <path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z"></path>
            </svg>
          </div>
          <h2>Willkommen beim KI-Assistenten</h2>
          <p>Ich kann Ihnen bei Fragen zu folgenden Themen helfen:</p>
          <ul class="topic-list">
            <li>📚 Seminare und Veranstaltungen</li>
            <li>📝 Abschlussarbeiten und Themen</li>
            <li>📋 Klausuren und Prüfungen</li>
            <li>❓ Allgemeine Fragen zum Lehrstuhl</li>
          </ul>
        </div>

        <!-- Messages -->
        <div 
          v-for="message in chatStore.messages" 
          :key="message.id || message.timestamp"
          :class="['message', message.role]"
        >
          <div class="message-avatar">
            <template v-if="message.role === 'user'">
              <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path>
                <circle cx="12" cy="7" r="4"></circle>
              </svg>
            </template>
            <template v-else>
              <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                <path d="M12 8V4H8"></path>
                <rect width="16" height="12" x="4" y="8" rx="2"></rect>
                <path d="M2 14h2"></path>
                <path d="M20 14h2"></path>
                <path d="M15 13v2"></path>
                <path d="M9 13v2"></path>
              </svg>
            </template>
          </div>
          <div class="message-content">
            <div class="message-header">
              <span class="message-sender">{{ message.role === 'user' ? 'Sie' : 'KI-Assistent' }}</span>
              <span class="message-time">{{ message.formatted_time }}</span>
            </div>
            <div class="message-text" v-html="formatMessageContent(message.content)"></div>
          </div>
        </div>

        <!-- Loading indicator -->
        <div v-if="chatStore.isLoading" class="message assistant loading">
          <div class="message-avatar">
            <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
              <path d="M12 8V4H8"></path>
              <rect width="16" height="12" x="4" y="8" rx="2"></rect>
              <path d="M2 14h2"></path>
              <path d="M20 14h2"></path>
              <path d="M15 13v2"></path>
              <path d="M9 13v2"></path>
            </svg>
          </div>
          <div class="message-content">
            <div class="typing-indicator">
              <span></span>
              <span></span>
              <span></span>
            </div>
          </div>
        </div>
      </div>

      <!-- Input area -->
      <div class="input-area">
        <div class="input-wrapper">
          <textarea
            v-model="newMessage"
            @keydown="handleKeydown"
            placeholder="Schreiben Sie Ihre Nachricht..."
            rows="1"
            :disabled="chatStore.isLoading"
          ></textarea>
          <button 
            class="send-button"
            @click="handleSend"
            :disabled="!newMessage.trim() || chatStore.isLoading"
          >
            <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
              <line x1="22" y1="2" x2="11" y2="13"></line>
              <polygon points="22 2 15 22 11 13 2 9 22 2"></polygon>
            </svg>
          </button>
        </div>
        <p class="input-hint">Drücken Sie Enter zum Senden</p>
      </div>
    </div>
  </div>
</template>

<style scoped>
.chat-view {
  height: 100%;
  display: flex;
  flex-direction: column;
}

.page-header {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  margin-bottom: var(--spacing-lg);
  flex-shrink: 0;
}

.header-content h1 {
  font-size: var(--font-size-2xl);
  font-weight: 600;
  color: var(--text-primary);
  margin: 0;
}

.subtitle {
  color: var(--text-secondary);
  margin-top: var(--spacing-xs);
}

.chat-container {
  flex: 1;
  display: flex;
  flex-direction: column;
  background: var(--bg-primary);
  border: 1px solid var(--border-color);
  border-radius: var(--radius-lg);
  overflow: hidden;
  min-height: 0;
}

.messages-area {
  flex: 1;
  overflow-y: auto;
  padding: var(--spacing-lg);
  display: flex;
  flex-direction: column;
  gap: var(--spacing-md);
}

/* Welcome Message */
.welcome-message {
  text-align: center;
  padding: var(--spacing-2xl);
  color: var(--text-secondary);
}

.welcome-icon {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  width: 80px;
  height: 80px;
  background: var(--primary-lighter);
  border-radius: 50%;
  margin-bottom: var(--spacing-lg);
  color: var(--primary);
}

.welcome-message h2 {
  font-size: var(--font-size-xl);
  font-weight: 600;
  color: var(--text-primary);
  margin-bottom: var(--spacing-sm);
}

.welcome-message p {
  margin-bottom: var(--spacing-md);
}

.topic-list {
  list-style: none;
  padding: 0;
  display: inline-flex;
  flex-direction: column;
  gap: var(--spacing-sm);
  text-align: left;
}

.topic-list li {
  padding: var(--spacing-sm) var(--spacing-md);
  background: var(--bg-secondary);
  border-radius: var(--radius-md);
}

/* Messages */
.message {
  display: flex;
  gap: var(--spacing-md);
  max-width: 80%;
}

.message.user {
  align-self: flex-end;
  flex-direction: row-reverse;
}

.message.assistant {
  align-self: flex-start;
}

.message-avatar {
  flex-shrink: 0;
  width: 36px;
  height: 36px;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
}

.message.user .message-avatar {
  background: var(--primary);
  color: white;
}

.message.assistant .message-avatar {
  background: var(--bg-tertiary);
  color: var(--text-secondary);
}

.message-content {
  display: flex;
  flex-direction: column;
  gap: var(--spacing-xs);
}

.message-header {
  display: flex;
  align-items: center;
  gap: var(--spacing-sm);
  font-size: var(--font-size-xs);
}

.message-sender {
  font-weight: 500;
  color: var(--text-primary);
}

.message-time {
  color: var(--text-tertiary);
}

.message-text {
  padding: var(--spacing-md);
  border-radius: var(--radius-lg);
  line-height: 1.5;
}

.message.user .message-text {
  background: var(--primary);
  color: white;
  border-bottom-right-radius: var(--radius-sm);
}

.message.assistant .message-text {
  background: var(--bg-secondary);
  color: var(--text-primary);
  border-bottom-left-radius: var(--radius-sm);
}

.message-text :deep(code) {
  background: rgba(0, 0, 0, 0.1);
  padding: 2px 6px;
  border-radius: var(--radius-sm);
  font-family: var(--font-mono);
  font-size: 0.9em;
}

.message.user .message-text :deep(code) {
  background: rgba(255, 255, 255, 0.2);
}

/* Typing Indicator */
.typing-indicator {
  display: flex;
  gap: 4px;
  padding: var(--spacing-md);
  background: var(--bg-secondary);
  border-radius: var(--radius-lg);
  border-bottom-left-radius: var(--radius-sm);
}

.typing-indicator span {
  width: 8px;
  height: 8px;
  background: var(--text-tertiary);
  border-radius: 50%;
  animation: typing 1.4s infinite;
}

.typing-indicator span:nth-child(2) {
  animation-delay: 0.2s;
}

.typing-indicator span:nth-child(3) {
  animation-delay: 0.4s;
}

@keyframes typing {
  0%, 60%, 100% {
    transform: translateY(0);
    opacity: 0.4;
  }
  30% {
    transform: translateY(-4px);
    opacity: 1;
  }
}

/* Input Area */
.input-area {
  padding: var(--spacing-md) var(--spacing-lg);
  border-top: 1px solid var(--border-color);
  background: var(--bg-secondary);
}

.input-wrapper {
  display: flex;
  gap: var(--spacing-sm);
  align-items: flex-end;
}

.input-wrapper textarea {
  flex: 1;
  padding: var(--spacing-md);
  border: 1px solid var(--border-color);
  border-radius: var(--radius-lg);
  background: var(--bg-primary);
  font-family: inherit;
  font-size: var(--font-size-sm);
  resize: none;
  min-height: 44px;
  max-height: 120px;
  transition: var(--transition-fast);
}

.input-wrapper textarea:focus {
  outline: none;
  border-color: var(--primary);
  box-shadow: 0 0 0 3px var(--primary-lighter);
}

.input-wrapper textarea:disabled {
  background: var(--bg-tertiary);
  cursor: not-allowed;
}

.send-button {
  flex-shrink: 0;
  width: 44px;
  height: 44px;
  border: none;
  border-radius: var(--radius-lg);
  background: var(--primary);
  color: white;
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
  transition: var(--transition-fast);
}

.send-button:hover:not(:disabled) {
  background: var(--primary-dark);
}

.send-button:disabled {
  background: var(--bg-tertiary);
  color: var(--text-tertiary);
  cursor: not-allowed;
}

.input-hint {
  font-size: var(--font-size-xs);
  color: var(--text-tertiary);
  margin-top: var(--spacing-xs);
  text-align: center;
}

/* Responsive */
@media (max-width: 768px) {
  .message {
    max-width: 90%;
  }
  
  .welcome-message {
    padding: var(--spacing-lg);
  }
}
</style>
