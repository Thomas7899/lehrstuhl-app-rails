<template>
  <div class="container mt-5">
    <div class="students-header text-center mb-5">
      <h1 class="display-4"><i class="bi bi-journal-richtext"></i> Abstrakte Seminare</h1>
      <p class="lead text-muted">Übergeordnete Seminarangebote und Themenbereiche.</p>
    </div>

    <div v-if="abstrakteSeminare && abstrakteSeminare.length > 0" class="row row-cols-1 row-cols-md-2 row-cols-lg-3 g-4">
      <div v-for="seminar in abstrakteSeminare" :key="seminar.id" class="col">
        <div class="card h-100 modern-student-card-grid">
          <div class="card-header">
            <h5 class="card-title fw-bold text-primary">{{ seminar.thema }}</h5>
          </div>
          <div class="card-body">
            <p class="card-text">{{ seminar.beschreibung }}</p>
          </div>
          <div class="card-footer bg-light text-muted">
            Verantwortlich: {{ seminar.mitarbeiter.titel }} {{ seminar.mitarbeiter.nachname }}
          </div>
        </div>
      </div>
    </div>
    <div v-else class="alert alert-info modern-alert text-center">
      <i class="bi bi-info-circle-fill me-2"></i>
      Es sind aktuell keine abstrakten Seminare vorhanden.
    </div>
  </div>
</template>

<script setup lang="ts">
import { type PropType, defineProps } from 'vue'

interface Mitarbeiter {
  titel: string
  nachname: string
}

interface AbstraktesSeminar {
  id: string | number
  thema: string
  beschreibung: string
  mitarbeiter: Mitarbeiter
}

defineProps({
  abstrakteSeminare: {
    type: Array as PropType<AbstraktesSeminar[]>,
    required: true
  }
})
</script>
