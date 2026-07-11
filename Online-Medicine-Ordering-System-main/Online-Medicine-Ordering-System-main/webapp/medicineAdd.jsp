<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>MediQuick Admin - New Medicine</title>
  <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-[#eaf3ff] h-screen flex items-center justify-center">

  <div class="flex w-full max-w-6xl h-[90vh] bg-white rounded-xl shadow-lg overflow-hidden">

    <!-- Left side: Title -->
    <div class="w-1/3 bg-[#4da5eb] text-white flex flex-col items-center justify-between py-12 px-10">
      <div class="text-center">
        <h2 class="text-3xl font-bold mb-4">Add New Medicine</h2>
      </div>
      <div class="flex gap-4">
        <a href="displayMedicine" class="bg-white text-[#2a75c0] px-6 py-2 rounded hover:bg-gray-200 transition">Cancel</a>
        <button form="medicineForm" type="submit" class="bg-white text-[#2a75c0] font-medium px-6 py-2 rounded hover:bg-gray-200 transition">Add Medicine</button>
      </div>
    </div>

    <!-- Right side: Form -->
    <div class="w-2/3 p-10 overflow-y-auto">
      <form id="medicineForm" class="space-y-4" method="post" action="${pageContext.request.contextPath}/addMedicine" enctype="multipart/form-data" novalidate>

        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
        
		  <!-- Medicine Name-->        
		  <div class="md:col-span-1">
		     <label for="medName" class="block text-sm font-medium text-gray-700 mb-1">Medicine Name</label>
		     <input type="text" id="medName" name="medicineName" required placeholder="e.g., Paracetamol"
		        class="w-full px-4 py-2 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-blue-400">
		  </div>
		
		  <!-- Image Upload-->
		  <div class="md:col-span-1">
		     <label for="image" class="block text-sm font-medium text-gray-700 mb-1">Medicine Image</label>
		     <input type="file" id="image" name="image" accept="image/*"
		        class="w-full px-2 py-2 border border-gray-300 rounded file:mr-4 file:py-2 file:px-4 file:rounded file:border-0 file:text-sm file:bg-blue-50 file:text-blue-700 hover:file:bg-blue-100">
		  </div>

		  <!-- Brand-->
          <div>
            <label for="brand" class="block text-sm font-medium text-gray-700 mb-1">Brand</label>
            <input type="text" id="brand" name="brand" required placeholder="e.g., GlaxoSmithKline"
              class="w-full px-4 py-2 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-blue-400">
          </div>

		  <!-- Dosage-->
          <div>
            <label for="dosage" class="block text-sm font-medium text-gray-700 mb-1">Dosage</label>
            <input type="text" id="dosage" name="dosage" required placeholder="e.g., 500mg, 10ml"
              class="w-full px-4 py-2 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-blue-400">
          </div>

		  <!-- Quantity-->
          <div>
            <label for="quantity" class="block text-sm font-medium text-gray-700 mb-1">Quantity</label>
            <input type="number" id="quantity" name="quantity" required placeholder="e.g., 100"
              class="w-full px-4 py-2 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-blue-400">
          </div>
		
		  <!-- Unit Price-->
          <div>
            <label for="unitPrice" class="block text-sm font-medium text-gray-700 mb-1">Unit Price (LKR)</label>
            <input type="number" step="0.01" id="unitPrice" name="unitPrice" required placeholder="e.g., 12.50"
              class="w-full px-4 py-2 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-blue-400">
          </div>

		  <!-- Medicine Type-->
          <div>
            <label for="medType" class="block text-sm font-medium text-gray-700 mb-1">Medicine Type</label>
            <select id="medType" name="type" required
              class="w-full px-4 py-2 border border-gray-300 rounded bg-white focus:outline-none focus:ring-2 focus:ring-blue-400">
              <option value="">Select Type</option>
              <option value="Tablet">Tablet</option>
              <option value="Syrup">Syrup</option>
              <option value="Capsule">Capsule</option>
              <option value="Injection">Injection</option>
              <option value="Cream">Cream</option>
              <option value="Drops">Drops</option>
              <option value="Gel">Gel</option>
              <option value="Inhaler">Inhaler</option>
              <option value="Powder">Powder</option>
              <option value="Others">Others</option>
            </select>
          </div>

		  <!-- Category-->
          <div>
            <label for="category" class="block text-sm font-medium text-gray-700 mb-1">Category</label>
            <select id="category" name="category" required
              class="w-full px-4 py-2 border border-gray-300 rounded bg-white focus:outline-none focus:ring-2 focus:ring-blue-400">
              <option value="">Select Category</option>
              <option value="Painkiller">Painkiller</option>
              <option value="Antibiotic">Antibiotic</option>
              <option value="Vitamin">Vitamin</option>
              <option value="Cough & Cold">Cough & Cold</option>
              <option value="Antacid">Antacid</option>
              <option value="Antifungal">Antifungal</option>
              <option value="Antiviral">Antiviral</option>
              <option value="Diabetes">Diabetes</option>
              <option value="Skin Care">Skin Care</option>
              <option value="Blood Pressure">Blood Pressure</option>
              <option value="Digestive Health">Digestive Health</option>
              <option value="Supplement">Supplement</option>
            </select>
          </div>
        </div>

		<!-- Description-->
        <div>
          <label for="description" class="block text-sm font-medium text-gray-700 mb-1">Description</label>
          <textarea id="description" name="description" rows="3" placeholder="Short description..."
            class="w-full px-4 py-2 border border-gray-300 rounded resize-none focus:outline-none focus:ring-2 focus:ring-blue-400"></textarea>
        </div>

      </form>
    </div>
  </div>
</body>
</html>
