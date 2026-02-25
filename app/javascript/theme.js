const THEME_KEY = "theme";

function readSavedTheme() {
  try {
    return localStorage.getItem(THEME_KEY);
  } catch (_error) {
    return null;
  }
}

function saveTheme(theme) {
  try {
    localStorage.setItem(THEME_KEY, theme);
  } catch (_error) {
    // localStorage が使えない環境でも見た目の切替だけは継続する
  }
}

function applyThemeClass(theme) {
  document.documentElement.classList.toggle("dark", theme === "dark");
}

function resolveInitialTheme() {
  const savedTheme = readSavedTheme();
  if (savedTheme === "dark" || savedTheme === "light") return savedTheme;
  return window.matchMedia("(prefers-color-scheme: dark)").matches ? "dark" : "light";
}

function toggleTheme() {
  const nextTheme = document.documentElement.classList.contains("dark") ? "light" : "dark";
  applyThemeClass(nextTheme);
  saveTheme(nextTheme);
}

function bindThemeToggle() {
  const toggleBtn = document.getElementById("theme-toggle");
  if (!toggleBtn || toggleBtn.dataset.themeBound === "true") return;

  toggleBtn.dataset.themeBound = "true";
  toggleBtn.addEventListener("click", toggleTheme);
}

function initializeTheme() {
  applyThemeClass(resolveInitialTheme());
  bindThemeToggle();
}

initializeTheme();
document.addEventListener("turbo:load", initializeTheme);
