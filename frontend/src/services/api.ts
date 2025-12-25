import axios, { type AxiosInstance, type AxiosError } from 'axios'

// API Base URL - in Production über Umgebungsvariable setzen
const API_BASE_URL = import.meta.env.VITE_API_URL || 'http://localhost:3000/api/v1'

// Axios Instance mit Standard-Konfiguration
const apiClient: AxiosInstance = axios.create({
  baseURL: API_BASE_URL,
  headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json'
  },
  timeout: 10000
})

// Request Interceptor für Auth Token (falls benötigt)
apiClient.interceptors.request.use(
  (config) => {
    const token = localStorage.getItem('auth_token')
    if (token) {
      config.headers.Authorization = `Bearer ${token}`
    }
    return config
  },
  (error) => Promise.reject(error)
)

// Response Interceptor für Error Handling
apiClient.interceptors.response.use(
  (response) => response,
  (error: AxiosError) => {
    if (error.response?.status === 401) {
      // Handle unauthorized - redirect to login
      localStorage.removeItem('auth_token')
      window.location.href = '/login'
    }
    return Promise.reject(error)
  }
)

// =====================================================
// API Response Types
// =====================================================

export interface PaginationMeta {
  current_page: number
  total_pages: number
  total_count: number
  per_page: number
}

export interface ApiResponse<T> {
  data: T
  meta?: PaginationMeta
}

export interface ApiError {
  errors: string[]
}

// =====================================================
// Entity Types
// =====================================================

export interface Student {
  id: number
  vorname: string
  nachname: string
  full_name: string
  matrikelnummer: string
  email: string
  geburtsdatum?: string
  created_at: string
  updated_at: string
  abschlussarbeiten?: Abschlussarbeit[]
}

export interface Seminar {
  id: string
  titel: string
  semester?: string
  aufnahmekapazitaet?: number
  praesenzdatum?: string
  ort?: string
  created_at: string
  updated_at: string
}

export interface AbstraktesSeminar {
  id: number
  titel: string
  beschreibung?: string
}

export interface Abschlussarbeit {
  id: number
  titel: string
  beschreibung?: string
  betreuer?: string
  forschungsprojekt?: string
  semester?: string
  matrikelnummer?: string
  studienniveau?: string
  abgabedatum?: string
  anmeldung_pruefungsamt?: string
  status: 'pending' | 'in_progress' | 'completed'
  abstrakte_abschlussarbeit?: AbstrakteAbschlussarbeit
  student?: Student
  created_at: string
  updated_at: string
}

export interface AbstrakteAbschlussarbeit {
  id: number
  titel: string
  beschreibung?: string
}

export interface DashboardStats {
  students: {
    total: number
    recent: number
  }
  seminare: {
    total: number
    active: number
  }
  abschlussarbeiten: {
    total: number
    in_progress: number
    completed: number
  }
}

// =====================================================
// API Service Functions
// =====================================================

// ----- Dashboard -----
export const dashboardApi = {
  getStats: () => 
    apiClient.get<ApiResponse<DashboardStats>>('/dashboard/stats')
}

// ----- Students -----
export const studentsApi = {
  getAll: (params?: { page?: number; per_page?: number; search?: string; sort?: string }) =>
    apiClient.get<ApiResponse<Student[]>>('/students', { params }),
  
  getById: (id: number) =>
    apiClient.get<ApiResponse<Student>>(`/students/${id}`),
  
  create: (data: Partial<Student>) =>
    apiClient.post<ApiResponse<Student>>('/students', { student: data }),
  
  update: (id: number, data: Partial<Student>) =>
    apiClient.patch<ApiResponse<Student>>(`/students/${id}`, { student: data }),
  
  delete: (id: number) =>
    apiClient.delete(`/students/${id}`)
}

// ----- Seminare -----
export const seminareApi = {
  getAll: (params?: { search?: string }) =>
    apiClient.get<ApiResponse<Seminar[]>>('/seminare', { params }),
  
  getById: (id: string) =>
    apiClient.get<ApiResponse<Seminar>>(`/seminare/${id}`),
  
  create: (data: Partial<Seminar>) =>
    apiClient.post<ApiResponse<Seminar>>('/seminare', { seminar: data }),
  
  update: (id: string, data: Partial<Seminar>) =>
    apiClient.patch<ApiResponse<Seminar>>(`/seminare/${id}`, { seminar: data }),
  
  delete: (id: string) =>
    apiClient.delete(`/seminare/${id}`)
}

// ----- Abschlussarbeiten -----
export const abschlussarbeitenApi = {
  getAll: (params?: { search?: string; status?: string }) =>
    apiClient.get<ApiResponse<Abschlussarbeit[]>>('/abschlussarbeiten', { params }),
  
  getById: (id: number) =>
    apiClient.get<ApiResponse<Abschlussarbeit>>(`/abschlussarbeiten/${id}`),
  
  create: (data: Partial<Abschlussarbeit>) =>
    apiClient.post<ApiResponse<Abschlussarbeit>>('/abschlussarbeiten', { abschlussarbeit: data }),
  
  update: (id: number, data: Partial<Abschlussarbeit>) =>
    apiClient.patch<ApiResponse<Abschlussarbeit>>(`/abschlussarbeiten/${id}`, { abschlussarbeit: data }),
  
  delete: (id: number) =>
    apiClient.delete(`/abschlussarbeiten/${id}`)
}

export default apiClient
