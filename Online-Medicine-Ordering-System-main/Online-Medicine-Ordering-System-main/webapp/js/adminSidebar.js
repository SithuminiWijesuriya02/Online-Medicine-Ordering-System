
document.getElementById("toggleSidebar").addEventListener("click", function () {
	  const sidebar = document.getElementById("sidebar");
	  const main = document.getElementById("mainContent");

	  if (sidebar.classList.contains("hidden")) {
	    // Show sidebar
	    sidebar.classList.remove("hidden");
	    main.classList.remove("ml-0", "w-full");
	    main.classList.add("ml-[250px]", "w-[calc(100%-250px)]");
	  } else {
	    // Hide sidebar and expand content
	    sidebar.classList.add("hidden");
	    main.classList.remove("ml-[250px]", "w-[calc(100%-250px)]");
	    main.classList.add("ml-0", "w-full");
	  }
 });