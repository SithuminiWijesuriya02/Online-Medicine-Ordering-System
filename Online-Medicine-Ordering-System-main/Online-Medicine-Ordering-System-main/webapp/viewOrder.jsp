<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>MediQuick - My Orders</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
  <style>
    .order-card.hidden {
      display: none !important;
    }    
    .fade-in {
	  animation: fadeIn 0.3s ease-in-out;
	}  
    .filter-active {
      background: linear-gradient(to right, #3b82f6, #1d4ed8);
      color: white;
    }
    .filter-btn.filter-active {
	  background: linear-gradient(to right, #3b82f6, #1d4ed8);
	  color: white;
	  border-color: transparent;
	  box-shadow: 0 4px 10px rgba(59, 130, 246, 0.3); 
	  transform: scale(1.05);
	}
	.modal-backdrop {
	  backdrop-filter: blur(8px);
	  background: rgba(0, 0, 0, 0.5);
	}
	.modal-content {
	  animation: modalSlideIn 0.3s ease-out;
	}
	@keyframes modalSlideIn {
	  from {
	    opacity: 0;
	    transform: translateY(-50px) scale(0.9);
	  }
	  to {
	    opacity: 1;
	    transform: translateY(0) scale(1);
	  }
	}
  </style>
</head>
<body class="bg-[#ecf1fc] via-purple-50 to-pink-50 text-[#333] font-sans tracking-wide min-h-screen">

  <!-- Navigation Bar -->
  <%@ include file="./partials/navBar.jsp" %>

  <!-- Background Pattern -->
  <div class="fixed inset-0 opacity-5 pointer-events-none">
    <div class="absolute inset-0" style="background-image: radial-gradient(circle at 25px 25px, #3b82f6 2px, transparent 0), radial-gradient(circle at 75px 75px, #1d4ed8 2px, transparent 0); background-size: 100px 100px;"></div>
  </div>

  <main class="relative z-10 px-4 py-10">
    <!-- Header Section -->
    <div class="max-w-7xl mx-auto mt-28 px-4">
    
      <!-- Order Statistics Header -->
      <div class="max-w-6xl mx-auto bg-white/95 backdrop-blur-sm shadow-2xl rounded-3xl p-8 mb-8 border border-white/20">
        <div class="mb-6">
          <h3 class="text-3xl font-bold bg-gradient-to-r from-blue-500 to-blue-600 bg-clip-text text-transparent">My Orders</h3>
        </div>
        
        <!-- Dynamic Order Statistics -->
        <div class="grid grid-cols-1 md:grid-cols-4 gap-6 mb-6">
          <div class="bg-gradient-to-r from-blue-500 to-blue-600 rounded-2xl p-6 text-white" id="total-orders-card">
            <div class="flex items-center justify-between">
              <div>
                <div class="text-3xl font-bold" id="total-count">${fn:length(orders)}</div>
                <div class="text-blue-100">Total Orders</div>
              </div>
              <i class="fas fa-shopping-bag text-2xl text-blue-200"></i>
            </div>
          </div>
          <div class="bg-gradient-to-r from-blue-500 to-blue-600 rounded-2xl p-6 text-white" id="to-pay-card">
            <div class="flex items-center justify-between">
              <div>
                <div class="text-3xl font-bold" id="to-pay-count">
                  <c:set var="toPayCount" value="0"/>
                  <c:forEach var="order" items="${orders}">
                    <c:if test="${order.status == 'To Pay'}">
                      <c:set var="toPayCount" value="${toPayCount + 1}"/>
                    </c:if>
                  </c:forEach>
                  ${toPayCount}
                </div>
                <div class="text-red-100">To Pay</div>
              </div>
              <i class="fas fa-clock text-2xl text-blue-200"></i>
            </div>
          </div>
          <div class="bg-gradient-to-r from-blue-500 to-blue-600 rounded-2xl p-6 text-white" id="processing-card">
            <div class="flex items-center justify-between">
              <div>
                <div class="text-3xl font-bold" id="processing-count">
                  <c:set var="processingCount" value="0"/>
                  <c:forEach var="order" items="${orders}">
                    <c:if test="${order.status == 'Processing'}">
                      <c:set var="processingCount" value="${processingCount + 1}"/>
                    </c:if>
                  </c:forEach>
                  ${processingCount}
                </div>
                <div class="text-blue-100">Processing</div>
              </div>
              <i class="fas fa-cog text-2xl text-blue-200"></i>
            </div>
          </div>
          <div class="bg-gradient-to-r from-blue-500 to-blue-600 rounded-2xl p-6 text-white" id="completed-card">
            <div class="flex items-center justify-between">
              <div>
                <div class="text-3xl font-bold" id="completed-count">
                  <c:set var="completedCount" value="0"/>
                  <c:forEach var="order" items="${orders}">
                    <c:if test="${order.status == 'Delivered' || order.status == 'Shipped'}">
                      <c:set var="completedCount" value="${completedCount + 1}"/>
                    </c:if>
                  </c:forEach>
                  ${completedCount}
                </div>
                <div class="text-blue-100">Completed</div>
              </div>
              <i class="fas fa-check-circle text-2xl text-blue-200"></i>
            </div>
          </div>
        </div>
        
        <!-- Action Buttons-->
        <div class="flex justify-end gap-3">
          <button onclick="history.back()" 
                  class="bg-gradient-to-r from-gray-500 to-gray-600 text-white px-6 py-3 rounded-2xl hover:from-gray-600 hover:to-gray-700 transition-all duration-300 shadow-lg hover:shadow-xl transform hover:scale-105 flex items-center gap-2 font-semibold">
            <i class="fas fa-arrow-left"></i>
            Back to Profile
          </button>
        </div>
      </div>
      
      <!-- Enhanced Filter and Search -->
      <div class="max-w-6xl mx-auto bg-white/95 backdrop-blur-sm rounded-3xl shadow-xl p-6 mb-8 border border-white/20">
        <div class="flex flex-wrap items-center justify-between gap-4">
          <div class="flex items-center gap-4">
            <h3 class="text-xl font-semibold text-gray-800">Filter Orders</h3>
            
            <!-- Filter Buttons -->
            <div class="flex flex-wrap gap-2">
              <button onclick="filterOrders('all')" class="filter-btn px-4 py-2 rounded-xl border border-gray-200 hover:bg-blue-50 transition-all duration-300" 
                      data-filter="all">All Orders 
              </button>
              <button onclick="filterOrders('To Pay')"  class="filter-btn px-4 py-2 rounded-xl border border-gray-200 hover:bg-red-50 transition-all duration-300" 
                      data-filter="To Pay">To Pay
              </button>
              <button onclick="filterOrders('Processing')" class="filter-btn px-4 py-2 rounded-xl border border-gray-200 hover:bg-yellow-50 transition-all duration-300" 
                      data-filter="Processing">Processing
              </button>
              <button onclick="filterOrders('Shipped')" class="filter-btn px-4 py-2 rounded-xl border border-gray-200 hover:bg-green-50 transition-all duration-300" 
                      data-filter="Shipped">Shipped
              </button>
              <button onclick="filterOrders('Delivered')" class="filter-btn px-4 py-2 rounded-xl border border-gray-200 hover:bg-blue-50 transition-all duration-300" 
                      data-filter="Delivered">Delivered 
              </button>
            </div>
          </div>          
        </div>
      </div>

      <!-- Orders Grid -->
      <c:if test="${not empty orders}">
      <div class="grid grid-cols-1 md:grid-cols-2 gap-6 items-stretch justify-items-center" id="ordersContainer">
        <c:forEach var="order" items="${orders}">
          <div class="order-card w-full max-w-[600px] min-h-[280px] bg-white rounded-3xl shadow-xl p-8 h-full flex flex-col justify-between border-l-4 border-blue-500 transition-all duration-300 transform translate-y-0 hover:scale-[1.02] hover:-translate-y-1 hover:shadow-2xl hover:border-blue-700"
			     data-status="${order.status}" 
			     data-order-id="${order.orderId}"
			     data-order-date="<fmt:formatDate value='${order.orderDate}' pattern='yyyy-MM-dd'/>">
            <div class="flex items-start justify-between mb-6">
              <div class="flex items-center gap-4">
                <div class="w-16 h-16 bg-blue-500 rounded-2xl flex items-center justify-center text-white text-xl font-bold">
                  <i class="fas fa-shopping-bag"></i>
                </div>
                <div>
                  <h3 class="text-2xl font-bold text-gray-800">Order #${order.orderId}</h3>
                  <p class="text-gray-600">
                    <fmt:formatDate value="${order.orderDate}" pattern="MMMM dd, yyyy  hh:mm a"/>
                  </p>
                  <c:choose>
                    <c:when test="${order.status == 'To Pay'}">
                      <span class="inline-flex items-center gap-2 px-3 py-1 rounded-full text-sm font-medium bg-red-100 text-red-800 mt-2">
                        ${order.status}
                      </span>
                    </c:when>
                    <c:when test="${order.status == 'Processing'}">
                      <span class="inline-flex items-center gap-2 px-3 py-1 rounded-full text-sm font-medium bg-yellow-100 text-yellow-800 mt-2">
                        ${order.status}
                      </span>
                    </c:when>
                    <c:when test="${order.status == 'Shipped'}">
                      <span class="inline-flex items-center gap-2 px-3 py-1 rounded-full text-sm font-medium bg-emerald-100 text-emerald-800 mt-2">
                        Shipped
                      </span>
                    </c:when>
                    <c:when test="${order.status == 'Delivered'}">
                      <span class="inline-flex items-center gap-2 px-3 py-1 rounded-full text-sm font-medium bg-blue-100 text-blue-800 mt-2">
                        Delivered
                      </span>
                      <c:if test="${not empty order.deliveredDate}">
					    <div class="text-sm text-gray-500 mt-1">
					      <i class="fas fa-calendar-check text-blue-500 mr-1"></i>
					      <fmt:formatDate value="${order.deliveredDate}" pattern="yyyy-MM-dd"/>
					    </div>
					  </c:if>
                    </c:when>
                    <c:otherwise>
                      <span class="inline-flex items-center gap-2 px-3 py-1 rounded-full text-sm font-medium bg-green-100 text-green-800 mt-2">
                        ${order.status}
                      </span>
                    </c:otherwise>
                  </c:choose>
                </div>
              </div>
              <div class="text-right">
                <div class="text-3xl font-bold text-gray-800">
                  $<fmt:formatNumber value="${order.totalAmount}" type="number" minFractionDigits="2"/>
                </div>
              </div>
            </div>

            <div class="mt-auto pt-4 flex justify-end gap-3">            
				<button type="button" onclick="viewOrderDetails('${order.orderId}', '${order.email}', '${order.orderDate}', '${order.totalAmount}', '${order.status}', '${order.deliveredDate}')"
                        class="bg-slate-600 text-white px-6 py-3 rounded-full shadow-md hover:bg-slate-700 hover:shadow-lg transform hover:scale-105 transition">
                        <i class="fas fa-eye mr-2"></i> View Details
                </button>  

              <c:if test="${order.status == 'To Pay'}">
                <button onclick="payNow(event, '${order.orderId}')" class="bg-gradient-to-r from-orange-500 to-red-500 text-white px-6 py-3 rounded-full shadow-md hover:from-orange-600 hover:to-red-600 transform hover:scale-105 transition">
                  <i class="fas fa-credit-card mr-2"></i> Pay Now
                </button>
              </c:if>

              <c:if test="${order.status == 'To Pay' || order.status == 'Processing'}">
                <form id="cancelForm_${order.orderId}" action="deleteOrder" method="post">
                  <input type="hidden" name="orderId" value="${order.orderId}" />
                </form>
                <button onclick="if(confirm('Are you sure you want to cancel this order?')) document.getElementById('cancelForm_${order.orderId}').submit();" class="bg-gradient-to-r from-purple-500 to-indigo-600 text-white px-6 py-3 rounded-full shadow-md hover:from-purple-600 hover:to-indigo-700 transform hover:scale-105 transition">
                  <i class="fas fa-times mr-2"></i> Cancel
                </button>
              </c:if>

              <c:if test="${order.status == 'Shipped'}">
                <form id="receivedForm_${order.orderId}" action="updateOrder" method="post" style="display:none;">
                  <input type="hidden" name="orderId" value="${order.orderId}" />
                  <input type="hidden" name="action" value="markReceived" />
                </form>
                <button onclick="markAsReceived(event, '${order.orderId}')" class="bg-gradient-to-r from-green-500 to-green-600 text-white px-6 py-3 rounded-full shadow-md hover:from-green-600 hover:to-green-700 transform hover:scale-105 transition">
                  <i class="fas fa-check-circle mr-2"></i> Mark as Received
                </button>
              </c:if>

              <c:if test="${order.status == 'Delivered'}">
                <button onclick="writeReview('${order.orderId}')" class="bg-gradient-to-r from-yellow-400 to-yellow-500 text-white px-6 py-3 rounded-full shadow-md hover:from-yellow-500 hover:to-yellow-600 transform hover:scale-105 transition">
                  <i class="fas fa-star mr-2"></i> Write Review
                </button>

                <form id="deleteForm_${order.orderId}" action="deleteOrder" method="post" style="display:none;">
                  <input type="hidden" name="orderId" value="${order.orderId}" />
                </form>
                <button onclick="if(confirm('Delete this completed order?')) document.getElementById('deleteForm_${order.orderId}').submit();" class="bg-gradient-to-r from-red-500 to-red-600 text-white px-6 py-3 rounded-full shadow-md hover:from-red-600 hover:to-red-700 transform hover:scale-105 transition">
                  <i class="fas fa-trash-alt mr-2"></i> Delete
                </button>
              </c:if>
            </div>
          </div>
        </c:forEach>
      </div>
      </c:if>
      
      <!-- No Results Message -->
      <div id="noResultsMessage" class="hidden text-center py-12">
		  <div class="max-w-md mx-auto">
		    <i class="fas fa-search text-6xl text-gray-300 mb-4"></i>
		    <h3 class="text-2xl font-semibold text-gray-600 mb-2">No Orders Found</h3>
		    <p class="text-gray-500">Try adjusting your filters or search terms.</p>
		  </div>
		</div>
    </div>
  </main>
  
  <!-- Order Details Modal -->
	<div id="orderModal" class="fixed inset-0 modal-backdrop hidden z-50 flex items-center justify-center p-4">
	  <div class="modal-content bg-white rounded-2xl max-w-4xl w-full max-h-[90vh] overflow-y-auto shadow-2xl">
	    <!-- Modal Header -->
	    <div class="bg-blue-600 text-white p-6 rounded-t-2xl">
	      <div class="flex items-center justify-between">
	        <div>
	          <h3 class="text-2xl font-bold">Order Details</h3>
	        </div>
	        <button onclick="closeModal()" class="text-white hover:text-gray-200 p-2 rounded-lg hover:bg-white/20 transition-colors">
	          <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
	            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>
	          </svg>
	        </button>
	      </div>
	    </div>
	
	    <!-- Modal Content -->
	    <div class="p-6">
	      <div class="grid grid-cols-1 lg:grid-cols-2 gap-8">
	        <!-- Order Information -->
	        <div class="space-y-6">
	          <div class="bg-gray-50 rounded-xl p-6">
	            <h4 class="text-lg font-semibold text-gray-800 mb-4 flex items-center">
	              <svg class="w-5 h-5 mr-2 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
	                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"></path>
	              </svg>
	              Order Information
	            </h4>
	            <div class="space-y-3">
	              <div class="flex justify-between py-2 border-b border-gray-200">
	                <span class="text-gray-600 font-medium">Order ID:</span>
	                <span class="font-bold text-gray-900" id="modalOrderId">-</span>
	              </div>
	              <div class="flex justify-between py-2 border-b border-gray-200 hidden">
	                <span class="text-gray-600 font-medium">Customer Email:</span>
	                <span class="font-medium text-gray-900" id="modalEmail">-</span>
	              </div>
	              <div class="flex justify-between py-2 border-b border-gray-200">
	                <span class="text-gray-600 font-medium">Order Date:</span>
	                <span class="font-medium text-gray-900" id="modalOrderDate">-</span>
	              </div>
	              <div class="flex justify-between py-2 border-b border-gray-200">
	                <span class="text-gray-600 font-medium">Total Amount:</span>
	                <span class="font-bold text-lg text-green-600" id="modalTotalAmount">-</span>
	              </div>
	              <div class="flex justify-between py-2 border-b border-gray-200">
	                <span class="text-gray-600 font-medium">Status:</span>
	                <span id="modalStatus" class="px-3 py-1 rounded-full text-sm font-semibold">-</span>
	              </div>
	              <div class="flex justify-between py-2">
	                <span class="text-gray-600 font-medium">Delivered Date:</span>
	                <span class="font-medium text-gray-900" id="modalDeliveredDate">-</span>
	              </div>
	            </div>
	          </div>
	          
	          <!-- Timeline -->
	          <div class="bg-green-50 rounded-xl p-6">
	            <h4 class="text-lg font-semibold text-gray-800 mb-4 flex items-center">
	              <svg class="w-5 h-5 mr-2 text-green-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
	                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"></path>
	              </svg>
	              Order Timeline
	            </h4>
	            <div class="space-y-4" id="orderTimeline">
				  <!-- Timeline will be generated here -->
				</div>
	          </div>
	
	          <!-- Customer Details (Hidden)-->
	          <div class="bg-blue-50 rounded-xl p-6 hidden">
	            <h4 class="text-lg font-semibold text-gray-800 mb-4 flex items-center">
	              <svg class="w-5 h-5 mr-2 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
	                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"></path>
	              </svg>
	              Customer Details
	            </h4>
	            <div class="flex items-center">
	              <div class="w-12 h-12 bg-blue-500 rounded-full flex items-center justify-center text-white font-bold mr-4">
	                <span id="customerInitial">-</span>
	              </div>
	              <div>
	                <div class="font-semibold text-gray-900" id="customerEmail">-</div>
	                <div class="text-gray-600 text-sm">Registered Customer</div>
	              </div>
	            </div>
	          </div>
	        </div>
	
	        <!-- Order Items -->
	        <div class="space-y-6">
	          <div class="bg-gray-50 rounded-xl p-6">
	            <h4 class="text-lg font-semibold text-gray-800 mb-4 flex items-center">
	              <svg class="w-5 h-5 mr-2 text-green-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
	                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 11H5m14 0a2 2 0 012 2v6a2 2 0 01-2 2H5a2 2 0 01-2-2v-6a2 2 0 012-2m14 0V9a2 2 0 00-2-2M5 11V9a2 2 0 012-2m0 0V5a2 2 0 012-2h6a2 2 0 012 2v2M7 7h10"></path>
	              </svg>
	              Order Items
	            </h4>
	            <div id="orderItemsList" class="space-y-3">
	              <div class="text-center py-8">
	                <div class="animate-spin rounded-full h-8 w-8 border-b-2 border-blue-600 mx-auto mb-3"></div>
	                <p class="text-gray-500">Loading order items...</p>
	              </div>
	            </div>
	          </div>
			</div>		
		</div>
	
	      <!-- Modal Footer -->
	      <div class="mt-8 flex justify-end gap-4 pt-6 border-t border-gray-200">
	        <button onclick="closeModal()" class="px-6 py-3 bg-gray-500 hover:bg-gray-600 text-white rounded-xl font-medium transition-colors">
	          Close
	        </button>
	      </div>
	    </div>
	  </div>
	</div>
  
  <!-- Footer -->
  <%@ include file="./partials/footer.jsp" %>

	<script>
	// Global variables
	let currentFilter = 'all';
	let currentSearch = '';
	
	
	function payNow(event, orderId) {
	  const btn = event.target;
	  btn.innerHTML = '<i class="fas fa-spinner fa-spin mr-2"></i>Redirecting...';
	  btn.disabled = true;
	
	  setTimeout(() => {
	    window.location.href = 'payment.jsp?orderId=' + orderId;
	  }, 1000);
	}
	
	function markAsReceived(event, orderId) {
		  if (confirm('Mark this order as received? This action cannot be undone.')) {
		    const btn = event.target;
		    btn.innerHTML = '<i class="fas fa-spinner fa-spin mr-2"></i>Processing...';
		    btn.disabled = true;
		    document.getElementById('receivedForm_' + orderId).submit();
		  }
	}
	
	
	function filterOrders(status) {
	  currentFilter = status;
	  applyFilters();
	
	  document.querySelectorAll('.filter-btn').forEach(btn => {
	    btn.classList.remove('filter-active');
	  });
	
	  const activeBtn = document.querySelector('.filter-btn[data-filter="' + status + '"]');
	  if (activeBtn) {
	    activeBtn.classList.add('filter-active');
	  }
	}
	
	function applyFilters() {
	  const orderCards = document.querySelectorAll('.order-card');
	  let visibleCount = 0;
	
	  orderCards.forEach(card => {
	    const status = card.getAttribute('data-status');
	    const orderId = card.getAttribute('data-order-id').toLowerCase();
	    const statusMatch = currentFilter === 'all' || status === currentFilter;
	    const searchMatch = currentSearch === '' || orderId.includes(currentSearch);
	
	    if (statusMatch && searchMatch) {
	      card.classList.remove('hidden');
	      card.classList.add('fade-in');
	      visibleCount++;
	    } else {
	      card.classList.add('hidden');
	      card.classList.remove('fade-in');
	    }
	  });
	
	  const noResultsMessage = document.getElementById('noResultsMessage');
	  if (noResultsMessage) {
	    noResultsMessage.classList.toggle('hidden', visibleCount > 0);
	  }
	}
	
	function updateStatusBadge(status) {
	  const statusElement = document.getElementById('modalStatus');
	  statusElement.textContent = status;
	  statusElement.className = 'px-3 py-1 rounded-full text-sm font-semibold';
	  
	  if (status === 'To Pay') {
	    statusElement.classList.add('bg-red-100', 'text-red-800');
	  } else if (status === 'Processing') {
	    statusElement.classList.add('bg-yellow-100', 'text-yellow-800');
	  } else if (status === 'Shipped') {
	    statusElement.classList.add('bg-blue-100', 'text-blue-800');
	  } else if (status === 'Delivered') {
	    statusElement.classList.add('bg-green-100', 'text-green-800');
	  }
	}
	
	// Event listeners
	document.addEventListener('DOMContentLoaded', function() {
	  // Set default filter
	  const defaultFilter = document.querySelector('[data-filter="all"]');
	  if (defaultFilter) {
	    defaultFilter.classList.add('filter-active');
	  }
	  applyFilters();
	  
	  });
	
	// Modal Functions
    function viewOrderDetails(orderId, email, orderDate, totalAmount, status, deliveredDate) {
      console.log('Opening modal for order:', orderId);
      
      // Update modal content
      document.getElementById('modalOrderId').textContent = orderId;
      document.getElementById('modalEmail').textContent = email;
      document.getElementById('modalOrderDate').textContent = orderDate;
      document.getElementById('modalTotalAmount').textContent = 'Rs. ' + parseFloat(totalAmount).toFixed(2);
      document.getElementById('modalDeliveredDate').textContent = deliveredDate === 'null' || !deliveredDate ? 'Not delivered yet' : deliveredDate;
      
      // Update customer details
      document.getElementById('customerEmail').textContent = email;
      document.getElementById('customerInitial').textContent = email.charAt(0).toUpperCase();
      
      // Update status badge
      const statusElement = document.getElementById('modalStatus');
      statusElement.textContent = status;
      statusElement.className = 'px-3 py-1 rounded-full text-sm font-semibold';
      
      if (status === 'To Pay') {
        statusElement.classList.add('bg-red-100', 'text-red-800');
      } else if (status === 'Processing') {
        statusElement.classList.add('bg-yellow-100', 'text-yellow-800');
      } else if (status === 'Shipped') {
        statusElement.classList.add('bg-blue-100', 'text-blue-800');
      } else if (status === 'Delivered') {
        statusElement.classList.add('bg-green-100', 'text-green-800');
      }
      
      // Load order items
      loadOrderItems(orderId);
      
      // Generate timeline
      generateOrderTimeline(status, orderDate, deliveredDate);
      
      // Show modal
      document.getElementById('orderModal').classList.remove('hidden');
      document.body.style.overflow = 'hidden';
    }
    
    function closeModal() {
      document.getElementById('orderModal').classList.add('hidden');
      document.body.style.overflow = 'auto';
    }
    
    function loadOrderItems(orderId) {
      const orderItemsList = document.getElementById('orderItemsList');
      orderItemsList.innerHTML = `
        <div class="text-center py-8">
          <div class="animate-spin rounded-full h-8 w-8 border-b-2 border-blue-600 mx-auto mb-3"></div>
          <p class="text-gray-500">Loading order items...</p>
        </div>
      `;

      fetch('getOrderDetails?orderId=' + orderId)
        .then(function(res) {
          return res.json();
        })
        .then(function(data) {
          let html = '';
          let subtotal = 0;

          if (data && data.length > 0) {
            data.forEach(function(item) {
              const total = item.quantity * item.pricePerUnit;
              subtotal += total;

              html += '<div class="bg-white border border-gray-200 rounded-xl p-4 shadow-sm">';
              html += '<div class="flex items-center justify-between">';
              html += '<div>';
              html += '<div class="font-semibold text-gray-900">Medicine ID: ' + item.medId + '</div>';
              html += '<div class="text-gray-600 text-sm">Quantity: ' + item.quantity + ' x Rs. ' + item.pricePerUnit.toFixed(2) + '</div>';
              html += '</div>';
              html += '<div class="text-right">';
              html += '<div class="font-bold text-gray-900">Rs. ' + total.toFixed(2) + '</div>';
              html += '</div>';
              html += '</div>';
              html += '</div>';
            });

            html += '<div class="border-t border-gray-200 pt-4 mt-4 bg-white rounded-xl p-4">';
            html += '<div class="flex justify-between mb-2">';
            html += '<span class="font-semibold text-gray-700">Subtotal:</span>';
            html += '<span class="font-semibold text-gray-900">Rs. ' + subtotal.toFixed(2) + '</span>';
            html += '</div>';
            html += '<div class="flex justify-between mb-2">';
            html += '<span class="font-semibold text-gray-700">Delivery Fee:</span>';
            html += '<span class="font-semibold text-gray-900">Rs. 150.00</span>';
            html += '</div>';
            html += '<div class="flex justify-between pt-2 border-t border-gray-200">';
            html += '<span class="font-bold text-lg text-gray-900">Total:</span>';
            html += '<span class="font-bold text-lg text-green-600">Rs. ' + (subtotal + 150).toFixed(2) + '</span>';
            html += '</div>';
            html += '</div>';
          } else {
            html = '<p class="text-gray-500 text-center py-4">No items found for this order.</p>';
          }

          orderItemsList.innerHTML = html;
        })
        .catch(function(err) {
          orderItemsList.innerHTML = '<p class="text-red-500">Failed to load order items.</p>';
          console.error('Error loading order items:', err);
        });
    }

    function generateOrderTimeline(status, orderDate, deliveredDate) {
      const timeline = document.getElementById('orderTimeline');
      const statuses = ['To Pay', 'Processing', 'Shipped', 'Delivered'];
      const currentIndex = statuses.indexOf(status);
      
      let timelineHTML = '';
      
      statuses.forEach(function(statusItem, index) {
        const isCompleted = index <= currentIndex;
        const isCurrent = index === currentIndex;
        
        let statusClass = '';
        let textClass = '';
        let iconHTML = '';
        let lineClass = '';
        
        if (isCompleted) {
          statusClass = 'bg-green-500 text-white';
          textClass = 'text-green-600';
          iconHTML = '<svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path></svg>';
          lineClass = 'bg-green-500';
        } else {
          statusClass = 'bg-gray-200 text-gray-500';
          textClass = 'text-gray-500';
          iconHTML = '<div class="w-2 h-2 bg-current rounded-full"></div>';
          lineClass = 'bg-gray-200';
        }
        
        let statusDescription = '';
        if (isCurrent) {
          statusDescription = 'Current Status';
        } else if (isCompleted) {
          statusDescription = 'Completed';
        } else {
          statusDescription = 'Pending';
        }
        
        timelineHTML += '<div class="flex items-center';
        if (index < statuses.length - 1) {
          timelineHTML += ' pb-4';
        }
        timelineHTML += '">';
        
        timelineHTML += '<div class="flex flex-col items-center mr-4">';
        timelineHTML += '<div class="w-8 h-8 rounded-full flex items-center justify-center ' + statusClass + '">';
        timelineHTML += iconHTML;
        timelineHTML += '</div>';
        
        if (index < statuses.length - 1) {
          timelineHTML += '<div class="w-px h-8 ' + lineClass + ' mt-2"></div>';
        }
        timelineHTML += '</div>';
        
        timelineHTML += '<div class="flex-1">';
        timelineHTML += '<div class="font-medium ' + textClass + '">' + statusItem + '</div>';
        timelineHTML += '<div class="text-sm text-gray-500">' + statusDescription + '</div>';
        timelineHTML += '</div>';
        timelineHTML += '</div>';
      });
      
      timeline.innerHTML = timelineHTML;
    }
    
    // Close modal when clicking outside
    document.getElementById('orderModal').addEventListener('click', function(e) {
      if (e.target === this) {
        closeModal();
      }
    });
    
	</script>

</body>
</html>