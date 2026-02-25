const MOUSE_STALKER_ROOT_ID = "mouse-stalker";

function shouldEnableMouseStalker() {
  const hasFinePointer = window.matchMedia("(pointer: fine)").matches;
  const reducedMotion = window.matchMedia("(prefers-reduced-motion: reduce)").matches;
  return hasFinePointer && !reducedMotion;
}

function setupMouseStalker() {
  const root = document.getElementById(MOUSE_STALKER_ROOT_ID);
  if (!root || root.dataset.initialized === "true") return;
  if (!shouldEnableMouseStalker()) return;

  const ring = root.querySelector("[data-stalker-ring]");
  const dot = root.querySelector("[data-stalker-dot]");
  if (!ring || !dot) return;

  root.dataset.initialized = "true";
  document.body.classList.add("mouse-stalker-enabled");

  let mouseX = window.innerWidth / 2;
  let mouseY = window.innerHeight / 2;
  let ringX = mouseX;
  let ringY = mouseY;
  let rafId = null;

  const updateHoverState = (target) => {
    const interactive = target.closest("a, button, [role='button'], input, textarea, select, label");
    root.classList.toggle("is-hover", !!interactive);
  };

  const animate = () => {
    ringX += (mouseX - ringX) * 0.18;
    ringY += (mouseY - ringY) * 0.18;

    ring.style.transform = `translate3d(${ringX}px, ${ringY}px, 0)`;
    dot.style.transform = `translate3d(${mouseX}px, ${mouseY}px, 0)`;

    rafId = window.requestAnimationFrame(animate);
  };

  const onMove = (event) => {
    mouseX = event.clientX;
    mouseY = event.clientY;
    root.classList.add("is-visible");
    updateHoverState(event.target);
  };

  const onLeave = () => {
    root.classList.remove("is-visible", "is-hover");
  };

  const onMouseOver = (event) => updateHoverState(event.target);

  document.addEventListener("mousemove", onMove);
  document.addEventListener("mouseover", onMouseOver);
  document.addEventListener("mouseleave", onLeave);

  animate();

  document.addEventListener("turbo:before-cache", () => {
    if (rafId) window.cancelAnimationFrame(rafId);
    document.removeEventListener("mousemove", onMove);
    document.removeEventListener("mouseover", onMouseOver);
    document.removeEventListener("mouseleave", onLeave);
    document.body.classList.remove("mouse-stalker-enabled");
    root.dataset.initialized = "false";
  }, { once: true });
}

document.addEventListener("turbo:load", setupMouseStalker);
