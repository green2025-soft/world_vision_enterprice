
// sidebar collapse js
document.addEventListener("DOMContentLoaded", function () {
    var sidebar = document.getElementById("sidebar-wrapper");
    var contentWrapper = document.getElementById("page-content-wrapper");

    // Adjust content wrapper based on initial sidebar state
    if (sidebar.classList.contains("collapsed")) {
        contentWrapper.style.marginLeft = "80px";
    } else {
        contentWrapper.style.marginLeft = "250px";
    }
});

document.getElementById("sidebarToggle").addEventListener("click", function () {
    var sidebar = document.getElementById("sidebar-wrapper");
    var contentWrapper = document.getElementById("page-content-wrapper");

    sidebar.classList.toggle("collapsed");

    if (sidebar.classList.contains("collapsed")) {
        contentWrapper.style.marginLeft = "80px";
    } else {
        contentWrapper.style.marginLeft = "250px";
    }
});






// Fullscreen js
const fullscreenBtn = document.getElementById('fullscreenBtn');

fullscreenBtn.addEventListener('click', function (e) {
    e.preventDefault();
    if (!document.fullscreenElement) {
        // Request fullscreen
        document.documentElement.requestFullscreen();
        fullscreenBtn.innerHTML = '<i class="fas fa-compress"></i>'; // Change icon to compress
    } else {
        // Exit fullscreen
        if (document.exitFullscreen) {
            document.exitFullscreen();
            fullscreenBtn.innerHTML = '<i class="fas fa-expand"></i>'; // Change icon back to expand
        }
    }
});



/*******image light box********/
document.getElementById("featured_image").addEventListener("change", function (event) {
    var preview = document.getElementById("imagePreview");
    var file = event.target.files[0];
    var reader = new FileReader();

    reader.onload = function (e) {
        preview.src = e.target.result;
        preview.style.display = "block";
    }

    if (file) {
        reader.readAsDataURL(file);
    }
});

// Function to open the lightbox
function openLightbox(src) {
    var lightbox = document.getElementById("lightbox");
    var lightboxImage = document.getElementById("lightboxImage");
    lightbox.style.display = "block";
    lightboxImage.src = src;
}

// Function to close the lightbox
function closeLightbox() {
    document.getElementById("lightbox").style.display = "none";
}






/************ Common Setting Logo Upload ***********/

function previewImage(event) {
    var file = event.target.files[0];
    if (file) {
        var reader = new FileReader();

        reader.onload = function (e) {
            var preview = document.getElementById('logoPreview');
            preview.src = e.target.result;
            preview.style.display = "block";
        }

        reader.readAsDataURL(file);
    }
}









