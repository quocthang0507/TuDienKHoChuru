
function loaderOn() {
	document.getElementById("overlay").style.display = "block";
}

function loaderOff() {
	document.getElementById("overlay").style.display = "none";
}

function showSnackbar(content) {
	// Get the snackbar DIV
	var x = document.getElementById("snackbar");
	// Add content to DIV
	x.innerHTML = content;
	// Add the "show" class to DIV
	x.className = "show";
	// After several seconds, remove the show class from DIV
	setTimeout(function () { x.className = x.className.replace("show", ""); }, 5000);
}

function isNumeric(str) {
	if (typeof str != "string") return false // we only process strings!  
	return !isNaN(str) && // use type coercion to parse the _entirety_ of the string (`parseFloat` alone does not do this)...
		!isNaN(parseFloat(str)) // ...and ensure strings of whitespace fail
}

// When the user scrolls down 20px from the top of the document, show the button
window.onscroll = function () { scrollFunction() };

function scrollFunction() {
	if (document.body.scrollTop > 20 || document.documentElement.scrollTop > 20) {
		btnTop.style.display = "block";
	} else {
		btnTop.style.display = "none";
	}
}

// When the user clicks on the button, scroll to the top of the document
function topFunction() {
	window.scrollTo({ top: 0, behavior: 'smooth' });
}

$(document).ready(function () {
	$('[data-tooltip="tooltip"]').tooltip();

	setTimeout(function () {
		if ($('#message').length > 0) {
			$('#message').fadeOut(500, function () { $(this).remove(); });
		}
	}, 5000);
});