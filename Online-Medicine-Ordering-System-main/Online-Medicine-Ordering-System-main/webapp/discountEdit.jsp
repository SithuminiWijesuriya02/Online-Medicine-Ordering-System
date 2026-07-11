<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>MediQuick Admin - Edit Discount</title>
  <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-[#eaf3ff] min-h-screen flex items-center justify-center p-6">
        
  <div class="w-full max-w-xl bg-white p-8 rounded-lg shadow-lg">
    <h2 class="text-2xl font-bold text-center text-[#2c3e50] mb-6">Edit Discount</h2>

    <form id="discountForm" action="${pageContext.request.contextPath}/updateDiscount" method="post" class="space-y-5" novalidate>
      <!-- Discount Code -->
      <div>
        <label class="block text-sm font-medium text-gray-700 mb-1">Discount Code</label>
        <input type="text" name="code" value="${param.code}" 
          class="w-full px-4 py-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-blue-400" />
      </div>

      <!-- Description -->
      <div>
        <label class="block text-sm font-medium text-gray-700 mb-1">Description</label>
        <textarea name="description" rows="3" 
          class="w-full px-4 py-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-blue-400">${param.description}</textarea>
      </div>

      <!-- Discount Percentage -->
      <div>
        <label class="block text-sm font-medium text-gray-700 mb-1">Discount Percentage (%)</label>
        <input type="number" id="percent" name="percentage"  value="${param.percentage}"
          class="w-full px-4 py-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-blue-400" />
      </div>

      <!-- Start Date -->
      <div>
        <label class="block text-sm font-medium text-gray-700 mb-1">Start Date</label>
        <input type="date" id="startDate" name="startDate"  value="${param.startDate}"
          class="w-full px-4 py-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-blue-400" />
      </div>

      <!-- End Date -->
      <div>
        <label class="block text-sm font-medium text-gray-700 mb-1">End Date</label>
        <input type="date" id="endDate" name="endDate"  value="${param.endDate}"
          class="w-full px-4 py-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-blue-400" />
      </div>

      <!-- Buttons -->
      <div class="flex justify-between mt-6">
      
		  <!-- Back Button -->
		 <a href="displayDiscounts" class="bg-gray-500 text-white px-6 py-2 rounded hover:bg-gray-600 transition">Cancel</a>
	 	
	 	
        <button type="submit"
          class="bg-[#1e88e5] text-white px-6 py-2 rounded hover:bg-blue-600 transition">Update Discount</button>
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
