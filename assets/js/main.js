/**
 * Shieldcore Security - Main JavaScript
 */

document.addEventListener('DOMContentLoaded', () => {
  initTheme();
  initNavigation();
  initThreeJSHero();
  initBackToTop();
});

/**
 * Theme Management (Dark/Light Mode)
 */
function initTheme() {
  const themeToggle = document.getElementById('theme-toggle');
  if (!themeToggle) return;

  const currentTheme = localStorage.getItem('theme') || 'dark';
  document.documentElement.setAttribute('data-theme', currentTheme);
  updateThemeIcon(currentTheme);

  themeToggle.addEventListener('click', () => {
    const isDark = document.documentElement.getAttribute('data-theme') === 'dark';
    const newTheme = isDark ? 'light' : 'dark';

    document.documentElement.setAttribute('data-theme', newTheme);
    localStorage.setItem('theme', newTheme);
    updateThemeIcon(newTheme);
  });
}

function updateThemeIcon(theme) {
  const icon = document.querySelector('#theme-toggle i');
  if (!icon) return;

  if (theme === 'dark') {
    icon.classList.remove('fa-moon');
    icon.classList.add('fa-sun');
  } else {
    icon.classList.remove('fa-sun');
    icon.classList.add('fa-moon');
  }
}

/**
 * Navigation Logic
 */
function initNavigation() {
  const mobileMenuToggle = document.getElementById('mobile-menu-toggle');
  const mobileNavPanel = document.getElementById('mobile-nav-panel');
  const overlay = document.getElementById('nav-overlay');

  if (mobileMenuToggle && mobileNavPanel && overlay) {
    mobileMenuToggle.addEventListener('click', () => {
      mobileNavPanel.classList.toggle('active');
      overlay.classList.toggle('active');
      document.body.classList.toggle('no-scroll');
    });

    overlay.addEventListener('click', () => {
      mobileNavPanel.classList.remove('active');
      overlay.classList.remove('active');
      document.body.classList.remove('no-scroll');
    });

    const mobileMenuClose = document.getElementById('mobile-menu-close');
    if (mobileMenuClose) {
      mobileMenuClose.addEventListener('click', () => {
        mobileNavPanel.classList.remove('active');
        overlay.classList.remove('active');
        document.body.classList.remove('no-scroll');
      });
    }
  }

  // Mobile Accordion Logic
  const accordionToggles = document.querySelectorAll('.mobile-dropdown-toggle');
  accordionToggles.forEach(toggle => {
    toggle.addEventListener('click', (e) => {
      e.preventDefault();
      const content = toggle.nextElementSibling;
      const icon = toggle.querySelector('i');

      content.classList.toggle('active');
      if (content.classList.contains('active')) {
        content.style.maxHeight = content.scrollHeight + 'px';
        icon.style.transform = 'rotate(180deg)';
      } else {
        content.style.maxHeight = '0px';
        icon.style.transform = 'rotate(0deg)';
      }
    });
  });

  // Active state for nav links on click
  const navLinks = document.querySelectorAll('.nav-links a, .mobile-links a');
  navLinks.forEach(link => {
    link.addEventListener('click', function() {
      // Don't apply to dropdown toggles
      if (this.classList.contains('mobile-dropdown-toggle')) return;
      if (this.nextElementSibling && this.nextElementSibling.classList.contains('dropdown-menu-custom')) return;
      
      navLinks.forEach(a => a.classList.remove('active'));
      this.classList.add('active');
    });
  });
}

/**
 * Three.js Hero Setup
 */
function initThreeJSHero() {
  const container = document.getElementById('three-canvas-container');
  if (!container || typeof THREE === 'undefined') return;

  const prefersReducedMotion = window.matchMedia('(prefers-reduced-motion: reduce)').matches;

  // Scene Setup
  const scene = new THREE.Scene();

  // Camera Setup
  const camera = new THREE.PerspectiveCamera(75, window.innerWidth / window.innerHeight, 0.1, 1000);
  camera.position.z = 30;

  // Renderer Setup
  const renderer = new THREE.WebGLRenderer({ alpha: true, antialias: true });
  renderer.setSize(window.innerWidth, window.innerHeight);
  renderer.setPixelRatio(Math.min(window.devicePixelRatio, 2)); // Adaptive pixel ratio
  container.appendChild(renderer.domElement);

  // Lighting
  const ambientLight = new THREE.AmbientLight(0xffffff, 0.5);
  scene.add(ambientLight);

  const pointLight = new THREE.PointLight(0xF4C95D, 2, 100);
  pointLight.position.set(0, 0, 10);
  scene.add(pointLight);

  // Central Shield Geometry (Basic representation for now)
  const shieldGeometry = new THREE.IcosahedronGeometry(8, 1);
  const shieldMaterial = new THREE.MeshStandardMaterial({
    color: 0x07111F,
    emissive: 0x0D1B2A,
    wireframe: true,
    transparent: true,
    opacity: 0.8
  });
  const shield = new THREE.Mesh(shieldGeometry, shieldMaterial);
  scene.add(shield);

  // Security Ring
  const ringGeometry = new THREE.TorusGeometry(12, 0.1, 16, 100);
  const ringMaterial = new THREE.MeshBasicMaterial({
    color: 0xF4C95D,
    transparent: true,
    opacity: 0.5
  });
  const ring = new THREE.Mesh(ringGeometry, ringMaterial);
  scene.add(ring);

  // Particles (Glitter)
  const particleCount = prefersReducedMotion ? 100 : (window.innerWidth < 768 ? 200 : 800);
  const particlesGeometry = new THREE.BufferGeometry();
  const particlesPosArray = new Float32Array(particleCount * 3);

  for (let i = 0; i < particleCount * 3; i++) {
    particlesPosArray[i] = (Math.random() - 0.5) * 60;
  }

  particlesGeometry.setAttribute('position', new THREE.BufferAttribute(particlesPosArray, 3));
  const particlesMaterial = new THREE.PointsMaterial({
    size: 0.15,
    color: 0xF4C95D,
    transparent: true,
    opacity: 0.8,
    blending: THREE.AdditiveBlending
  });

  const particlesMesh = new THREE.Points(particlesGeometry, particlesMaterial);
  scene.add(particlesMesh);

  // Mouse Interaction
  let mouseX = 0;
  let mouseY = 0;
  let targetX = 0;
  let targetY = 0;

  const windowHalfX = window.innerWidth / 2;
  const windowHalfY = window.innerHeight / 2;

  document.addEventListener('mousemove', (event) => {
    mouseX = (event.clientX - windowHalfX);
    mouseY = (event.clientY - windowHalfY);
  });

  // Animation Loop
  const clock = new THREE.Clock();

  function animate() {
    requestAnimationFrame(animate);

    const elapsedTime = clock.getElapsedTime();

    if (!prefersReducedMotion) {
      // Rotation
      shield.rotation.y = elapsedTime * 0.2;
      shield.rotation.x = elapsedTime * 0.1;

      ring.rotation.x = Math.PI / 2 + Math.sin(elapsedTime * 0.5) * 0.2;
      ring.rotation.y = elapsedTime * 0.1;

      particlesMesh.rotation.y = -elapsedTime * 0.05;

      // Mouse Parallax
      targetX = mouseX * 0.001;
      targetY = mouseY * 0.001;

      shield.rotation.y += 0.05 * (targetX - shield.rotation.y);
      shield.rotation.x += 0.05 * (targetY - shield.rotation.x);

      camera.position.x += (mouseX * 0.005 - camera.position.x) * 0.05;
      camera.position.y += (-mouseY * 0.005 - camera.position.y) * 0.05;
      camera.lookAt(scene.position);
    }

    renderer.render(scene, camera);
  }

  animate();

  // Resize Handler
  window.addEventListener('resize', () => {
    camera.aspect = window.innerWidth / window.innerHeight;
    camera.updateProjectionMatrix();
    renderer.setSize(window.innerWidth, window.innerHeight);
  });
}

/**
 * Interactions and Animations
 */
document.addEventListener('DOMContentLoaded', () => {
  initCounters();
  initScrollAnimations();
  initMagneticButtons();
});

function initCounters() {
  const counters = document.querySelectorAll('.counter');

  const observerOptions = {
    threshold: 0.5
  };

  const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
      if (entry.isIntersecting) {
        const counter = entry.target;
        const target = +counter.getAttribute('data-target');

        let start = 0;
        const duration = 2000;
        const increment = target / (duration / 16); // 60fps

        const updateCounter = () => {
          start += increment;
          if (start < target) {
            counter.innerText = Math.ceil(start);
            requestAnimationFrame(updateCounter);
          } else {
            counter.innerText = target;
          }
        };

        updateCounter();
        observer.unobserve(counter);
      }
    });
  }, observerOptions);

  counters.forEach(counter => {
    observer.observe(counter);
  });
}

function initScrollAnimations() {
  const elements = document.querySelectorAll('.service-card, .industry-row, .process-step, .stat-card');

  elements.forEach(el => {
    el.style.opacity = '0';
    el.style.transform = 'translateY(30px)';
    el.style.transition = 'opacity 0.6s ease, transform 0.6s ease';
  });

  const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
      if (entry.isIntersecting) {
        entry.target.style.opacity = '1';
        entry.target.style.transform = 'translateY(0)';

        if (entry.target.classList.contains('process-step')) {
          setTimeout(() => {
            entry.target.classList.add('active');
            const nextLine = entry.target.nextElementSibling;
            if (nextLine && nextLine.classList.contains('process-line')) {
              nextLine.classList.add('active');
            }
          }, 300);
        }

        observer.unobserve(entry.target);
      }
    });
  }, { threshold: 0.2 });

  elements.forEach(el => {
    observer.observe(el);
  });
}

function initMagneticButtons() {
  const magnets = document.querySelectorAll('.cta-magnetic');
  const prefersReducedMotion = window.matchMedia('(prefers-reduced-motion: reduce)').matches;

  if (prefersReducedMotion) return;

  magnets.forEach(magnet => {
    magnet.addEventListener('mousemove', (e) => {
      const rect = magnet.getBoundingClientRect();
      const x = e.clientX - rect.left - rect.width / 2;
      const y = e.clientY - rect.top - rect.height / 2;

      magnet.style.transform = `translate(${x * 0.2}px, ${y * 0.2}px)`;
    });

    magnet.addEventListener('mouseleave', () => {
      magnet.style.transform = `translate(0px, 0px)`;
    });
  });
}

function initBackToTop() {
  const backToTop = document.getElementById('back-to-top');
  if (!backToTop) return;

  window.addEventListener('scroll', () => {
    if (window.scrollY > 300) {
      backToTop.classList.add('active');
    } else {
      backToTop.classList.remove('active');
    }
  });

  backToTop.addEventListener('click', (e) => {
    e.preventDefault();
    window.scrollTo({
      top: 0,
      behavior: 'smooth'
    });
  });
}
