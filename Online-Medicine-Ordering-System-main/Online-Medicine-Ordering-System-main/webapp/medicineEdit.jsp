<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>MediQuick Admin - Edit Medicine</title>
  <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-[#eaf3ff] h-screen flex items-center justify-center">

  <div class="flex w-full max-w-6xl h-[90vh] bg-white rounded-xl shadow-lg overflow-hidden">

    <!-- Left side -->
    <div class="w-1/3 bg-[#4da5eb] text-white flex flex-col items-center justify-between py-12 px-10">
      <div class="text-center">
        <h2 class="text-3xl font-bold mb-4">Edit Medicine</h2>
         <p class="bg-white text-[#2a75c0] font-semibold rounded px-4 py-1 mt-3">MedicineID: ${param.id}</p>
      </div>
      <div class="flex gap-4">
        <a href="displayMedicine" class="bg-white text-[#2a75c0] px-6 py-2 rounded hover:bg-gray-200 transition">Cancel</a>
        <button form="medicineForm" type="submit" class="bg-white text-[#2a75c0] font-medium px-6 py-2 rounded hover:bg-gray-200 transition">Update</button>
      </div>
    </div>

    <!-- Right side: Form -->
    <div class="w-2/3 p-10 overflow-y-auto">
      <form id="medicineForm" action="${pageContext.request.contextPath}/updateMedicine" method="post" class="space-y-4" enctype="multipart/form-data" novalidate>

        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">

          <!-- Name -->
          <div>
            <label class="block text-sm font-medium text-gray-700 mb-1">Medicine Name</label>
            <input type="text" name="medName" value="${param.medName}"
              class="w-full px-4 py-2 border rounded focus:outline-none focus:ring-2 focus:ring-blue-400" />
          </div>

          <!-- Image -->
          <div>
            <label class="block text-sm font-medium text-gray-700 mb-1">Medicine Image</label>
            <input type="file" id="image" name="image" accept="image/*"
              class="w-full px-2 py-2 border border-gray-300 rounded file:mr-4 file:py-2 file:px-4 file:rounded file:border-0 file:text-sm file:bg-blue-50 file:text-blue-700 hover:file:bg-blue-100">
          </div>

          <!-- Brand -->
          <div>
            <label class="block text-sm font-medium text-gray-700 mb-1">Brand</label>
            <input type="text" name="brand" value="${param.brand}"
              class="w-full px-4 py-2 border rounded focus:outline-none focus:ring-2 focus:ring-blue-400" />
          </div>

          <!-- Dosage -->
          <div>
            <label class="block text-sm font-medium text-gray-700 mb-1">Dosage</label>
            <input type="text" name="dosage" value="${param.dosage}" placeholder="e.g., 500mg, 10ml"
              class="w-full px-4 py-2 border rounded focus:outline-none focus:ring-2 focus:ring-blue-400" />
          </div>

          <!-- Quantity -->
          <div>
            <label class="block text-sm font-medium text-gray-700 mb-1">Quantity</label>
            <input type="number" name="quantity" value="${param.quantity}"
              class="w-full px-4 py-2 border rounded focus:outline-none focus:ring-2 focus:ring-blue-400" />
          </div>

          <!-- Unit Price -->
          <div>
            <label class="block text-sm font-medium text-gray-700 mb-1">Unit Price</label>
            <input type="number" step="0.01" name="unitPrice" value="${param.unitPrice}"
              class="w-full px-4 py-2 border rounded focus:outline-none focus:ring-2 focus:ring-blue-400" />
          </div>

          <!-- Type -->
          <div>
            <label class="block text-sm font-medium text-gray-700 mb-1">Medicine Type</label>
            <select name="type" class="w-full px-4 py-2 border rounded focus:outline-none focus:ring-2 focus:ring-blue-400">
              <option value="">Select Type</option>
              <option value="Tablet" ${param.type == 'Tablet' ? 'selected' : ''}>Tablet</option>
              <option value="Syrup" ${param.type == 'Syrup' ? 'selected' : ''}>Syrup</option>
              <option value="Capsule" ${param.type == 'Capsule' ? 'selected' : ''}>Capsule</option>
              <option value="Injection" ${param.type == 'Injection' ? 'selected' : ''}>Injection</option>
              <option value="Cream" ${param.type == 'Cream' ? 'selected' : ''}>Cream</option>
              <option value="Drops" ${param.type == 'Drops' ? 'selected' : ''}>Drops</option>
              <option value="Gel" ${param.type == 'Gel' ? 'selected' : ''}>Gel</option>
              <option value="Inhaler" ${param.type == 'Inhaler' ? 'selected' : ''}>Inhaler</option>
              <option value="Powder" ${param.type == 'Powder' ? 'selected' : ''}>Powder</option>
              <option value="Others" ${param.type == 'Others' ? 'selected' : ''}>Others</option>
            </select>
          </div>

          <!-- Category -->
          <div>
            <label class="block text-sm font-medium text-gray-700 mb-1">Category</label>
            <input type="text" name="category" value="${param.category}"
              class="w-full px-4 py-2 border rounded focus:outline-none focus:ring-2 focus:ring-blue-400" />
          </div>
        </div>

        <!-- Description -->
        <div>
          <label class="block text-sm font-medium text-gray-700 mb-1">Description</label>
          <textarea name="description" value="${param.description}" rows="3" class="w-full px-4 py-2 border rounded focus:outline-none focus:ring-2 focus:ring-blue-400">${param.description}</textarea>
        </div>

      </form>
    </div>
  </div>
</body>
</html>
