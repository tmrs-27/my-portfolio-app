document.addEventListener("turbo:load", () => {
  const html = document.documentElement;
  const darkModeKey = "theme"; // 保存用の名前

  // 1. 保存された設定を最優先。なければOSの設定を見る
  const savedTheme = localStorage.getItem(darkModeKey);
  if (savedTheme === "dark" || (!savedTheme && window.matchMedia("(prefers-color-scheme: dark)").matches)) {
    html.classList.add("dark");
  } else {
    html.classList.remove("dark");
  }

  // 2. ボタンクリック時の処理（手動切り替えを最優先・即保存）
  const toggleBtn = document.getElementById("theme-toggle");
  if (toggleBtn) {
    toggleBtn.addEventListener("click", () => {
      if (html.classList.contains("dark")) {
        html.classList.remove("dark");
        localStorage.setItem(darkModeKey, "light");
      } else {
        html.classList.add("dark");
        localStorage.setItem(darkModeKey, "dark");
      }
    });
  }
});
