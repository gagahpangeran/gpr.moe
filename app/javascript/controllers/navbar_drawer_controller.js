import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="navbar-drawer"
export default class extends Controller {
  static targets = ["menu"];

  toggle() {
    const state = this.menuTarget.dataset.mobileState;
    this.menuTarget.dataset.mobileState = state === "close" ? "open" : "close";
  }
}
