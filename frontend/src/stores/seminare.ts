import { defineStore } from 'pinia'
import { ref, computed } from 'vue'
import { seminareApi, type Seminar } from '@/services/api'

export const useSeminareStore = defineStore('seminare', () => {
  // State
  const seminare = ref<Seminar[]>([])
  const currentSeminar = ref<Seminar | null>(null)
  const loading = ref(false)
  const error = ref<string | null>(null)
  
  // Filters
  const searchQuery = ref('')

  // Getters
  const totalSeminare = computed(() => seminare.value.length)

  // Actions
  async function fetchSeminare() {
    loading.value = true
    error.value = null
    
    try {
      const response = await seminareApi.getAll({
        search: searchQuery.value || undefined
      })
      
      seminare.value = response.data.data
    } catch (err: any) {
      error.value = err.response?.data?.errors?.[0] || 'Fehler beim Laden der Seminare'
      console.error('Error fetching seminare:', err)
    } finally {
      loading.value = false
    }
  }

  async function fetchSeminar(id: string) {
    loading.value = true
    error.value = null
    
    try {
      const response = await seminareApi.getById(id)
      currentSeminar.value = response.data.data
      return currentSeminar.value
    } catch (err: any) {
      error.value = err.response?.data?.errors?.[0] || 'Fehler beim Laden des Seminars'
      console.error('Error fetching seminar:', err)
      return null
    } finally {
      loading.value = false
    }
  }

  async function createSeminar(data: Partial<Seminar>) {
    loading.value = true
    error.value = null
    
    try {
      const response = await seminareApi.create(data)
      seminare.value.unshift(response.data.data)
      return response.data.data
    } catch (err: any) {
      error.value = err.response?.data?.errors?.[0] || 'Fehler beim Erstellen des Seminars'
      throw err
    } finally {
      loading.value = false
    }
  }

  async function updateSeminar(id: string, data: Partial<Seminar>) {
    loading.value = true
    error.value = null
    
    try {
      const response = await seminareApi.update(id, data)
      const index = seminare.value.findIndex(s => s.id === id)
      if (index !== -1) {
        seminare.value[index] = response.data.data
      }
      if (currentSeminar.value?.id === id) {
        currentSeminar.value = response.data.data
      }
      return response.data.data
    } catch (err: any) {
      error.value = err.response?.data?.errors?.[0] || 'Fehler beim Aktualisieren des Seminars'
      throw err
    } finally {
      loading.value = false
    }
  }

  async function deleteSeminar(id: string) {
    loading.value = true
    error.value = null
    
    try {
      await seminareApi.delete(id)
      seminare.value = seminare.value.filter(s => s.id !== id)
      if (currentSeminar.value?.id === id) {
        currentSeminar.value = null
      }
    } catch (err: any) {
      error.value = err.response?.data?.errors?.[0] || 'Fehler beim Löschen des Seminars'
      throw err
    } finally {
      loading.value = false
    }
  }

  function setSearch(query: string) {
    searchQuery.value = query
    fetchSeminare()
  }

  function clearError() {
    error.value = null
  }

  return {
    // State
    seminare,
    currentSeminar,
    loading,
    error,
    searchQuery,
    
    // Getters
    totalSeminare,
    
    // Actions
    fetchSeminare,
    fetchSeminar,
    createSeminar,
    updateSeminar,
    deleteSeminar,
    setSearch,
    clearError
  }
})
