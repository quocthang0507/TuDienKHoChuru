var audio_context;
var recorder;
var audioBlob;

function showLog(showAlert, e, data) {
	if (showAlert)
		alert(e + " " + (data || ''));
	console.log(e + " " + (data || ''));
}

function startUserMedia(stream) {
	var input = audio_context.createMediaStreamSource(stream);
	showLog(false, 'Media stream created.');

	recorder = new Recorder(input);
	showLog(false, 'Recorder initialized.');
}

function startRecording(button) {
	recorder && recorder.record();
	button.disabled = true;
	button.nextElementSibling.disabled = false;
	showLog(false, 'Recording...', null);
}

function stopRecording(button) {
	recorder && recorder.stop();

	button.disabled = true;
	button.previousElementSibling.disabled = false;

	recorder && recorder.exportWAV(blob => {
		validateAudio(blob);
	});
	showLog(false, 'Stopped recording.', null);
	recorder.clear();
}

function validateAudio(blob) {
	switch (blob.type) {
		case 'audio/wav':
		case 'audio/mpeg':
		case 'audio/ogg':
			break;
		default:
			alert('Không hỗ trợ các định dạng tập tin âm thanh khác, vui lòng chỉ chọn các tập tin có đuôi như sau: *.mp3, *.wav, *.ogg');
			audioBlob = null;
			return;
	}

	var url = URL.createObjectURL(blob);
	var audio = document.getElementById('audioPreview');
	var source = document.getElementById('audioSource');
	source.src = url;
	audioBlob = blob;
	audio.load();
}

function createInputMeaning(required) {
	var input = document.createElement('input');
	input.type = 'text';
	input.className = 'form-control';
	input.placeholder = 'Nhập nghĩa tại đây';
	input.name = 'Meaning';
	input.required = required;
	return input;
}

function addInputMeaning() {
	var group = document.getElementById('inputMeanings');
	var i = group.childElementCount;
	let input;
	if (i == 0)
		input = createInputMeaning(true);
	else
		input = createInputMeaning(false);
	group.appendChild(input);
	input.focus();
}

function removeInputMeaning() {
	var group = document.getElementById('inputMeanings');
	if (group.childElementCount >= 2)
		group.removeChild(group.lastChild);
	else
		alert("Một từ phải có ít nhất một nghĩa");
}

function validateImageFile() {
	var fileInput = document.querySelector('[type=file]');
	var filePath = fileInput.value;
	// Allowing 2 extensions
	var allowedExtensions = /(\.jpg|\.png)$/i;
	if (fileInput.files && fileInput.files[0]) {
		if (!allowedExtensions.exec(filePath)) {
			alert('Chỉ chấp nhận hình JPG và PNG!');
			fileInput.value = '';
		} else {
			const Bytes = fileInput.files[0].size;
			const KB = Math.round((Bytes / 1024));
			// The size of the file. 
			if (KB > 2048) {
				alert('Kích thước tập tin quá lớn, vui lòng gửi tập tin nhỏ hơn 2MB.');
				return null;
			} else {
				return fileInput.files[0];
			}
		}
	}
	return null;
}

function showImagePreview() {
	return function () {
		var file = validateImageFile();
		if (file !== false) {
			var reader = new FileReader();
			reader.onload = function (e) {
				document.getElementById('divImagePreview').innerHTML = '<img class="imgPreview full-width" src="' + e.target.result + '"/>';
			};
			reader.readAsDataURL(file);
		}
	}
}

function loadDictionaryNewType() {
	return function () {
		var id = $('#selectDictType').val();
		window.location = '/ManageDictionary?dictTypeID=' + id;
	}
}

function handleSubmitForm(e) {
	e.preventDefault();
	var form = new FormData();

	var wordID = document.getElementsByName('WordID')[0].value;
	var word = document.getElementsByName('Word')[0].value;
	var wordTypeID = document.getElementsByName('WordTypeID')[0].value;
	var image = validateImageFile();
	var meanings = $('#formAddOrUpdateWord').map(function () {
		return {
			WordID: wordID,
			Meaning: $(this).find('[name="Meaning"]').value
		}
	});
	if (wordID && word && meanings) {
		var url = window.location.origin + '/api/AddOrUpdateWord';

		form.append('WordID', wordID);
		form.append('Word', word);
		form.append('WordTypeID', wordTypeID);
		form.append('ImageFile', image);
		form.append('AudioFile', audioBlob);
		//form.append('Meanings', meanings);

		fetch(url, {
			method: 'POST',
			body: form
		}).then(response => response.text()).then(data => {
			showLog(true, data ? JSON.parse(data) : {});
		}).catch(error => {
			console.error(error);
			showLog(true, error);
		});
	} else {
		showLog(true, 'Vui lòng kiểm tra lại dữ liệu nhập vào');
	}
}

$(document).ready(function () {
	// Thêm sự kiện đổi loại từ điển
	$("#selectDictType").change(loadDictionaryNewType());

	// Xử lý khi di chuyển pagination
	var prev = $(".pagination li.prev");
	var next = $(".pagination li.next");

	next.click(function () {
		$('li.active').removeClass('active').next().addClass('active');
	});

	prev.click(function () {
		$('li.active').removeClass('active').prev().addClass('active');
	});

	// Xử lý khi chọn hình ảnh từ tập tin
	$('#inputImage').on('change', showImagePreview());

	// Khởi tạo Audio
	try {
		// webkit shim
		window.AudioContext = window.AudioContext || window.webkitAudioContext;
		navigator.getUserMedia = navigator.getUserMedia || navigator.webkitGetUserMedia;
		window.URL = window.URL || window.webkitURL;

		audio_context = new AudioContext();
		showLog(false, 'AudioContext set up.');
		showLog(false, 'navigator.getUserMedia ' + (navigator.getUserMedia ? 'available.' : 'not present!'));
	} catch (e) {
		alert('Trình duyệt này không hỗ trợ web audio!');
	}

	navigator.getUserMedia({ audio: true }, startUserMedia, function (e) {
		showLog('No live audio input: ' + e);
		alert('Vui lòng cho chép trang web này sử dụng microphone của bạn, sau đó tải lại trang để cập nhật trạng thái.');
	});

	inputAudioFile.addEventListener('change', e => validateAudio(e.target.files[0]));

	// Xử lý sự kiện submit form
	let form = document.getElementById('formAddOrUpdateWord');
	form.addEventListener('submit', e => handleSubmitForm(e));
});
