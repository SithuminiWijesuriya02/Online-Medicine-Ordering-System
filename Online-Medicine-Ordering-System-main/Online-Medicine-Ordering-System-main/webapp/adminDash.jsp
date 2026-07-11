<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>MediQuick - Admin Dashboard</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <style>
    .card-hover {
      transition: all 0.3s ease-in-out;
      transform: translateY(0);
    }
    .card-hover:hover {
      transform: translateY(-8px);
      box-shadow: 0 25px 50px rgba(0,0,0,0.15);
    }
    .stat-card {
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      position: relative;
      overflow: hidden;
    }
    .stat-card::before {
      content: '';
      position: absolute;
      top: -50%;
      right: -50%;
      width: 200%;
      height: 200%;
      background: radial-gradient(circle, rgba(255,255,255,0.1) 0%, transparent 70%);
      animation: pulse 3s ease-in-out infinite;
    }
    @keyframes pulse {
      0%, 100% { transform: scale(1); opacity: 0.5; }
      50% { transform: scale(1.1); opacity: 0.8; }
    }
    .gradient-bg {
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    }
    .glass-effect {
      backdrop-filter: blur(10px);
      background: rgba(255, 255, 255, 0.95);
      border: 1px solid rgba(255, 255, 255, 0.2);
    }
    .status-badge {
      padding: 0.25rem 0.75rem;
      border-radius: 9999px;
      font-size: 0.75rem;
      font-weight: 600;
      text-transform: uppercase;
      letter-spacing: 0.05em;
    }
    .status-delivered {
      background: linear-gradient(135deg, #10b981, #059669);
      color: white;
    }
    .status-processing {
      background: linear-gradient(135deg, #f59e0b, #d97706);
      color: white;
    }
    .status-shipped {
      background: linear-gradient(135deg, #3b82f6, #1d4ed8);
      color: white;
    }
    .status-to-pay {
      background: linear-gradient(135deg, #ef4444, #dc2626);
      color: white;
    }
    .low-stock {
      background: linear-gradient(135deg, #ef4444, #dc2626);
      color: white;
    }
    .action-btn {
      transition: all 0.3s ease;
      position: relative;
      overflow: hidden;
    }
    .action-btn::before {
      content: '';
      position: absolute;
      top: 50%;
      left: 50%;
      width: 0;
      height: 0;
      background: rgba(255, 255, 255, 0.3);
      border-radius: 50%;
      transition: all 0.3s ease;
      transform: translate(-50%, -50%);
    }
    .action-btn:hover::before {
      width: 100%;
      height: 100%;
    }
    .chart-container {
      height: 300px;
      position: relative;
    }
    .sidebar-closed {
      margin-left: 0;
      width: 100%;
    }
    .fade-in {
      animation: fadeIn 0.6s ease-in-out;
    }
    @keyframes fadeIn {
      from { opacity: 0; transform: translateY(20px); }
      to { opacity: 1; transform: translateY(0); }
    }
    .progress-bar {
      width: 100%;
      height: 6px;
      background: #e5e7eb;
      border-radius: 3px;
      overflow: hidden;
    }
    .progress-fill {
      height: 100%;
      background: linear-gradient(90deg, #10b981, #059669);
      transition: width 0.3s ease;
    }
  </style>
</head>
<body class="bg-gradient-to-br from-blue-50 via-indigo-50 to-purple-50 text-gray-800 min-h-screen">

  <!-- Background Pattern -->
  <div class="fixed inset-0 opacity-5 pointer-events-none">
    <div class="absolute inset-0" style="background-image: radial-gradient(circle at 25px 25px, #3b82f6 2px, transparent 0), radial-gradient(circle at 75px 75px, #8b5cf6 2px, transparent 0); background-size: 100px 100px;"></div>
  </div>

  <%@ include file="../partials/adminSidebar.jsp" %>

  <!-- Main Content -->
  <div id="mainContent" class="flex-1 ml-[250px] p-6 transition-all duration-300 relative z-10">
    
    <!-- Top Header -->
    <header class="glass-effect rounded-3xl p-6 mb-8 shadow-2xl fade-in">
      <div class="flex justify-between items-center">
        <div class="flex items-center gap-4">
          <button id="toggleSidebar" class="text-2xl text-gray-700 hover:text-blue-600 transition-colors p-2 rounded-xl hover:bg-blue-50">
            <i class="fas fa-bars"></i>
          </button>
          <div>
            <h1 class="text-3xl font-bold bg-blue-600 to-purple-600 bg-clip-text text-transparent">
              Admin Dashboard
            </h1>
            <p class="text-gray-600 mt-1">Welcome back, ${sessionScope.loggedAdmin.adName}!</p>
          </div>
        </div>
        
        <div class="flex gap-3 items-center">
          
          <!-- Admin Profile Button -->
          <form action="${pageContext.request.contextPath}/displayAdmin" method="post">
            <input type="hidden" name="adEmail" value="${sessionScope.loggedAdmin.adEmail}">
            <button type="submit" class="bg-gradient-to-r from-blue-500 to-indigo-600 text-white rounded-2xl px-6 py-3 font-medium shadow-lg transition-all duration-300">
              <i class="fas fa-user-circle mr-2"></i>
              Profile
            </button>
          </form>
          
          <!-- Logout Button -->
          <a href="logout.jsp" class="bg-gradient-to-r from-red-500 to-pink-600 text-white rounded-2xl px-6 py-3 font-medium shadow-lg transition-all duration-300">
            <i class="fas fa-sign-out-alt mr-2"></i>
            Logout
          </a>
        </div>
      </div>
    </header>

    <!-- Add New Admin Button -->
    <div class="flex justify-end mb-6 fade-in">
      <a href="adminCreate.jsp" class="bg-gradient-to-r from-emerald-500 to-teal-600 text-white px-8 py-4 rounded-2xl font-semibold shadow-lg transition-all duration-300">
        <i class="fas fa-user-plus mr-2"></i>
        Add New Admin
      </a>
    </div>

    <!-- Dashboard Stats -->
    <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6 mb-8">
      <div class="stat-card card-hover rounded-3xl p-6 text-white shadow-2xl fade-in" style="background: linear-gradient(135deg, #3b82f6, #1d4ed8);">
        <div class="flex items-center justify-between">
          <div>
            <p class="text-blue-100 text-sm font-medium uppercase tracking-wide">Total Sales</p>
            <p class="text-3xl font-bold mt-2">$24,568</p>
            <div class="flex items-center mt-3">
              <i class="fas fa-arrow-up text-blue-300 mr-1"></i>
              <span class="text-blue-300 text-sm font-medium">+15.3%</span>
              <span class="text-blue-200 text-sm ml-2">from last month</span>
            </div>
          </div>
          <div class="w-16 h-16 bg-white/20 rounded-2xl flex items-center justify-center">
            <i class="fas fa-dollar-sign text-2xl"></i>
          </div>
        </div>
      </div>

      <div class="stat-card card-hover rounded-3xl p-6 text-white shadow-2xl fade-in" style="background: linear-gradient(135deg, #3b82f6, #1d4ed8);">
        <div class="flex items-center justify-between">
          <div>
            <p class="text-blue-100 text-sm font-medium uppercase tracking-wide">Orders</p>
            <p class="text-3xl font-bold mt-2">${fn:length(orderList)}</p>
            <div class="flex items-center mt-3">
              <i class="fas fa-arrow-up text-blue-300 mr-1"></i>
              <span class="text-blue-300 text-sm font-medium">+5.2%</span>
              <span class="text-blue-200 text-sm ml-2">from last month</span>
            </div>
          </div>
          <div class="w-16 h-16 bg-white/20 rounded-2xl flex items-center justify-center">
            <i class="fas fa-shopping-cart text-2xl"></i>
          </div>
        </div>
      </div>

      <div class="stat-card card-hover rounded-3xl p-6 text-white shadow-2xl fade-in" style="background: linear-gradient(135deg, #3b82f6, #1d4ed8);">
        <div class="flex items-center justify-between">
          <div>
            <p class="text-blue-100 text-sm font-medium uppercase tracking-wide">Customers</p>
            <p class="text-3xl font-bold mt-2">1,245</p>
            <div class="flex items-center mt-3">
              <i class="fas fa-arrow-up text-blue-300 mr-1"></i>
              <span class="text-blue-300 text-sm font-medium">+12.1%</span>
              <span class="text-blue-200 text-sm ml-2">from last month</span>
            </div>
          </div>
          <div class="w-16 h-16 bg-white/20 rounded-2xl flex items-center justify-center">
            <i class="fas fa-users text-2xl"></i>
          </div>
        </div>
      </div>

      <div class="stat-card card-hover rounded-3xl p-6 text-white shadow-2xl fade-in" style="background: linear-gradient(135deg, #3b82f6, #1d4ed8);">
        <div class="flex items-center justify-between">
          <div>
            <p class="text-blue-100 text-sm font-medium uppercase tracking-wide">Low Stock</p>
            <p class="text-3xl font-bold mt-2">${fn:length(lowStockList)}</p>
            <div class="flex items-center mt-3">
              <i class="fas fa-exclamation-triangle text-blue-300 mr-1"></i>
              <span class="text-blue-300 text-sm font-medium">Alert</span>
              <span class="text-blue-200 text-sm ml-2">needs attention</span>
            </div>
          </div>
          <div class="w-16 h-16 bg-white/20 rounded-2xl flex items-center justify-center">
            <i class="fas fa-exclamation-triangle text-2xl"></i>
          </div>
        </div>
      </div>
    </div>

    <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">
      <!-- Recent Orders -->
      <div class="lg:col-span-2 glass-effect rounded-3xl p-8 shadow-2xl fade-in">
        <div class="flex items-center justify-between mb-6">
          <h2 class="text-2xl font-bold text-gray-800">Processing Orders</h2>
          <a href="orders.jsp" class="text-blue-600 hover:text-blue-800 font-medium">View All</a>
        </div>
        
        <div class="overflow-x-auto">
          <table class="w-full">
            <thead>
              <tr class="text-left border-b-2 border-gray-100">
                <th class="pb-4 font-semibold text-gray-700">Order ID</th>
                <th class="pb-4 font-semibold text-gray-700">Customer</th>
                <th class="pb-4 font-semibold text-gray-700">Date</th>
                <th class="pb-4 font-semibold text-gray-700">Amount</th>
                <th class="pb-4 font-semibold text-gray-700">Status</th>               
              </tr>
            </thead>
            <tbody class="divide-y divide-gray-50">
              <c:set var="processingOrdersFound" value="false"/>
              <c:choose>
                <c:when test="${not empty orderList}">
                  <c:forEach var="order" items="${orderList}" varStatus="status">
                    <c:if test="${order.status == 'Processing' && status.index < 10}">
                      <c:set var="processingOrdersFound" value="true"/>
                      <tr class="hover:bg-gray-50 transition-colors">
                        <td class="py-4 font-medium text-gray-900">#${order.orderId}</td>
                        
                        <td class="py-4">
                          <div class="flex items-center">
                            <div class="w-8 h-8 bg-blue-500 rounded-full flex items-center justify-center text-white font-bold text-sm mr-3">
                              <c:set var="emailParts" value="${fn:split(order.email, '@')}" />
                              <c:set var="firstChar" value="${fn:substring(emailParts[0], 0, 1)}" />
                              ${fn:toUpperCase(firstChar)}
                            </div>
                            <div>
                              <div class="font-medium text-gray-900">${order.email}</div>
                              <div class="text-sm text-gray-500">Customer</div>
                            </div>
                          </div>
                        </td>
                        
                        <td class="py-4 text-gray-600">
                          <fmt:formatDate value="${order.orderDate}" pattern="MMM dd, yyyy" />
                          <div class="text-sm text-gray-500">
                            <fmt:formatDate value="${order.orderDate}" pattern="HH:mm" />
                          </div>
                        </td>
                        
                        <td class="py-4 font-bold text-gray-900">
                          $<fmt:formatNumber value="${order.totalAmount}" type="number" minFractionDigits="2" maxFractionDigits="2"/>
                        </td>
                        
                        <td class="py-4">
                          <span class="status-badge status-processing">
                            Processing
                          </span>
                        </td>                     
                      </tr>
                    </c:if>
                  </c:forEach>
                  
                  <c:if test="${not processingOrdersFound}">
                    <tr>
                      <td colspan="6" class="py-8 text-center text-gray-500">
                        <i class="fas fa-clipboard-check text-4xl mb-4 block text-green-500"></i>
                        <div class="text-lg font-medium">No Processing Orders</div>
                        <div class="text-sm">All orders are either completed or pending payment</div>
                      </td>
                    </tr>
                  </c:if>
                </c:when>
                <c:otherwise>
                  <tr>
                    <td colspan="6" class="py-8 text-center text-gray-500">
                      <i class="fas fa-shopping-cart text-4xl mb-4 block"></i>
                      No orders found
                    </td>
                  </tr>
                </c:otherwise>
              </c:choose>
            </tbody>
          </table>
        </div>
      </div>

      <!-- Quick Actions -->
      <div class="glass-effect rounded-3xl p-8 shadow-2xl fade-in">
        <h2 class="text-2xl font-bold text-gray-800 mb-6">Quick Actions</h2>
        <div class="space-y-4">
          <a href="medicineAdd.jsp" class="flex items-center justify-between bg-gradient-to-r from-blue-500 to-blue-600 text-white p-4 rounded-2xl font-medium shadow-lg transition-all duration-300 hover:shadow-xl transform hover:scale-105">
            <div class="flex items-center">
              <i class="fas fa-pills mr-3 text-lg"></i>
              <span>Add New Medicine</span>
            </div>
            <i class="fas fa-arrow-right"></i>
          </a>
          
          <a href="discountAdd.jsp" class="flex items-center justify-between bg-gradient-to-r from-blue-500 to-blue-600 text-white p-4 rounded-2xl font-medium shadow-lg transition-all duration-300 hover:shadow-xl transform hover:scale-105">
            <div class="flex items-center">
              <i class="fas fa-percent mr-3 text-lg"></i>
              <span>Create Discount</span>
            </div>
            <i class="fas fa-arrow-right"></i>
          </a>
          
          <a href="viewOrders" class="flex items-center justify-between bg-gradient-to-r from-blue-500 to-blue-600 text-white p-4 rounded-2xl font-medium shadow-lg transition-all duration-300 hover:shadow-xl transform hover:scale-105">
            <div class="flex items-center">
              <i class="fas fa-chart-line mr-3 text-lg"></i>
              <span>View All Orders</span>
            </div>
            <i class="fas fa-arrow-right"></i>
          </a>
          
          <a href="" class="flex items-center justify-between bg-gradient-to-r from-blue-500 to-blue-600 text-white p-4 rounded-2xl font-medium shadow-lg transition-all duration-300 hover:shadow-xl transform hover:scale-105">
            <div class="flex items-center">
              <i class="fas fa-warehouse mr-3 text-lg"></i>
              <span>Manage Inventory</span>
            </div>
            <i class="fas fa-arrow-right"></i>
          </a>
        </div>

        <!-- Quick Stats -->
        <div class="mt-8 pt-6 border-t border-gray-200">
          <h3 class="text-lg font-semibold text-gray-800 mb-4">Today's Summary</h3>
          <div class="space-y-3">
            <div class="flex justify-between items-center">
              <span class="text-gray-600">New Orders</span>
              <span class="font-bold text-blue-600">
                <c:set var="todayOrders" value="0"/>
                <c:forEach var="order" items="${orderList}">
                  <c:set var="today" value="<%=new java.util.Date()%>"/>
                  <fmt:formatDate var="orderDateString" value="${order.orderDate}" pattern="yyyy-MM-dd"/>
                  <fmt:formatDate var="todayString" value="${today}" pattern="yyyy-MM-dd"/>
                  <c:if test="${orderDateString eq todayString}">
                    <c:set var="todayOrders" value="${todayOrders + 1}"/>
                  </c:if>
                </c:forEach>
                ${todayOrders}
              </span>
            </div>
            <div class="flex justify-between items-center">
              <span class="text-gray-600">Revenue</span>
              <span class="font-bold text-green-600">$1,847</span>
            </div>
            <div class="flex justify-between items-center">
              <span class="text-gray-600">Low Stock Items</span>
              <span class="font-bold text-red-600">${fn:length(lowStockList)}</span>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Low Stock Alert -->
    <c:if test="${not empty lowStockList}">
      <div class="glass-effect rounded-3xl p-8 shadow-2xl mt-8 fade-in">
        <div class="flex items-center justify-between mb-6">
          <h2 class="text-2xl font-bold text-gray-800">Low Stock Alert</h2>
          <div class="flex items-center space-x-2">
            <span class="low-stock px-3 py-1 rounded-full text-sm font-semibold">
              <i class="fas fa-exclamation-triangle mr-1"></i>
              Critical
            </span>
            <a href="medicines.jsp" class="text-blue-600 hover:text-blue-800 font-medium">Manage Stock</a>
          </div>
        </div>
        
        <div class="overflow-x-auto">
          <table class="w-full">
            <thead>
              <tr class="text-left border-b-2 border-gray-100">
                <th class="pb-4 font-semibold text-gray-700">Product Name</th>
                <th class="pb-4 font-semibold text-gray-700">Category</th>
                <th class="pb-4 font-semibold text-gray-700">Current Stock</th>
                <th class="pb-4 font-semibold text-gray-700">Unit Price</th>
              </tr>
            </thead>
            <tbody class="divide-y divide-gray-50">
              <c:forEach var="med" items="${lowStockList}" varStatus="status">
                <c:if test="${status.index < 5}">
                  <tr class="hover:bg-red-50 transition-colors">
                    <td class="py-4">
                      <div class="flex items-center">
                        <div class="w-10 h-10 bg-red-100 rounded-xl flex items-center justify-center mr-3">
                          <i class="fas fa-pills text-red-600"></i>
                        </div>
                        <div>
                          <div class="font-medium text-gray-900">${med.medName}</div>
                          <div class="text-sm text-gray-500">SKU: ${med.medId}</div>
                        </div>
                      </div>
                    </td>

                    <td class="py-4 text-gray-600">${med.category}</td>

                    <td class="py-4">
                      <span class="font-bold text-red-600">${med.quantity} units</span>
                    </td>

                    <td class="py-4 text-gray-600">
                      $<fmt:formatNumber value="${med.unitPrice}" type="number" minFractionDigits="2" maxFractionDigits="2"/>
                    </td>                  
                  </tr>
                </c:if>
              </c:forEach>
            </tbody>
          </table>
        </div>
      </div>
    </c:if>

  </div>

  <!-- Order Details Modal -->
  <div id="orderModal" class="fixed inset-0 bg-black bg-opacity-50 hidden z-50 flex items-center justify-center p-4">
    <div class="bg-white rounded-2xl max-w-2xl w-full max-h-[90vh] overflow-y-auto shadow-2xl">
      <!-- Modal Header -->
      <div class="bg-gradient-to-r from-teal-500 to-blue-600 text-white p-6 rounded-t-2xl">
        <div class="flex items-center justify-between">
          <div>
            <h3 class="text-2xl font-bold">Order Details</h3>
            <p class="text-teal-100 mt-1">Complete order information</p>
          </div>
          <button onclick="closeOrderModal()" class="text-white hover:text-gray-200 p-2 rounded-lg hover:bg-white/20 transition-colors">
            <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>
            </svg>
          </button>
        </div>
      </div>
      
      <!-- Modal Content -->
      <div class="p-6">
        <div class="grid grid-cols-1 gap-6">
          <!-- Order Information -->
          <div class="bg-gray-50 rounded-xl p-6">
            <h4 class="text-lg font-semibold text-gray-800 mb-4">Order Information</h4>
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
        </div>
        
        <!-- Modal Actions -->
        <div class="mt-6 flex justify-end gap-4 pt-6 border-t border-gray-200">
          <button onclick="closeOrderModal()" class="px-6 py-3 bg-gray-500 hover:bg-gray-600 text-white rounded-xl font-medium transition-colors">
            Close
          </button>
          <a href="orders.jsp" class="px-6 py-3 bg-gradient-to-r from-blue-500 to-teal-600 hover:from-blue-600 hover:to-teal-700 text-white rounded-xl font-medium transition-all">
            View All Orders
          </a>
        </div>
      </div>
    </div>
  </div>

  <script>
    // Modal Functions
    function viewOrderDetails(orderId, email, orderDate, totalAmount, status, deliveredDate) {
      console.log('Opening order modal:', orderId);
      
      // Update modal content
      document.getElementById('modalOrderId').textContent = orderId;
      document.getElementById('modalEmail').textContent = email;
      document.getElementById('modalOrderDate').textContent = orderDate;
      document.getElementById('modalTotalAmount').textContent = ' + parseFloat(totalAmount).toFixed(2);
      document.getElementById('modalDeliveredDate').textContent = deliveredDate === 'null' || !deliveredDate ? 'Not delivered yet' : deliveredDate;
      
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
      
      // Show modal
      document.getElementById('orderModal').classList.remove('hidden');
      document.body.style.overflow = 'hidden';
    }

    function closeOrderModal() {
      document.getElementById('orderModal').classList.add('hidden');
      document.body.style.overflow = 'auto';
    }

    // Sidebar toggle functionality
    document.getElementById('toggleSidebar').addEventListener('click', function() {
      const sidebar = document.getElementById('sidebar');
      const mainContent = document.getElementById('mainContent');
      
      if (sidebar && sidebar.classList.contains('sidebar-collapsed')) {
        sidebar.classList.remove('sidebar-collapsed');
        mainContent.classList.remove('sidebar-closed');
      } else if (sidebar) {
        sidebar.classList.add('sidebar-collapsed');
        mainContent.classList.add('sidebar-closed');
      }
    });

    // Animate stats on load
    document.addEventListener('DOMContentLoaded', function() {
      const statCards = document.querySelectorAll('.stat-card');
      statCards.forEach((card, index) => {
        card.style.animationDelay = `${index * 0.1}s`;
      });

      // Animate progress bars
      const progressBars = document.querySelectorAll('.progress-fill');
      progressBars.forEach(bar => {
        const width = bar.style.width;
        bar.style.width = '0%';
        setTimeout(() => {
          bar.style.width = width;
        }, 500);
      });
      
      // Close modal when clicking outside
      const modal = document.getElementById('orderModal');
      if (modal) {
        modal.addEventListener('click', function(e) {
          if (e.target === this) {
            closeOrderModal();
          }
        });
      }
      
      // Close modal with Escape key
      document.addEventListener('keydown', function(e) {
        if (e.key === 'Escape') {
          closeOrderModal();
        }
      });
    });

    // Add ripple effect to buttons
    document.querySelectorAll('.action-btn').forEach(button => {
      button.addEventListener('click', function(e) {
        const ripple = document.createElement('div');
        const rect = this.getBoundingClientRect();
        const size = Math.max(rect.width, rect.height);
        const x = e.clientX - rect.left - size / 2;
        const y = e.clientY - rect.top - size / 2;

        ripple.style.cssText = `
          position: absolute;
          width: ${size}px;
          height: ${size}px;
          left: ${x}px;
          top: ${y}px;
          background: rgba(255,255,255,0.6);
          border-radius: 50%;
          transform: scale(0);
          animation: ripple 0.6s ease-out;
          pointer-events: none;
        `;

        this.appendChild(ripple);
        setTimeout(() => ripple.remove(), 600);
      });
    });

    // Counter animation for stats
    function animateCounter(element, target, duration = 2000) {
      const start = 0;
      const increment = target / (duration / 16);
      let current = start;
      
      const timer = setInterval(() => {
        current += increment;
        if (current >= target) {
          current = target;
          clearInterval(timer);
        }
        
        if (element.textContent.includes(')) {
          element.textContent = ' + Math.floor(current).toLocaleString();
        } else {
          element.textContent = Math.floor(current).toLocaleString();
        }
      }, 16);
    }

    // Real-time clock
    function updateClock() {
      const now = new Date();
      const timeString = now.toLocaleTimeString();
      const dateString = now.toLocaleDateString();
      
      // Add clock if header exists
      const header = document.querySelector('header .flex div:last-child');
      if (header && !document.getElementById('clock')) {
        const clockDiv = document.createElement('div');
        clockDiv.id = 'clock';
        clockDiv.className = 'text-center mr-4 text-sm text-gray-600';
        clockDiv.innerHTML = `
          <div class="font-semibold">${timeString}</div>
          <div class="text-xs">${dateString}</div>
        `;
        header.insertBefore(clockDiv, header.firstChild);
      } else if (document.getElementById('clock')) {
        document.getElementById('clock').innerHTML = `
          <div class="font-semibold">${timeString}</div>
          <div class="text-xs">${dateString}</div>
        `;
      }
    }

    // Update clock every second
    setInterval(updateClock, 1000);
    updateClock();

    // Smooth scrolling for internal links
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
      anchor.addEventListener('click', function (e) {
        e.preventDefault();
        const target = document.querySelector(this.getAttribute('href'));
        if (target) {
          target.scrollIntoView({
            behavior: 'smooth',
            block: 'start'
          });
        }
      });
    });

    // Table row hover effects
    document.querySelectorAll('tbody tr').forEach(row => {
      row.addEventListener('mouseenter', function() {
        this.style.transform = 'scale(1.01)';
        this.style.zIndex = '10';
      });
      
      row.addEventListener('mouseleave', function() {
        this.style.transform = 'scale(1)';
        this.style.zIndex = 'auto';
      });
    });

    // Add CSS for ripple animation
    const style = document.createElement('style');
    style.textContent = `
      @keyframes ripple {
        to {
          transform: scale(4);
          opacity: 0;
        }
      }
      
      .sidebar-collapsed {
        margin-left: -250px;
      }
      
      .sidebar-closed {
        margin-left: 0;
        width: 100%;
      }
    `;
    document.head.appendChild(style);
  </script>

  <script src="<%= request.getContextPath() %>/js/adminSidebar.js"></script>

</body>
</html>