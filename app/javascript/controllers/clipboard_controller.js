import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="clipboard"
export default class extends Controller {
  static targets = ["button", "anchor"];

  copy() {
    const url = this.anchorTarget.href;
    let status = "Copy";

    try {
      navigator.clipboard.writeText(url);
      status = "Copied!";
    } catch (error) {
      console.error("Failed to copy to clipboard", error);
      status = "Failed";
    }

    this.buttonTarget.innerText = status;
    setTimeout(() => { this.buttonTarget.innerText = "Copy"; }, 300);
  }
}
