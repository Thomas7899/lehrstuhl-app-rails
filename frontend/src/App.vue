<template>
  <div class="app-layout">
    <!-- Sidebar Navigation -->
    <aside class="sidebar" :class="{ open: isSidebarOpen }">
      <div class="sidebar-header">
        <router-link to="/" class="sidebar-logo">
          <div class="sidebar-logo-icon">LS</div>
          <span class="sidebar-logo-text">Lehrstuhl</span>
        </router-link>
      </div>
      
      <nav class="sidebar-nav">
        <div class="nav-section">
          <div class="nav-section-title">Übersicht</div>
          <router-link to="/dashboard" class="nav-link" active-class="active">
            <svg class="nav-link-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <rect x="3" y="3" width="7" height="7" rx="1"/>
              <rect x="14" y="3" width="7" height="7" rx="1"/>
              <rect x="3" y="14" width="7" height="7" rx="1"/>
              <rect x="14" y="14" width="7" height="7" rx="1"/>
            </svg>
            <span>Dashboard</span>
          </router-link>
        </div>

        <div class="nav-section">
          <div class="nav-section-title">Verwaltung</div>
          <router-link to="/students" class="nav-link" active-class="active">
            <svg class="nav-link-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/>
              <circle cx="9" cy="7" r="4"/>
              <path d="M23 21v-2a4 4 0 0 0-3-3.87"/>
              <path d="M16 3.13a4 4 0 0 1 0 7.75"/>
            </svg>
            <span>Studierende</span>
          </router-link>
          
          <router-link to="/seminare" class="nav-link" active-class="active">
            <svg class="nav-link-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <path d="M4 19.5A2.5 2.5 0 0 1 6.5 17H20"/>
              <path d="M6.5 2H20v20H6.5A2.5 2.5 0 0 1 4 19.5v-15A2.5 2.5 0 0 1 6.5 2z"/>
            </svg>
            <span>Seminare</span>
          </router-link>
          
          <router-link to="/theses" class="nav-link" active-class="active">
            <svg class="nav-link-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"/>
              <polyline points="14 2 14 8 20 8"/>
              <line x1="16" y1="13" x2="8" y2="13"/>
              <line x1="16" y1="17" x2="8" y2="17"/>
              <polyline points="10 9 9 9 8 9"/>
            </svg>
            <span>Abschlussarbeiten</span>
          </router-link>
        </div>

        <div class="nav-section">
          <div class="nav-section-title">Assistenz</div>
          <router-link to="/chat" class="nav-link" active-class="active">
            <svg class="nav-link-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z"/>
            </svg>
            <span>KI-Assistent</span>
          </router-link>
        </div>
      </nav>
      
      <div class="sidebar-footer">
        <div class="user-info">
          <div class="user-avatar">TO</div>
          <div class="user-details">
            <div class="user-name">Thomas Osterlehner</div>
            <div class="user-role">Administrator</div>
          </div>
        </div>
      </div>
    </aside>

    <!-- Main Content -->
    <main class="main-content">
      <header class="main-header">
        <div class="header-left">
          <button class="btn btn-ghost mobile-menu-btn" @click="toggleSidebar">
            <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <line x1="3" y1="12" x2="21" y2="12"/>
              <line x1="3" y1="6" x2="21" y2="6"/>
              <line x1="3" y1="18" x2="21" y2="18"/>
            </svg>
          </button>
          <h1 class="page-title">{{ pageTitle }}</h1>
        </div>
        
        <div class="header-right">
          <div class="search-input-wrapper">
            <svg class="search-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <circle cx="11" cy="11" r="8"/>
              <line x1="21" y1="21" x2="16.65" y2="16.65"/>
            </svg>
            <input 
              type="text" 
              class="form-input search-input" 
              placeholder="Suchen..."
              v-model="globalSearch"
              @keyup.enter="handleSearch"
            />
          </div>
        </div>
      </header>
      
      <div class="main-container">
        <RouterView />
      </div>
    </main>
  </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue'
import { useRoute } from 'vue-router'

const route = useRoute()
const isSidebarOpen = ref(false)
const globalSearch = ref('')

const pageTitle = computed(() => {
  const titles: Record<string, string> = {
    dashboard: 'Dashboard',
    students: 'Studierende',
    seminare: 'Seminare',
    theses: 'Abschlussarbeiten',
    chat: 'KI-Assistent'
  }
  return titles[route.name as string] || 'Lehrstuhl App'
})

const toggleSidebar = () => {
  isSidebarOpen.value = !isSidebarOpen.value
}

const handleSearch = () => {
  console.log('Search:', globalSearch.value)
}
</script>

<style scoped>
.sidebar-footer {
  padding: var(--space-4);
  border-top: 1px solid var(--color-neutral-100);
}

.user-info {
  display: flex;
  align-items: center;
  gap: var(--space-3);
}

.user-avatar {
  width: 36px;
  height: 36px;
  border-radius: var(--radius-full);
  background: var(--color-primary-100);
  color: var(--color-primary-700);
  display: flex;
  align-items: center;
  justify-content: center;
  font-weight: var(--font-semibold);
  font-size: var(--text-sm);
}

.user-details {
  flex: 1;
  min-width: 0;
}

.user-name {
  font-size: var(--text-sm);
  font-weight: var(--font-medium);
  color: var(--color-neutral-900);
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

.user-role {
  font-size: var(--text-xs);
  color: var(--color-neutral-500);
}

.header-left {
  display: flex;
  align-items: center;
  gap: var(--space-4);
}

.header-right {
  display: flex;
  align-items: center;
  gap: var(--space-4);
}

.page-title {
  font-size: var(--text-xl);
  font-weight: var(--font-semibold);
  color: var(--color-neutral-900);
}

.mobile-menu-btn {
  display: none;
}

.search-input {
  width: 280px;
}

@media (max-width: 768px) {
  .mobile-menu-btn {
    display: flex;
  }
  
  .search-input-wrapper {
    display: none;
  }
}
</style>