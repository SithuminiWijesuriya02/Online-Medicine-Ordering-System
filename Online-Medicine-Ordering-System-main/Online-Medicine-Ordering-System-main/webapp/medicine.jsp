<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>MediQuick - Medicine</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
</head>
<body class="bg-blue-50 text-[#333] font-sans font-medium tracking-wide min-h-screen flex flex-col pt-20">

  <%@ include file="./partials/navBar.jsp" %>

  <!-- Enhanced Filters Section -->
  <section class="bg-blue-800 py-8 shadow-lg relative overflow-hidden">
    <!-- Background Pattern -->
    <div class="absolute inset-0 opacity-10">
      <div class="absolute inset-0" style="background-image: radial-gradient(circle at 25% 25%, white 2px, transparent 2px), radial-gradient(circle at 75% 75%, white 2px, transparent 2px); background-size: 50px 50px;"></div>
    </div>
    
    <div class="max-w-7xl mx-auto px-6 relative z-10">
      <div class="text-center mb-8">
        <h1 class="text-4xl font-bold text-white mb-2">
          <i class="fas fa-pills mr-3"></i>Find Your Medicine
        </h1>
        <p class="text-blue-100 text-lg">Discover quality healthcare solutions at your fingertips</p>
      </div>
      
      <div class="bg-white/10 backdrop-blur-sm rounded-2xl p-6 border border-white/20">
        <div class="flex flex-wrap gap-4 items-center justify-between">
          <div class="flex flex-wrap gap-4">
            <select id="categoryFilter" class="px-4 py-3 bg-white/90 backdrop-blur-sm border-2 border-white/30 rounded-xl focus:outline-none focus:ring-2 focus:ring-white focus:border-transparent transition-all duration-300 font-medium">
              <option value="">All Categories</option>
              <option value="Painkiller">Pain Relief</option>
              <option value="Antibiotic">Antibiotics</option>
              <option value="Vitamin">Vitamins</option>
              <option value="Supplement">Supplements</option>
              <option value="Cough & Cold">Cough & Cold</option>
              <option value="Diabetes">Diabetes</option>
            </select>
            
            <select id="priceFilter" class="px-4 py-3 bg-white/90 backdrop-blur-sm border-2 border-white/30 rounded-xl focus:outline-none focus:ring-2 focus:ring-white focus:border-transparent transition-all duration-300 font-medium">
              <option value="">All Prices</option>
              <option value="0-10">$0 - $10</option>
              <option value="10-25">$10 - $25</option>
              <option value="25-50">$25 - $50</option>
              <option value="50+">$50+</option>
            </select>
            
            <button id="prescriptionFilter" class="px-6 py-3 bg-white/20 hover:bg-white/30 border-2 border-white/30 rounded-xl transition-all duration-300 text-white font-medium backdrop-blur-sm">
              <i class="fas fa-prescription-bottle mr-2"></i>Prescription Only
            </button>
          </div>
          
          <div class="flex items-center gap-3">
            <span class="text-white font-medium">Sort by:</span>
            <select id="sortFilter" class="px-4 py-3 bg-white/90 backdrop-blur-sm border-2 border-white/30 rounded-xl focus:outline-none focus:ring-2 focus:ring-white focus:border-transparent transition-all duration-300 font-medium">
              <option value="name">Name A-Z</option>
              <option value="price-low">Price: Low to High</option>
              <option value="price-high">Price: High to Low</option>
              <option value="stock">Stock Level</option>
            </select>
          </div>
        </div>
      </div>
    </div>
  </section>

  <main class="flex-grow mt-8">
    <div class="max-w-7xl mx-auto px-6 py-6">
      <!-- Results Header -->
      <div class="flex justify-between items-center mb-8">
        <div>
          <h2 class="text-3xl font-bold text-blue-600">
            Our Medicine Collection
          </h2>
          <p class="text-gray-600 mt-1">Premium quality medicines for your health needs</p>
        </div>
      </div>

      <!-- Enhanced Medicine Grid -->
      <div id="medicineGrid" class="grid gap-8 grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4">
        <c:forEach var="medicine" items="${allMedicines}">
          <div class="transition-transform duration-500 hover:-translate-y-2 hover:shadow-2xl bg-white rounded-2xl shadow-lg hover:shadow-2xl overflow-hidden border border-gray-100 group cursor-pointer"
               data-category="${medicine.category}"
		       data-price="${medicine.unitPrice}"
		       data-name="${medicine.medName}"
		       data-brand="${medicine.brand}">
            
            <!-- Image Section with Enhanced Styling -->
            <div class="relative h-64 overflow-hidden bg-gradient-to-br from-gray-50 to-gray-100 flex items-center justify-center">
              <img src="medicineImage?id=${medicine.medId}" 
                   alt="${medicine.medName}" 
                   class="w-full h-full object-contain group-hover:scale-105 transition-transform duration-500" 
                   onerror="this.onerror=null; this.src='assets/default-med.png';" />
              
              <!-- Category & Stock Badge -->
			  <div class="absolute top-4 right-4 space-y-1 flex flex-col items-end">
			    <span class="bg-blue-500 text-white text-xs px-3 py-1 rounded-full font-bold shadow-lg">
			      ${medicine.category}
			    </span>
			  
			    <c:if test="${medicine.quantity == 0}">
			      <span class="animate-pulse bg-red-600 text-white text-xs px-3 py-1 rounded-full font-bold shadow-lg stock-badge">
			        Out of Stock
			      </span>
			    </c:if>
			  </div>
            </div>

            <!-- Enhanced Card Content -->
            <div class="p-6">
              <!-- Medicine Info -->
              <div class="mb-4">
                <h3 class="text-xl font-bold text-blue-600 mb-1 group-hover:text-blue-700 transition-colors duration-300">
                  ${medicine.medName}
                </h3>
                <p class="text-gray-500 font-medium mb-3">${medicine.brand}</p>
                
                <div class="flex items-center gap-3 mb-3">
                  <span class="bg-blue-50 text-blue-700 text-sm px-3 py-1 rounded-full font-medium border border-blue-200">
                    ${medicine.type}
                  </span>
                  <c:if test="${not empty medicine.dosage}">
                    <span class="text-gray-600 text-sm font-medium">
                      ${medicine.dosage}mg
                    </span>
                  </c:if>
                </div>
                
                <p class="text-gray-600 text-sm leading-relaxed mb-4">${medicine.description}</p>
              </div>
              
              <!-- Price Section -->
              <div class="flex justify-between items-end mb-4">
                <div>
                  <span class="text-3xl font-bold text-blue-600" style="text-shadow: 0 0 20px rgba(30, 136, 229, 0.5)">$${medicine.unitPrice}</span>
				</div>
              </div>
              
              <!-- Add to Cart Button -->
              <button type="button"
                      onclick="event.stopPropagation(); showCartModal('${medicine.medId}', '${medicine.medName}', '${medicine.unitPrice}')"
                      class="w-full bg-[#1D8DFB] hover:bg-blue-700 text-white py-3 px-4 rounded-xl font-semibold transition-all duration-300 shadow-lg hover:shadow-xl transform hover:scale-105 disabled:opacity-50 disabled:cursor-not-allowed disabled:transform-none"
                      ${medicine.quantity == 0 ? 'disabled' : ''}>
                <i class="fas fa-shopping-cart mr-2"></i>Add to Cart
              </button>
            </div>
          </div>
         </c:forEach>
                
      
      <!-- No Medicines Found -->
      <c:if test="${empty allMedicines}">
        <div class="text-center py-16">
          <div class="w-32 h-32 bg-gradient-to-br from-blue-100 to-purple-100 rounded-full flex items-center justify-center mx-auto mb-6">
            <i class="fas fa-pills text-blue-400 text-4xl"></i>
          </div>
          <h3 class="text-2xl font-bold text-gray-600 mb-2">No medicines found</h3>
          <p class="text-gray-500">Please check back later or contact us for assistance.</p>
        </div>
      </c:if>
    </div>
    </div>
  </main>

  <!-- Enhanced Cart Modal -->
  <div id="cartModal" class="fixed inset-0 hidden bg-black/60 backdrop-blur-sm z-50 flex items-center justify-center">
    <div class="bg-white p-8 rounded-2xl shadow-2xl w-[28rem] border border-gray-200">
      <div class="text-center mb-6">
        <div class="w-16 h-16 bg-blue-600 rounded-full flex items-center justify-center mx-auto mb-4">
          <i class="fas fa-cart-plus text-white text-2xl"></i>
        </div>
        <h2 class="text-2xl font-bold text-gray-800 mb-2">Add to Cart</h2>
        <p id="modalMedName" class="text-gray-600 font-medium">Medicine Name</p>
      </div>
      
      <hr class="mb-6 border-gray-200" />

      <form action="createCart" method="post" class="space-y-6">
        <input type="hidden" name="medId" id="modalHiddenMedId" />

        <div class="text-center">
          <label for="cartQtyInputForm" class="block text-sm font-semibold text-gray-700 mb-3">Select Quantity:</label>
          <input type="number" name="quantity" id="cartQtyInputForm"
                 class="border-2 border-gray-200 rounded-xl px-4 py-3 text-center w-32 mx-auto focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all duration-300"
                 value="1" min="1" max="10" required
                 oninput="updateModalPrice()" />
        </div>

        <div class="text-center bg-blue-50 rounded-xl p-4">
          <p class="text-gray-600 mb-2">Total Price:</p>
          <p class="text-4xl font-bold text-blue-600">
            $<span id="modalPrice">0.00</span>
          </p>
        </div>

        <div class="flex gap-3">
          <button type="submit" class="flex-1 bg-blue-600 hover:bg-blue-700 text-white px-6 py-3 rounded-xl font-semibold transition-all duration-300 shadow-lg hover:shadow-xl transform hover:scale-105">
            <i class="fas fa-cart-plus mr-2"></i>Add to Cart
          </button>
          <button type="button" onclick="closeCartModal()" class="px-6 py-3 bg-gray-100 hover:bg-gray-200 border border-gray-300 rounded-xl transition-all duration-300 font-semibold text-gray-700">
            Cancel
          </button>
        </div>
      </form>
    </div>
  </div>

  <%@ include file="./partials/footer.jsp" %>
  
  <script>
    let currentMedPrice = 0;
    let prescriptionFilterActive = false;

    // Cart Modal Functions
    function showCartModal(medId, medName, price) {
      document.getElementById('modalHiddenMedId').value = medId;
      document.getElementById('modalMedName').textContent = medName;
      currentMedPrice = parseFloat(price);
      updateModalPrice();
      
      const modal = document.getElementById('cartModal');
      modal.classList.remove('hidden');
      setTimeout(() => modal.querySelector('.bg-white').classList.add('modal-enter'), 10);
    }

    function closeCartModal() {
      const modal = document.getElementById('cartModal');
      modal.querySelector('.bg-white').classList.add('modal-exit');
      setTimeout(() => {
        modal.classList.add('hidden');
        modal.querySelector('.bg-white').classList.remove('modal-enter', 'modal-exit');
      }, 300);
    }

    function updateModalPrice() {
      const quantity = document.getElementById('cartQtyInputForm').value;
      const totalPrice = (currentMedPrice * quantity).toFixed(2);
      document.getElementById('modalPrice').textContent = totalPrice;
    }

    // Filter Functions
    function togglePrescriptionFilter() {
      prescriptionFilterActive = !prescriptionFilterActive;
      const btn = document.getElementById('prescriptionFilter');
      
      if (prescriptionFilterActive) {
        btn.classList.add('bg-white/40');
        btn.classList.remove('bg-white/20');
      } else {
        btn.classList.remove('bg-white/40');
        btn.classList.add('bg-white/20');
      }
      
      applyFilters();
    }

    function applyFilters() {
      const categoryFilter = document.getElementById('categoryFilter').value;
      const priceFilter = document.getElementById('priceFilter').value;
      const sortFilter = document.getElementById('sortFilter').value;
      
      const medicineCards = Array.from(document.querySelectorAll('.medicine-card'));
      let visibleCount = 0;
      
      medicineCards.forEach(card => {
        let show = true;
        
        // Category filter
        if (categoryFilter && card.dataset.category !== categoryFilter) {
          show = false;
        }
        
        // Price filter
        if (priceFilter) {
          const price = parseFloat(card.dataset.price);
          const [min, max] = priceFilter.split('-').map(p => p.replace('+', ''));
          
          if (priceFilter.includes('+')) {
            if (price < parseFloat(min)) show = false;
          } else {
            if (price < parseFloat(min) || price > parseFloat(max)) show = false;
          }
        }
        
        if (show) {
          card.style.display = 'block';
          visibleCount++;
        } else {
          card.style.display = 'none';
        }
      });
      
      // Sort visible cards
      const visibleCards = medicineCards.filter(card => card.style.display !== 'none');
      sortMedicines(visibleCards, sortFilter);
      
      // Update count
      document.getElementById('medicineCount').textContent = visibleCount;
    }

    function sortMedicines(cards, sortBy) {
      const container = document.getElementById('medicineGrid');
      
      cards.sort((a, b) => {
        switch (sortBy) {
          case 'name':
            return a.dataset.name.localeCompare(b.dataset.name);
          case 'price-low':
            return parseFloat(a.dataset.price) - parseFloat(b.dataset.price);
          case 'price-high':
            return parseFloat(b.dataset.price) - parseFloat(a.dataset.price);
            default:
            return 0;
        }
      });
      
      // Re-append sorted cards
      cards.forEach(card => container.appendChild(card));
    }

    // Event Listeners
      document.addEventListener('DOMContentLoaded', function() {
      document.getElementById('categoryFilter').addEventListener('change', applyFilters);
      document.getElementById('priceFilter').addEventListener('change', applyFilters);
      document.getElementById('sortFilter').addEventListener('change', applyFilters);
      document.getElementById('prescriptionFilter').addEventListener('click', togglePrescriptionFilter);
      
      // Initialize
      applyFilters();
    });

    // Close modals with Escape key
    document.addEventListener('keydown', function(e) {
      if (e.key === 'Escape') {
        closeCartModal();       
      }
    });
  </script>
</body>
</html>