<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>MediQuick Admin - Orders</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <style>
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
<body class="bg-[#ecf1fc] text-[#333] min-h-screen flex font-sans">

  <%@ include file="../partials/adminSidebar.jsp" %>

  <div id="mainContent" class="flex-1 ml-[250px] p-5 w-[calc(100%-250px)] transition-all duration-300">
    <header class="flex justify-between items-center mb-8 pb-5 border-b border-[#e3ebf6]">
      <div class="flex items-center gap-4">
        <button id="toggleSidebar" class="text-2xl">☰</button>
        <h2 class="text-2xl font-semibold text-[#12263f]">Orders</h2>
      </div>
    </header>

    <div class="bg-white rounded-lg shadow p-6">
      <div class="flex justify-between items-center border-b border-[#e3ebf6] pb-4 mb-4">
        <h3 class="text-xl font-semibold text-[#12263f]">Order Management</h3>       
      </div>

      <h1 class="text-black text-base font-medium mb-4">
        List Size: 
        <c:choose>
          <c:when test="${not empty orderList}">
            <c:set var="filteredCount" value="0"/>
            <c:forEach var="order" items="${orderList}">
              <c:if test="${order.status != 'To Pay'}">
                <c:set var="filteredCount" value="${filteredCount + 1}"/>
              </c:if>
            </c:forEach>
            ${filteredCount}
          </c:when>
          <c:otherwise>
            0
          </c:otherwise>
        </c:choose>
      </h1>

      <div class="overflow-x-auto">
        <table class="w-full table-auto border-collapse">
          <thead>
            <tr class="text-left text-[#7b99c7] text-xs uppercase">
              <th class="px-4 py-2">Order ID</th>
              <th class="px-4 py-2">Email</th>
              <th class="px-4 py-2">Order Date</th>
              <th class="px-4 py-2">Total</th>
              <th class="px-4 py-2">Status</th>
              <th class="px-4 py-2">Delivered Date</th>
              <th class="px-4 py-2">Action</th>
            </tr>
          </thead>
          <tbody class="text-[#12263f]">
            <c:set var="hasFilteredOrders" value="false"/>
            <c:choose>
              <c:when test="${not empty orderList}">
                <c:forEach var="order" items="${orderList}">
                  <c:if test="${order.status != 'To Pay'}">
                    <c:set var="hasFilteredOrders" value="true"/>
                    <tr class="hover:bg-[#f9fbfd]">
                      <td class="px-4 py-2">${order.orderId}</td>
                      <td class="px-4 py-2">${order.email}</td>
                      <td class="px-4 py-2">
                        <fmt:formatDate value="${order.orderDate}" pattern="yyyy-MM-dd HH:mm"/>
                      </td>
                      <td class="px-4 py-2">Rs. <fmt:formatNumber value="${order.totalAmount}" type="number" minFractionDigits="2"/></td>
                      <td class="px-4 py-2 font-semibold text-sm">
                        <c:choose>
                          <c:when test="${order.status eq 'Processing'}">
                            <span class="text-yellow-500">${order.status}</span>
                          </c:when>
                          <c:when test="${order.status eq 'Shipped'}">
                            <span class="text-blue-500">${order.status}</span>
                          </c:when>
                          <c:when test="${order.status eq 'Delivered'}">
                            <span class="text-green-600">${order.status}</span>
                          </c:when>
                          <c:otherwise>
                            <span>${order.status}</span>
                          </c:otherwise>
                        </c:choose>
                      </td>
                      <td class="px-4 py-2">
                        <c:if test="${order.deliveredDate != null}">
                          <fmt:formatDate value="${order.deliveredDate}" pattern="yyyy-MM-dd"/>
                        </c:if>
                      </td>

                      <!-- action -->
                      <td class="px-4 py-2">
                         <button type="button" onclick="viewOrderDetails('${order.orderId}', '${order.email}', '${order.orderDate}', '${order.totalAmount}', '${order.status}', '${order.deliveredDate}')"
                            class="bg-teal-600 text-white px-3 py-1 rounded hover:bg-teal-700 ml-2">
                            View Details
                          </button>                  			                
                      <!-- Update Status -->
                        <c:if test="${order.status eq 'Processing'}">
                           <form action="updateOrder" method="post" class="inline">
                            <input type="hidden" name="orderId" value="${order.orderId}" />
                            <input type="hidden" name="email" value="${order.email}" />
                            <button type="submit" class="bg-blue-500 text-white px-3 py-1 rounded hover:bg-blue-600 ml-2">
                              Update
                            </button>
                          </form>
                        </c:if>

                        <!-- delete -->
                        <c:if test="${order.status eq 'Delivered'}">
                           <form action="deleteOrder" method="post" onsubmit="return confirm('Are you sure you want to delete this order?');" class="inline">
                             <input type="hidden" name="orderId" value="${order.orderId}" />
                             <button type="submit" class="bg-red-500 text-white px-3 py-1 rounded hover:bg-red-600 ml-2">
                               Delete
                             </button>
                           </form>
                        </c:if>             
                      </td>
                    </tr>
                  </c:if>
                </c:forEach>
                
                <c:if test="${not hasFilteredOrders}">
                  <tr>
                    <td colspan="7" class="px-4 py-8 text-center text-gray-500">
                      <div class="text-lg font-medium">No orders to display</div>
                      <div class="text-sm mt-1">Only orders beyond "To Pay" status are shown here</div>
                    </td>
                  </tr>
                </c:if>
              </c:when>
              <c:otherwise>
                <tr>
                  <td colspan="7" class="px-4 py-8 text-center text-gray-500">
                    <div class="text-lg font-medium">No orders found</div>
                    <div class="text-sm mt-1">Orders will appear here when customers place them</div>
                  </td>
                </tr>
              </c:otherwise>
            </c:choose>
          </tbody>
        </table>
      </div>
    </div>
  </div>

  <!-- Order Details Modal -->
  <div id="orderModal" class="fixed inset-0 modal-backdrop hidden z-50 flex items-center justify-center p-4">
    <div class="modal-content bg-white rounded-2xl max-w-4xl w-full max-h-[90vh] overflow-y-auto shadow-2xl">
      <!-- Modal Header -->
      <div class="bg-blue-600 text-white p-6 rounded-t-2xl">
        <div class="flex items-center justify-between">
          <div>
            <h3 class="text-2xl font-bold">Order Details</h3>
            <p class="text-teal-100 mt-1">Complete order information</p>
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
                <div class="flex justify-between py-2 border-b border-gray-200">
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
            
            <!-- Customer Details -->
            <div class="bg-blue-50 rounded-xl p-6">
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
            
            <!-- Order Timeline -->
            <div class="bg-green-50 rounded-xl p-6 hidden">
              <h4 class="text-lg font-semibold text-gray-800 mb-4 flex items-center">
                <svg class="w-5 h-5 mr-2 text-green-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                </svg>
                Order Timeline
              </h4>
              <div class="space-y-4" id="orderTimeline">
                <!-- Timeline will be generated based on status -->
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
                <!-- Order items will be loaded here -->
                <div class="text-center py-8">
                  <div class="animate-spin rounded-full h-8 w-8 border-b-2 border-blue-600 mx-auto mb-3"></div>
                  <p class="text-gray-500">Loading order items...</p>
                </div>
              </div>
            </div>           
          </div>
        </div>
        
        <!-- Modal Actions -->
        <div class="mt-8 flex justify-end gap-4 pt-6 border-t border-gray-200">
          <button onclick="closeModal()" class="px-6 py-3 bg-gray-500 hover:bg-gray-600 text-white rounded-xl font-medium transition-colors">
            Close
          </button>          
        </div>
      </div>
    </div>
  </div>

  <script>
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
    
    // Keyboard navigation
    document.addEventListener('keydown', function(e) {
      if (e.key === 'Escape') {
        closeModal();
      }
    });
    
    // Sidebar toggle
    document.getElementById('toggleSidebar').addEventListener('click', function() {
      console.log('Sidebar toggle clicked');
    });
  </script>

  <script src="<%= request.getContextPath() %>/js/adminSidebar.js"></script>
  
</body>
</html>