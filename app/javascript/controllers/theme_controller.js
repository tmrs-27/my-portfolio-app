import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { current: { type: String, default: "light" } }

  connect() {
    const saved = localStorage.getItem("theme")
    const theme = saved || "light"
    this.applyTheme(theme)
    this.currentValue = theme
    this.updateRadios(theme)
  }

  switch(event) {
    const theme = event.target.value
    this.applyTheme(theme)
    this.currentValue = theme
    localStorage.setItem("theme", theme)
  }

  applyTheme(theme) {
    const html = document.documentElement
    if (theme === "dark") {
      html.classList.add("dark")
    } else {
      html.classList.remove("dark")
    }
  }

  updateRadios(theme) {
    const radios = this.element.querySelectorAll('input[name="theme"]')
    radios.forEach((radio) => {
      radio.checked = radio.value === theme
    })
  }
}
