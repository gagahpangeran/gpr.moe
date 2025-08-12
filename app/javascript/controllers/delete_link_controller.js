import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="delete-link"
export default class extends Controller {
  static targets = ["confirmation", "button"];

  open() {
    this.confirmationTarget.className = "";
  }

  check(event) {
    const slug = event.target.dataset.slug;
    const value = event.target.value;
    this.buttonTarget.disabled = slug !== value;
  }
}
