<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>MediQuick - Prescription Management</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
  <style>
    .prescription-card {
      transition: all 0.3s ease-in-out;
      transform: translateY(0);
    }
    .prescription-card:hover {
      transform: translateY(-4px);
      box-shadow: 0 20px 40px rgba(0,0,0,0.15);
    }
    .upload-area {
      border: 2px dashed #cbd5e1;
      transition: all 0.3s ease;
    }
    .upload-area.dragover {
      border-color: #3b82f6;
      background-color: #eff6ff;
    }
    .status-pending {
      background: linear-gradient(135deg, #fbbf24, #f59e0b);
    }
    .status-approved {
      background: linear-gradient(135deg, #10b981, #059669);
    }
    .status-rejected {
      background: linear-gradient(135deg, #ef4444, #dc2626);
    }
    .status-expired {
      background: linear-gradient(135deg, #6b7280, #4b5563);
    }
    .fade-in {
      animation: fadeIn 0.5s ease-in-out;
    }
    @keyframes fadeIn {
      from { opacity: 0; transform: translateY(20px); }
      to { opacity: 1; transform: translateY(0); }
    }
  </style>
</head>
<body class="bg-[#ecf1fc] text-gray-800 font-sans tracking-wide min-h-screen flex flex-col">

  <!-- Navigation Bar -->
  <%@ include file="./partials/navBar.jsp" %>

  <!-- Background Pattern -->
  <div class="fixed inset-0 opacity-5 pointer-events-none">
    <div class="absolute inset-0" style="background-image: radial-gradient(circle at 25px 25px, #3b82f6 2px, transparent 0), radial-gradient(circle at 75px 75px, #8b5cf6 2px, transparent 0); background-size: 100px 100px;"></div>
  </div>

  <main class="relative z-10 pt-20 pb-12">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
      
      <!-- Header Section -->
      <div class="text-center mb-12 fade-in">
        <h1 class="text-4xl md:text-5xl font-bold bg-gradient-to-r from-blue-600 to-purple-600 bg-clip-text text-transparent mb-4">
          Prescription Management
        </h1>
        <p class="text-xl text-gray-600 max-w-3xl mx-auto">
          Upload your prescriptions securely, track their verification status, and order prescribed medicines with ease.
        </p>
      </div>

      <!-- Success/Error Messages -->
      <c:if test="${not empty sessionScope.successMessage}">
        <div class="max-w-4xl mx-auto mb-8">
          <div class="bg-green-50 border border-green-200 rounded-2xl p-4 shadow-lg fade-in">
            <div class="flex items-center">
              <i class="fas fa-check-circle text-green-500 text-xl mr-3"></i>
              <p class="text-green-800 font-medium">${sessionScope.successMessage}</p>
              <button onclick="this.parentElement.parentElement.parentElement.style.display='none'" 
                      class="ml-auto text-green-500 hover:text-green-700">
                <i class="fas fa-times"></i>
              </button>
            </div>
          </div>
        </div>
        <c:remove var="successMessage" scope="session"/>
      </c:if>

      <!-- Upload New Prescription Section -->
      <div class="max-w-4xl mx-auto mb-12">
        <div class="bg-white/95 backdrop-blur-sm rounded-3xl shadow-2xl p-8 border border-white/20">
          <div class="flex items-center mb-6">
            <div class="w-12 h-12 bg-blue-500 rounded-2xl flex items-center justify-center mr-4">
              <i class="fas fa-upload text-white text-xl"></i>
            </div>
            <h2 class="text-2xl font-bold text-gray-800">Upload New Prescription</h2>
          </div>

          <form id="prescriptionForm" action="uploadPrescription" method="post" enctype="multipart/form-data" class="space-y-6">
            <!-- Patient Information -->
            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
              <div>
                <label class="block text-sm font-semibold text-gray-700 mb-2">Patient Name</label>
                <input type="text" name="patientName" required
                       class="w-full px-4 py-3 rounded-xl border border-gray-200 focus:border-blue-400 focus:outline-none focus:ring-2 focus:ring-blue-200 transition-all"
                       placeholder="Enter patient full name">
              </div>
              <div>
                <label class="block text-sm font-semibold text-gray-700 mb-2">Patient Age</label>
                <input type="number" name="patientAge" required min="1" max="120"
                       class="w-full px-4 py-3 rounded-xl border border-gray-200 focus:border-blue-400 focus:outline-none focus:ring-2 focus:ring-blue-200 transition-all"
                       placeholder="Enter age">
              </div>
            </div>

            <!-- Doctor Information -->
            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
              <div>
                <label class="block text-sm font-semibold text-gray-700 mb-2">Doctor Name</label>
                <input type="text" name="doctorName" required
                       class="w-full px-4 py-3 rounded-xl border border-gray-200 focus:border-blue-400 focus:outline-none focus:ring-2 focus:ring-blue-200 transition-all"
                       placeholder="Enter doctor's name">
              </div>
              <div>
                <label class="block text-sm font-semibold text-gray-700 mb-2">Hospital/Clinic</label>
                <input type="text" name="hospital" required
                       class="w-full px-4 py-3 rounded-xl border border-gray-200 focus:border-blue-400 focus:outline-none focus:ring-2 focus:ring-blue-200 transition-all"
                       placeholder="Enter hospital or clinic name">
              </div>
            </div>

            <!-- Prescription Date -->
            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
              <div>
                <label class="block text-sm font-semibold text-gray-700 mb-2">Prescription Date</label>
                <input type="date" name="prescriptionDate" required
                       class="w-full px-4 py-3 rounded-xl border border-gray-200 focus:border-blue-400 focus:outline-none focus:ring-2 focus:ring-blue-200 transition-all">
              </div>
              <div>
                <label class="block text-sm font-semibold text-gray-700 mb-2">Priority</label>
                <select name="priority" required
                        class="w-full px-4 py-3 rounded-xl border border-gray-200 focus:border-blue-400 focus:outline-none focus:ring-2 focus:ring-blue-200 transition-all">
                  <option value="">Select Priority</option>
                  <option value="Normal">Normal</option>
                  <option value="Urgent">Urgent</option>
                  <option value="Emergency">Emergency</option>
                </select>
              </div>
            </div>

            <!-- Notes -->
            <div>
              <label class="block text-sm font-semibold text-gray-700 mb-2">Additional Notes (Optional)</label>
              <textarea name="notes" rows="3"
                        class="w-full px-4 py-3 rounded-xl border border-gray-200 focus:border-blue-400 focus:outline-none focus:ring-2 focus:ring-blue-200 transition-all"
                        placeholder="Any special instructions or notes..."></textarea>
            </div>

            <!-- File Upload Area -->
            <div>
              <label class="block text-sm font-semibold text-gray-700 mb-2">Prescription Image/Document</label>
              <div class="upload-area rounded-2xl p-8 text-center cursor-pointer" 
                   onclick="document.getElementById('fileInput').click()"
                   ondrop="handleDrop(event)" 
                   ondragover="handleDragOver(event)"
                   ondragenter="handleDragEnter(event)"
                   ondragleave="handleDragLeave(event)">
                <input type="file" id="fileInput" name="prescriptionFile" accept="image/*,.pdf" required class="hidden">
                <div id="uploadContent">
                  <i class="fas fa-cloud-upload-alt text-4xl text-gray-400 mb-4"></i>
                  <p class="text-lg font-semibold text-gray-600 mb-2">Drop your prescription here or click to browse</p>
                  <p class="text-sm text-gray-500">Supports: JPG, PNG, PDF (Max size: 10MB)</p>
                </div>
                <div id="filePreview" class="hidden">
                  <img id="previewImage" class="max-w-xs mx-auto rounded-lg shadow-lg mb-4">
                  <p id="fileName" class="text-sm font-medium text-gray-700"></p>
                  <button type="button" onclick="clearFile()" class="mt-2 text-red-500 hover:text-red-700">
                    <i class="fas fa-times mr-1"></i>Remove
                  </button>
                </div>
              </div>
            </div>

            <!-- Submit Button -->
            <div class="flex justify-end">
              <button type="submit" 
                      class="bg-gradient-to-r from-blue-500 to-purple-600 text-white px-8 py-4 rounded-2xl font-semibold text-lg hover:from-blue-600 hover:to-purple-700 transform hover:scale-105 transition-all duration-300 shadow-lg hover:shadow-xl flex items-center gap-3">
                <i class="fas fa-paper-plane"></i>
                Submit Prescription
              </button>
            </div>
          </form>
        </div>
      </div>

    </div>
  </main>

  <!-- Prescription Detail Modal -->
  <div id="prescriptionModal" class="fixed inset-0 bg-black bg-opacity-50 hidden z-50 flex items-center justify-center p-4">
    <div class="bg-white rounded-3xl max-w-2xl w-full max-h-[90vh] overflow-y-auto">
      <div class="p-6 border-b border-gray-200">
        <div class="flex items-center justify-between">
          <h3 class="text-2xl font-bold text-gray-800">Prescription Details</h3>
          <button onclick="closeModal()" class="text-gray-500 hover:text-gray-700">
            <i class="fas fa-times text-xl"></i>
          </button>
        </div>
      </div>    
    </div>
  </div>

  <!-- Footer -->
  <%@ include file="./partials/footer.jsp" %>

  <script>
    // File upload handling
    function handleDrop(e) {
      e.preventDefault();
      e.stopPropagation();
      
      const uploadArea = e.currentTarget;
      uploadArea.classList.remove('dragover');
      
      const files = e.dataTransfer.files;
      if (files.length > 0) {
        handleFileSelect(files[0]);
      }
    }

    function handleDragOver(e) {
      e.preventDefault();
      e.stopPropagation();
    }

    function handleDragEnter(e) {
      e.preventDefault();
      e.stopPropagation();
      e.currentTarget.classList.add('dragover');
    }

    function handleDragLeave(e) {
      e.preventDefault();
      e.stopPropagation();
      e.currentTarget.classList.remove('dragover');
    }

    document.getElementById('fileInput').addEventListener('change', function(e) {
      if (e.target.files.length > 0) {
        handleFileSelect(e.target.files[0]);
      }
    });

    function handleFileSelect(file) {
      const maxSize = 10 * 1024 * 1024; // 10MB
      const allowedTypes = ['image/jpeg', 'image/png', 'image/jpg', 'application/pdf'];
      
      if (file.size > maxSize) {
        alert('File size must be less than 10MB');
        return;
      }
      
      if (!allowedTypes.includes(file.type)) {
        alert('Please select a valid image (JPG, PNG) or PDF file');
        return;
      }
      
      const uploadContent = document.getElementById('uploadContent');
      const filePreview = document.getElementById('filePreview');
      const fileName = document.getElementById('fileName');
      const previewImage = document.getElementById('previewImage');
      
      uploadContent.classList.add('hidden');
      filePreview.classList.remove('hidden');
      fileName.textContent = file.name;
      
      if (file.type.startsWith('image/')) {
        const reader = new FileReader();
        reader.onload = function(e) {
          previewImage.src = e.target.result;
          previewImage.classList.remove('hidden');
        };
        reader.readAsDataURL(file);
      } else {
        previewImage.classList.add('hidden');
      }
    }

    function clearFile() {
      document.getElementById('fileInput').value = '';
      document.getElementById('uploadContent').classList.remove('hidden');
      document.getElementById('filePreview').classList.add('hidden');
      document.getElementById('previewImage').classList.add('hidden');
    }

    function refreshPrescriptions() {
      // Implement refresh functionality
      location.reload();
    }     

    // Initialize page
    document.addEventListener('DOMContentLoaded', function() {
      // Set max date for prescription date (today)
      const today = new Date().toISOString().split('T')[0];
      document.querySelector('input[name="prescriptionDate"]').max = today;
      
    });

  </script>

</body>
</html>