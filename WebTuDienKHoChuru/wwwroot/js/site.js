function loaderOn() {
	document.getElementById("overlay").style.display = "block";
}

function loaderOff() {
	document.getElementById("overlay").style.display = "none";
}

function showToast(title, content) {
	document.getElementById('titleToast').innerHTML = title;
	document.getElementsByClassName('toast-body')[0].innerHTML = content;
	$('.toast').toast('show');
}