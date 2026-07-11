<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ page isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/> 
  <title>MediQuick - Login</title>
  <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="relative min-h-screen flex items-center justify-center px-4 overflow-hidden">
  
  <!-- Background Image -->
  <div class="absolute inset-0 bg-[url('Images/img1.jpg')] bg-cover bg-center">
    <div class="absolute inset-0 bg-black opacity-50"></div>
  </div>

  <!-- Login Form -->
  <div class="relative z-10 w-full max-w-md bg-white rounded-2xl shadow-lg p-6">
    <!-- Header --> 
    <div class="flex justify-between items-center mb-6">
      <h2 class="text-2xl font-bold text-[#2c3e50]">Login</h2>
      <button class="text-2xl font-bold text-gray-500 close-btn">&times;</button>
    </div>

    <!-- Form -->
    <form class="space-y-5" action="login" method="post">
    <c:if test="${not empty error}">
	  <p class="text-red-600 text-sm font-medium mb-2">${error}</p>
	</c:if>
    
      <div>
        <label for="email" class="block mb-1 text-sm font-medium text-gray-700">Email</label>
        <input type="email" id="email" name="email" required
               class="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-400">
      </div>

      <div>
        <label for="password" class="block mb-1 text-sm font-medium text-gray-700">Password</label>
        <input type="password" id="password" name="password" required
               class="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-400">
      </div>

      <div class="text-right">
        <a href="#" class="text-sm text-gray-700">Forgot password?</a>
      </div>

      <button type="submit" class="w-full bg-[#1e88e5] text-white py-3 rounded-lg hover:bg-blue-600 transition font-bold">
        Login
      </button>      
    </form>

    <div class="text-center mt-6 text-sm text-gray-600">
      Don't have an account?
      <a href="signup.jsp" class="text-[#1e88e5] hover:underline font-medium">Sign up</a>
    </div>
  </div>

 <script>
  <!-- Close Button Redirect -->
  document.querySelectorAll('.close-btn').forEach(btn => {
      btn.addEventListener('click', () => {
        window.location.href = "Home.jsp";
      });
    });
    
  </script>
</body>
</html>
