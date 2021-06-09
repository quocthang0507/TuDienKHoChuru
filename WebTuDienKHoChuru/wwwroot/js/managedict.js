var audio_context;
var recorder;

function showLog(e, data) {
	console.log(e + " " + (data || ''));
}

function startUserMedia(stream) {
	var input = audio_context.createMediaStreamSource(stream);
	showLog('Media stream created.');

	recorder = new Recorder(input);
	showLog('Recorder initialized.');
}

function startRecording(button) {
	recorder && recorder.record();
	button.disabled = true;
	button.nextElementSibling.disabled = false;
	showLog('Recording...', null);
}

function stopRecording(button) {
	recorder && recorder.stop();

	button.disabled = true;
	button.previousElementSibling.disabled = false;

	recorder && recorder.exportWAV(blob => {
		handleRecorder(blob);
	});
	showLog('Stopped recording.', null);
	recorder.clear();
}

function handleRecorder(blob) {
	switch (blob.type) {
		case 'audio/wav':
		case 'audio/mpeg':
		case 'audio/ogg':
			break;
		default:
			alert('Không hỗ trợ các định dạng tập tin âm thanh khác, vui lòng chỉ chọn các tập tin có đuôi như sau: *.mp3, *.wav, *.ogg');
			return;
	}

	var url = URL.createObjectURL(blob);
	var audio = document.getElementById('audioPreview');
	var source = document.getElementById('audioSource');
	source.src = url;
	audio.load();
}

function addInputMeaning() {
	var group = document.getElementById('inputMeanings');
	var children = group.innerHTML;
	var i = group.childElementCount + 1;
	children += `<input type="text" class="form-control" id="inputMeaning${i}" placeholder="Nhập nghĩa tại đây" >`;
	group.innerHTML = children;
}

function removeInputMeaning() {
	var group = document.getElementById('inputMeanings');
	if (group.childElementCount >= 2)
		group.removeChild(group.lastChild);
	else
		alert("Một từ phải có ít nhất một nghĩa");
}

function validateImage() {
	var fileInput = document.querySelector('[type=file]');
	var filePath = fileInput.value;
	// Allowing 2 extensions
	var allowedExtensions = /(\.jpg|\.png)$/i;
	if (fileInput.files.length == 0)
		alert('Hình ảnh không được để trống!');
	else if (!allowedExtensions.exec(filePath)) {
		alert('Chỉ chấp nhận hình JPG và PNG!');
		fileInput.value = '';
	} else {
		// Image preview 
		if (fileInput.files && fileInput.files[0]) {
			const Bytes = fileInput.files[0].size;
			const KB = Math.round((Bytes / 1024));
			// The size of the file. 
			if (KB > 2048) {
				alert('Kích thước tập tin quá lớn, vui lòng gửi tập tin nhỏ hơn 2MB.');
				return false;
			} else {
				return fileInput.files[0];
			}
		}
	}
	return false;
}

$(document).ready(function () {
	// Thêm sự kiện đổi loại từ điển
	$("#selectDictType").change(function () {
		var id = $('#selectDictType').val();
		window.location = '/ManageDictionary?dictTypeID=' + id;
	});

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
	$('#inputImage').on('change', function () {
		var file = validateImage();
		if (file !== false) {
			var reader = new FileReader();
			reader.onload = function (e) {
				document.getElementById('divImagePreview').innerHTML = '<img class="imgPreview" class="full-width" src="' + e.target.result + '"/>';
			};
			reader.readAsDataURL(file);
		}
	});

	// Khởi tạo Audio
	try {
		// webkit shim
		window.AudioContext = window.AudioContext || window.webkitAudioContext;
		navigator.getUserMedia = navigator.getUserMedia || navigator.webkitGetUserMedia;
		window.URL = window.URL || window.webkitURL;

		audio_context = new AudioContext();
		showLog('AudioContext set up.');
		showLog('navigator.getUserMedia ' + (navigator.getUserMedia ? 'available.' : 'not present!'));
	} catch (e) {
		alert('Trình duyệt này không hỗ trợ web audio!');
	}

	navigator.getUserMedia({ audio: true }, startUserMedia, function (e) {
		showLog('No live audio input: ' + e);
		alert('Vui lòng cho chép trang web này sử dụng microphone của bạn, sau đó tải lại trang để cập nhật trạng thái.');
	});

	inputAudioFile.addEventListener('change', e => handleRecorder(e.target.files[0]));
});
