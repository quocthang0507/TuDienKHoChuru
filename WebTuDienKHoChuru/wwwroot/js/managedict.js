let audio_context;
let recorder;
let audioBlob = null;

function startUserMedia(stream) {
	var input = audio_context.createMediaStreamSource(stream);
	console.log('Media stream created.');

	recorder = new Recorder(input);
	console.log('Recorder initialized.');
}

function startRecording(button) {
	recorder && recorder.record();
	button.disabled = true;
	button.nextElementSibling.disabled = false;
	console.log('Recording...');
}

function stopRecording(button) {
	recorder && recorder.stop();

	button.disabled = true;
	button.previousElementSibling.disabled = false;

	recorder && recorder.exportWAV(blob => {
		validateAudio(blob);
	});
	console.log('Stopped recording.');
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
	audioFilename = url.replace(/^.*[\\\/]/, '');

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
		showToast('Cảnh báo', 'Một từ phải có ít nhất một nghĩa');
	group.lastChild.focus();
}

/**
 * Validate image file before submitting
 * Return: 
 * * true if it is corrected image format or no selected file,
 * * false if it is wrong supported image format or large file
*/
function validateImageInput() {
	var fileInput = document.getElementById('inputImage');
	var filePath = fileInput.value;
	// Allowing 2 extensions
	var allowedExtensions = /(\.jpg|\.png)$/i;
	if (fileInput.files && fileInput.files[0]) {
		if (!allowedExtensions.exec(filePath)) {
			showToast('Cảnh báo', 'Chỉ chấp nhận hình JPG và PNG!');
			fileInput.value = '';
			return false;
		}
		const Bytes = fileInput.files[0].size;
		const KB = Math.round((Bytes / 1024));
		// The size of the file. 
		if (KB > 2048) {
			showToast('Cảnh báo', 'Kích thước tập tin quá lớn, vui lòng gửi tập tin nhỏ hơn 2MB.');
			return false;
		}
		return true;
	}
	return true;
}

function showImagePreview() {
	return function () {
		if (validateImageInput()) {
			var reader = new FileReader();
			reader.onload = function (e) {
				document.getElementById('imagePreview').src = e.target.result;
			};
			reader.readAsDataURL(document.getElementById('inputImage').files[0]);
		}
	}
}

function eventChangeDictType() {
	return function () {
		var id = $('#selectDictType').val();
		window.location = '/ManageDictionary?dictTypeID=' + id;
	}
}

function collectData(form) {
	var formData = new FormData(form);

	var dictTypeID = parseInt(document.getElementById('selectDictType').value);
	var wordID = parseInt(document.getElementById('inputWordID').value);
	var word = document.getElementById('inputWord').value;
	var image = validateImageInput();
	var meanings = $('[name="Meaning"]').map(function () {
		return {
			ID: 0,
			WordID: wordID,
			Meaning: $(this).val()
		}
	}).get();

	// Kiểm tra hợp lệ
	if (!wordID)
		showToast('Cảnh báo', 'Thiếu ID từ');
	else if (!word)
		showToast('Cảnh báo', 'Không được bỏ trống ô từ vựng');
	else if (meanings.length == 0 || !meanings[0].Meaning)
		showToast('Cảnh báo', 'Vui lòng nhập ít nhất một nghĩa cho từ này');
	else if (image) {
		formData.append('JMeanings', JSON.stringify(meanings));
		formData.append('AudioFile', audioBlob);
		formData.append('DictType', dictTypeID);
		return formData;
	}
	return null;
}

async function deleteWord(wordID) {
	if (confirm('Bạn có chắc chắn muốn xóa từ này không? Sau khi xóa đi thì không thể khôi phục lại được')) {
		$.ajax({
			method: 'GET',
			url: window.location.origin + '/api/DeleteWord/' + wordID,
			success: function (data) {
				if (data != -1) {
					var url = new URL(window.location.href);
					var params = url.searchParams;
					params.set('wordID', data);
					window.location.href = params.toString();
				}
				else
					showToast('Lỗi', "Xóa không thành công");
			},
			error: function (request, status, error) {
				showToast('Lỗi', 'Đã xảy ra lỗi khi nhận yêu cầu xóa này');
			}
		});
	}
}

$(document).ready(function () {
	// Thêm sự kiện đổi loại từ điển
	$("#selectDictType").change(eventChangeDictType());

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
		console.log('AudioContext set up.');
		console.log('Navigator.getUserMedia ' + (navigator.getUserMedia ? 'available.' : 'not present!'));
	} catch (e) {
		alert('Trình duyệt này không hỗ trợ web audio!');
	}

	navigator.getUserMedia({ audio: true }, startUserMedia, function (e) {
		console.log('No live audio input: ' + e);
		alert('Vui lòng cho chép trang web này sử dụng microphone của bạn, sau đó tải lại trang để cập nhật trạng thái.');
	});

	// Load audio từ tập tin
	inputAudioFile.addEventListener('change', e => validateAudio(e.target.files[0]));

	// Xử lý sự kiện submit form
	$('#formAddOrUpdateWord').submit(async function (e) {
		// Chuẩn bị dữ liệu
		var data = collectData(this);
		if (data != null) {
			loaderOn();
			$.ajax({
				method: 'POST',
				url: $(this).attr('action'),
				data: data,
				cache: false,
				contentType: false,
				processData: false,
				success: function (data, text) {
					loaderOff();
					showToast('Lưu', 'Lưu thành công vào cơ sở dữ liệu');
				},
				error: function (request, status, error) {
					loaderOff();
					showToast('Lưu', request.responseText);
					console.error('Error: ', error);
				}
			});
			e.preventDefault();
		}
	});
});
