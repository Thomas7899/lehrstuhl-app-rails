<template>
  <div class="students-view animate-fadeIn">
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
            placeholder="Studierende suchen..."
            v-model="searchInput"
            @input="debouncedSearch"
          />
        </div>
        <select class="form-input sort-select" v-model="sortBy" @change="handleSort">
          <option value="created_at">Neueste zuerst</option>
          <option value="name_asc">Name A-Z</option>
          <option value="name_desc">Name Z-A</option>
          <option value="matrikel">Matrikelnummer</option>
        </select>
      </div>
      <button class="btn btn-primary" @click="showCreateModal = true">
        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
          <line x1="12" y1="5" x2="12" y2="19"/>
          <line x1="5" y1="12" x2="19" y2="12"/>
        </svg>
        Neu anlegen
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
      <button class="btn btn-ghost btn-sm" @click="store.clearError">Schließen</button>
    </div>

    <!-- Empty State -->
    <div v-else-if="store.students.length === 0" class="empty-state">
      <div class="empty-state-icon">
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5">
          <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/>
          <circle cx="9" cy="7" r="4"/>
          <path d="M23 21v-2a4 4 0 0 0-3-3.87"/>
          <path d="M16 3.13a4 4 0 0 1 0 7.75"/>
        </svg>
      </div>
      <h3 class="empty-state-title">Keine Studierenden gefunden</h3>
      <p class="empty-state-description">
        {{ store.searchQuery ? 'Versuchen Sie eine andere Suchanfrage.' : 'Legen Sie den ersten Studierenden an.' }}
      </p>
      <button v-if="!store.searchQuery" class="btn btn-primary" @click="showCreateModal = true">
        Studierenden anlegen
      </button>
    </div>

    <!-- Students Table -->
    <div v-else class="card">
      <div class="table-container">
        <table class="table">
          <thead>
            <tr>
              <th>Name</th>
              <th>Matrikelnummer</th>
              <th>E-Mail</th>
              <th>Geburtsdatum</th>
              <th class="text-right">Aktionen</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="student in store.students" :key="student.id">
              <td>
                <div class="student-name">
                  <div class="student-avatar">{{ getInitials(student) }}</div>
                  <div>
                    <span class="student-fullname">{{ student.full_name }}</span>
                  </div>
                </div>
              </td>
              <td>
                <span class="badge badge-neutral">{{ student.matrikelnummer }}</span>
              </td>
              <td>{{ student.email }}</td>
              <td>{{ formatDate(student.geburtsdatum) }}</td>
              <td class="text-right">
                <div class="action-buttons">
                  <button class="btn btn-ghost btn-sm" @click="viewStudent(student)" title="Details">
                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                      <path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"/>
                      <circle cx="12" cy="12" r="3"/>
                    </svg>
                  </button>
                  <button class="btn btn-ghost btn-sm" @click="editStudent(student)" title="Bearbeiten">
                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                      <path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7"/>
                      <path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z"/>
                    </svg>
                  </button>
                  <button class="btn btn-ghost btn-sm text-error" @click="confirmDelete(student)" title="Löschen">
                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                      <polyline points="3 6 5 6 21 6"/>
                      <path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"/>
                    </svg>
                  </button>
                </div>
              </td>
            </tr>
          </tbody>
        </table>
      </div>

      <!-- Pagination -->
      <div class="card-footer" v-if="store.totalPages > 1">
        <div class="pagination">
          <button 
            class="btn btn-secondary btn-sm" 
            :disabled="!store.hasPrevPage"
            @click="store.prevPage"
          >
            Zurück
          </button>
          <span class="pagination-info">
            Seite {{ store.currentPage }} von {{ store.totalPages }}
            ({{ store.totalStudents }} Einträge)
          </span>
          <button 
            class="btn btn-secondary btn-sm" 
            :disabled="!store.hasNextPage"
            @click="store.nextPage"
          >
            Weiter
          </button>
        </div>
      </div>
    </div>

    <!-- Create/Edit Modal -->
    <div v-if="showCreateModal || showEditModal" class="modal-overlay" @click.self="closeModals">
      <div class="modal">
        <div class="modal-header">
          <h2 class="modal-title">{{ showEditModal ? 'Studierenden bearbeiten' : 'Neuen Studierenden anlegen' }}</h2>
          <button class="btn btn-ghost" @click="closeModals">
            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <line x1="18" y1="6" x2="6" y2="18"/>
              <line x1="6" y1="6" x2="18" y2="18"/>
            </svg>
          </button>
        </div>
        <form @submit.prevent="submitForm" class="modal-body">
          <div class="form-row">
            <div class="form-group">
              <label class="form-label">Vorname *</label>
              <input type="text" class="form-input" v-model="formData.vorname" required />
            </div>
            <div class="form-group">
              <label class="form-label">Nachname *</label>
              <input type="text" class="form-input" v-model="formData.nachname" required />
            </div>
          </div>
          <div class="form-group">
            <label class="form-label">Matrikelnummer *</label>
            <input type="text" class="form-input" v-model="formData.matrikelnummer" required />
          </div>
          <div class="form-group">
            <label class="form-label">E-Mail *</label>
            <input type="email" class="form-input" v-model="formData.email" required />
          </div>
          <div class="form-group">
            <label class="form-label">Geburtsdatum</label>
            <input type="date" class="form-input" v-model="formData.geburtsdatum" />
          </div>
        </form>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" @click="closeModals">Abbrechen</button>
          <button type="submit" class="btn btn-primary" @click="submitForm" :disabled="formLoading">
            {{ formLoading ? 'Speichern...' : (showEditModal ? 'Aktualisieren' : 'Anlegen') }}
          </button>
        </div>
      </div>
    </div>

    <!-- Delete Confirmation Modal -->
    <div v-if="showDeleteModal" class="modal-overlay" @click.self="showDeleteModal = false">
      <div class="modal modal-sm">
        <div class="modal-header">
          <h2 class="modal-title">Studierenden löschen?</h2>
        </div>
        <div class="modal-body">
          <p>Möchten Sie <strong>{{ studentToDelete?.full_name }}</strong> wirklich löschen? Diese Aktion kann nicht rückgängig gemacht werden.</p>
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
import { useStudentsStore } from '@/stores/students'
import type { Student } from '@/services/api'

const store = useStudentsStore()

// UI State
const searchInput = ref('')
const sortBy = ref('created_at')
const showCreateModal = ref(false)
const showEditModal = ref(false)
const showDeleteModal = ref(false)
const formLoading = ref(false)
const studentToDelete = ref<Student | null>(null)

// Form Data
const formData = ref({
  vorname: '',
  nachname: '',
  matrikelnummer: '',
  email: '',
  geburtsdatum: ''
})

const editingId = ref<number | null>(null)

// Debounced Search
let searchTimeout: ReturnType<typeof setTimeout>
const debouncedSearch = () => {
  clearTimeout(searchTimeout)
  searchTimeout = setTimeout(() => {
    store.setSearch(searchInput.value)
  }, 300)
}

const handleSort = () => {
  store.setSort(sortBy.value)
}

const getInitials = (student: Student) => {
  return `${student.vorname?.[0] || ''}${student.nachname?.[0] || ''}`.toUpperCase()
}

const formatDate = (dateString?: string) => {
  if (!dateString) return '—'
  const date = new Date(dateString)
  return date.toLocaleDateString('de-DE')
}

const viewStudent = (student: Student) => {
  // TODO: Implement detail view or router navigation
  console.log('View student:', student)
}

const editStudent = (student: Student) => {
  editingId.value = student.id
  formData.value = {
    vorname: student.vorname,
    nachname: student.nachname,
    matrikelnummer: student.matrikelnummer,
    email: student.email,
    geburtsdatum: student.geburtsdatum || ''
  }
  showEditModal.value = true
}

const confirmDelete = (student: Student) => {
  studentToDelete.value = student
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
    vorname: '',
    nachname: '',
    matrikelnummer: '',
    email: '',
    geburtsdatum: ''
  }
}

const submitForm = async () => {
  formLoading.value = true
  try {
    if (showEditModal.value && editingId.value) {
      await store.updateStudent(editingId.value, formData.value)
    } else {
      await store.createStudent(formData.value)
    }
    closeModals()
  } catch (e) {
    // Error is handled in store
  } finally {
    formLoading.value = false
  }
}

const handleDelete = async () => {
  if (!studentToDelete.value) return
  
  formLoading.value = true
  try {
    await store.deleteStudent(studentToDelete.value.id)
    showDeleteModal.value = false
    studentToDelete.value = null
  } catch (e) {
    // Error is handled in store
  } finally {
    formLoading.value = false
  }
}

onMounted(() => {
  store.fetchStudents()
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

.sort-select {
  width: 180px;
}

.loading-state {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: var(--space-3);
  padding: var(--space-12);
  color: var(--color-neutral-500);
}

.student-name {
  display: flex;
  align-items: center;
  gap: var(--space-3);
}

.student-avatar {
  width: 36px;
  height: 36px;
  border-radius: var(--radius-full);
  background: var(--color-primary-100);
  color: var(--color-primary-700);
  display: flex;
  align-items: center;
  justify-content: center;
  font-weight: var(--font-semibold);
  font-size: var(--text-sm);
}

.student-fullname {
  font-weight: var(--font-medium);
  color: var(--color-neutral-900);
}

.action-buttons {
  display: flex;
  gap: var(--space-1);
  justify-content: flex-end;
}

.text-error {
  color: var(--color-error);
}

.pagination {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: var(--space-4);
}

.pagination-info {
  font-size: var(--text-sm);
  color: var(--color-neutral-500);
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
  animation: fadeIn var(--transition-fast);
}

.modal {
  background: var(--color-neutral-0);
  border-radius: var(--radius-xl);
  width: 100%;
  max-width: 500px;
  max-height: 90vh;
  overflow: hidden;
  animation: slideIn var(--transition-base);
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

.form-row {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: var(--space-4);
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
  .sort-select {
    width: 100%;
  }
  
  .form-row {
    grid-template-columns: 1fr;
  }
}
</style>