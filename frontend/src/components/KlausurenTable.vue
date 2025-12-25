<template>
  <div class="container mt-5">
    <div class="students-header text-center mb-5">
      <h1 class="display-4"><i class="bi bi-calendar3-event"></i> Klausuren</h1>
      <p class="lead text-muted">Übersicht der angebotenen Klausuren.</p>
    </div>

    <div v-if="klausuren && klausuren.length > 0" class="table-responsive">
      <table class="table modern-table align-middle">
        <thead>
          <tr>
            <th>Titel</th>
            <th>Modul</th>
            <th>Semester</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="klausur in klausuren" :key="klausur.id">
            <td>{{ klausur.titel }}</td>
            <td>{{ klausur.modul }}</td>
            <td>{{ klausur.semester }}</td>
          </tr>
        </tbody>
      </table>
    </div>
    <div v-else class="alert alert-info modern-alert text-center">
      <i class="bi bi-info-circle-fill me-2"></i>
      Es sind aktuell keine Klausuren geplant.
    </div>
  </div>
</template>

<script setup lang="ts">
import { type PropType, defineProps } from 'vue'

interface Klausur {
  id: string | number;
  titel: string;
  modul: string;
  semester: string;
}

defineProps({
  klausuren: {
    type: Array as PropType<Klausur[]>,
    required: true
  }
})
</script>
