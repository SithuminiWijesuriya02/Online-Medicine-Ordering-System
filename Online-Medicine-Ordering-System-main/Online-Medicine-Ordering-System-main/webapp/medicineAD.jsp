<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>MediQuick Admin - Medicine</title>
	<script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-[#ecf1fc] text-[#333] min-h-screen flex font-sans">

	<!-- Sidebar -->
	<%@ include file="../partials/adminSidebar.jsp" %>

	<!-- Main Content -->
	<div id="mainContent" class="flex-1 ml-[250px] p-5 w-[calc(100%-250px)] transition-all duration-300">
		<header class="flex justify-between items-center mb-8 pb-5 border-b border-[#e3ebf6]">
			<div class="flex items-center gap-4">
				<button id="toggleSidebar" class="text-2xl">☰</button>
				<h2 class="text-2xl font-semibold text-[#12263f]">Medicines</h2>
			</div>
		</header>

		<div class="bg-white rounded-lg shadow p-6">
			<div class="flex justify-between items-center border-b border-[#e3ebf6] pb-4 mb-4">
				<h3 class="text-xl font-semibold text-[#12263f]">All Medicines</h3>
				<a href="medicineAdd.jsp" class="bg-[#1e88e5] text-white px-4 py-2 rounded hover:bg-blue-600">Add Medicine</a>
			</div>

			<h1 class="text-black text-base font-medium mb-4">List Size: ${fn:length(allMedicines)}</h1>

			<div class="overflow-x-auto">
				<table class="w-full table-auto border-collapse">
					<thead>
						<tr class="text-left text-[#7b99c7] text-xs uppercase">
							<th class="px-4 py-2">ID</th>
							<th class="px-4 py-2">Name</th>
							<th class="px-4 py-2">Brand</th>
							<th class="px-4 py-2">Category</th>
							<th class="px-4 py-2">Type</th>
							<th class="px-4 py-2">Dosage</th>
							<th class="px-4 py-2">Quantity</th>
							<th class="px-4 py-2">Price</th>
							<th class="px-4 py-2" colspan="2">Actions</th>
						</tr>
					</thead>
					<tbody class="text-[#12263f]">
						<c:forEach var="medicine" items="${allMedicines}">
							<tr class="hover:bg-[#f9fbfd]">
								<td class="px-4 py-2">${medicine.medId}</td>
								<td class="px-4 py-2">${medicine.medName}</td>
								<td class="px-4 py-2">${medicine.brand}</td>
								<td class="px-4 py-2">${medicine.category}</td>
								<td class="px-4 py-2">${medicine.type}</td>							
								<td class="px-4 py-2">${medicine.dosage}</td>
								<td class="px-4 py-2">${medicine.quantity}</td>
								<td class="px-4 py-2">${medicine.unitPrice}</td>
								<!-- Edit -->
								<td class="px-4 py-2">
									<form action="medicineEdit.jsp" method="post">
										<input type="hidden" name="id" value="${medicine.medId}" />
										<input type="hidden" name="medName" value="${medicine.medName}" />
										<input type="hidden" name="brand" value="${medicine.brand}" />
										<input type="hidden" name="quantity" value="${medicine.quantity}" />
										<input type="hidden" name="unitPrice" value="${medicine.unitPrice}" />
										<input type="hidden" name="type" value="${medicine.type}" />
										<input type="hidden" name="type" value="${medicine.description}" />
										<input type="hidden" name="dosage" value="${medicine.dosage}" />
										<input type="hidden" name="dosage" value="${medicine.category}" />
										<input type="hidden" name="description" value="${medicine.description}" />
										<button type="submit" class="bg-[#02bc6e] text-white px-3 py-1 rounded hover:bg-green-700">
											Edit
										</button>
									</form>
								</td>

								<!-- Delete -->
								<td class="px-4 py-2">
									<form action="deleteMedicine" method="post" onsubmit="return confirm('Are you sure?');">
										<input type="hidden" name="id" value="${medicine.medId}" />
										<button type="submit" class="bg-[#d2314f] text-white px-3 py-1 rounded hover:bg-red-600">
											Delete
										</button>
									</form>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</div>

	<script src="<%= request.getContextPath() %>/js/adminSidebar.js"></script>
</body>
</html>
