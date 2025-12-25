<template>
  <div class="theses-view animate-fadeIn">
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
            placeholder="Abschlussarbeiten suchen..."
            v-model="searchInput"
            @input="debouncedSearch"
          />
        </div>
        <select class="form-input filter-select" v-model="statusFilter" @change="handleFilter">
          <option value="">Alle Status</option>
          <option value="pending">Ausstehend</option>
          <option value="in_progress">In Bearbeitung</option>
          <option value="completed">Abgeschlossen</option>
          <option value="cancelled">Abgebrochen</option>
        </select>
      </div>
      <button class="btn btn-primary" @click="showCreateModal = true">
        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
          <line x1="12" y1="5" x2="12" y2="19"/>
          <line x1="5" y1="12" x2="19" y2="12"/>
        </svg>
        Neue Arbeit
      </button>
    </div>

    <!-- Stats Cards -->
    <div class="stats-row">
      <div class="mini-stat">
        <span class="mini-stat-value">{{ store.totalTheses }}</span>
        <span class="mini-stat-label">Gesamt</span>
      </div>
      <div class="mini-stat">
        <span class="mini-stat-value text-warning">{{ store.pendingTheses.length }}</span>
        <span class="mini-stat-label">Ausstehend</span>
      </div>
      <div class="mini-stat">
        <span class="mini-stat-value text-primary">{{ store.inProgressTheses.length }}</span>
        <span class="mini-stat-label">In Bearbeitung</span>
      </div>
      <div class="mini-stat">
        <span class="mini-stat-value text-success">{{ store.completedTheses.length }}</span>
        <span class="mini-stat-label">Abgeschlossen</span>
      </div>
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
    <div v-else-if="store.theses.length === 0" class="empty-state">
      <div class="empty-state-icon">
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5">
          <path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"/>
          <polyline points="14 2 14 8 20 8"/>
        </svg>
      </div>
      <h3 class="empty-state-title">Keine Abschlussarbeiten gefunden</h3>
      <p class="empty-state-description">
        {{ store.searchQuery || store.statusFilter ? 'Versuchen Sie andere Filterkriterien.' : 'Erstellen Sie die erste Abschlussarbeit.' }}
      </p>
      <button v-if="!store.searchQuery && !store.statusFilter" class="btn btn-primary" @click="showCreateModal = true">
        Abschlussarbeit erstellen
      </button>
    </div>

    <!-- Theses List -->
    <div v-else class="theses-list">
      <div v-for="thesis in store.theses" :key="thesis.id" class="card thesis-card">
        <div class="thesis-content">
          <div class="thesis-header">
            <h3 class="thesis-title">{{ thesis.titel }}</h3>
            <span :class="['badge', statusBadgeClass(thesis.status)]">
              {{ statusLabel(thesis.status) }}
            </span>
          </div>
          <p class="thesis-description">{{ thesis.beschreibung || 'Keine Beschreibung vorhanden.' }}</p>
          <div class="thesis-meta">
            <span v-if="thesis.matrikelnummer" class="meta-item">
              <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"/>
                <circle cx="12" cy="7" r="4"/>
              </svg>
              {{ thesis.matrikelnummer }}
            </span>
            <span v-if="thesis.abgabedatum" class="meta-item">
              <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <rect x="3" y="4" width="18" height="18" rx="2" ry="2"/>
                <line x1="16" y1="2" x2="16" y2="6"/>
                <line x1="8" y1="2" x2="8" y2="6"/>
                <line x1="3" y1="10" x2="21" y2="10"/>
              </svg>
              Abgabe: {{ formatDate(thesis.abgabedatum) }}
            </span>
          </div>
        </div>
        <div class="thesis-actions">
          <button class="btn btn-ghost btn-sm" @click="editThesis(thesis)" title="Bearbeiten">
            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7"/>
              <path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z"/>
            </svg>
          </button>
          <button class="btn btn-ghost btn-sm text-error" @click="confirmDelete(thesis)" title="Löschen">
            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <polyline points="3 6 5 6 21 6"/>
              <path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"/>
            </svg>
          </button>
        </div>
      </div>
    </div>

    <!-- Create/Edit Modal -->
    <div v-if="showCreateModal || showEditModal" class="modal-overlay" @click.self="closeModals">
      <div class="modal">
        <div class="modal-header">
          <h2 class="modal-title">{{ showEditModal ? 'Abschlussarbeit bearbeiten' : 'Neue Abschlussarbeit' }}</h2>
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
              <label class="form-label">Status</label>
              <select class="form-input" v-model="formData.status">
                <option value="pending">Ausstehend</option>
                <option value="in_progress">In Bearbeitung</option>
                <option value="completed">Abgeschlossen</option>
                <option value="cancelled">Abgebrochen</option>
              </select>
            </div>
            <div class="form-group">
              <label class="form-label">Matrikelnummer</label>
              <input type="text" class="form-input" v-model="formData.matrikelnummer" />
            </div>
          </div>
          <div class="form-group">
            <label class="form-label">Abgabedatum</label>
            <input type="date" class="form-input" v-model="formData.abgabedatum" />
          </div>
          <div class="form-group">
            <label class="form-label">Beschreibung</label>
            <textarea class="form-input" v-model="formData.beschreibung" rows="4"></textarea>
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
          <h2 class="modal-title">Abschlussarbeit löschen?</h2>
        </div>
        <div class="modal-body">
          <p>Möchten Sie <strong>{{ thesisToDelete?.titel }}</strong> wirklich löschen?</p>
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
import { useThesesStore } from '@/stores/theses'
import type { Abschlussarbeit } from '@/services/api'

const store = useThesesStore()

// UI State
const searchInput = ref('')
const statusFilter = ref('')
const showCreateModal = ref(false)
const showEditModal = ref(false)
const showDeleteModal = ref(false)
const formLoading = ref(false)
const thesisToDelete = ref<Abschlussarbeit | null>(null)

// Form Data
const formData = ref({
  titel: '',
  beschreibung: '',
  status: 'pending' as 'pending' | 'in_progress' | 'completed',
  matrikelnummer: '',
  abgabedatum: ''
})

const editingId = ref<number | null>(null)

// Helpers
const formatDate = (dateString: string) => {
  return new Date(dateString).toLocaleDateString('de-DE')
}

const statusLabel = (status: string) => {
  const labels: Record<string, string> = {
    pending: 'Ausstehend',
    in_progress: 'In Bearbeitung',
    completed: 'Abgeschlossen',
    cancelled: 'Abgebrochen'
  }
  return labels[status] || status
}

const statusBadgeClass = (status: string) => {
  const classes: Record<string, string> = {
    pending: 'badge-warning',
    in_progress: 'badge-primary',
    completed: 'badge-success',
    cancelled: 'badge-error'
  }
  return classes[status] || 'badge-neutral'
}

// Debounced Search
let searchTimeout: ReturnType<typeof setTimeout>
const debouncedSearch = () => {
  clearTimeout(searchTimeout)
  searchTimeout = setTimeout(() => {
    store.setSearch(searchInput.value)
  }, 300)
}

const handleFilter = () => {
  store.setStatusFilter(statusFilter.value)
}

const editThesis = (thesis: Abschlussarbeit) => {
  editingId.value = thesis.id
  formData.value = {
    titel: thesis.titel,
    beschreibung: thesis.beschreibung || '',
    status: thesis.status,
    matrikelnummer: thesis.matrikelnummer || '',
    abgabedatum: thesis.abgabedatum || ''
  }
  showEditModal.value = true
}

const confirmDelete = (thesis: Abschlussarbeit) => {
  thesisToDelete.value = thesis
  showDeleteModal.value = true
}

const closeModals = () => {
  showCreateModal.value = false
  showEditModal.value = false
  editingId.value = null
  resetForm()
}

const resetForm = () => {
  formData.value = {
    titel: '',
    beschreibung: '',
    status: 'pending',
    matrikelnummer: '',
    abgabedatum: ''
  }
}

const submitForm = async () => {
  formLoading.value = true
  try {
    if (showEditModal.value && editingId.value) {
      await store.updateThesis(editingId.value, formData.value)
    } else {
      await store.createThesis(formData.value)
    }
    closeModals()
  } catch (e) {
    // Error handled in store
  } finally {
    formLoading.value = false
  }
}

const handleDelete = async () => {
  if (!thesisToDelete.value) return
  
  formLoading.value = true
  try {
    await store.deleteThesis(thesisToDelete.value.id)
    showDeleteModal.value = false
    thesisToDelete.value = null
  } catch (e) {
    // Error handled in store
  } finally {
    formLoading.value = false
  }
}

onMounted(() => {
  store.fetchTheses()
})
</script>

<style scoped>
.view-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: var(--space-5);
}

.view-header-left {
  display: flex;
  gap: var(--space-3);
}

.search-input {
  width: 280px;
  padding-left: var(--space-10);
}

.filter-select {
  width: 160px;
}

.stats-row {
  display: flex;
  gap: var(--space-4);
  margin-bottom: var(--space-6);
}

.mini-stat {
  background: var(--color-neutral-0);
  border: 1px solid var(--color-neutral-200);
  border-radius: var(--radius-md);
  padding: var(--space-3) var(--space-4);
  display: flex;
  flex-direction: column;
  align-items: center;
  min-width: 100px;
}

.mini-stat-value {
  font-size: var(--text-xl);
  font-weight: var(--font-bold);
  color: var(--color-neutral-900);
}

.mini-stat-value.text-warning { color: var(--color-warning); }
.mini-stat-value.text-primary { color: var(--color-primary-600); }
.mini-stat-value.text-success { color: var(--color-success); }

.mini-stat-label {
  font-size: var(--text-xs);
  color: var(--color-neutral-500);
  margin-top: var(--space-1);
}

.loading-state {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: var(--space-3);
  padding: var(--space-12);
  color: var(--color-neutral-500);
}

.theses-list {
  display: flex;
  flex-direction: column;
  gap: var(--space-4);
}

.thesis-card {
  display: flex;
  justify-content: space-between;
  padding: var(--space-5);
}

.thesis-content {
  flex: 1;
}

.thesis-header {
  display: flex;
  align-items: center;
  gap: var(--space-3);
  margin-bottom: var(--space-2);
}

.thesis-title {
  font-size: var(--text-base);
  font-weight: var(--font-semibold);
  color: var(--color-neutral-900);
  margin: 0;
}

.thesis-description {
  font-size: var(--text-sm);
  color: var(--color-neutral-600);
  margin: 0 0 var(--space-3) 0;
  line-height: var(--leading-relaxed);
}

.thesis-meta {
  display: flex;
  gap: var(--space-4);
}

.meta-item {
  display: flex;
  align-items: center;
  gap: var(--space-1);
  font-size: var(--text-xs);
  color: var(--color-neutral-500);
}

.thesis-actions {
  display: flex;
  gap: var(--space-1);
  align-items: flex-start;
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

.modal-sm { max-width: 400px; }

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

.modal-body { padding: var(--space-6); }

.modal-footer {
  display: flex;
  justify-content: flex-end;
  gap: var(--space-3);
  padding: var(--space-4) var(--space-6);
  border-top: 1px solid var(--color-neutral-100);
  background: var(--color-neutral-50);
}

.form-row {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: var(--space-4);
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
  
  .view-header-left {
    flex-direction: column;
  }
  
  .search-input,
  .filter-select {
    width: 100%;
  }
  
  .stats-row {
    flex-wrap: wrap;
  }
  
  .mini-stat {
    flex: 1;
    min-width: 80px;
  }
  
  .form-row {
    grid-template-columns: 1fr;
  }
}
</style>