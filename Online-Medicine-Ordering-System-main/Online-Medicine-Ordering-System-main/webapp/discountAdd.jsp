<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>MediQuick Admin - New Discount</title>
  <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-[#eaf3ff] min-h-screen flex items-center justify-center p-6">
    
  <div class="w-full max-w-xl bg-white p-8 rounded-lg shadow-lg">
    <h2 class="text-2xl font-bold text-center text-[#2c3e50] mb-6">Create New Discount</h2>

    <form id="discountForm" class="space-y-4" method="post" action="${pageContext.request.contextPath}/addDiscount" novalidate>
    
    <!-- Discount Code -->
      <div>
        <label for="code" class="block text-sm font-medium text-gray-700 mb-1">Discount Code</label>
        <input type="text" id="code" name="code"  placeholder="e.g., SAVE10"
          class="w-full px-4 py-2 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-blue-400">
      </div>
      
	  <!-- Description -->
      <div>
        <label for="desc" class="block text-sm font-medium text-gray-700 mb-1">Description</label>
        <textarea id="desc" name="desc"  placeholder="e.g., 10% off orders above $50"
          class="w-full px-4 py-2 border border-gray-300 rounded h-24 resize-none focus:outline-none focus:ring-2 focus:ring-blue-400"></textarea>
      </div>

	  <!-- Discount Percentage -->
      <div>
        <label for="percent" class="block text-sm font-medium text-gray-700 mb-1">Discount Percentage (%)</label>
        <input type="number" id="percent" name="percentage" placeholder="e.g., 10"
          class="w-full px-4 py-2 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-blue-400">
      </div>

	  <!-- Start Date -->
      <div>
        <label for="startDate" class="block text-sm font-medium text-gray-700 mb-1">Start Date</label>
        <input type="date" id="startDate" name="startDate" 
          class="w-full px-4 py-2 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-blue-400">
      </div>

	  <!-- End Date -->
      <div>
        <label for="endeDate" class="block text-sm font-medium text-gray-700 mb-1">End Date</label>
        <input type="date" id="endDate" name="endDate" 
          class="w-full px-4 py-2 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-blue-400">
      </div>

      <!-- Button Row -->
      <div class="flex justify-between mt-6">
        <!-- Back Button -->
		 <a href="displayDiscounts" class="bg-gray-500 text-white px-6 py-2 rounded hover:bg-gray-600 transition">Cancel</a>
		 	
        <!-- Submit Button -->
        <button type="submit"
          class="px-6 py-2 bg-[#1e88e5] text-white font-medium rounded hover:bg-blue-600 transition">
          Create Discount
        </button>
      </div>
    </form>
  </div>
  
 <script>
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

 </script>


</body>
</html>
