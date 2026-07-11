<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MediQuick Admin - Profile Edit</title>
</head>
<body class="bg-[#ecf1fc] text-[#333] min-h-screen flex font-sans">

    <!-- Sidebar Navigation -->
   <%@ include file="../partials/adminSidebar.jsp" %>
   
	<div id="mainContent" class="flex-1 ml-[250px] p-5 w-[calc(100%-250px)] transition-all duration-300">
        <!-- Top Header -->
        <header class="flex justify-between items-center mb-8 pb-5 border-b border-[#e3ebf6]">
            <div class="flex items-center gap-4">
           	 	<button id="toggleSidebar" class="text-2xl">☰</button>
                <h2 class="text-2xl font-semibold text-[#12263f]">Admin Profile Edit</h2>
            </div>
        </header>
           
	<div class="max-w-xl mx-auto bg-white p-8 rounded-lg shadow-md mt-10">
	  <h2 class="text-2xl font-bold mb-6 text-center">Admin Profile Edit</h2>
	
	  <form action="${pageContext.request.contextPath}/updateAdmin" method="post" class="space-y-5">
	   <!-- ID -->
	    <div>
	      <label class="block text-sm font-medium text-gray-700 mb-1">ID</label>
	      <input type="text" name="adID" readonly value="${param.adID}"
	             class="w-full px-4 py-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-blue-400"/>
	    </div>
	    <!-- Name -->
	    <div>
	      <label class="block text-sm font-medium text-gray-700 mb-1">Name</label>
	      <input type="text" name="adName" value="${param.adName}"
	             class="w-full px-4 py-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-blue-400"/>
	    </div>
	
	    <!-- Email -->
	    <div>
	      <label class="block text-sm font-medium text-gray-700 mb-1">Email</label>
	      <input type="email" name="adEmail" value="${param.adEmail}"
	             class="w-full px-4 py-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-blue-400"/>
	    </div>
	
		 <!-- Phone -->
	    <div>
	      <label class="block text-sm font-medium text-gray-700 mb-1">Phone</label>
	      <input type="number" name="adphone" value="${param.adphone}"
	             class="w-full px-4 py-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-blue-400"/>
	    </div>
	   
	    <!-- Password -->
	    <div>
	      <label class="block text-sm font-medium text-gray-700 mb-1">Password</label>
	      <input type="text" name="adPassword" value="${param.adPassword}"
	             class="w-full px-4 py-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-blue-400"/>
	    </div>
	
	    <!-- Buttons -->
	      <div class="flex justify-between items-center mt-6">
		  <!-- Back -->
		   <form action="${pageContext.request.contextPath}/displayAdmin" method="post">
			  <button type="submit" class="bg-gray-500 text-white px-6 py-2 rounded hover:bg-gray-600 transition">
			    Back
			  </button>
	 	   </form>
		  
	      <button type="submit" class="bg-blue-600 text-white px-6 py-2 rounded hover:bg-blue-700">
	        Save Changes
	      </button>
	    </div>
	  </form>
	</div>
	</div>
	
	<script src="<%= request.getContextPath() %>/js/adminSidebar.js"></script>
</body>
</html>