import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="clipboard"
export default class extends Controller {
  copy(event) {
    const url = event.target.dataset.text;
    let status = "Copy";

    try {
      navigator.clipboard.writeText(url);
      status = "Copied!";
    } catch (error) {
      console.error("Failed to copy to clipboard", error);
      status = "Failed";
    }

    event.target.innerText = status;
    setTimeout(() => { event.target.innerText = "Copy"; }, 300);
  }
}
