<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>MediQuick - Cart</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
</head>
<body class="bg-[#ecf1fc] text-[#333] font-sans font-medium tracking-wide min-h-screen flex flex-col pt-20">

  <%@ include file="./partials/navBar.jsp" %>

  <main class="px-4 py-10">
    <div class="max-w-screen-xl mx-auto grid grid-cols-1 lg:grid-cols-[2fr_1fr] gap-8 items-start">

      <!-- Left Column: Header + Cart Items -->
      <div class="flex-1 space-y-8">

        <!-- Shopping Cart Header -->
        <div class="bg-white rounded-xl shadow p-5 flex justify-between items-center">
          <div class="flex items-center gap-4">
            <div class="w-10 h-10 bg-gradient-to-r from-blue-400 to-purple-500 rounded-full"></div>
            <div>
              <h1 class="text-xl font-bold text-gray-800">Shopping Cart</h1>
              <p class="text-sm text-gray-500"><span id="item-count-top">${fn:length(cartItems)}</span> items in your cart</p>
            </div>
          </div>
          <a href="viewMedicine" class="text-blue-600 font-medium hover:no-underline text-sm">Add More Items</a>
		</div>

        <!-- Cart Items -->
        <div class="bg-white rounded-xl shadow p-6 space-y-6" id="cart-items">
          <c:forEach var="item" items="${cartItems}">
            <div class="cart-row flex flex-col md:flex-row justify-between border-b pb-5 group rounded-xl transition">

              <div class="flex items-start gap-4">
                <img src="medicineImage?id=${item.medId}" alt="${item.medName}" class="w-24 h-24 object-cover rounded border">
                <div>
                  <h2 class="text-lg font-bold text-gray-900">${item.medName}</h2>
                  <p class="text-sm text-gray-500">${item.brand}</p>
                  <p class="text-sm text-gray-500">${item.type} • ${item.dosage}</p>
                  <span class="inline-block bg-green-100 text-green-700 text-xs px-2 py-1 mt-1 rounded-full">In Stock</span>
                  <div class="mt-3 flex items-center gap-2">
                    <form action="updateCart" method="post" class="flex items-center gap-2">
					  <input type="hidden" name="email" value="${loggedCustomer.email}" />
					  <input type="hidden" name="medId" value="${item.medId}" />
					  <input type="number" name="quantity"
					         class="quantity-input w-16 px-2 py-1 border rounded text-center"
					         min="1" max="10" value="${item.quantity}" data-price="${item.unitPrice}"
					         onchange="this.form.submit()" />
					  <span class="text-sm text-gray-500">Qty</span>
					</form>
                  </div>
                </div>
              </div>
              <div class="mt-4 md:mt-0 flex flex-col items-end justify-between">
                <form action="deleteCart" method="post">
				  <input type="hidden" name="medId" value="${item.medId}">
				  <button class="text-red-500 text-sm hover:no-underline mb-2">
				    <i class="fas fa-trash mr-1"></i>Remove
				  </button>
				</form>
                <div class="text-right">
                  <p class="text-xl font-semibold text-[#1e88e5]">$<span class="item-total">${item.unitPrice * item.quantity}</span></p>
                  <p class="text-sm text-gray-400">$${item.unitPrice} each</p>
                </div>
              </div>
            </div>
          </c:forEach>

          <c:if test="${empty cartItems}">
            <div class="text-center py-20">
              <i class="fas fa-shopping-cart text-4xl text-gray-300 mb-4"></i>
              <h3 class="text-lg font-semibold text-gray-600 mb-2">Your cart is empty</h3>
              <a href="viewMedicine" class="inline-block mt-3 px-6 py-2 bg-[#1e88e5] text-white rounded hover:bg-blue-700 transition">
                <i class="fas fa-plus mr-1"></i>Shop Medicines
              </a>
            </div>
          </c:if>
        </div>
      </div>

      <!-- Right Column: Summary -->
      <div class="w-full lg:max-w-sm bg-white rounded-xl shadow p-6 lg:sticky lg:top-24 space-y-4">
	   <h3 class="text-xl font-bold mb-2"><i class="fas fa-receipt mr-2 text-[#1e88e5]"></i>Summary</h3>
		  <div class="flex justify-between items-center py-1">
		    <span class="text-sm">Subtotal (<span id="item-count">0</span>)</span>
		    <span class="text-sm font-medium">$<span id="subtotal">0.00</span></span>
		  </div>
		  <div class="flex justify-between">
		    <span>Shipping</span>
		    <span>$<span id="shipping">5.00</span></span>
		  </div>
		  <div class="flex justify-between text-gray-400">
		    <span>Discount</span>
		    <span>$<span id="discount">0.00</span></span>
		  </div>
		  <hr>
		  <div class="flex justify-between text-lg font-bold">
		    <span>Total</span>
		    <span class="text-[#1e88e5]">$<span id="total">0.00</span></span>
		  </div>
		  <form action="orderConfirm" method="post" id="checkoutForm">
			  <input type="hidden" name="email" value="${loggedCustomer.email}" />
			  <input type="hidden" name="subtotal" id="subtotalField" />
			  <input type="hidden" name="total" id="totalField" />
			  <button type="submit" class="w-full bg-[#1e88e5] text-white py-3 rounded-lg hover:bg-blue-700 transition">
			    <i class="fas fa-lock mr-2"></i>Checkout Securely
			  </button>
			</form>

	  </div>
    </div>
  </main>

  <%@ include file="./partials/footer.jsp" %>

  
  <script>
  function updateTotals() {
    let rows = document.querySelectorAll('.cart-row');
    let subtotal = 0;
    let count = 0;

    rows.forEach(row => {
      const input = row.querySelector('.quantity-input');
      const price = parseFloat(input.dataset.price);
      const qty = parseInt(input.value);
      const itemTotal = price * qty;

      count += qty;
      subtotal += itemTotal;

      const totalElem = row.querySelector('.item-total');
      if (totalElem) {
        totalElem.textContent = itemTotal.toFixed(2);
      }
    });

    const shipping = 5.00;
    const total = subtotal + shipping;

    document.getElementById('item-count').textContent = count;
    document.getElementById('item-count-top').textContent = count;
    document.getElementById('subtotal').textContent = subtotal.toFixed(2);
    document.getElementById('shipping').textContent = shipping.toFixed(2);
    document.getElementById('discount').textContent = "0.00";
    document.getElementById('total').textContent = total.toFixed(2);
  }

  document.addEventListener('input', function (e) {
    if (e.target.classList.contains('quantity-input')) {
      updateTotals();
    }
  });

  window.addEventListener('load', function () {
    updateTotals();
  });

  // ✅ This is the code you were asking about:
  document.getElementById("checkoutForm").addEventListener("submit", function () {
    const subtotal = document.getElementById("subtotal").textContent;
    const total = document.getElementById("total").textContent;

    document.getElementById("subtotalField").value = subtotal;
    document.getElementById("totalField").value = total;
  });
</script>



</body>
</html>
