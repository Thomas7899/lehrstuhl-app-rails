import { defineStore } from 'pinia'
import { ref, computed } from 'vue'
import { dashboardApi, type DashboardStats } from '@/services/api'

export const useDashboardStore = defineStore('dashboard', () => {
  // State
  const stats = ref<DashboardStats | null>(null)
  const loading = ref(false)
  const error = ref<string | null>(null)
  const lastFetched = ref<Date | null>(null)

  // Getters
  const studentCount = computed(() => stats.value?.students.total ?? 0)
  const recentStudentCount = computed(() => stats.value?.students.recent ?? 0)
  const seminarCount = computed(() => stats.value?.seminare.total ?? 0)
  const activeSeminarCount = computed(() => stats.value?.seminare.active ?? 0)
  const thesisCount = computed(() => stats.value?.abschlussarbeiten.total ?? 0)
  const thesisInProgressCount = computed(() => stats.value?.abschlussarbeiten.in_progress ?? 0)
  const thesisCompletedCount = computed(() => stats.value?.abschlussarbeiten.completed ?? 0)

  // Actions
  async function fetchStats(force = false) {
    // Cache für 5 Minuten, außer force refresh
    if (!force && lastFetched.value) {
      const fiveMinutesAgo = new Date(Date.now() - 5 * 60 * 1000)
      if (lastFetched.value > fiveMinutesAgo) {
        return stats.value
      }
    }

    loading.value = true
    error.value = null
    
    try {
      const response = await dashboardApi.getStats()
      stats.value = response.data.data
      lastFetched.value = new Date()
      return stats.value
    } catch (err: any) {
      error.value = err.response?.data?.errors?.[0] || 'Fehler beim Laden der Dashboard-Daten'
      console.error('Error fetching dashboard stats:', err)
      return null
    } finally {
      loading.value = false
    }
  }

  function clearError() {
    error.value = null
  }

  return {
    // State
    stats,
    loading,
    error,
    lastFetched,
    
    // Getters
    studentCount,
    recentStudentCount,
    seminarCount,
    activeSeminarCount,
    thesisCount,
    thesisInProgressCount,
    thesisCompletedCount,
    
    // Actions
    fetchStats,
    clearError
  }
})
