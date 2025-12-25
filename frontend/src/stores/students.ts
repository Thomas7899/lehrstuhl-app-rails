import { defineStore } from 'pinia'
import { ref, computed } from 'vue'
import { studentsApi, type Student, type PaginationMeta } from '@/services/api'

export const useStudentsStore = defineStore('students', () => {
  // State
  const students = ref<Student[]>([])
  const currentStudent = ref<Student | null>(null)
  const meta = ref<PaginationMeta | null>(null)
  const loading = ref(false)
  const error = ref<string | null>(null)
  
  // Filters
  const searchQuery = ref('')
  const sortBy = ref('created_at')
  const currentPage = ref(1)
  const perPage = ref(20)

  // Getters
  const totalStudents = computed(() => meta.value?.total_count ?? 0)
  const totalPages = computed(() => meta.value?.total_pages ?? 1)
  const hasNextPage = computed(() => currentPage.value < totalPages.value)
  const hasPrevPage = computed(() => currentPage.value > 1)

  // Actions
  async function fetchStudents() {
    loading.value = true
    error.value = null
    
    try {
      const response = await studentsApi.getAll({
        page: currentPage.value,
        per_page: perPage.value,
        search: searchQuery.value || undefined,
        sort: sortBy.value
      })
      
      students.value = response.data.data
      meta.value = response.data.meta ?? null
    } catch (err: any) {
      error.value = err.response?.data?.errors?.[0] || 'Fehler beim Laden der Studierenden'
      console.error('Error fetching students:', err)
    } finally {
      loading.value = false
    }
  }

  async function fetchStudent(id: number) {
    loading.value = true
    error.value = null
    
    try {
      const response = await studentsApi.getById(id)
      currentStudent.value = response.data.data
      return currentStudent.value
    } catch (err: any) {
      error.value = err.response?.data?.errors?.[0] || 'Fehler beim Laden des Studierenden'
      console.error('Error fetching student:', err)
      return null
    } finally {
      loading.value = false
    }
  }

  async function createStudent(data: Partial<Student>) {
    loading.value = true
    error.value = null
    
    try {
      const response = await studentsApi.create(data)
      students.value.unshift(response.data.data)
      return response.data.data
    } catch (err: any) {
      error.value = err.response?.data?.errors?.[0] || 'Fehler beim Erstellen des Studierenden'
      throw err
    } finally {
      loading.value = false
    }
  }

  async function updateStudent(id: number, data: Partial<Student>) {
    loading.value = true
    error.value = null
    
    try {
      const response = await studentsApi.update(id, data)
      const index = students.value.findIndex(s => s.id === id)
      if (index !== -1) {
        students.value[index] = response.data.data
      }
      if (currentStudent.value?.id === id) {
        currentStudent.value = response.data.data
      }
      return response.data.data
    } catch (err: any) {
      error.value = err.response?.data?.errors?.[0] || 'Fehler beim Aktualisieren des Studierenden'
      throw err
    } finally {
      loading.value = false
    }
  }

  async function deleteStudent(id: number) {
    loading.value = true
    error.value = null
    
    try {
      await studentsApi.delete(id)
      students.value = students.value.filter(s => s.id !== id)
      if (currentStudent.value?.id === id) {
        currentStudent.value = null
      }
    } catch (err: any) {
      error.value = err.response?.data?.errors?.[0] || 'Fehler beim Löschen des Studierenden'
      throw err
    } finally {
      loading.value = false
    }
  }

  function setSearch(query: string) {
    searchQuery.value = query
    currentPage.value = 1
    fetchStudents()
  }

  function setSort(sort: string) {
    sortBy.value = sort
    fetchStudents()
  }

  function setPage(page: number) {
    currentPage.value = page
    fetchStudents()
  }

  function nextPage() {
    if (hasNextPage.value) {
      setPage(currentPage.value + 1)
    }
  }

  function prevPage() {
    if (hasPrevPage.value) {
      setPage(currentPage.value - 1)
    }
  }

  function clearError() {
    error.value = null
  }

  return {
    // State
    students,
    currentStudent,
    meta,
    loading,
    error,
    searchQuery,
    sortBy,
    currentPage,
    perPage,
    
    // Getters
    totalStudents,
    totalPages,
    hasNextPage,
    hasPrevPage,
    
    // Actions
    fetchStudents,
    fetchStudent,
    createStudent,
    updateStudent,
    deleteStudent,
    setSearch,
    setSort,
    setPage,
    nextPage,
    prevPage,
    clearError
  }
})
