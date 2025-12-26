<template>
  <div class="seminare-view animate-fadeIn">
    <!-- Header with Actions -->
    <div class="view-header">
      <div class="view-header-left">
        <div class="search-input-wrapper">
          <svg class="search-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
            <circle cx="11" cy="11" r="8"/>
            <line x1="21" y1="21" x2="16.65" y2="16.65"/>
          </svg>
          <input 
            type="text" 
            class="form-input search-input" 
            placeholder="Seminare suchen..."
            v-model="searchInput"
            @input="debouncedSearch"
          />
        </div>
      </div>
      <button class="btn btn-primary" @click="showCreateModal = true">
        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
          <line x1="12" y1="5" x2="12" y2="19"/>
          <line x1="5" y1="12" x2="19" y2="12"/>
        </svg>
        Neues Seminar
      </button>
    </div>

    <!-- Loading State -->
    <div v-if="store.loading" class="loading-state">
      <div class="spinner"></div>
      <span>Laden...</span>
    </div>

    <!-- Error State -->
    <div v-else-if="store.error" class="alert alert-error">
      <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
        <circle cx="12" cy="12" r="10"/>
        <line x1="12" y1="8" x2="12" y2="12"/>
        <line x1="12" y1="16" x2="12.01" y2="16"/>
      </svg>
      {{ store.error }}
    </div>

    <!-- Empty State -->
    <div v-else-if="store.seminare.length === 0" class="empty-state">
      <div class="empty-state-icon">
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5">
          <path d="M4 19.5A2.5 2.5 0 0 1 6.5 17H20"/>
          <path d="M6.5 2H20v20H6.5A2.5 2.5 0 0 1 4 19.5v-15A2.5 2.5 0 0 1 6.5 2z"/>
        </svg>
      </div>
      <h3 class="empty-state-title">Keine Seminare gefunden</h3>
      <p class="empty-state-description">
        {{ store.searchQuery ? 'Versuchen Sie eine andere Suchanfrage.' : 'Erstellen Sie das erste Seminar.' }}
      </p>
      <button v-if="!store.searchQuery" class="btn btn-primary" @click="showCreateModal = true">
        Seminar erstellen
      </button>
    </div>

    <!-- Seminare Grid -->
    <div v-else class="seminare-grid">
      <div v-for="seminar in store.seminare" :key="seminar.id" class="card seminar-card">
        <div class="card-body">
          <div class="seminar-header">
            <h3 class="seminar-title">{{ seminar.titel }}</h3>
            <span v-if="seminar.semester" class="badge badge-primary">{{ seminar.semester }}</span>
          </div>
          <div class="seminar-details">
            <p v-if="seminar.ort" class="seminar-detail">
              <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z"/>
                <circle cx="12" cy="10" r="3"/>
              </svg>
              {{ seminar.ort }}
            </p>
            <p v-if="seminar.praesenzdatum" class="seminar-detail">
              <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <rect x="3" y="4" width="18" height="18" rx="2" ry="2"/>
                <line x1="16" y1="2" x2="16" y2="6"/>
                <line x1="8" y1="2" x2="8" y2="6"/>
                <line x1="3" y1="10" x2="21" y2="10"/>
              </svg>
              {{ formatDate(seminar.praesenzdatum) }}
            </p>
            <p v-if="seminar.aufnahmekapazitaet" class="seminar-detail">
              <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/>
                <circle cx="9" cy="7" r="4"/>
                <path d="M23 21v-2a4 4 0 0 0-3-3.87"/>
                <path d="M16 3.13a4 4 0 0 1 0 7.75"/>
              </svg>
              max. {{ seminar.aufnahmekapazitaet }} Teilnehmer
            </p>
          </div>
        </div>
        <div class="card-footer">
          <div class="seminar-meta">
            <span class="text-muted text-small">
              Erstellt: {{ formatDate(seminar.created_at) }}
            </span>
          </div>
          <div class="action-buttons">
            <button class="btn btn-ghost btn-sm" @click="editSeminar(seminar)" title="Bearbeiten">
              <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7"/>
                <path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z"/>
              </svg>
            </button>
            <button class="btn btn-ghost btn-sm text-error" @click="confirmDelete(seminar)" title="Löschen">
              <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <polyline points="3 6 5 6 21 6"/>
                <path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"/>
              </svg>
            </button>
          </div>
        </div>
      </div>
    </div>

    <!-- Create/Edit Modal -->
    <div v-if="showCreateModal || showEditModal" class="modal-overlay" @click.self="closeModals">
      <div class="modal">
        <div class="modal-header">
          <h2 class="modal-title">{{ showEditModal ? 'Seminar bearbeiten' : 'Neues Seminar erstellen' }}</h2>
          <button class="btn btn-ghost" @click="closeModals">
            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <line x1="18" y1="6" x2="6" y2="18"/>
              <line x1="6" y1="6" x2="18" y2="18"/>
            </svg>
          </button>
        </div>
        <form @submit.prevent="submitForm" class="modal-body">
          <div class="form-group">
            <label class="form-label">Titel *</label>
            <input type="text" class="form-input" v-model="formData.titel" required />
          </div>
          <div class="form-row">
            <div class="form-group">
              <label class="form-label">Semester</label>
              <input type="text" class="form-input" v-model="formData.semester" placeholder="z.B. WiSe 24/25" />
            </div>
            <div class="form-group">
              <label class="form-label">Kapazität</label>
              <input type="number" class="form-input" v-model.number="formData.aufnahmekapazitaet" min="1" />
            </div>
          </div>
          <div class="form-row">
            <div class="form-group">
              <label class="form-label">Präsenzdatum</label>
              <input type="date" class="form-input" v-model="formData.praesenzdatum" />
            </div>
            <div class="form-group">
              <label class="form-label">Ort</label>
              <input type="text" class="form-input" v-model="formData.ort" placeholder="z.B. Raum A101" />
            </div>
          </div>
        </form>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" @click="closeModals">Abbrechen</button>
          <button type="submit" class="btn btn-primary" @click="submitForm" :disabled="formLoading">
            {{ formLoading ? 'Speichern...' : (showEditModal ? 'Aktualisieren' : 'Erstellen') }}
          </button>
        </div>
      </div>
    </div>

    <!-- Delete Modal -->
    <div v-if="showDeleteModal" class="modal-overlay" @click.self="showDeleteModal = false">
      <div class="modal modal-sm">
        <div class="modal-header">
          <h2 class="modal-title">Seminar löschen?</h2>
        </div>
        <div class="modal-body">
          <p>Möchten Sie <strong>{{ seminarToDelete?.titel }}</strong> wirklich löschen?</p>
        </div>
        <div class="modal-footer">
          <button class="btn btn-secondary" @click="showDeleteModal = false">Abbrechen</button>
          <button class="btn btn-danger" @click="handleDelete" :disabled="formLoading">
            {{ formLoading ? 'Löschen...' : 'Löschen' }}
          </button>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { useSeminareStore } from '@/stores/seminare'
import type { Seminar } from '@/services/api'

const store = useSeminareStore()

// UI State
const searchInput = ref('')
const showCreateModal = ref(false)
const showEditModal = ref(false)
const showDeleteModal = ref(false)
const formLoading = ref(false)
const seminarToDelete = ref<Seminar | null>(null)

// Form Data
const formData = ref<Partial<Seminar>>({
  titel: '',
  semester: '',
  aufnahmekapazitaet: undefined,
  praesenzdatum: '',
  ort: ''
})

const editingId = ref<string | null>(null)

// Helper
const formatDate = (dateString: string) => {
  return new Date(dateString).toLocaleDateString('de-DE')
}

// Debounced Search
let searchTimeout: ReturnType<typeof setTimeout>
const debouncedSearch = () => {
  clearTimeout(searchTimeout)
  searchTimeout = setTimeout(() => {
    store.setSearch(searchInput.value)
  }, 300)
}

const editSeminar = (seminar: Seminar) => {
  editingId.value = seminar.id
  formData.value = {
    titel: seminar.titel,
    semester: seminar.semester || '',
    aufnahmekapazitaet: seminar.aufnahmekapazitaet,
    praesenzdatum: seminar.praesenzdatum || '',
    ort: seminar.ort || ''
  }
  showEditModal.value = true
}

const confirmDelete = (seminar: Seminar) => {
  seminarToDelete.value = seminar
  showDeleteModal.value = true
}

const closeModals = () => {
  showCreateModal.value = false
  showEditModal.value = false
  editingId.value = null
  resetForm()
}

const resetForm = () => {
  formData.value = { titel: '', semester: '', aufnahmekapazitaet: undefined, praesenzdatum: '', ort: '' }
}

const submitForm = async () => {
  formLoading.value = true
  try {
    if (showEditModal.value && editingId.value) {
      await store.updateSeminar(editingId.value, formData.value)
    } else {
      await store.createSeminar(formData.value)
    }
    closeModals()
  } catch (e) {
    // Error handled in store
  } finally {
    formLoading.value = false
  }
}

const handleDelete = async () => {
  if (!seminarToDelete.value) return
  
  formLoading.value = true
  try {
    await store.deleteSeminar(seminarToDelete.value.id)
    showDeleteModal.value = false
    seminarToDelete.value = null
  } catch (e) {
    // Error handled in store
  } finally {
    formLoading.value = false
  }
}

onMounted(() => {
  store.fetchSeminare()
})
</script>

<style scoped>
.view-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: var(--space-6);
}

.view-header-left {
  display: flex;
  gap: var(--space-3);
}

.search-input {
  width: 280px;
  padding-left: var(--space-10);
}

.loading-state {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: var(--space-3);
  padding: var(--space-12);
  color: var(--color-neutral-500);
}

.seminare-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(340px, 1fr));
  gap: var(--space-5);
}

.seminar-card .card-body {
  padding: var(--space-5);
}

.seminar-header {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  margin-bottom: var(--space-3);
}

.seminar-title {
  font-size: var(--text-lg);
  font-weight: var(--font-semibold);
  color: var(--color-neutral-900);
  margin: 0;
}

.seminar-details {
  display: flex;
  flex-direction: column;
  gap: var(--space-2);
}

.seminar-detail {
  display: flex;
  align-items: center;
  gap: var(--space-2);
  font-size: var(--text-sm);
  color: var(--color-neutral-600);
  margin: 0;
}

.seminar-detail svg {
  color: var(--color-neutral-400);
  flex-shrink: 0;
}

.seminar-description {
  font-size: var(--text-sm);
  color: var(--color-neutral-600);
  line-height: var(--leading-relaxed);
  margin: 0;
}

.form-row {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: var(--space-4);
}

.seminar-card .card-footer {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.action-buttons {
  display: flex;
  gap: var(--space-1);
}

.text-error {
  color: var(--color-error);
}

/* Modal Styles */
.modal-overlay {
  position: fixed;
  inset: 0;
  background: rgba(0, 0, 0, 0.5);
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 1000;
}

.modal {
  background: var(--color-neutral-0);
  border-radius: var(--radius-xl);
  width: 100%;
  max-width: 500px;
  max-height: 90vh;
  overflow: hidden;
}

.modal-sm {
  max-width: 400px;
}

.modal-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: var(--space-5) var(--space-6);
  border-bottom: 1px solid var(--color-neutral-100);
}

.modal-title {
  font-size: var(--text-lg);
  font-weight: var(--font-semibold);
  color: var(--color-neutral-900);
}

.modal-body {
  padding: var(--space-6);
}

.modal-footer {
  display: flex;
  justify-content: flex-end;
  gap: var(--space-3);
  padding: var(--space-4) var(--space-6);
  border-top: 1px solid var(--color-neutral-100);
  background: var(--color-neutral-50);
}

textarea.form-input {
  resize: vertical;
  min-height: 100px;
}

@media (max-width: 768px) {
  .view-header {
    flex-direction: column;
    gap: var(--space-4);
    align-items: stretch;
  }
  
  .search-input {
    width: 100%;
  }
  
  .seminare-grid {
    grid-template-columns: 1fr;
  }
}
</style>
