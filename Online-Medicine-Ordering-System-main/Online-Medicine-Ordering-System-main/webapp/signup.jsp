<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>MediQuick - Sign Up</title>
  <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="relative min-h-screen flex items-center justify-center px-4 overflow-hidden">
  <!-- background image -->
  <div class="absolute inset-0 bg-[url('Images/img1.jpg')] bg-cover bg-center">
    <div class="absolute inset-0 bg-black opacity-50"></div>
  </div>

  <!-- Signup Form -->
  <div class="relative z-10 w-full max-w-[36rem] bg-white rounded-2xl shadow-lg p-6">
    <div class="flex justify-between items-center mb-6">
      <h2 class="text-2xl font-bold text-[#2c3e50]">Create Your Account</h2>
      <button class="text-2xl font-bold text-gray-500 close-btn">&times;</button>
    </div>

    <form class="space-y-3" method="post" action="addCustomer">
      <div>
        <label for="name" class="block mb-1 text-sm font-medium text-gray-700">Name</label>
        <input type="text" id="name" name="name" required
               class="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-400">
      </div>

      <div>
        <label for="email" class="block mb-1 text-sm font-medium text-gray-700">Email</label>
        <input type="email" id="email" name="email" required
               class="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-400">
      </div>

      <div>
        <label for="phone" class="block mb-1 text-sm font-medium text-gray-700">Phone Number</label>
        <input type="tel" id="phone" name="phone" required
               class="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-400">
      </div>

      <div>
        <label for="password" class="block mb-1 text-sm font-medium text-gray-700">Password</label>
        <input type="password" id="password" name="password" required
               class="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-400">
      </div>

      <div>
        <label for="confirmPassword" class="block mb-1 text-sm font-medium text-gray-700">Confirm Password</label>
        <input type="password" id="confirmPassword" required
               class="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-400">
      </div>

      <div class="flex items-center space-x-2">
        <input type="checkbox" id="terms" required class="accent-blue-500">
        <label for="terms" class="text-sm text-gray-700">I agree to the Terms and Privacy Policy</label>
      </div>

      <button type="submit" class="w-full bg-[#1e88e5] text-white py-3 rounded-lg hover:bg-blue-600 transition font-bold">
        Create Account
      </button>
    </form>

    <div class="text-center mt-4 text-sm text-gray-600">
      Already have an account?
      <a href="login.jsp" class="text-[#1e88e5] hover:underline font-medium">Log in</a>
    </div>
  </div>

  <!-- Close Button Redirect -->
  <script>
    document.querySelectorAll('.close-btn').forEach(btn => {
      btn.addEventListener('click', () => {
        window.location.href = "Home.jsp";
      });
    });
    
    const form = document.querySelector("form");
    const password = document.getElementById("password");
    const confirmPassword = document.getElementById("confirmPassword");

    form.addEventListener("submit", function (e) {
      if (password.value !== confirmPassword.value) {
        e.preventDefault(); // stop form submission
        alert("Passwords do not match!");
        password.value = "";
        confirmPassword.value = "";
        password.focus(); // set focus to password field
      }
    });
  </script>
</body>

</html>