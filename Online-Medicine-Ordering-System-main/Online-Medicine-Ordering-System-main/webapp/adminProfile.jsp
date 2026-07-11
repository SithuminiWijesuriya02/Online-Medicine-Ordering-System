<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>MediQuick - Admin Profile</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="bg-[#ecf1fc] text-[#333] font-sans">

  <%@ include file="../partials/adminSidebar.jsp" %>

  <div class="ml-[250px] p-6 w-[calc(100%-250px)] transition-all duration-300">
    <div class="max-w-4xl mx-auto mt-10">
      <!-- Admin Profile Card -->
      <div class="bg-white rounded-3xl shadow-xl border border-gray-100 p-8 flex flex-col md:flex-row items-center gap-8">

        <!-- Avatar with Initials -->
        <div class="w-32 h-32 rounded-full bg-gradient-to-br from-blue-600 via-purple-600 to-green-500 text-white text-4xl font-bold flex items-center justify-center shadow-2xl">
          <c:choose>
            <c:when test="${not empty loggedAdmin and not empty loggedAdmin.adName}">
              ${fn:substring(loggedAdmin.adName, 0, 1)}
            </c:when>
            <c:otherwise>A</c:otherwise>
          </c:choose>
        </div>

        <!-- Admin Info -->
        <div class="flex-1 text-center md:text-left">
          <h1 class="text-4xl font-bold bg-gradient-to-r from-blue-600 via-purple-600 to-green-500 bg-clip-text text-transparent mb-2">
            ${loggedAdmin.adName}
          </h1>
          <p class="text-gray-600 text-lg mb-3">Admin ID: ${loggedAdmin.adID}</p>

          <!-- Buttons -->
          <div class="flex flex-wrap gap-4 justify-center md:justify-start">
            <!-- Edit -->
            <form action="adProfileEdit.jsp" method="post">
              <input type="hidden" name="adID" value="${loggedAdmin.adID}">
              <input type="hidden" name="adName" value="${loggedAdmin.adName}">
              <input type="hidden" name="adEmail" value="${loggedAdmin.adEmail}">
              <input type="hidden" name="adPassword" value="${loggedAdmin.adPassword}">
              <input type="hidden" name="adphone" value="${loggedAdmin.adphone}">
              <button type="submit"
                class="bg-gradient-to-r from-blue-500 to-blue-600 text-white px-6 py-3 rounded-2xl hover:from-blue-600 hover:to-blue-700 transition-all duration-300 shadow-lg hover:shadow-xl transform hover:scale-105 flex items-center gap-2 font-semibold">
                <i class="fas fa-pen"></i> Edit
              </button>
            </form>

            <!-- Delete -->
            <form action="deleteAdmin" method="post" onsubmit="return confirm('Are you sure you want to delete this admin?')">
              <input type="hidden" name="adEmail" value="${loggedAdmin.adEmail}" />
              <button type="submit"
                class="bg-gradient-to-r from-red-500 to-red-600 text-white px-6 py-3 rounded-2xl hover:from-red-600 hover:to-red-700 transition-all duration-300 shadow-lg hover:shadow-xl transform hover:scale-105 flex items-center gap-2 font-semibold">
                <i class="fas fa-trash-alt"></i> Delete
              </button>
            </form>
          </div>
        </div>
      </div>

      <!-- Admin Info Section -->
      <div class="mt-10 bg-white rounded-xl shadow">
        <div class="bg-blue-600 text-white px-6 py-3 rounded-t-xl">
          <h2 class="text-xl font-semibold"><i class="fas fa-user-shield mr-2"></i> Admin Information</h2>
        </div>
        <div class="p-6 space-y-4 text-[16px]">
          <div class="flex items-center gap-4">
            <label class="w-40 font-medium">Admin ID</label>
            <input disabled value="${loggedAdmin.adID}" class="flex-1 rounded-md border-gray-300 bg-gray-50 px-3 py-2" />
          </div>
          <div class="flex items-center gap-4">
            <label class="w-40 font-medium">Name</label>
            <input disabled value="${loggedAdmin.adName}" class="flex-1 rounded-md border-gray-300 bg-gray-50 px-3 py-2" />
          </div>
          <div class="flex items-center gap-4">
            <label class="w-40 font-medium">Email</label>
            <input disabled value="${loggedAdmin.adEmail}" class="flex-1 rounded-md border-gray-300 bg-gray-50 px-3 py-2" />
          </div>
          <div class="flex items-center gap-4">
            <label class="w-40 font-medium">Phone</label>
            <input disabled value="${loggedAdmin.adphone}" class="flex-1 rounded-md border-gray-300 bg-gray-50 px-3 py-2" />
          </div>
        </div>
      </div>

      <!-- Back Button -->
      <div class="mt-8 text-center">
        <a href="adminDash.jsp" class="inline-block bg-gray-500 text-white px-6 py-2 rounded-xl hover:bg-gray-700 transition">
          Back to Dashboard
        </a>
      </div>
    </div>
  </div>

  <script src="<%= request.getContextPath() %>/js/adminSidebar.js"></script>
</body>
</html>
