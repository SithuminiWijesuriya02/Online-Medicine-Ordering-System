<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>MediQuick - Secure Payment</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
  <style>
  .input-group {
    position: relative;
  }

  .floating-label {
    transition: all 0.2s ease-in-out;
    left: 1rem;
    top: 1.25rem;
    font-size: 1rem;
  }

  .input-group.has-value .floating-label,
  .input-group input:focus + .floating-label {
    top: -0.5rem;
    left: 1rem;
    font-size: 0.75rem;
    background: white;
    padding: 0 0.25rem;
    color: #3b82f6; /* Tailwind blue-600 */
  }
</style>
</head>
<body class="bg-[#ecf1fc] text-[#333] font-sans tracking-wide min-h-screen flex flex-col">

  <!-- Navigation Bar -->
  <%@ include file="./partials/navBar.jsp" %>

  <main class="flex-grow px-4 py-10">
  <!-- Step Progress Bar -->
  <div class="max-w-6xl mx-auto mt-28 px-4">
    <div class="bg-white rounded-2xl shadow-lg p-8">
      <div class="relative flex justify-between items-center">
        <!-- Progress line -->
        <div class="absolute top-5 left-0 w-full h-1 bg-gray-200 rounded-full z-0">
          <div class="h-full bg-green-500 rounded-full transition-all duration-1000 ease-out" style="width: 66.66%;"></div>
        </div>

        <!-- Step 1 -->
        <div class="relative z-10 flex flex-col items-center">
          <div class="w-12 h-12 bg-green-500 text-white rounded-full flex items-center justify-center text-sm font-bold shadow-lg">
            <i class="fas fa-check"></i>
          </div>
          <span class="text-sm font-medium text-gray-600 mt-3">Shopping Cart</span>
        </div>

        <!-- Step 2 -->
        <div class="relative z-10 flex flex-col items-center">
          <div class="w-12 h-12 bg-green-500 text-white rounded-full flex items-center justify-center text-sm font-bold shadow-lg">
            <i class="fas fa-check"></i>
          </div>
          <span class="text-sm font-medium text-gray-600 mt-3">Order Details</span>
        </div>

        <!-- Step 3 -->
        <div class="relative z-10 flex flex-col items-center">
          <div class="w-12 h-12 bg-green-500 text-white rounded-full flex items-center justify-center text-sm font-bold shadow-lg animate-pulse">
            3
          </div>
          <span class="text-sm font-medium text-green-600 mt-3 font-semibold">Secure Payment</span>
        </div>

        <!-- Step 4 -->
        <div class="relative z-10 flex flex-col items-center">
          <div class="w-12 h-12 bg-gray-200 text-gray-500 rounded-full flex items-center justify-center text-sm font-bold">4</div>
          <span class="text-sm font-medium text-gray-400 mt-3">Confirmation</span>
        </div>
      </div>
  </div>

  <!-- Main Content -->
  <div class="max-w-7xl mx-auto px-4 py-10">
    <div class="grid grid-cols-1 lg:grid-cols-2 gap-12">
      
      <!-- Left Section - Payment Method Selection -->
      <div class="space-y-8">
        <!-- Choose Payment Method Section -->
        <div class="bg-white rounded-2xl shadow-lg overflow-hidden">
          <div class="bg-blue-600 text-white px-8 py-6">
            <h2 class="text-2xl font-bold flex items-center gap-3">
              <i class="fas fa-credit-card"></i>
              Choose Payment Method
            </h2>
            <p class="text-blue-100 mt-2">Select your preferred payment option</p>
          </div>

          <div class="p-8">
            <!-- Payment Method Selection Cards -->
            <div class="space-y-4">
              <!-- Credit Card -->
              <label class="payment-method-card cursor-pointer block">
                <input type="radio" name="paymentMethod" value="credit_card" checked class="hidden payment-radio">
                <div class="bg-white border-2 rounded-xl p-6 flex items-center gap-4 hover:shadow-lg transition-all">
                  <div class="w-16 h-16 bg-blue-500 rounded-full flex items-center justify-center flex-shrink-0">
                    <i class="fas fa-credit-card text-white text-xl"></i>
                  </div>
                  <div class="flex-1">
                    <h3 class="font-semibold text-gray-800 mb-1">Credit/Debit Card</h3>
                    <p class="text-sm text-gray-600">Visa, Mastercard, AMEX</p>
                    <div class="mt-2 flex gap-2">
                      <i class="fab fa-cc-visa text-blue-600"></i>
                      <i class="fab fa-cc-mastercard text-red-500"></i>
                      <i class="fab fa-cc-amex text-blue-700"></i>
                    </div>
                  </div>
                </div>
              </label>

              <!-- PayPal -->
              <label class="payment-method-card cursor-pointer block">
                <input type="radio" name="paymentMethod" value="paypal" class="hidden payment-radio">
                <div class="bg-white border-2 rounded-xl p-6 flex items-center gap-4 hover:shadow-lg transition-all">
                  <div class="w-16 h-16 bg-purple-600 rounded-full flex items-center justify-center flex-shrink-0">
                    <i class="fab fa-paypal text-white text-xl"></i>
                  </div>
                  <div class="flex-1">
                    <h3 class="font-semibold text-gray-800 mb-1">PayPal</h3>
                    <p class="text-sm text-gray-600">Fast & Secure payment</p>
                    <div class="mt-2">
                      <i class="fab fa-paypal text-purple-600 text-lg"></i>
                    </div>
                  </div>
                </div>
              </label>

              <!-- Bank Transfer -->
              <label class="payment-method-card cursor-pointer block">
                <input type="radio" name="paymentMethod" value="bank_transfer" class="hidden payment-radio">
                <div class="bg-white border-2 rounded-xl p-6 flex items-center gap-4 hover:shadow-lg transition-all">
                  <div class="w-16 h-16 bg-green-500 rounded-full flex items-center justify-center flex-shrink-0">
                    <i class="fas fa-university text-white text-xl"></i>
                  </div>
                  <div class="flex-1">
                    <h3 class="font-semibold text-gray-800 mb-1">Bank Transfer</h3>
                    <p class="text-sm text-gray-600">Direct bank payment</p>
                    <div class="mt-2">
                      <i class="fas fa-university text-green-500"></i>
                    </div>
                  </div>
                </div>
              </label>
            </div>
          </div>
        </div>
      </div>

      <!-- Right Section - Payment Details Form -->
      <div class="space-y-8">
        <form id="paymentForm" action="updateOrder" method="post">
        <input type="hidden" name="orderId" value="${orderId}" />
        <input type="hidden" name="action" value="payNow" />
          
          <!-- Credit Card Section -->
          <div id="creditCardSection" class="bg-white rounded-2xl shadow-lg">
            <div class="bg-blue-600 text-white px-8 py-6">
              <h2 class="text-xl font-bold flex items-center gap-3">
                <i class="fas fa-lock"></i>
                Card Information
              </h2>
              <p class="text-blue-100 mt-1">Your payment details are encrypted and secure</p>
            </div>

            <div class="p-8 space-y-6">
              <div class="input-group relative">
                <input type="text" name="cardNumber" id="cardNumber" maxlength="19" 
                       class="w-full p-4 border-2 rounded-xl focus:border-green-500 focus:outline-none transition-all peer placeholder-transparent" 
                       placeholder="Card Number" required>
                <label for="cardNumber" class="floating-label absolute left-4 top-4 text-gray-500 pointer-events-none">
                  Card Number
                </label>
                <div class="absolute right-4 top-4" id="cardTypeIcon">
                  <i class="fas fa-credit-card text-gray-400 text-xl"></i>
                </div>
              </div>

              <div class="input-group relative">
                <input type="text" name="cardholderName" id="cardholderName" 
                       class="w-full p-4 border-2 rounded-xl focus:border-green-500 focus:outline-none transition-all peer placeholder-transparent" 
                        required>
                <label for="cardholderName" class="floating-label absolute left-4 top-4 text-gray-500 pointer-events-none">
                  Cardholder Name
                </label>
              </div>

              <div class="grid grid-cols-2 gap-4">
                <div class="input-group relative">
                  <input type="text" name="expiryDate" id="expiryDate" maxlength="5" 
                         class="w-full p-4 border-2 rounded-xl focus:border-green-500 focus:outline-none transition-all peer placeholder-transparent" 
                         placeholder="MM/YY" required>
                  <label for="expiryDate" class="floating-label absolute left-4 top-4 text-gray-500 pointer-events-none">
                    MM/YY
                  </label>
                </div>
                <div class="input-group relative">
                  <input type="text" name="cvv" id="cvv" maxlength="4" 
                         class="w-full p-4 border-2 rounded-xl focus:border-green-500 focus:outline-none transition-all peer placeholder-transparent" 
                         placeholder="CVV" required>
                  <label for="cvv" class="floating-label absolute left-4 top-4 text-gray-500 pointer-events-none">
                    CVV
                  </label>
                  <i class="fas fa-question-circle absolute right-4 top-4 text-gray-400 cursor-help" 
                     title="3 or 4 digit security code on the back of your card"></i>
                </div>
              </div>

              <!-- Security Features -->
              <div class="bg-blue-50 border border-blue-200 rounded-xl p-4">
                <div class="flex items-center gap-3">
                  <i class="fas fa-shield-alt text-blue-600 text-xl"></i>
                  <div>
                    <div class="font-semibold text-blue-800">256-bit SSL Encryption</div>
                    <div class="text-sm text-blue-600">Your payment is 100% secure and encrypted</div>
                  </div>
                </div>
              </div>
            </div>
          </div>

          <!-- PayPal Section -->
          <div id="paypalSection" class="hidden bg-white rounded-2xl shadow-lg mb-8">
            <div class="bg-purple-600 text-white px-8 py-6">
              <h2 class="text-xl font-bold flex items-center gap-3">
                <i class="fab fa-paypal"></i>
                PayPal Payment
              </h2>
            </div>
            <div class="p-8 text-center">
              <div class="w-24 h-24 bg-purple-100 rounded-full flex items-center justify-center mx-auto mb-6">
                <i class="fab fa-paypal text-purple-600 text-3xl"></i>
              </div>
              <h3 class="text-xl font-semibold text-gray-800 mb-4">Secure PayPal Checkout</h3>
              <p class="text-gray-600 mb-6">You'll be redirected to PayPal to complete your payment securely.</p>
              <div class="bg-purple-50 border border-blue-200 rounded-xl p-4">
                <div class="flex items-center justify-center gap-2 text-purple-700">
                  <i class="fas fa-shield-check"></i>
                  <span class="font-medium">PayPal Buyer Protection</span>
                </div>
              </div>
            </div>
          </div>

          <!-- Bank Transfer Section -->
          <div id="bankTransferSection" class="hidden bg-white rounded-2xl shadow-lg mb-8">
            <div class="bg-green-600 text-white px-8 py-6">
              <h2 class="text-xl font-bold flex items-center gap-3">
                <i class="fas fa-university"></i>
                Bank Transfer Details
              </h2>
            </div>
            <div class="p-8">
              <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
                <div>
                  <h4 class="font-semibold text-gray-800 mb-4">Transfer to:</h4>
                  <div class="bg-gray-50 rounded-xl p-6 space-y-3">
                    <div class="flex justify-between">
                      <span class="text-gray-600">Bank:</span>
                      <span class="font-semibold">Commercial Bank of Ceylon</span>
                    </div>
                    <div class="flex justify-between">
                      <span class="text-gray-600">Account Name:</span>
                      <span class="font-semibold">MediQuick (Pvt) Ltd</span>
                    </div>
                    <div class="flex justify-between">
                      <span class="text-gray-600">Account Number:</span>
                      <span class="font-mono font-semibold">8001234567</span>
                    </div>
                    <div class="flex justify-between">
                      <span class="text-gray-600">Branch:</span>
                      <span class="font-semibold">Colombo Main</span>
                    </div>
                    <div class="flex justify-between border-t pt-2">
                      <span class="text-gray-600">Reference:</span>
                      <span class="font-mono font-semibold text-blue-600">ORDER-${orderId}</span>
                    </div>
                  </div>
                </div>

                <!-- Bank Slip Upload -->
                <div>
                  <h4 class="font-semibold text-gray-800 mb-4">Upload Payment Proof</h4>
                  <div class="border-2 border-dashed border-gray-300 rounded-xl p-8 text-center hover:border-blue-400 transition-all">
                    <input type="file" name="bankSlip" accept=".jpg,.jpeg,.png,.pdf" class="hidden" id="bankSlipInput">
                    <div id="uploadArea" class="cursor-pointer" onclick="document.getElementById('bankSlipInput').click()">
                      <i class="fas fa-cloud-upload-alt text-gray-400 text-4xl mb-4"></i>
                      <p class="text-gray-600 mb-2">Click to upload or drag and drop</p>
                      <p class="text-sm text-gray-500">JPG, PNG or PDF (max 5MB)</p>
                    </div>
                    <div id="uploadedFile" class="hidden">
                      <i class="fas fa-file-check text-blue-500 text-3xl mb-2"></i>
                      <p id="fileName" class="text-blue-600 font-semibold"></p>
                      <button type="button" onclick="removeFile()" class="text-red-500 text-sm mt-2">Remove</button>
                    </div>
                  </div>
                </div>
              </div>

              <div class="bg-amber-50 border border-amber-200 rounded-xl p-4 mt-6">
                <div class="flex items-start gap-3">
                  <i class="fas fa-exclamation-triangle text-amber-600 mt-1"></i>
                  <div class="text-amber-800">
                    <div class="font-semibold">Important Instructions:</div>
                    <ul class="text-sm mt-1 space-y-1">
                      <li>Use the exact reference number when making the transfer</li>
                      <li>Upload a clear photo/scan of your bank slip</li>
                      <li>Processing time: 1-2 business days</li>
                    </ul>
                  </div>
                </div>
              </div>
            </div>
          </div>

          <!-- Action Buttons -->
          <div class="flex gap-6 mt-8">
            <button type="button" onclick="history.back()" 
                    class="flex-1 bg-gray-500 text-white font-semibold py-4 px-8 rounded-xl hover:bg-gray-600 transition-all duration-200 shadow-lg hover:shadow-xl">
              <i class="fas fa-arrow-left mr-2"></i>
              Back to Order Details
            </button>                     
	            <button type="submit" id="submitBtn"
	                    class="flex-1 bg-blue-600 text-white font-semibold py-4 px-8 rounded-xl hover:bg-blue-700 transition-all duration-200 shadow-lg hover:shadow-xl transform hover:scale-105">
	              <i class="fas fa-lock mr-2"></i>
	              <span id="submitText">Complete Secure Payment</span>
	            </button>	         
          </div>
        </form>
      </div>
    </div>
    </div>
  </div>
  </main>
  
	<!-- Payment Success Modal -->
	<div id="successModal" class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 hidden">
	  <div class="bg-white p-8 rounded-2xl shadow-lg text-center max-w-md w-full transform transition-all duration-500 scale-90 opacity-0">
	    <div class="text-green-500 text-5xl mb-4">
	      <i class="fas fa-check-circle"></i>
	    </div>
	    <h2 class="text-2xl font-bold text-gray-800 mb-2">Payment Successful</h2>
	    <p class="text-gray-600 mb-6">Thank you! Your payment was completed successfully.</p>
	    <form action="updateOrder" method="post">  
		    <button class="bg-blue-600 text-white font-semibold px-6 py-3 rounded-xl hover:bg-blue-700 transition">
		      View My Order
		    </button>
		    </form>
		</div>
	</div>

   
  <!-- Footer -->
  <%@ include file="./partials/footer.jsp" %>

  <script>
	  // Payment method selection
	  document.querySelectorAll('.payment-radio').forEach(radio => {
	    radio.addEventListener('change', function () {
	      document.querySelectorAll('.payment-method-card').forEach(card => {
	        card.classList.remove('selected');
	      });
	      this.closest('.payment-method-card').classList.add('selected');
	
	      document.getElementById('creditCardSection').classList.add('hidden');
	      document.getElementById('paypalSection').classList.add('hidden');
	      document.getElementById('bankTransferSection').classList.add('hidden');
	
	      if (this.value === 'credit_card') {
	        document.getElementById('creditCardSection').classList.remove('hidden');
	      } else if (this.value === 'paypal') {
	        document.getElementById('paypalSection').classList.remove('hidden');
	      } else if (this.value === 'bank_transfer') {
	        document.getElementById('bankTransferSection').classList.remove('hidden');
	      }
	    });
	  });
	
	  document.querySelector('.payment-radio').closest('.payment-method-card').classList.add('selected');
	
	  // Card number formatting
	  document.getElementById('cardNumber').addEventListener('input', function () {
	    let value = this.value.replace(/\s+/g, '').replace(/[^0-9]/gi, '');
	    this.value = value.match(/.{1,4}/g)?.join(' ') || value;
	
	    const cardTypeIcon = document.getElementById('cardTypeIcon');
	    if (value.startsWith('4')) cardTypeIcon.innerHTML = '<i class="fab fa-cc-visa text-blue-600 text-xl"></i>';
	    else if (value.startsWith('5')) cardTypeIcon.innerHTML = '<i class="fab fa-cc-mastercard text-red-500 text-xl"></i>';
	    else if (value.startsWith('3')) cardTypeIcon.innerHTML = '<i class="fab fa-cc-amex text-blue-700 text-xl"></i>';
	    else cardTypeIcon.innerHTML = '<i class="fas fa-credit-card text-gray-400 text-xl"></i>';
	
	    updateFloatingLabel(this);
	  });
	
	  document.getElementById('cardholderName').addEventListener('input', function () {
	    updateFloatingLabel(this);
	  });
	
	  document.getElementById('expiryDate').addEventListener('input', function () {
	    let value = this.value.replace(/\D/g, '');
	    if (value.length >= 2) {
	      value = value.substring(0, 2) + '/' + value.substring(2, 4);
	    }
	    this.value = value;
	    updateFloatingLabel(this);
	  });
	
	  document.getElementById('cvv').addEventListener('input', function () {
	    this.value = this.value.replace(/\D/g, '').substring(0, 4);
	    updateFloatingLabel(this);
	  });
	
	  function updateFloatingLabel(input) {
	    const group = input.closest('.input-group');
	    input.value.trim() ? group.classList.add('has-value') : group.classList.remove('has-value');
	  }
	
	  document.querySelectorAll('.input-group input').forEach(input => {
	    updateFloatingLabel(input);
	    input.addEventListener('blur', () => updateFloatingLabel(input));
	  });
	
	  // Bank slip upload logic
	  const bankSlipInput = document.getElementById('bankSlipInput');
	  bankSlipInput.addEventListener('change', function () {
	    const file = this.files[0];
	    if (file && file.size <= 5 * 1024 * 1024) {
	      document.getElementById('uploadArea').classList.add('hidden');
	      document.getElementById('uploadedFile').classList.remove('hidden');
	      document.getElementById('fileName').textContent = file.name;
	    } else {
	      alert('File must be less than 5MB');
	      this.value = '';
	    }
	  });
	
	  function removeFile() {
	    bankSlipInput.value = '';
	    document.getElementById('uploadArea').classList.remove('hidden');
	    document.getElementById('uploadedFile').classList.add('hidden');
	  }
	
	  const uploadArea = document.getElementById('uploadArea');
	  ['dragenter', 'dragover', 'dragleave', 'drop'].forEach(eventName => {
	    uploadArea.addEventListener(eventName, e => {
	      e.preventDefault();
	      e.stopPropagation();
	    });
	  });
	
	  uploadArea.addEventListener('dragenter', () => uploadArea.classList.add('border-blue-400', 'bg-blue-50'));
	  uploadArea.addEventListener('dragleave', () => uploadArea.classList.remove('border-blue-400', 'bg-blue-50'));
	  uploadArea.addEventListener('drop', e => {
	    const files = e.dataTransfer.files;
	    if (files.length > 0) {
	      bankSlipInput.files = files;
	      bankSlipInput.dispatchEvent(new Event('change'));
	    }
	  });
	
	  // Payment form submission
	  document.getElementById('paymentForm').addEventListener('submit', function (e) {
		  
	    const paymentMethod = document.querySelector('input[name="paymentMethod"]:checked').value;
	    const submitBtn = document.getElementById('submitBtn');
	    const submitText = document.getElementById('submitText');
	
	    let isValid = true;
	
	    if (paymentMethod === 'credit_card') {
	      const cardNumber = document.getElementById('cardNumber').value.replace(/\s/g, '');
	      const cardholderName = document.getElementById('cardholderName').value;
	      const expiryDate = document.getElementById('expiryDate').value;
	      const cvv = document.getElementById('cvv').value;
	
	      if (cardNumber.length < 13 || cardNumber.length > 19) {
	        alert('Please enter a valid card number');
	        isValid = false;
	      } else if (!cardholderName.trim()) {
	        alert('Please enter the cardholder name');
	        isValid = false;
	      } else if (!/^\d{2}\/\d{2}$/.test(expiryDate)) {
	        alert('Please enter a valid expiry date (MM/YY)');
	        isValid = false;
	      } else if (cvv.length < 3) {
	        alert('Please enter a valid CVV');
	        isValid = false;
	      }
	
	      if (isValid) {
	        const [month, year] = expiryDate.split('/');
	        const expiry = new Date(2000 + parseInt(year), parseInt(month) - 1);
	        const now = new Date();
	        if (expiry < now) {
	          alert('Card has expired');
	          isValid = false;
	        }
	      }
	    } else if (paymentMethod === 'bank_transfer' && !bankSlipInput.files.length) {
	      alert('Please upload your bank slip');
	      isValid = false;
	    }
	
	    if (isValid) {
	      submitBtn.disabled = true;
	      submitBtn.classList.add('opacity-75', 'cursor-not-allowed');
	      submitText.innerHTML = '<i class="fas fa-spinner fa-spin mr-2"></i>Processing Payment...';
	
	      setTimeout(() => {
	        if (paymentMethod === 'paypal') {
	          window.location.href = 'https://www.paypal.com/checkout';
	        } else {
	          document.getElementById('successModal').classList.remove('hidden');
	        }
	      }, 2000);
	    }
	  });
	
	  // Animations on load
	  window.addEventListener('load', function () {
	    document.querySelectorAll('.bg-white').forEach((el, index) => {
	      el.style.opacity = '0';
	      el.style.transform = 'translateY(20px)';
	      el.style.transition = 'all 0.6s ease';
	      setTimeout(() => {
	        el.style.opacity = '1';
	        el.style.transform = 'translateY(0)';
	      }, index * 100);
	    });
	  });
	
	  
	  
	</script>

</body>
</html>   
