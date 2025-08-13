import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="clipboard"
export default class extends Controller {
  copy(event) {
    const url = event.target.dataset.text;
    let status = "default";

    try {
      navigator.clipboard.writeText(url);
      status = "success";
    } catch (error) {
      console.error("Failed to copy to clipboard", error);
      status = "failed";
    }

    event.target.className = status;
    setTimeout(() => {
      event.target.className = "default";
    }, 300);
  }
}
