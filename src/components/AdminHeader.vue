<script setup>
import { authenticate } from "@/store/authenticate";
import { onMounted } from 'vue'

const auth = authenticate;

// Sidebar toggle (collapsing the sidebar)
function toggleSidebar() {
  const sidebar = document.getElementById('sidebar-wrapper')
  const content = document.getElementById('page-content-wrapper')

  sidebar?.classList.toggle('collapsed')
  if (sidebar?.classList.contains('collapsed')) {
    content.style.marginLeft = '80px'
  } else {
    content.style.marginLeft = '250px'
  }
}

// Fullscreen toggle
function toggleFullscreen(e) {
  e.preventDefault()
  const btn = document.getElementById('fullscreenBtn')
  const icon = btn.querySelector('i')

  if (!document.fullscreenElement) {
    document.documentElement.requestFullscreen()
    icon.classList.remove('fa-expand')
    icon.classList.add('fa-compress')
  } else {
    document.exitFullscreen()
    icon.classList.remove('fa-compress')
    icon.classList.add('fa-expand')
  }
}

const user = auth.getUser();
</script>

<template>
  <nav class="main-header navbar navbar-expand-lg navbar-light bg-light border-bottom">
    <div class="container-fluid">
      <!-- Offcanvas Menu Toggle -->
      <button
        class="btn"
        id="menu-toggle"
        data-bs-toggle="offcanvas"
        href="#offcanvasSidebar"
        role="button"
        aria-controls="offcanvasSidebar"
      >
        <i class="fas fa-bars"></i>
      </button>

      <!-- Sidebar Collapse Button -->
      <button class="btn" id="sidebarToggle" @click="toggleSidebar">
        <i class="fas fa-bars"></i>
      </button>

      <!-- Right Section -->
      <ul class="list-unstyled d-flex align-items-center mb-0">
        <!-- External Website Link -->
        <!-- <li class="me-3">
          <a href="#" class="text-dark text-decoration-none d-flex align-items-center">
            <i class="fas fa-globe me-1"></i> Go to Website
          </a>
        </li> -->

        <!-- Admin Dropdown -->
        <li class="dropdown ms-3">
        
          <a
            href="#"
            class="text-dark text-decoration-none dropdown-toggle"
            id="adminDropdown"
            data-bs-toggle="dropdown"
            aria-expanded="false"
          >
            <i class="fas fa-user me-1"></i>  {{ user.data.user.name }}
          </a>
          <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="adminDropdown">
            <!-- <li><a class="dropdown-item" href="#">Profile</a></li> -->
            <li><a class="dropdown-item" href="#"  @click.prevent="auth.logout()
                            ">Logout</a></li>
          </ul>
        </li>

        <!-- Fullscreen Toggle -->
        <li class="ms-3">
          <a href="#" class="text-dark text-decoration-none" id="fullscreenBtn" @click="toggleFullscreen">
            <i class="fas fa-expand"></i>
          </a>
        </li>
      </ul>
    </div>
  </nav>
</template>
