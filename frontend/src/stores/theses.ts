import { defineStore } from 'pinia'
import { ref, computed } from 'vue'
import { abschlussarbeitenApi, type Abschlussarbeit } from '@/services/api'

export const useThesesStore = defineStore('theses', () => {
  // State
  const theses = ref<Abschlussarbeit[]>([])
  const currentThesis = ref<Abschlussarbeit | null>(null)
  const loading = ref(false)
  const error = ref<string | null>(null)
  
  // Filters
  const searchQuery = ref('')
  const statusFilter = ref<string>('')

  // Getters
  const totalTheses = computed(() => theses.value.length)
  
  const pendingTheses = computed(() => 
    theses.value.filter(t => t.status === 'pending')
  )
  
  const inProgressTheses = computed(() => 
    theses.value.filter(t => t.status === 'in_progress')
  )
  
  const completedTheses = computed(() => 
    theses.value.filter(t => t.status === 'completed')
  )

  // Actions
  async function fetchTheses() {
    loading.value = true
    error.value = null
    
    try {
      const response = await abschlussarbeitenApi.getAll({
        search: searchQuery.value || undefined,
        status: statusFilter.value || undefined
      })
      
      theses.value = response.data.data
    } catch (err: any) {
      error.value = err.response?.data?.errors?.[0] || 'Fehler beim Laden der Abschlussarbeiten'
      console.error('Error fetching theses:', err)
    } finally {
      loading.value = false
    }
  }

  async function fetchThesis(id: number) {
    loading.value = true
    error.value = null
    
    try {
      const response = await abschlussarbeitenApi.getById(id)
      currentThesis.value = response.data.data
      return currentThesis.value
    } catch (err: any) {
      error.value = err.response?.data?.errors?.[0] || 'Fehler beim Laden der Abschlussarbeit'
      console.error('Error fetching thesis:', err)
      return null
    } finally {
      loading.value = false
    }
  }

  async function createThesis(data: Partial<Abschlussarbeit>) {
    loading.value = true
    error.value = null
    
    try {
      const response = await abschlussarbeitenApi.create(data)
      theses.value.unshift(response.data.data)
      return response.data.data
    } catch (err: any) {
      error.value = err.response?.data?.errors?.[0] || 'Fehler beim Erstellen der Abschlussarbeit'
      throw err
    } finally {
      loading.value = false
    }
  }

  async function updateThesis(id: number, data: Partial<Abschlussarbeit>) {
    loading.value = true
    error.value = null
    
    try {
      const response = await abschlussarbeitenApi.update(id, data)
      const index = theses.value.findIndex(t => t.id === id)
      if (index !== -1) {
        theses.value[index] = response.data.data
      }
      if (currentThesis.value?.id === id) {
        currentThesis.value = response.data.data
      }
      return response.data.data
    } catch (err: any) {
      error.value = err.response?.data?.errors?.[0] || 'Fehler beim Aktualisieren der Abschlussarbeit'
      throw err
    } finally {
      loading.value = false
    }
  }

  async function deleteThesis(id: number) {
    loading.value = true
    error.value = null
    
    try {
      await abschlussarbeitenApi.delete(id)
      theses.value = theses.value.filter(t => t.id !== id)
      if (currentThesis.value?.id === id) {
        currentThesis.value = null
      }
    } catch (err: any) {
      error.value = err.response?.data?.errors?.[0] || 'Fehler beim Löschen der Abschlussarbeit'
      throw err
    } finally {
      loading.value = false
    }
  }

  function setSearch(query: string) {
    searchQuery.value = query
    fetchTheses()
  }

  function setStatusFilter(status: string) {
    statusFilter.value = status
    fetchTheses()
  }

  function clearError() {
    error.value = null
  }

  return {
    // State
    theses,
    currentThesis,
    loading,
    error,
    searchQuery,
    statusFilter,
    
    // Getters
    totalTheses,
    pendingTheses,
    inProgressTheses,
    completedTheses,
    
    // Actions
    fetchTheses,
    fetchThesis,
    createThesis,
    updateThesis,
    deleteThesis,
    setSearch,
    setStatusFilter,
    clearError
  }
})
