if (
  "IntersectionObserver" in window &&
  "IntersectionObserverEntry" in window &&
  "intersectionRatio" in window.IntersectionObserverEntry.prototype
) {
let observer = new IntersectionObserver(entries => {
  if (entries[0].boundingClientRect.y < 0) {
    document.querySelector('nav').classList.add("header-not-at-top");
    document.querySelector('nav').classList.remove("header-at-top");
  } else {
    if (document.querySelector('nav').classList.contains("header-not-at-top")){
      document.querySelector('nav').classList.add("header-at-top");
    }
    document.querySelector('nav').classList.remove("header-not-at-top");
  }
});
observer.observe(document.querySelector("#top-of-site-pixel-anchor"));
}