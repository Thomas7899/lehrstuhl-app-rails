<template>
  <div>
    <div v-if="notice" class="alert alert-success alert-dismissible fade show modern-alert" role="alert">
      <i class="bi bi-check-circle-fill me-2"></i>
      {{ notice }}
      <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>

    <div id="search_results" class="text-center mb-4">
      <!-- Suchergebnisse können hier dynamisch eingefügt werden -->
    </div>

    <div class="thesis-header text-center mb-5">
      <h1 class="display-4 fw-bold text-primary mb-3">
        <i class="bi bi-file-earmark-check-fill me-3"></i>Konkrete Abschlussarbeiten
      </h1>
      <p class="lead text-muted mb-4">Verwalten Sie die laufenden Abschlussarbeiten Ihres Lehrstuhls</p>
      
      <div class="d-flex justify-content-center">
        <router-link to="/konkrete_abschlussarbeiten/new" class="btn btn-success btn-lg px-4 py-2 shadow-sm modern-btn">
          <i class="bi bi-plus-circle-fill me-2"></i>
          Neue Abschlussarbeit erstellen
        </router-link>
      </div>
    </div>

    <!-- Statistik Cards -->
    <div class="stats-row mb-5">
      <div class="container-fluid">
        <div class="row g-4">
          <div class="col-lg-3 col-md-6">
            <div class="stat-card">
              <div class="stat-icon thesis-icon"><i class="bi bi-file-earmark-check"></i></div>
              <div class="stat-content">
                <h3 class="stat-number">{{ stats.laufendeArbeiten }}</h3>
                <p class="stat-label">Laufende Arbeiten</p>
              </div>
            </div>
          </div>
          <div class="col-lg-3 col-md-6">
            <div class="stat-card">
              <div class="stat-icon progress-icon"><i class="bi bi-clock-history"></i></div>
              <div class="stat-content">
                <h3 class="stat-number">{{ stats.diesenMonat }}</h3>
                <p class="stat-label">Diesen Monat</p>
              </div>
            </div>
          </div>
          <div class="col-lg-3 col-md-6">
            <div class="stat-card">
              <div class="stat-icon student-icon"><i class="bi bi-person-workspace"></i></div>
              <div class="stat-content">
                <h3 class="stat-number">{{ stats.aktiveStudierende }}</h3>
                <p class="stat-label">Aktive Studierende</p>
              </div>
            </div>
          </div>
          <div class="col-lg-3 col-md-6">
            <div class="stat-card">
              <div class="stat-icon completion-icon"><i class="bi bi-trophy-fill"></i></div>
              <div class="stat-content">
                <h3 class="stat-number">85%</h3>
                <p class="stat-label">Erfolgsrate</p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Moderne Card-Ansicht -->
    <div class="thesis-grid">
      <div class="container-fluid">
        <div v-if="konkreteAbschlussarbeiten && konkreteAbschlussarbeiten.length > 0" class="row g-4">
          <div v-for="arbeit in konkreteAbschlussarbeiten" :key="arbeit.id" class="col-xl-4 col-lg-6 col-md-6">
            <div class="thesis-card">
              <div class="thesis-card-header">
                <div class="thesis-status active">
                  <i class="bi bi-circle-fill"></i>
                  <span>Aktiv</span>
                </div>
                <div class="thesis-date">
                  <i class="bi bi-calendar3"></i>
                  {{ new Date(arbeit.created_at).toLocaleDateString('de-DE') }}
                </div>
              </div>
              <div class="thesis-card-body">
                <h5 class="thesis-title">
                  <router-link :to="{ name: 'KonkreteAbschlussarbeitDetails', params: { id: arbeit.id } }" class="text-decoration-none">
                    {{ arbeit.angepasste_themenskizze || "Ohne Titel" }}
                  </router-link>
                </h5>
                <div class="thesis-meta">
                  <div v-if="arbeit.student" class="meta-item">
                    <i class="bi bi-person-fill"></i>
                    <span>{{ arbeit.student.vorname }} {{ arbeit.student.nachname }}</span>
                  </div>
                  <div v-if="arbeit.studienniveau" class="meta-item">
                    <i class="bi bi-bookmark-fill"></i>
                    <span class="text-capitalize">{{ arbeit.studienniveau }}</span>
                  </div>
                </div>
                <p v-if="arbeit.gesetzte_schwerpunkte" class="thesis-description">
                  {{ truncate(arbeit.gesetzte_schwerpunkte, 120) }}
                </p>
              </div>
              <div class="thesis-card-footer">
                <div class="thesis-actions">
                  <router-link :to="{ name: 'KonkreteAbschlussarbeitDetails', params: { id: arbeit.id } }" class="btn btn-outline-primary btn-sm">
                    <i class="bi bi-eye-fill me-1"></i>Details
                  </router-link>
                  <router-link :to="{ name: 'KonkreteAbschlussarbeitEdit', params: { id: arbeit.id } }" class="btn btn-outline-secondary btn-sm">
                    <i class="bi bi-pencil-fill me-1"></i>Bearbeiten
                  </router-link>
                </div>
                <div class="thesis-progress">
                  <div class="progress-bar">
                    <div class="progress-fill" :style="{ width: `${Math.floor(Math.random() * (90 - 20 + 1)) + 20}%` }"></div>
                  </div>
                  <small class="text-muted">Fortschritt</small>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div v-else class="empty-state text-center py-5">
          <div class="empty-icon"><i class="bi bi-file-earmark-x"></i></div>
          <h3 class="empty-title">Keine konkreten Abschlussarbeiten vorhanden</h3>
          <p class="empty-description">Erstellen Sie Ihre erste konkrete Abschlussarbeit, um loszulegen.</p>
          <router-link to="/konkrete_abschlussarbeiten/new" class="btn btn-primary">
            <i class="bi bi-plus-circle-fill me-2"></i>
            Erste Abschlussarbeit erstellen
          </router-link>
        </div>
      </div>
    </div>

    <div class="d-flex justify-content-center mt-3">
      <!-- Hier müsste eine Paginierungs-Komponente eingefügt werden, z.B. vue-paginate -->
    </div>
  </div>
</template>

<script setup lang="ts">
import { type PropType, defineProps } from 'vue'

interface Student {
  vorname: string
  nachname: string
}

interface KonkreteAbschlussarbeit {
  id: string | number
  created_at: string
  angepasste_themenskizze: string | null
  student?: Student
  studienniveau?: string
  gesetzte_schwerpunkte?: string
}

interface KonkreteStats {
  laufendeArbeiten: number
  diesenMonat: number
  aktiveStudierende: number
}

defineProps({
  konkreteAbschlussarbeiten: { type: Array as PropType<KonkreteAbschlussarbeit[]>, required: true },
  stats: { type: Object as PropType<KonkreteStats>, required: true },
  notice: { type: String, default: '' }
})

function truncate(text: string, length: number): string {
  if (text.length <= length) {
    return text
  }
  return text.substring(0, length) + '...'
}
</script>

<style scoped>
.text-capitalize {
  text-transform: capitalize;
}
</style>
