<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>MediQuick - About Us</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
  <style>
  .fade-in-up {
    animation: fadeInUp 0.6s ease-out;
  }
  @keyframes fadeInUp {
    from {
      opacity: 0;
      transform: translateY(20px);
    }
    to {
      opacity: 1;
      transform: translateY(0);
    }
  }
 </style>
  
</head>
<body class="bg-[#ecf1fc] text-gray-800 font-sans tracking-wide min-h-screen flex flex-col">

  <%@ include file="./partials/navBar.jsp" %>

  <!-- Hero Section -->
  <section class="pt-32 bg-blue-500 text-white pb-16">
    <div class="max-w-7xl mx-auto px-4 text-center">
      <h1 class="text-5xl md:text-6xl font-bold mb-6">About MediQuick</h1>
      <p class="text-xl md:text-2xl mb-8 max-w-3xl mx-auto">Your trusted partner in healthcare, delivering quality medicines and exceptional service since our inception.</p>
      <div class="text-6xl text-pink-200 animate-pulse">
        <i class="fas fa-heartbeat"></i>
      </div>
    </div>
  </section>

  <!-- Mission & Vision -->
  <section class="py-20 bg-white">
    <div class="max-w-7xl mx-auto px-4 grid lg:grid-cols-2 gap-12 items-center">
      <div>
        <h2 class="text-4xl font-bold mb-6">Our Mission</h2>
        <p class="text-lg mb-4">At MediQuick, we are committed to making healthcare accessible and affordable for everyone. Our mission is to provide high-quality medicines with fast, reliable delivery service.</p>
        <p class="text-lg">We build trust through transparency, quality assurance, and exceptional service.</p>
      </div>
      <div class="bg-gradient-to-br from-blue-50 to-purple-100 p-8 rounded-3xl shadow-lg">
        <h3 class="text-3xl font-bold mb-4">Our Vision</h3>
        <p class="text-lg mb-4">To revolutionize healthcare by creating a seamless bridge between patients and quality medications.</p>
        <div class="flex items-center space-x-4">
          <div class="w-16 h-16 bg-blue-500 rounded-full flex justify-center items-center">
            <i class="fas fa-eye text-white text-2xl"></i>
          </div>
          <div>
            <h4 class="font-semibold">Looking Forward</h4>
            <p>Building a healthier tomorrow</p>
          </div>
        </div>
      </div>
    </div>
  </section>

  <!-- Statistics -->
  <section class="py-20 bg-blue-500 text-white">
    <div class="max-w-7xl mx-auto px-4 text-center">
      <h2 class="text-4xl font-bold mb-4">Our Impact in Numbers</h2>
      <p class="text-xl opacity-90 mb-12">Trusted by thousands of customers nationwide</p>
      <div class="grid grid-cols-2 md:grid-cols-4 gap-6">
        <div class="bg-white/10 p-6 rounded-2xl backdrop-blur text-center">
          <div class="text-4xl font-bold counter">25,000+</div>
          <p class="text-lg">Happy Customers</p>
        </div>
        <div class="bg-white/10 p-6 rounded-2xl backdrop-blur text-center">
          <div class="text-4xl font-bold counter">50,000+</div>
          <p class="text-lg">Orders Delivered</p>
        </div>
        <div class="bg-white/10 p-6 rounded-2xl backdrop-blur text-center">
          <div class="text-4xl font-bold counter">2,500+</div>
          <p class="text-lg">Medicines Available</p>
        </div>
        <div class="bg-white/10 p-6 rounded-2xl backdrop-blur text-center">
          <div class="text-4xl font-bold counter">99.5%</div>
          <p class="text-lg">Customer Satisfaction</p>
        </div>
      </div>
    </div>
  </section>

  <!-- Core Values -->
  <section class="py-20 bg-gray-50">
    <div class="max-w-7xl mx-auto px-4 text-center">
      <h2 class="text-4xl font-bold mb-4">Our Core Values</h2>
      <p class="text-xl text-gray-600 mb-12">The principles that guide everything we do</p>
      <div class="grid md:grid-cols-2 lg:grid-cols-3 gap-8 text-left">
        <div class="bg-white p-6 rounded-2xl shadow hover:shadow-xl transition">
          <div class="w-16 h-16 bg-blue-100 rounded-full flex items-center justify-center mb-4">
            <i class="fas fa-shield-alt text-blue-600 text-2xl"></i>
          </div>
          <h3 class="text-2xl font-bold mb-2">Quality Assurance</h3>
          <p>All medicines meet the highest standards through rigorous testing and verification.</p>
        </div>
        <div class="bg-white p-6 rounded-2xl shadow hover:shadow-xl transition">
          <div class="w-16 h-16 bg-green-100 rounded-full flex items-center justify-center mb-4">
            <i class="fas fa-shipping-fast text-green-600 text-2xl"></i>
          </div>
          <h3 class="text-2xl font-bold mb-2">Fast Delivery</h3>
          <p>Reliable delivery service to ensure timely access to medicines.</p>
        </div>
        <div class="bg-white p-6 rounded-2xl shadow hover:shadow-xl transition">
          <div class="w-16 h-16 bg-purple-100 rounded-full flex items-center justify-center mb-4">
            <i class="fas fa-user-md text-purple-600 text-2xl"></i>
          </div>
          <h3 class="text-2xl font-bold mb-2">Expert Support</h3>
          <p>Professional healthcare experts are always available to assist you.</p>
        </div>
        <div class="bg-white p-6 rounded-2xl shadow hover:shadow-xl transition">
          <div class="w-16 h-16 bg-red-100 rounded-full flex items-center justify-center mb-4">
            <i class="fas fa-heart text-red-600 text-2xl"></i>
          </div>
          <h3 class="text-2xl font-bold mb-2">Patient Care</h3>
          <p>Putting patients first with compassion and care in every order.</p>
        </div>
        <div class="bg-white p-6 rounded-2xl shadow hover:shadow-xl transition">
          <div class="w-16 h-16 bg-yellow-100 rounded-full flex items-center justify-center mb-4">
            <i class="fas fa-dollar-sign text-yellow-600 text-2xl"></i>
          </div>
          <h3 class="text-2xl font-bold mb-2">Affordable Pricing</h3>
          <p>We offer competitive prices to make healthcare affordable to all.</p>
        </div>
        <div class="bg-white p-6 rounded-2xl shadow hover:shadow-xl transition">
          <div class="w-16 h-16 bg-indigo-100 rounded-full flex items-center justify-center mb-4">
            <i class="fas fa-lock text-indigo-600 text-2xl"></i>
          </div>
          <h3 class="text-2xl font-bold mb-2">Privacy & Security</h3>
          <p>Your personal and medical information is protected with top security.</p>
        </div>
      </div>
    </div>
  </section>
  
  <!-- Team Section -->
  <section class="py-20 bg-white">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
      <div class="text-center mb-16">
        <h2 class="text-4xl font-bold text-gray-800 mb-4">Meet Our Leadership Team</h2>
        <p class="text-xl text-gray-600">Experienced professionals dedicated to your health</p>
      </div>
      <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-12">
        <div class="card-hover text-center">
          <div class="w-48 h-48 bg-gradient-to-br from-blue-400 to-blue-600 rounded-full mx-auto mb-6 flex items-center justify-center">
            <i class="fas fa-user-tie text-white text-6xl"></i>
          </div>
          <h3 class="text-2xl font-bold text-gray-800 mb-2">Dr. Sarah Johnson</h3>
          <p class="text-blue-600 font-semibold mb-3">Chief Executive Officer</p>
          <p class="text-gray-600 leading-relaxed">
            With over 15 years in healthcare management, Dr. Johnson leads our mission to make healthcare accessible to all.
          </p>
        </div>
        <div class="card-hover text-center">
          <div class="w-48 h-48 bg-gradient-to-br from-green-400 to-green-600 rounded-full mx-auto mb-6 flex items-center justify-center">
            <i class="fas fa-user-md text-white text-6xl"></i>
          </div>
          <h3 class="text-2xl font-bold text-gray-800 mb-2">Dr. Michael Chen</h3>
          <p class="text-green-600 font-semibold mb-3">Chief Pharmacist</p>
          <p class="text-gray-600 leading-relaxed">
            Licensed pharmacist with 12+ years ensuring medication safety and quality control standards.
          </p>
        </div>
        <div class="card-hover text-center">
          <div class="w-48 h-48 bg-gradient-to-br from-purple-400 to-purple-600 rounded-full mx-auto mb-6 flex items-center justify-center">
            <i class="fas fa-cogs text-white text-6xl"></i>
          </div>
          <h3 class="text-2xl font-bold text-gray-800 mb-2">Emma Rodriguez</h3>
          <p class="text-purple-600 font-semibold mb-3">Head of Operations</p>
          <p class="text-gray-600 leading-relaxed">
            Operations expert managing our supply chain and delivery systems to ensure timely service.
          </p>
        </div>
      </div>
    </div>
  </section>
  
  <!-- Why Choose Us Section -->
  <section class="py-20 bg-gradient-to-br from-blue-50 to-purple-50">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
      <div class="grid grid-cols-1 lg:grid-cols-2 gap-12 items-center">
        <div>
          <h2 class="text-4xl font-bold text-gray-800 mb-8">Why Choose MediQuick?</h2>
          <div class="space-y-6">
            <div class="flex items-start space-x-4">
              <div class="w-8 h-8 bg-blue-500 rounded-full flex items-center justify-center flex-shrink-0 mt-1">
                <i class="fas fa-check text-white text-sm"></i>
              </div>
              <div>
                <h4 class="text-lg font-semibold text-gray-800 mb-2">Licensed & Certified</h4>
                <p class="text-gray-600">Fully licensed pharmacy with all necessary certifications and regulatory approvals.</p>
              </div>
            </div>
            <div class="flex items-start space-x-4">
              <div class="w-8 h-8 bg-green-500 rounded-full flex items-center justify-center flex-shrink-0 mt-1">
                <i class="fas fa-check text-white text-sm"></i>
              </div>
              <div>
                <h4 class="text-lg font-semibold text-gray-800 mb-2">24/7 Customer Support</h4>
                <p class="text-gray-600">Round-the-clock customer service to assist with your queries and concerns.</p>
              </div>
            </div>
            <div class="flex items-start space-x-4">
              <div class="w-8 h-8 bg-purple-500 rounded-full flex items-center justify-center flex-shrink-0 mt-1">
                <i class="fas fa-check text-white text-sm"></i>
              </div>
              <div>
                <h4 class="text-lg font-semibold text-gray-800 mb-2">Secure Transactions</h4>
                <p class="text-gray-600">Advanced encryption and secure payment gateways for safe online transactions.</p>
              </div>
            </div>
            <div class="flex items-start space-x-4">
              <div class="w-8 h-8 bg-red-500 rounded-full flex items-center justify-center flex-shrink-0 mt-1">
                <i class="fas fa-check text-white text-sm"></i>
              </div>
              <div>
                <h4 class="text-lg font-semibold text-gray-800 mb-2">Easy Returns</h4>
                <p class="text-gray-600">Hassle-free return policy for your peace of mind and satisfaction.</p>
              </div>
            </div>
          </div>
        </div>
        <div class="text-center">
          <div class="bg-white rounded-3xl p-8 shadow-2xl card-hover">
            <div class="w-32 h-32 bg-gradient-to-br from-blue-400 to-purple-600 rounded-full mx-auto mb-6 flex items-center justify-center">
              <i class="fas fa-medal text-white text-5xl"></i>
            </div>
            <h3 class="text-2xl font-bold text-gray-800 mb-4">Award-Winning Service</h3>
            <p class="text-gray-600 mb-6">
              Recognized as the "Best Online Pharmacy" for three consecutive years by Healthcare Excellence Awards.
            </p>
            <div class="flex justify-center space-x-2">
              <i class="fas fa-star text-yellow-400 text-xl"></i>
              <i class="fas fa-star text-yellow-400 text-xl"></i>
              <i class="fas fa-star text-yellow-400 text-xl"></i>
              <i class="fas fa-star text-yellow-400 text-xl"></i>
              <i class="fas fa-star text-yellow-400 text-xl"></i>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>

  <!-- Call to Action -->
  <section class="py-20 bg-blue-500 text-white text-center">
    <div class="max-w-4xl mx-auto px-4">
      <h2 class="text-4xl font-bold mb-6">Ready to Experience Better Healthcare?</h2>
      <p class="text-xl mb-8">Join thousands of satisfied customers who trust MediQuick.</p>
      <div class="flex flex-col sm:flex-row justify-center gap-4">
        <a href="medicines.jsp" class="bg-white text-blue-600 px-8 py-3 rounded-full font-semibold text-lg hover:bg-gray-100 transition">
          <i class="fas fa-pills mr-2"></i> Browse Medicines
        </a>
        <a href="contact.jsp" class="border-2 border-white px-8 py-3 rounded-full font-semibold text-lg hover:bg-white hover:text-blue-600 transition">
          <i class="fas fa-phone mr-2"></i> Contact Us
        </a>
      </div>
    </div>
  </section>

  <%@ include file="./partials/footer.jsp" %>

  <script>
    // Counter animation
    function animateCounters() {
      const counters = document.querySelectorAll('.counter');
      counters.forEach(counter => {
        const target = parseInt(counter.textContent.replace(/[^0-9]/g, ''));
        const increment = target / 100;
        let current = 0;
        
        const updateCounter = () => {
          if (current < target) {
            current += increment;
            if (counter.textContent.includes('+')) {
              counter.textContent = Math.ceil(current).toLocaleString() + '+';
            } else if (counter.textContent.includes('%')) {
              counter.textContent = Math.ceil(current) + '%';
            } else {
              counter.textContent = Math.ceil(current).toLocaleString();
            }
            requestAnimationFrame(updateCounter);
          } else {
            counter.textContent = counter.textContent; // Reset to original
          }
        };
        
        updateCounter();
      });
    }

    // Intersection Observer for animations
    const observerOptions = {
      threshold: 0.1,
      rootMargin: '0px 0px -50px 0px'
    };

    const observer = new IntersectionObserver((entries) => {
      entries.forEach(entry => {
        if (entry.isIntersecting) {
          entry.target.classList.add('fade-in-up');
          if (entry.target.querySelector('.counter')) {
            animateCounters();
          }
        }
      });
    }, observerOptions);

    // Observe all sections
    document.addEventListener('DOMContentLoaded', () => {
      const sections = document.querySelectorAll('section');
      sections.forEach(section => {
        observer.observe(section);
      });
    });

    // Smooth scrolling for anchor links
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
  </script>


</body>
</html>
