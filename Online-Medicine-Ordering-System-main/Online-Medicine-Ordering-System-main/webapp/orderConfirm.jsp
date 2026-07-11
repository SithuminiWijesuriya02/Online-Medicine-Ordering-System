<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>MediQuick - Order Confirmation</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
</head>
<body class="bg-[#ecf1fc] text-[#333] font-sans tracking-wide min-h-screen flex flex-col">

  <!-- Navigation Bar -->
  <%@ include file="./partials/navBar.jsp" %>

  <main class="flex-grow px-4 py-10">
  
  	<!-- Step Progress Bar -->
	<div class="max-w-6xl mx-auto mt-28 px-4">
	  <div class="bg-white rounded-2xl shadow-lg p-8">
	    <div class="relative flex justify-between items-center">
	      <!-- Progress line background -->
	      <div class="absolute top-5 left-0 w-full h-1 bg-gray-200 rounded-full z-0">
	        <div class="h-full bg-green-500 rounded-full transition-all duration-1000 ease-out" style="width: 50%;"></div>
	      </div>
	
	      <!-- Step 1 -->
	      <div class="relative z-10 flex flex-col items-center">
	        <div class="w-12 h-12 bg-green-500 text-white rounded-full flex items-center justify-center text-sm font-bold shadow-lg">
	          <i class="fas fa-check"></i>
	        </div>
	        <span class="text-sm font-medium text-gray-600 mt-3">Shopping Cart</span>
	      </div>
	
	      <!-- Step 2 (Current) -->
	      <div class="relative z-10 flex flex-col items-center">
	        <div class="w-12 h-12 bg-green-500 text-white rounded-full flex items-center justify-center text-sm font-bold shadow-lg animate-pulse">
	          2
	        </div>
	        <span class="text-sm font-medium text-green-600 mt-3 font-semibold">Order Details</span>
	      </div>
	
	      <!-- Step 3 -->
	      <div class="relative z-10 flex flex-col items-center">
	        <div class="w-12 h-12 bg-gray-300 text-gray-600 rounded-full flex items-center justify-center text-sm font-bold">
	          3
	        </div>
	        <span class="text-sm font-medium text-gray-500 mt-3">Payment</span>
	      </div>
	
	      <!-- Step 4 -->
	      <div class="relative z-10 flex flex-col items-center">
	        <div class="w-12 h-12 bg-gray-300 text-gray-600 rounded-full flex items-center justify-center text-sm font-bold">
	          4
	        </div>
	        <span class="text-sm font-medium text-gray-500 mt-3">Confirmation</span>
	      </div>
	    </div>
	  </div>
	</div>


  <!-- Main Content -->
  <div class="max-w-6xl mx-auto px-4 py-10">
    <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">
      <!-- Customer Information Form -->
      <div class="lg:col-span-2">
        <form id="orderForm" class="bg-white rounded-xl shadow" method="post" action="createOrder">
          <div class="bg-[#2563eb] text-white px-6 py-3 text-lg font-semibold flex items-center gap-2 rounded-t-xl">
            <i class="fas fa-user"></i> Customer Information
          </div>

          <div class="p-6 space-y-6">
            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
              <div>
                <label class="block font-medium">First Name <span class="text-red-500">*</span></label>
                <input type="text" name="firstName" value="${loggedCustomer.firstName}" required class="mt-1 w-full p-3 border rounded-lg focus:ring-2 focus:ring-blue-400 focus:border-blue-400">
              </div>
              <div>
                <label class="block font-medium">Last Name <span class="text-red-500">*</span></label>
                <input type="text" name="lastName" value="${loggedCustomer.lastName}" required class="mt-1 w-full p-3 border rounded-lg focus:ring-2 focus:ring-blue-400 focus:border-blue-400">
              </div>
            </div>

            <div>
              <label class="block font-medium">Email <span class="text-red-500">*</span></label>
              <input type="email" name="email" value="${loggedCustomer.email}" required class="mt-1 w-full p-3 border rounded-lg focus:ring-2 focus:ring-blue-400 focus:border-blue-400">
            </div>
         
              <div>
                <label class="block font-medium">Phone <span class="text-red-500">*</span></label>
                <input type="tel" name="phone" value="${loggedCustomer.phone}" required class="mt-1 w-full p-3 border rounded-lg focus:ring-2 focus:ring-blue-400 focus:border-blue-400">
              </div>
           
            <div>
              <label class="block font-medium">Street Address <span class="text-red-500">*</span></label>
              <input type="text" name="address" value="${loggedCustomer.street}" required class="mt-1 w-full p-3 border rounded-lg focus:ring-2 focus:ring-blue-400 focus:border-blue-400">
            </div>

            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
              <div>
                <label class="block font-medium">City <span class="text-red-500">*</span></label>
                <input type="text" name="city" value="${loggedCustomer.city}" required class="mt-1 w-full p-3 border rounded-lg focus:ring-2 focus:ring-blue-400 focus:border-blue-400">
              </div>
              <div>
                <label class="block font-medium">Province <span class="text-red-500">*</span></label>
                <select name="state" required class="mt-1 w-full p-3 border rounded-lg focus:ring-2 focus:ring-blue-400 focus:border-blue-400">
                  <option value="">Select Province</option>
                  <option value="Western Province" ${loggedCustomer.state == 'Western Province' ? 'selected' : ''}>Western Province</option>
                  <option value="Central Province" ${loggedCustomer.state == 'Central Province' ? 'selected' : ''}>Central Province</option>
                  <option value="Southern Province" ${loggedCustomer.state == 'Southern Province' ? 'selected' : ''}>Southern Province</option>
                  <option value="Northern Province" ${loggedCustomer.state == 'Northern Province' ? 'selected' : ''}>Northern Province</option>
                  <option value="Eastern Province" ${loggedCustomer.state == 'Eastern Province' ? 'selected' : ''}>Eastern Province</option>
                  <option value="North Western Province" ${loggedCustomer.state == 'North Western Province' ? 'selected' : ''}>North Western Province</option>
                  <option value="North Central Province" ${loggedCustomer.state == 'North Central Province' ? 'selected' : ''}>North Central Province</option>
                  <option value="Uva Province" ${loggedCustomer.state == 'Uva Province' ? 'selected' : ''}>Uva Province</option>
                  <option value="Sabaragamuwa Province" ${loggedCustomer.state == 'Sabaragamuwa Province' ? 'selected' : ''}>Sabaragamuwa Province</option>
                </select>
              </div>
            </div>

            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
              <div>
                <label class="block font-medium">Postal Code <span class="text-red-500">*</span></label>
                <input type="text" name="postal" value="${loggedCustomer.zipCode}" required class="mt-1 w-full p-3 border rounded-lg focus:ring-2 focus:ring-blue-400 focus:border-blue-400">
              </div>
              <div>
                <label class="block font-medium">Country <span class="text-red-500">*</span></label>
                <select name="country" required class="mt-1 w-full p-3 border rounded-lg focus:ring-2 focus:ring-blue-400 focus:border-blue-400">
                  <option value="Sri Lanka">Sri Lanka</option>
                </select>
              </div>
            </div>

            <div class="flex items-start gap-2">
              <input type="checkbox" id="terms" required class="mt-1">
              <label for="terms" class="text-sm">I agree to the <a href="#" class="text-blue-600 underline hover:text-blue-800">Terms & Conditions</a> and 
                <a href="#" class="text-blue-600 underline hover:text-blue-800">Privacy Policy</a></label>
            </div>

            <button type="submit" class="w-full bg-blue-600 text-white font-semibold py-3 rounded-lg hover:bg-blue-700 hover:shadow-md transition duration-200">
              Proceed to Payment
            </button>
          </div>
        </form>
      </div>

   <!-- Order Summary -->
   <div class="lg:col-span-1">
     <div class="bg-white rounded-xl shadow sticky top-24">
       <!-- Section Header -->
        <div class="bg-[#2563eb] text-white px-6 py-3 text-lg font-semibold flex items-center gap-2 rounded-t-xl">
          <i class="fas fa-box"></i> Order Summary
        </div>

        <!-- Product List -->
		<div class="p-6 space-y-4">
		  <c:set var="subtotal" value="0" />
		  <c:forEach var="item" items="${cartItems}">
		    <c:set var="itemTotal" value="${item.unitPrice * item.quantity}" />
		    <c:set var="subtotal" value="${subtotal + itemTotal}" />
		    
		    <div class="flex items-center justify-between bg-gray-50 rounded-lg p-3 hover:bg-gray-100 transition">
		      <div class="flex items-center gap-3">
		        <div class="w-10 h-10 bg-white rounded-full shadow flex items-center justify-center">
		          <i class="fas fa-pills text-red-500"></i>
		        </div>
		        <div>
		          <div class="font-semibold text-gray-800">${item.medName}</div>
		          <div class="text-sm text-gray-500">${item.brand} • Qty: ${item.quantity}</div>
		        </div>
		      </div>
		      <div class="text-blue-600 font-semibold">$<fmt:formatNumber value="${itemTotal}" type="number" minFractionDigits="2" /></div>
		    </div>
		  </c:forEach>
		</div>

		<!-- Price Summary -->
		<div class="border-t px-6 py-4 space-y-3">
		  <c:set var="shipping" value="5.00" />
		  <c:set var="discount" value="0.00" />
		  <c:set var="total" value="${subtotal + shipping - discount}" />
		
		  <div class="flex justify-between text-sm text-gray-600">
			  <span>Subtotal (${fn:length(cartItems)} items):</span>
			  <span>$<fmt:formatNumber value="${subtotal}" type="number" minFractionDigits="2" /></span>
		  </div>
		  <div class="flex justify-between text-sm text-gray-600">
			  <span>Shipping:</span>
			  <span>$<fmt:formatNumber value="${shipping}" type="number" minFractionDigits="2" /></span>
		  </div>
		  <div class="flex justify-between text-sm text-gray-600">
			  <span>Discount:</span>
			  <span class="text-green-600">$<fmt:formatNumber value="${discount}" type="number" minFractionDigits="2" /></span>
		  </div>
			<hr class="my-2">
		  <div class="flex justify-between font-bold text-lg text-blue-600">
			  <span>Total:</span>
			  <span>$<fmt:formatNumber value="${total}" type="number" minFractionDigits="2" /></span>
		  </div>
		  

        </div>
       </div>
      </div>
     </div>
    </div>
   </main>
   
  <!-- Footer -->
  <%@ include file="./partials/footer.jsp" %>
	

  <script>
	  document.getElementById('subtotalField').value = subtotal.toFixed(2);
	  document.getElementById('totalField').value = total.toFixed(2);

	  document.getElementById('orderForm').addEventListener('submit', function (e) {
	    const requiredFields = this.querySelectorAll('[required]');
	    let isValid = true;
	
	    requiredFields.forEach(field => {
	      if (!field.value.trim()) {
	        field.classList.add('border-red-500');
	        isValid = false;
	      } else {
	        field.classList.remove('border-red-500');
	      }
	    });
	
	    if (!isValid) {
	      e.preventDefault(); // Block submission only if validation fails
	      alert("Please fill in all required fields.");
	    } else {
	      // Optional success message
	      alert("Order information submitted! Redirecting to payment...");
	      //  Let form submit to action="createOrder"
	    }
	  });
	
	  // Remove red border when typing again
	  document.querySelectorAll('input, select').forEach(field => {
	    field.addEventListener('input', function () {
	      this.classList.remove('border-red-500');
	    });
	  });
	</script>

</body>
</html>