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
        <i class="bi bi-lightbulb-fill me-3"></i>Abstrakte Abschlussarbeiten
      </h1>
      <p class="lead text-muted mb-4">Verwalten Sie die verfügbaren Themen für Abschlussarbeiten</p>
      
      <div class="d-flex justify-content-center">
        <router-link to="/abstrakte_abschlussarbeiten/new" class="btn btn-success btn-lg px-4 py-2 shadow-sm modern-btn">
          <i class="bi bi-plus-circle-fill me-2"></i>
          Neues Thema erstellen
        </router-link>
      </div>
    </div>

    <!-- Statistik Cards -->
    <div class="stats-row mb-5">
      <div class="container-fluid">
        <div class="row g-4">
          <div class="col-lg-3 col-md-6">
            <div class="stat-card">
              <div class="stat-icon topic-icon"><i class="bi bi-lightbulb"></i></div>
              <div class="stat-content">
                <h3 class="stat-number">{{ stats.verfuegbareThemen }}</h3>
                <p class="stat-label">Verfügbare Themen</p>
              </div>
            </div>
          </div>
          <div class="col-lg-3 col-md-6">
            <div class="stat-card">
              <div class="stat-icon new-icon"><i class="bi bi-star-fill"></i></div>
              <div class="stat-content">
                <h3 class="stat-number">{{ stats.neueThemen }}</h3>
                <p class="stat-label">Neue Themen</p>
              </div>
            </div>
          </div>
          <div class="col-lg-3 col-md-6">
            <div class="stat-card">
              <div class="stat-icon category-icon"><i class="bi bi-tags-fill"></i></div>
              <div class="stat-content">
                <h3 class="stat-number">{{ stats.kategorien }}</h3>
                <p class="stat-label">Kategorien</p>
              </div>
            </div>
          </div>
          <div class="col-lg-3 col-md-6">
            <div class="stat-card">
              <div class="stat-icon available-icon"><i class="bi bi-check2-circle"></i></div>
              <div class="stat-content">
                <h3 class="stat-number">100%</h3>
                <p class="stat-label">Verfügbar</p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Moderne Card-Ansicht -->
    <div class="thesis-grid">
      <div class="container-fluid">
        <div v-if="abstrakteAbschlussarbeiten && abstrakteAbschlussarbeiten.length > 0" class="row g-4">
          <div v-for="arbeit in abstrakteAbschlussarbeiten" :key="arbeit.id" class="col-xl-4 col-lg-6 col-md-6">
            <div class="topic-card">
              <div class="topic-card-header">
                <div class="topic-status available">
                  <i class="bi bi-circle-fill"></i>
                  <span>Verfügbar</span>
                </div>
                <div class="topic-date">
                  <i class="bi bi-calendar3"></i>
                  {{ new Date(arbeit.created_at).toLocaleDateString('de-DE') }}
                </div>
              </div>
              <div class="topic-card-body">
                <h5 class="topic-title">
                  <router-link :to="{ name: 'AbstrakteAbschlussarbeitDetails', params: { id: arbeit.id } }" class="text-decoration-none">
                    {{ arbeit.thema || "Ohne Titel" }}
                  </router-link>
                </h5>
                <div class="topic-meta">
                  <div v-if="arbeit.forschungsprojekt" class="meta-item">
                    <i class="bi bi-bookmark-fill"></i>
                    <span>{{ arbeit.forschungsprojekt }}</span>
                  </div>
                  <div class="meta-item">
                    <i class="bi bi-clock-fill"></i>
                    <span>6 Monate</span>
                  </div>
                </div>
                <p v-if="arbeit.themenskizze" class="topic-description">
                  {{ truncate(arbeit.themenskizze, 150) }}
                </p>
              </div>
              <div class="topic-card-footer">
                <div class="topic-actions">
                  <router-link :to="{ name: 'AbstrakteAbschlussarbeitDetails', params: { id: arbeit.id } }" class="btn btn-outline-primary btn-sm">
                    <i class="bi bi-eye-fill me-1"></i>Details
                  </router-link>
                  <router-link :to="{ name: 'AbstrakteAbschlussarbeitEdit', params: { id: arbeit.id } }" class="btn btn-outline-secondary btn-sm">
                    <i class="bi bi-pencil-fill me-1"></i>Bearbeiten
                  </router-link>
                </div>
                <div class="topic-difficulty">
                  <div class="difficulty-stars">
                    <i v-for="i in 3" :key="`filled-${i}`" class="bi bi-star-fill"></i>
                    <i v-for="i in 2" :key="`empty-${i}`" class="bi bi-star"></i>
                  </div>
                  <small class="text-muted">Schwierigkeit</small>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div v-else class="empty-state text-center py-5">
          <div class="empty-icon"><i class="bi bi-lightbulb"></i></div>
          <h3 class="empty-title">Keine abstrakten Abschlussarbeiten vorhanden</h3>
          <p class="empty-description">Erstellen Sie Ihr erstes Thema, um Studierenden Auswahlmöglichkeiten zu bieten.</p>
          <router-link to="/abstrakte_abschlussarbeiten/new" class="btn btn-primary">
            <i class="bi bi-plus-circle-fill me-2"></i>
            Erstes Thema erstellen
          </router-link>
        </div>
      </div>
    </div>

    <div class="d-flex justify-content-center">
       <!-- Hier müsste eine Paginierungs-Komponente eingefügt werden -->
    </div>
  </div>
</template>

<script setup lang="ts">
import { type PropType, defineProps } from 'vue'

interface AbstrakteAbschlussarbeit {
  id: string | number
  created_at: string
  thema: string | null
  forschungsprojekt?: string
  themenskizze?: string
}

interface AbstrakteStats {
  verfuegbareThemen: number
  neueThemen: number
  kategorien: number
}

defineProps({
  abstrakteAbschlussarbeiten: { type: Array as PropType<AbstrakteAbschlussarbeit[]>, required: true },
  stats: { type: Object as PropType<AbstrakteStats>, required: true },
  notice: { type: String, default: '' }
})

function truncate(text: string, length: number): string {
  if (text.length <= length) {
    return text
  }
  return text.substring(0, length) + '...'
}
</script>
