<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>MediQuick - My Profile</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="bg-[#ecf1fc] text-gray-800 font-sans tracking-wide">

  <%@ include file="./partials/navBar.jsp" %>

  <main class="max-w-5xl mx-auto px-6 pt-20 pb-16">

    <!-- Profile Header -->
	<div class="bg-white shadow-xl rounded-3xl p-8 flex flex-col md:flex-row items-center md:items-start gap-8 mb-8 border border-gray-100">
	  <!-- Profile Avatar with Enhanced Design -->
	  <div class="relative">
	    <div class="w-32 h-32 rounded-full bg-gradient-to-br from-blue-600 via-purple-600 to-green-500 text-white text-4xl font-bold flex items-center justify-center shadow-2xl">
	      ${cus.firstName.substring(0,1)}${cus.lastName.substring(0,1)}
	    </div>
	  </div>
	
	  <!-- Profile Information -->
	  <div class="flex-1 text-center md:text-left">
	    <h1 class="text-4xl font-bold bg-gradient-to-r from-blue-600 via-purple-600 to-green-500 bg-clip-text text-transparent mb-2">
	      ${cus.firstName} ${cus.lastName}
	    </h1>
	    <p class="text-gray-600 text-lg mb-3">Customer ID: ${cus.cusID}</p>
	     
	    <!-- Enhanced Action Buttons -->
	    <div class="flex flex-wrap gap-4 justify-center md:justify-start">
	      <!-- View Orders Button -->
	      <a href="viewOrder" 
	         class="bg-gradient-to-r from-blue-500 to-blue-600 text-white px-6 py-3 rounded-2xl hover:from-blue-600 hover:to-blue-700 transition-all duration-300 shadow-lg hover:shadow-xl transform hover:scale-105 flex items-center gap-2 font-semibold">
	        <i class="fas fa-box"></i>
	        View Orders
	      </a>
	
	      <!-- Payment History Button -->
	      <a href="paymentHistory.jsp" 
	         class="bg-gradient-to-r from-purple-500 to-purple-600 text-white px-6 py-3 rounded-2xl hover:from-purple-600 hover:to-purple-700 transition-all duration-300 shadow-lg hover:shadow-xl transform hover:scale-105 flex items-center gap-2 font-semibold">
	        <i class="fas fa-credit-card"></i>
	        Payment History
	      </a>
	
	      <!-- Edit Profile Form -->
	      <form action="CusProfileEdit.jsp" method="post" class="inline-block">
		     <c:set var="cus" value="${cus}" scope="session" />
		     <button type="submit"
		         class="bg-gradient-to-r from-emerald-500 to-emerald-600 text-white px-6 py-3 rounded-2xl hover:from-emerald-600 hover:to-emerald-700 transition-all duration-300 shadow-lg hover:shadow-xl transform hover:scale-105 flex items-center gap-2 font-semibold">
		         <i class="fas fa-pen"></i> Edit Profile
		     </button>
		  </form>

	      <!-- Delete Profile Form -->
	      <form action="deleteCustomer" method="post" 
	            onsubmit="return confirm('Are you sure you want to delete your profile?');" 
	            class="inline-block">
	        <input type="hidden" name="cusID" value="${cus.cusID}" />
	        <input type="hidden" name="email" value="${cus.email}" />
	        
	        <button type="submit" 
	                class="bg-gradient-to-r from-red-500 to-red-600 text-white px-6 py-3 rounded-2xl hover:from-red-600 hover:to-red-700 transition-all duration-300 shadow-lg hover:shadow-xl transform hover:scale-105 flex items-center gap-2 font-semibold">
	          <i class="fas fa-trash-alt"></i>
	          Delete Profile
	        </button>
	      </form>
	    </div>
	  </div>
	</div>

     <!-- Profile Content -->
	<div class="space-y-6 text-[16px]">
	
	  <!-- Personal Info -->
	  <div class="bg-white rounded-xl shadow">
	    <div class="bg-blue-600 text-white px-6 py-3 rounded-t-xl">
		  <h2 class="text-xl font-semibold"><i class="fas fa-user mr-2"></i> Personal Information</h2>
		</div>
	    <div class="p-6 space-y-2">
	      <div class="flex items-center gap-4">
	        <label class="w-40 font-medium">First Name</label>
	        <input name="firstName" disabled class="flex-1 rounded-md border-gray-300 shadow-sm bg-gray-50 px-3 py-1.5" value="${cus.firstName}" />
	      </div>
	      <div class="flex items-center gap-4">
	        <label class="w-40 font-medium">Last Name</label>
	        <input name="lastName" disabled class="flex-1 rounded-md border-gray-300 shadow-sm bg-gray-50 px-3 py-1.5" value="${cus.lastName}" />
	      </div>
	      <div class="flex items-center gap-4">
	        <label class="w-40 font-medium">Email Address</label>
	        <input name="email" disabled class="flex-1 rounded-md border-gray-300 shadow-sm bg-gray-50 px-3 py-1.5" value="${cus.email}" />
	      </div>
	      <div class="flex items-center gap-4">
	        <label class="w-40 font-medium">Phone Number</label>
	        <input name="phone" disabled class="flex-1 rounded-md border-gray-300 shadow-sm bg-gray-50 px-3 py-1.5" value="${cus.phone}" />
	      </div>
	      <div class="flex items-center gap-4">
	        <label class="w-40 font-medium">Date of Birth</label>
	        <input name="dob" type="date" disabled class="flex-1 rounded-md border-gray-300 shadow-sm bg-gray-50 px-3 py-1.5" value="${cus.dob}" />
	      </div>
	      <div class="flex items-center gap-4 relative">
	        <label class="w-40 font-medium">Password</label>
	        <input name="password" type="password" id="password" disabled class="flex-1 rounded-md border-gray-300 shadow-sm bg-gray-50 px-3 py-1.5" value="${cus.password}" />
	        <button type="button" onclick="togglePassword()" class="absolute right-3 top-2 text-gray-500">
	          <i class="fas fa-eye"></i>
	        </button>
	      </div>
	    </div>
	  </div>
	
	  <!-- Address Info -->
	  <div class="bg-white rounded-xl shadow">
	    <div class="bg-blue-600 text-white px-6 py-3 rounded-t-xl">
		  <h2 class="text-xl font-semibold"><i class="fas fa-map-marker-alt mr-2"></i> Address Information</h2>
		</div>
	    <div class="p-6 space-y-2">
	      <div class="flex items-center gap-4">
	        <label class="w-40 font-medium">Street Address</label>
	        <input name="street" disabled class="flex-1 rounded-md border-gray-300 shadow-sm bg-gray-50 px-3 py-1.5" value="${cus.street}" />
	      </div>
	      <div class="flex items-center gap-4">
	        <label class="w-40 font-medium">City</label>
	        <input name="city" disabled class="flex-1 rounded-md border-gray-300 shadow-sm bg-gray-50 px-3 py-1.5" value="${cus.city}" />
	      </div>
	      <div class="flex items-center gap-4">
	        <label class="w-40 font-medium">State / Province</label>
	        <input name="state" disabled class="flex-1 rounded-md border-gray-300 shadow-sm bg-gray-50 px-3 py-1.5" value="${cus.state}" />
	      </div>
	      <div class="flex items-center gap-4">
	        <label class="w-40 font-medium">ZIP / Postal Code</label>
	        <input name="zipCode" disabled class="flex-1 rounded-md border-gray-300 shadow-sm bg-gray-50 px-3 py-1.5" value="${cus.zipCode}" />
	      </div>
	    </div>
	  </div>
	
	</div>
     
  </main>
  
  <c:if test="${sessionScope.profileUpdateSuccess == true}">
  <script>
    alert("✅ Profile updated successfully!");
  </script>
  <c:remove var="profileUpdateSuccess" scope="session" />
</c:if>
  

  <%@ include file="./partials/footer.jsp" %>

  <script>
    function togglePassword() {
    	  const pass = document.getElementById('password');
    	  pass.type = pass.type === 'password' ? 'text' : 'password';
    	}

  </script>

</body>
</html>