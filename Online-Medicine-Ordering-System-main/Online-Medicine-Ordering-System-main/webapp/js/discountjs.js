console.log(" discountjs.js loaded!");

document.addEventListener("DOMContentLoaded", function () {
  const form = document.getElementById("discountForm");

  form.addEventListener("submit", function (e) {
    const percent = parseFloat(document.getElementById("percent").value);
    const startDate = new Date(document.getElementById("startDate").value);
    const endDate = new Date(document.getElementById("endDate").value);

    let errors = [];

    // Percentage check
    if (isNaN(percent) || percent < 1 || percent > 100) {
      errors.push("Discount percentage must be between 1 and 100.");
    }

    // Date validation
    if (startDate >= endDate) {
      errors.push("End date must be after the start date.");
    }

    // If errors found, prevent submit and alert
    if (errors.length > 0) {
      e.preventDefault();
      alert(errors.join("\n"));
    }
  });
});
