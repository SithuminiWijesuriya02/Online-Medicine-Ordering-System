<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
 <head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>MediQuick - Navigation</title>
	<script src="https://cdn.tailwindcss.com"></script>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
	<style>
	  .nav-link {
	    position: relative;
	    transition: all 0.3s ease;
	  }
	  
	  .nav-link::after {
	    content: '';
	    position: absolute;
	    width: 0;
	    height: 2px;
	    bottom: -4px;
	    left: 50%;
	    background: linear-gradient(90deg, #1ac185, #00ff94);
	    transition: all 0.3s ease;
	    transform: translateX(-50%);
	  }
	  
	  .nav-link:hover::after {
	    width: 100%;
	  }
	  
	  .nav-link:hover {
	    transform: translateY(-1px);
	    color: #e0f4ff;
	  }
	  
	  .logo-glow {
	    text-shadow: 0 0 20px rgba(26, 193, 133, 0.3);
	  }
	  
	  .button-hover {
	    transition: all 0.3s cubic-bezier(0.175, 0.885, 0.32, 1.275);
	  }
	  
	  .button-hover:hover {
	    transform: translateY(-2px) scale(1.05);
	    box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
	  }
	  
	  .mobile-menu {
	    transform: translateX(100%);
	    transition: transform 0.3s ease;
	  }
	  
	  .mobile-menu.active {
	    transform: translateX(0);
	  }
	  
	  .backdrop-blur-custom {
	    backdrop-filter: blur(10px);
	    -webkit-backdrop-filter: blur(10px);
	  }
	</style>
 </head>
 <body class="pt-20 bg-blue-50 text-[#333] font-sans font-medium tracking-wide">

	<!-- Enhanced Header -->
	<header class="fixed top-0 left-0 w-full bg-gradient-to-r from-blue-600 via-blue-700 to-blue-800 text-white shadow-2xl z-50 backdrop-blur-custom border-b border-blue-500/20">
	  
	  <nav class="max-w-7xl mx-auto flex justify-between items-center px-4 py-4 relative z-10">	    
	    <div class="flex items-center space-x-6">
	      <div class="text-3xl font-bold flex items-center logo-glow group cursor-pointer">        
	        <span class="text-white">Medi</span><span class="text-white group-hover:text-[#00ff94] transition-colors duration-300">Quick</span>
	      </div>
	
	      <!-- Desktop Navigation Links -->
	      <div class="hidden lg:flex space-x-6 text-white text-[17px] font-medium items-center">
	        <a href="Home.jsp" class="nav-link flex items-center gap-2 px-3 py-2 rounded-lg hover:bg-white/10">
	          <i class="fas fa-home text-sm"></i>
	          <span>Home</span>
	        </a>
	        <a href="viewMedicine" class="nav-link flex items-center gap-2 px-3 py-2 rounded-lg hover:bg-white/10">
	          <i class="fas fa-pills text-sm"></i>
	          <span>Medicine</span>
	        </a>
	        <a href="prescriptions.jsp" class="nav-link flex items-center gap-2 px-3 py-2 rounded-lg hover:bg-white/10">
	          <i class="fas fa-prescription-bottle text-sm"></i>
	          <span>Prescriptions</span>
	        </a>
	        <a href="about.jsp" class="nav-link flex items-center gap-2 px-3 py-2 rounded-lg hover:bg-white/10">
	          <i class="fas fa-info-circle text-sm"></i>
	          <span>About Us</span>
	        </a>
	        <a href="contact.jsp" class="nav-link flex items-center gap-2 px-3 py-2 rounded-lg hover:bg-white/10">
	          <i class="fas fa-envelope text-sm"></i>
	          <span>Contact</span>
	        </a>
	      </div>
	    </div>
	
	    <!-- Account Buttons -->
	    <div id="authButtons" class="hidden lg:flex items-center">
	      
	      <!-- If NOT logged in -->
	      <c:if test="${empty sessionScope.loggedCustomer}">
	        <div class="flex space-x-3">
	          <!-- Login Button -->
	          <a href="login.jsp"
	             class="button-hover bg-gradient-to-r from-blue-600 to-blue-700 hover:from-blue-700 hover:to-blue-800 text-white px-6 py-2.5 rounded-xl text-sm font-semibold shadow-lg border border-blue-500/30 backdrop-blur-sm">
	            <i class="fas fa-sign-in-alt mr-2"></i>Login
	          </a>
	
	          <!-- Sign Up Button -->
	          <a href="signup.jsp"
	             class="button-hover bg-gradient-to-r from-emerald-500 to-green-600 hover:from-emerald-600 hover:to-green-700 text-white px-6 py-2.5 rounded-xl text-sm font-semibold shadow-lg border border-emerald-400/30">
	            <i class="fas fa-user-plus mr-2"></i>Sign Up
	          </a>
	        </div>
	      </c:if>
	
	      <!-- If logged in -->
	      <c:if test="${not empty sessionScope.loggedCustomer}">
	        <div class="flex items-center space-x-4">
	          <!-- Cart Button -->
	          <form action="${pageContext.request.contextPath}/displayCart" method="post" class="inline">
	            <input type="hidden" name="email" value="${sessionScope.loggedCustomer.email}">
	            <button type="submit"
	                    class="button-hover relative flex items-center gap-2 bg-gradient-to-r from-blue-500 to-blue-600 hover:from-blue-600 hover:to-blue-700 text-white px-4 py-2.5 rounded-xl text-sm font-semibold shadow-lg border border-blue-400/30">
	              <i class="fas fa-shopping-cart"></i>
	              <span>Cart</span>
	              </button>
	          </form>
	
	          <!-- Profile Button -->
	          <form action="${pageContext.request.contextPath}/displayCustomer" method="post" class="inline">
	            <input type="hidden" name="email" value="${sessionScope.loggedCustomer.email}">
	            <button type="submit"
	                    class="button-hover flex items-center gap-2 bg-gradient-to-r from-cyan-500 to-blue-500 hover:from-cyan-600 hover:to-blue-600 text-white px-4 py-2.5 rounded-xl text-sm font-semibold shadow-lg border border-cyan-400/30">
	              <i class="fas fa-user-circle"></i>
	              <span>Profile</span>
	            </button>
	          </form>
	
	          <!-- Logout Button -->
	          <a href="logout.jsp"
	             onclick="return confirm('Are you sure you want to logout?');"
	             class="button-hover flex items-center gap-2 bg-gradient-to-r from-red-500 to-red-600 hover:from-red-600 hover:to-red-700 text-white px-4 py-2.5 rounded-xl text-sm font-semibold shadow-lg border border-red-400/30">
	            <i class="fas fa-sign-out-alt"></i>
	            <span>Logout</span>
	          </a>
	        </div>
	      </c:if>
	    </div>
	
	    <!-- Mobile Menu Button -->
	    <button id="mobileMenuBtn" class="lg:hidden text-white p-2 rounded-lg hover:bg-white/10 transition-colors duration-300">
	      <i class="fas fa-bars text-xl"></i>
	    </button>
	  </nav>
	</header>

	<!-- Mobile Menu Overlay -->
	<div id="mobileMenuOverlay" class="fixed inset-0 bg-black/50 z-40 lg:hidden hidden backdrop-blur-sm"></div>
	
	<!-- Mobile Menu -->
	<div id="mobileMenu" class="mobile-menu fixed top-0 right-0 h-full w-80 bg-gradient-to-b from-blue-700 to-blue-800 z-50 lg:hidden shadow-2xl">
	  <div class="p-6">
	    <!-- Mobile Menu Header -->
	    <div class="flex justify-between items-center mb-8">
	      <div class="text-2xl font-bold flex items-center">
	        <span class="text-white">Medi</span><span class="text-[#1ac185]">Quick</span>
	      </div>
	      <button id="closeMobileMenu" class="text-white p-2 rounded-lg hover:bg-white/10">
	        <i class="fas fa-times text-xl"></i>
	      </button>
	    </div>
	
	    <!-- Mobile Navigation Links -->
	    <div class="space-y-4 mb-8">
	      <a href="Home.jsp" class="flex items-center gap-3 text-white hover:text-green-400 py-3 px-4 rounded-xl hover:bg-white/10 transition-all duration-300">
	        <i class="fas fa-home"></i>
	        <span>Home</span>
	      </a>
	      <a href="viewMedicine" class="flex items-center gap-3 text-white hover:text-green-400 py-3 px-4 rounded-xl hover:bg-white/10 transition-all duration-300">
	        <i class="fas fa-pills"></i>
	        <span>Medicine</span>
	      </a>
	      <a href="prescriptions.jsp" class="flex items-center gap-3 text-white hover:text-green-400 py-3 px-4 rounded-xl hover:bg-white/10 transition-all duration-300">
	        <i class="fas fa-prescription-bottle"></i>
	        <span>Prescriptions</span>
	      </a>
	      <a href="about.jsp" class="flex items-center gap-3 text-white hover:text-green-400 py-3 px-4 rounded-xl hover:bg-white/10 transition-all duration-300">
	        <i class="fas fa-info-circle"></i>
	        <span>About Us</span>
	      </a>
	      <a href="contact.jsp" class="flex items-center gap-3 text-white hover:text-green-400 py-3 px-4 rounded-xl hover:bg-white/10 transition-all duration-300">
	        <i class="fas fa-envelope"></i>
	        <span>Contact</span>
	      </a>
	    </div>
	
	    <!-- Mobile Account Section -->
	    <div class="border-t border-white/20 pt-6">
	      <c:if test="${empty sessionScope.loggedCustomer}">
	        <div class="space-y-3">
	          <a href="login.jsp" class="block bg-gradient-to-r from-blue-600 to-blue-700 text-white px-4 py-3 rounded-xl text-center font-semibold">
	            <i class="fas fa-sign-in-alt mr-2"></i>Login
	          </a>
	          <a href="signup.jsp" class="block bg-gradient-to-r from-emerald-500 to-green-600 text-white px-4 py-3 rounded-xl text-center font-semibold">
	            <i class="fas fa-user-plus mr-2"></i>Sign Up
	          </a>
	        </div>
	      </c:if>
	
	      <c:if test="${not empty sessionScope.loggedCustomer}">
	        <div class="space-y-3">
	          <form action="${pageContext.request.contextPath}/displayCart" method="post">
	            <input type="hidden" name="email" value="${sessionScope.loggedCustomer.email}">
	            <button type="submit" class="w-full bg-gradient-to-r from-blue-500 to-blue-600 text-white px-4 py-3 rounded-xl font-semibold">
	              <i class="fas fa-shopping-cart mr-2"></i>Cart
	            </button>
	          </form>
	          
	          <form action="${pageContext.request.contextPath}/displayCustomer" method="post">
	            <input type="hidden" name="email" value="${sessionScope.loggedCustomer.email}">
	            <button type="submit" class="w-full bg-gradient-to-r from-cyan-500 to-blue-500 text-white px-4 py-3 rounded-xl font-semibold">
	              <i class="fas fa-user-circle mr-2"></i>Profile
	            </button>
	          </form>
	          
	          <a href="logout.jsp" onclick="return confirm('Are you sure you want to logout?');" 
	             class="block bg-gradient-to-r from-red-500 to-red-600 text-white px-4 py-3 rounded-xl text-center font-semibold">
	            <i class="fas fa-sign-out-alt mr-2"></i>Logout
	          </a>
	        </div>
	      </c:if>
	    </div>
	  </div>
	</div>

	<script>
	  // Mobile menu functionality
	  const mobileMenuBtn = document.getElementById('mobileMenuBtn');
	  const mobileMenu = document.getElementById('mobileMenu');
	  const mobileMenuOverlay = document.getElementById('mobileMenuOverlay');
	  const closeMobileMenu = document.getElementById('closeMobileMenu');
	
	  function openMobileMenu() {
	    mobileMenu.classList.add('active');
	    mobileMenuOverlay.classList.remove('hidden');
	    document.body.style.overflow = 'hidden';
	  }
	
	  function closeMobileMenuFn() {
	    mobileMenu.classList.remove('active');
	    mobileMenuOverlay.classList.add('hidden');
	    document.body.style.overflow = '';
	  }
	
	  mobileMenuBtn.addEventListener('click', openMobileMenu);
	  closeMobileMenu.addEventListener('click', closeMobileMenuFn);
	  mobileMenuOverlay.addEventListener('click', closeMobileMenuFn);
	
	  // Close mobile menu on escape key
	  document.addEventListener('keydown', function(e) {
	    if (e.key === 'Escape') {
	      closeMobileMenuFn();
	    }
	  });
	
	  // Smooth scroll for navigation links
	  document.querySelectorAll('a[href^="#"]').forEach(anchor => {
	    anchor.addEventListener('click', function (e) {
	      e.preventDefault();
	      const target = document.querySelector(this.getAttribute('href'));
	      if (target) {
	        target.scrollIntoView({
	          behavior: 'smooth',
	          block: 'start'
	        });
	      }
	    });
	  });
	
	  // Add active state to current page
	  const currentPath = window.location.pathname.split('/').pop(); // Get the file name only
		document.querySelectorAll('.nav-link').forEach(link => {
		  const linkHref = link.getAttribute('href').split('/').pop();
		  if (linkHref === currentPath) {
		    link.classList.add('text-green-400');
		    // Simulate the ::after underline effect
		    link.style.setProperty('--tw-content', '""');
		    link.style.position = 'relative';
		   
		  }
	  });
	</script>

 </body>
</html>