<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>MediQuick - Profile Edit</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="bg-[#ecf1fc] text-gray-800 font-sans tracking-wide min-h-screen flex flex-col">

  <%@ include file="./partials/navBar.jsp" %>

  <main class="flex-grow w-full max-w-4xl mx-auto bg-white p-10 pt-10 mt-28 shadow-lg rounded-xl">
    <h2 class="text-3xl font-bold text-[#1e88e5] text-center mb-8">Edit Profile</h2>

	<jsp:useBean id="cus" scope="session" class="model.Customer" />
	
    <form action="updateCustomer" method="post" class="space-y-6">
      <input type="hidden" name="cusID" value="${cus.cusID}" />

      <div class="grid md:grid-cols-2 gap-6">
        <div>
          <label class="block text-sm font-medium mb-1">First Name</label>
          <input type="text" name="firstName" value="${cus.firstName}" class="w-full border border-gray-300 rounded-md p-2" />
        </div>
        <div>
          <label class="block text-sm font-medium mb-1">Last Name</label>
          <input type="text" name="lastName" value="${cus.lastName}" class="w-full border border-gray-300 rounded-md p-2" />
        </div>
        <div>
          <label class="block text-sm font-medium mb-1">Email</label>
          <input type="email" name="email" value="${cus.email}" class="w-full border border-gray-300 rounded-md p-2" />
        </div>
        <div>
          <label class="block text-sm font-medium mb-1">Phone</label>
          <input type="text" name="phone" value="${cus.phone}" class="w-full border border-gray-300 rounded-md p-2" />
        </div>
        <div>
          <label class="block text-sm font-medium mb-1">Date of Birth</label>
          <input type="date" name="dob" value="${cus.dob}" class="w-full border border-gray-300 rounded-md p-2" />
        </div>
        <div class="relative">
          <label class="block text-sm font-medium mb-1">Password</label>
          <input type="password" name="password" id="password" value="${cus.password}" class="w-full border border-gray-300 rounded-md p-2 pr-10" />
          <button type="button" onclick="togglePassword()" class="absolute top-8 right-3 text-gray-500">
            <i class="fas fa-eye"></i>
          </button>
        </div>
        <div class="md:col-span-2">
          <label class="block text-sm font-medium mb-1">Street</label>
          <input type="text" name="street" value="${cus.street}" class="w-full border border-gray-300 rounded-md p-2" />
        </div>
        <div>
          <label class="block text-sm font-medium mb-1">City</label>
          <input type="text" name="city" value="${cus.city}" class="w-full border border-gray-300 rounded-md p-2" />
        </div>
        <div>
          <label class="block text-sm font-medium mb-1">State</label>
          <input type="text" name="state" value="${cus.state}" class="w-full border border-gray-300 rounded-md p-2" />
        </div>
        <div class="md:col-span-2">
          <label class="block text-sm font-medium mb-1">ZIP Code</label>
          <input type="text" name="zipCode" value="${cus.zipCode}" class="w-full border border-gray-300 rounded-md p-2" />
        </div>
      </div>

      <div class="flex justify-end gap-4 pt-4">
        <a href="CusProfile.jsp">
		  <button type="button" class="bg-gray-200 hover:bg-gray-300 text-gray-800 px-4 py-2 rounded">Cancel</button>
		</a>
        <button type="submit" class="bg-blue-600 hover:bg-blue-700 text-white px-4 py-2 rounded flex items-center gap-2">
          <i class="fas fa-save"></i> Save Changes
        </button>
      </div>
    </form>
  </main>

  <%@ include file="./partials/footer.jsp" %>

  <script>
    function togglePassword() {
      const input = document.getElementById("password");
      input.type = input.type === "password" ? "text" : "password";
    }
  </script>

</body>
</html>
