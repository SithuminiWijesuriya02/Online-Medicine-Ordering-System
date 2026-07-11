<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Admin sidebar</title>
  <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-[#ecf1fc] text-[#333] min-h-screen flex font-sans">

	<nav id="sidebar" class="w-[250px] bg-[#1c324b] text-white h-screen fixed overflow-hidden px-1.5">
	  <div class="p-5 border-b border-white/10 flex justify-between items-center">
	    <h1 class="text-2xl font-bold">Medi<span class="text-[#1ac185]">Quick</span></h1>
	  </div>
	  
	  <div class="py-5">
	  	
	    <a href="dashboard" class="sidebar-link block px-5 py-3 text-white/70 hover:bg-white/10 hover:text-white border-l-4 border-transparent">Dashboard</a>
	    <form action="displayMedicine" method="post">
		  <button type="submit" class="sidebar-link block w-full text-left px-5 py-3 text-white/70 hover:bg-white/10 hover:text-white border-l-4 border-transparent">
		    Medicines
		  </button>
	 	</form>
	 	<form action="displayOrder" method="post">
		  <button type="submit" class="sidebar-link block w-full text-left px-5 py-3 text-white/70 hover:bg-white/10 hover:text-white border-l-4 border-transparent">
		    Orders
		  </button>
	 	</form>
	    <a href="#" class="sidebar-link block px-5 py-3 text-white/70 hover:bg-white/10 hover:text-white border-l-4 border-transparent">Customers</a>
	    <form action="displayDiscounts" method="post">
		  <button type="submit" class="sidebar-link block w-full text-left px-5 py-3 text-white/70 hover:bg-white/10 hover:text-white border-l-4 border-transparent">
		    Discounts
		  </button>
	 	</form>
 		    
	    <div class="text-xs uppercase text-white/40 px-5 pt-4">Inventory</div>
	    <a href="EditStock?medId=${medicine.medId}" class="sidebar-link block px-5 py-3 text-white/70 hover:bg-white/10 hover:text-white border-l-4 border-transparent">Stock Management</a>
	    <a href="#" class="sidebar-link block px-5 py-3 text-white/70 hover:bg-white/10 hover:text-white border-l-4 border-transparent">Suppliers & Delivery</a>
	
	    <div class="text-xs uppercase text-white/40 px-5 pt-4">Settings</div>
	    <a href="#" class="sidebar-link block px-5 py-3 text-white/70 hover:bg-white/10 hover:text-white border-l-4 border-transparent">General Settings</a>
	    <a href="#" class="sidebar-link block px-5 py-3 text-white/70 hover:bg-white/10 hover:text-white border-l-4 border-transparent">Admin User</a>
	  </div>
	</nav>
	
</body>
</html>
	