<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MediQuick Admin - Discounts</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-[#ecf1fc] text-[#333] min-h-screen flex font-sans">

    <!-- Sidebar Navigation -->
    <%@ include file="../partials/adminSidebar.jsp" %>

    <!-- Main Content -->
    <div id="mainContent" class="flex-1 ml-[250px] p-5 w-[calc(100%-250px)] transition-all duration-300">
    
        <!-- Top Header -->
        <header class="flex justify-between items-center mb-8 pb-5 border-b border-[#e3ebf6]">
            <div class="flex items-center gap-4">
                <button id="toggleSidebar" class="text-2xl">☰</button>
                <h2 class="text-2xl font-semibold text-[#12263f]">Discounts</h2>
            </div>
        </header>

        <!-- Discount Section -->
        <div class="bg-white rounded-lg shadow p-6">
            <div class="flex justify-between items-center border-b border-[#e3ebf6] pb-4 mb-4">
                <h3 class="text-xl font-semibold text-[#12263f]">Discounts</h3>
                <a href="discountAdd.jsp" class="bg-[#1e88e5] text-white px-4 py-2 rounded hover:bg-blue-600">Add Discount</a>
            </div>

            <div class="overflow-x-auto">
                <table class="w-full table-auto border-collapse">
                    <thead>
                        <tr class="text-left text-[#7b99c7] text-xs uppercase">
                            <th class="px-4 py-2">Discount Code</th>
                            <th class="px-4 py-2">Description</th>
                            <th class="px-4 py-2">Discount Percentage</th>
                            <th class="px-4 py-2">Start Date</th>
                            <th class="px-4 py-2">End Date</th>
                            <th class="px-4 py-2" colspan="2">Actions</th>
                        </tr>
                    </thead>
                    <tbody class="text-[#12263f]">
                        <c:forEach var="dis" items="${discount}">
                            <tr class="hover:bg-[#f9fbfd]">
                                <td class="px-4 py-2">${dis.code}</td>
                                <td class="px-4 py-2">${dis.description}</td>
                                <td class="px-4 py-2">${dis.percentage}</td>
                                <td class="px-4 py-2">${dis.startDate}</td>
                                <td class="px-4 py-2">${dis.endDate}</td>
                                <td class="px-4 py-2">
									<form action="discountEdit.jsp" method="post">
									    <input type="hidden" name="code" value="${dis.code}">
									    <input type="hidden" name="description" value="${dis.description}">
									    <input type="hidden" name="percentage" value="${dis.percentage}">
									    <input type="hidden" name="startDate" value="${dis.startDate}">
									    <input type="hidden" name="endDate" value="${dis.endDate}">
									    <button type="submit" class="bg-[#02bc6e] text-white px-3 py-1 rounded hover:bg-green-700">
									        Edit
									    </button>
									</form>
                                </td>
                                <td class="px-4 py-2">
                                    <form action="deleteDiscount" method="post">
                                        <input type="hidden" name="code" value="${dis.code}" />
                                        <button type="submit" class="bg-[#d2314f] text-white px-3 py-1 rounded hover:bg-red-600">Delete</button>
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
