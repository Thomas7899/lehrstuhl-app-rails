<template>
  <div class="table-responsive">
    <table class="table table-striped table-hover">
      <thead class="thead-light">
        <tr>
          <th>Titel</th>
          <th>Semester</th>
          <th>Dozent</th>
          <th>Ort</th>
          <th>Datum</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="seminar in seminare" :key="seminar.id">
          <td>{{ seminar.titel }}</td>
          <td>{{ seminar.semester }}</td>
          <td>
            {{ seminar.mitarbeiter?.titel }}
            {{ seminar.mitarbeiter?.vorname }}
            {{ seminar.mitarbeiter?.nachname }}
          </td>
          <td>{{ seminar.ort }}</td>
          <td>{{ seminar.praesenzdatum }}</td>
        </tr>
      </tbody>
    </table>

    <p v-if="seminare.length === 0">Keine Seminare gefunden...</p>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import axios from 'axios'


interface Mitarbeiter {
  titel?: string
  vorname?: string
  nachname?: string
}

interface AbstraktesSeminar {
  thema?: string
}

interface Seminar {
  id: number
  titel: string
  semester: string
  ort: string
  praesenzdatum: string
  mitarbeiter?: Mitarbeiter
  abstraktes_seminar?: AbstraktesSeminar
}

const seminare = ref<Seminar[]>([]) 

onMounted(async () => {
  try {
    const res = await axios.get('http://localhost:3000/api/seminare', {
      headers: {
        'Accept': 'application/json'
      }
    })
    console.log('📦 Seminar-Daten:', res.data)
    seminare.value = res.data
  } catch (error) {
    console.error('❌ Fehler beim Laden der Seminare:', error)
  }
})
</script>

