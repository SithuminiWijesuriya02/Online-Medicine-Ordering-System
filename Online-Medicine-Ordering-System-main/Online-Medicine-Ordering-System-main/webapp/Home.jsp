<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>MediQuick - Home</title>
  <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-[#ecf1fc] text-[#333] font-sans font-medium tracking-wide">

  <!-- Header -->
  <%@ include file="./partials/navBar.jsp" %>
  
 
  <!-- Hero Section -->
  <section class="relative w-full h-[750px] bg-cover bg-center relative flex items-center" style="background-image: url('Images/img1.jpg');">
  
    <div class="absolute inset-0 bg-black/50"></div>
    <div class="relative z-10 max-w-7xl mx-auto px-6 md:px-12 text-white">
      <div class="max-w-xl">
        <h1 class="text-4xl md:text-5xl font-bold mb-6">Your Health, Delivered to Your Doorstep</h1>
        <p class="text-lg mb-6 leading-relaxed">
          MediQuick provides a secure, convenient way to order your medications online. With fast delivery and reliable service, taking care of your health has never been easier.
        </p>
        <a href="viewMedicine"
          class="inline-block bg-[#1e88e5] text-white px-6 py-3 rounded font-semibold transition-colors duration-300 hover:bg-white hover:text-[#1e88e5]">
          Shop Medicines Now
        </a>

      </div>
    </div>
  </section>

  <!-- Features Section -->
  <section class="py-16 px-8 bg-white">
    <h2 class="text-center text-3xl font-semibold text-[#2c3e50] mb-12">Why Choose MediQuick?</h2>
    <div class="grid gap-8 grid-cols-1 md:grid-cols-2 lg:grid-cols-3 max-w-7xl mx-auto">
      <div class="bg-[#edf3fe] p-6 rounded-lg shadow text-center hover:-translate-y-1 transition">
        <h3 class="text-xl font-semibold mb-2 text-[#2c3e50]">Fast Delivery</h3>
        <p class="text-[#5d6d7e]">Get your medications delivered to your doorstep within 24 hours of ordering.</p>
      </div>
      <div class="bg-[#edf3fe] p-6 rounded-lg shadow text-center hover:-translate-y-1 transition">
        <h3 class="text-xl font-semibold mb-2 text-[#2c3e50]">Secure & Confidential</h3>
        <p class="text-[#5d6d7e]">Your medical information and orders are protected with top-level security measures.</p>
      </div>
      <div class="bg-[#edf3fe] p-6 rounded-lg shadow text-center hover:-translate-y-1 transition">
        <h3 class="text-xl font-semibold mb-2 text-[#2c3e50]">Best Prices</h3>
        <p class="text-[#5d6d7e]">We offer competitive prices and regular discounts to make healthcare affordable.</p>
      </div>
    </div>
  </section>

  <!-- footer -->
  <%@ include file="./partials/footer.jsp" %>

</body>
</html>