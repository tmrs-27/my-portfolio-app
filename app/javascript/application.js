// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "theme"
import "mouse_stalker"

const RUBY_SAMPLE_CODE = `class Engineer
  def initialize
    @name = "Ren"
    @skills = ["Ruby", "Rails", "Docker"]
  end

  def say_hello
    puts "Welcome to my portfolio!"
  end
end

Engineer.new.say_hello`

const escapeHtml = (text) =>
  text
    .replaceAll("&", "&amp;")
    .replaceAll("<", "&lt;")
    .replaceAll(">", "&gt;")
    .replaceAll('"', "&quot;")
    .replaceAll("'", "&#39;")

const highlightRuby = (codeText) => {
  let html = escapeHtml(codeText)
  html = html.replace(/\b(class|def|end|new|puts|initialize)\b/g, '<span class="text-pink-400">$1</span>')
  html = html.replace(/(@\w+)/g, '<span class="text-orange-300">$1</span>')
  html = html.replace(/(&quot;.*?&quot;)/g, '<span class="text-green-300">$1</span>')
  html = html.replace(/\n/g, "<br>")
  return html
}

document.addEventListener("turbo:load", () => {
  const target = document.getElementById("ruby-typing")
  if (!target) return

  let i = 0
  let typed = ""
  target.innerHTML = ""

  const typeWriter = () => {
    if (i >= RUBY_SAMPLE_CODE.length) return

    typed += RUBY_SAMPLE_CODE.charAt(i)
    target.innerHTML = highlightRuby(typed)
    i += 1
    setTimeout(typeWriter, 38)
  }

  setTimeout(typeWriter, 700)
})
