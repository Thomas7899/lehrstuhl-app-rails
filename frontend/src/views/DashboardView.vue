<template>
  <div class="dashboard-view animate-fadeIn">
    <!-- Stats Grid -->
    <div class="stats-grid">
      <div class="card stat-card">
        <div class="stat-card-icon students">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
            <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/>
            <circle cx="9" cy="7" r="4"/>
            <path d="M23 21v-2a4 4 0 0 0-3-3.87"/>
            <path d="M16 3.13a4 4 0 0 1 0 7.75"/>
          </svg>
        </div>
        <div class="stat-card-content">
          <span class="stat-card-label">Studierende</span>
          <span class="stat-card-value">{{ loading ? '...' : store.studentCount }}</span>
          <span class="stat-card-trend positive" v-if="store.recentStudentCount > 0">
            +{{ store.recentStudentCount }} neu (30 Tage)
          </span>
        </div>
      </div>

      <div class="card stat-card">
        <div class="stat-card-icon seminars">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
            <path d="M4 19.5A2.5 2.5 0 0 1 6.5 17H20"/>
            <path d="M6.5 2H20v20H6.5A2.5 2.5 0 0 1 4 19.5v-15A2.5 2.5 0 0 1 6.5 2z"/>
          </svg>
        </div>
        <div class="stat-card-content">
          <span class="stat-card-label">Seminare</span>
          <span class="stat-card-value">{{ loading ? '...' : store.seminarCount }}</span>
          <span class="stat-card-trend" v-if="store.activeSeminarCount > 0">
            {{ store.activeSeminarCount }} aktiv
          </span>
        </div>
      </div>

      <div class="card stat-card">
        <div class="stat-card-icon theses">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
            <path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"/>
            <polyline points="14 2 14 8 20 8"/>
            <line x1="16" y1="13" x2="8" y2="13"/>
            <line x1="16" y1="17" x2="8" y2="17"/>
          </svg>
        </div>
        <div class="stat-card-content">
          <span class="stat-card-label">Abschlussarbeiten</span>
          <span class="stat-card-value">{{ loading ? '...' : store.thesisCount }}</span>
          <span class="stat-card-trend" v-if="store.thesisInProgressCount > 0">
            {{ store.thesisInProgressCount }} in Bearbeitung
          </span>
        </div>
      </div>

      <div class="card stat-card">
        <div class="stat-card-icon completed">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
            <path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"/>
            <polyline points="22 4 12 14.01 9 11.01"/>
          </svg>
        </div>
        <div class="stat-card-content">
          <span class="stat-card-label">Abgeschlossen</span>
          <span class="stat-card-value">{{ loading ? '...' : store.thesisCompletedCount }}</span>
          <span class="stat-card-trend positive">
            Arbeiten erfolgreich beendet
          </span>
        </div>
      </div>
    </div>

    <!-- Quick Actions -->
    <div class="quick-actions">
      <h2 class="heading-3 mb-4">Schnellzugriff</h2>
      <div class="actions-grid">
        <router-link to="/students" class="action-card">
          <div class="action-icon">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <path d="M16 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/>
              <circle cx="8.5" cy="7" r="4"/>
              <line x1="20" y1="8" x2="20" y2="14"/>
              <line x1="23" y1="11" x2="17" y2="11"/>
            </svg>
          </div>
          <div class="action-content">
            <h3>Neuen Studierenden anlegen</h3>
            <p>Stammdaten eines neuen Studierenden erfassen</p>
          </div>
        </router-link>

        <router-link to="/seminare" class="action-card">
          <div class="action-icon">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <path d="M4 19.5A2.5 2.5 0 0 1 6.5 17H20"/>
              <path d="M6.5 2H20v20H6.5A2.5 2.5 0 0 1 4 19.5v-15A2.5 2.5 0 0 1 6.5 2z"/>
              <line x1="12" y1="6" x2="12" y2="10"/>
              <line x1="10" y1="8" x2="14" y2="8"/>
            </svg>
          </div>
          <div class="action-content">
            <h3>Neues Seminar erstellen</h3>
            <p>Ein neues Seminar für das aktuelle Semester anlegen</p>
          </div>
        </router-link>

        <router-link to="/theses" class="action-card">
          <div class="action-icon">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"/>
              <polyline points="14 2 14 8 20 8"/>
              <line x1="12" y1="18" x2="12" y2="12"/>
              <line x1="9" y1="15" x2="15" y2="15"/>
            </svg>
          </div>
          <div class="action-content">
            <h3>Abschlussarbeit zuweisen</h3>
            <p>Eine neue Abschlussarbeit einem Studierenden zuweisen</p>
          </div>
        </router-link>
      </div>
    </div>

    <!-- Error Display -->
    <div v-if="store.error" class="alert alert-error mt-4">
      <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
        <circle cx="12" cy="12" r="10"/>
        <line x1="12" y1="8" x2="12" y2="12"/>
        <line x1="12" y1="16" x2="12.01" y2="16"/>
      </svg>
      {{ store.error }}
    </div>
  </div>
</template>

<script setup lang="ts">
import { onMounted, computed } from 'vue'
import { useDashboardStore } from '@/stores/dashboard'

const store = useDashboardStore()
const loading = computed(() => store.loading)

onMounted(() => {
  store.fetchStats()
})
</script>

<style scoped>
.stats-grid {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: var(--space-5);
  margin-bottom: var(--space-8);
}

.stat-card {
  display: flex;
  align-items: flex-start;
  gap: var(--space-4);
  padding: var(--space-5);
}

.stat-card-icon {
  width: 48px;
  height: 48px;
  border-radius: var(--radius-lg);
  display: flex;
  align-items: center;
  justify-content: center;
  flex-shrink: 0;
}

.stat-card-icon svg {
  width: 24px;
  height: 24px;
}

.stat-card-icon.students {
  background: var(--color-primary-100);
  color: var(--color-primary-600);
}

.stat-card-icon.seminars {
  background: #dbeafe;
  color: #2563eb;
}

.stat-card-icon.theses {
  background: #fef3c7;
  color: #d97706;
}

.stat-card-icon.completed {
  background: var(--color-success-light);
  color: var(--color-success);
}

.stat-card-content {
  display: flex;
  flex-direction: column;
}

.stat-card-label {
  font-size: var(--text-sm);
  font-weight: var(--font-medium);
  color: var(--color-neutral-500);
}

.stat-card-value {
  font-size: var(--text-2xl);
  font-weight: var(--font-bold);
  color: var(--color-neutral-900);
  line-height: 1.2;
  margin-top: var(--space-1);
}

.stat-card-trend {
  font-size: var(--text-xs);
  color: var(--color-neutral-500);
  margin-top: var(--space-1);
}

.stat-card-trend.positive {
  color: var(--color-success);
}

.actions-grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: var(--space-4);
}

.action-card {
  display: flex;
  align-items: flex-start;
  gap: var(--space-4);
  padding: var(--space-5);
  background: var(--color-neutral-0);
  border: 1px solid var(--color-neutral-200);
  border-radius: var(--radius-lg);
  text-decoration: none;
  transition: all var(--transition-fast);
}

.action-card:hover {
  border-color: var(--color-primary-300);
  box-shadow: var(--shadow-md);
  transform: translateY(-2px);
}

.action-icon {
  width: 44px;
  height: 44px;
  border-radius: var(--radius-md);
  background: var(--color-neutral-100);
  display: flex;
  align-items: center;
  justify-content: center;
  flex-shrink: 0;
  transition: all var(--transition-fast);
}

.action-icon svg {
  width: 22px;
  height: 22px;
  color: var(--color-neutral-600);
}

.action-card:hover .action-icon {
  background: var(--color-primary-100);
}

.action-card:hover .action-icon svg {
  color: var(--color-primary-600);
}

.action-content h3 {
  font-size: var(--text-base);
  font-weight: var(--font-semibold);
  color: var(--color-neutral-900);
  margin-bottom: var(--space-1);
}

.action-content p {
  font-size: var(--text-sm);
  color: var(--color-neutral-500);
}

@media (max-width: 1200px) {
  .stats-grid {
    grid-template-columns: repeat(2, 1fr);
  }
}

@media (max-width: 768px) {
  .stats-grid {
    grid-template-columns: 1fr;
  }
  
  .actions-grid {
    grid-template-columns: 1fr;
  }
}
</style>