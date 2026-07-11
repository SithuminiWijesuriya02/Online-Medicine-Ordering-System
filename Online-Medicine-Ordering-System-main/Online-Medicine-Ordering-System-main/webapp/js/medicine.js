function openModal(id) {
    const modal = document.getElementById('modal-' + id);
    if (modal) {
      modal.classList.remove('opacity-0', 'pointer-events-none');
      modal.classList.add('opacity-100', 'pointer-events-auto');
    }
  }

  function closeModal(id) {
    const modal = document.getElementById('modal-' + id);
    if (modal) {
      modal.classList.remove('opacity-100', 'pointer-events-auto');
      modal.classList.add('opacity-0', 'pointer-events-none');
    }
  }
  
  let currentMedId = null;
  let currentUnitPrice = 0;

  function showCartModal(medId, medName, unitPrice) {
    currentMedId = medId;
    currentUnitPrice = parseFloat(unitPrice);

    document.getElementById("modalMedName").innerText = medName;
    document.getElementById("modalHiddenMedId").value = medId;
    document.getElementById("cartQtyInputForm").value = 1;
    updateModalPrice();
    document.getElementById("cartModal").classList.remove("hidden");
  }

  function updateModalPrice() {
    const qty = parseInt(document.getElementById("cartQtyInputForm").value || 1);
    document.getElementById("modalPrice").innerText = (currentUnitPrice * qty).toFixed(2);
  }

  function closeCartModal() {
    document.getElementById("cartModal").classList.add("hidden");
  }