var audio_context;
var recorder;
var audioBlob = null;

function startUserMedia(stream) {
	var input = audio_context.createMediaStreamSource(stream);
	console.log('Media stream created.');

	recorder = new Recorder(input);
	console.log('Recorder initialized.');
}

function startRecording(button) {
	if (audio_context) {
		recorder && recorder.record();
		button.disabled = true;
		button.nextElementSibling.disabled = false;
		console.log('Recording...');
	}
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
	audio.load();
}

function createInputMeaning(required) {
	var input = document.createElement('input');
	input.type = 'text';
	input.className = 'form-control';
	input.placeholder = 'Nhập nghĩa tại đây';
	input.name = 'WordMeaning';
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
		showSnackbar('Cảnh báo: Một từ phải có ít nhất một nghĩa');
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
			showSnackbar('Cảnh báo: Chỉ chấp nhận hình JPG và PNG!');
			fileInput.value = '';
			return false;
		}
		const Bytes = fileInput.files[0].size;
		const KB = Math.round((Bytes / 1024));
		// The size of the file. 
		if (KB > 2048) {
			showSnackbar('Cảnh báo: Kích thước tập tin quá lớn, vui lòng gửi tập tin nhỏ hơn 2MB.');
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
		window.location.href = window.location.origin + `/api/GoToWordPage/${id}/1`;
	}
}

function collectData(form) {
	var formData = new FormData(form);

	var dictTypeID = parseInt(document.getElementById('selectDictType').value);
	var wordID = parseInt(document.getElementById('inputWordID').value);
	var word = document.getElementById('inputWord').value;
	var image = validateImageInput();
	var meanings = $('[name="WordMeaning"]').map(function () {
		return {
			ID: 0,
			WordID: wordID,
			Meaning: $(this).val()
		}
	}).get();

	// Kiểm tra hợp lệ
	if (!wordID)
		showSnackbar('Cảnh báo: Thiếu ID từ');
	else if (!word)
		showSnackbar('Cảnh báo: Không được bỏ trống ô từ vựng');
	else if (meanings.length == 0 || !meanings[0].Meaning)
		showSnackbar('Cảnh báo: Vui lòng nhập ít nhất một nghĩa cho từ này');
	else if (image) {
		formData.append('JMeanings', JSON.stringify(meanings));
		formData.append('AudioFile', audioBlob);
		formData.append('DictType', dictTypeID);
		return formData;
	}
	return null;
}

function goToNext(button) {
	try {
		$(button).next()[0].click()
	} catch (e) {
	}
}

function goToPrevious(button) {
	try {
		$(button).prev()[0].click();
	} catch (e) {
	}
}

function deleteWord(wordID) {
	if (confirm('Bạn có chắc chắn muốn xóa từ này không? Sau khi xóa đi thì không thể khôi phục lại được')) {
		$.ajax({
			method: 'GET',
			url: window.location.origin + '/api/DeleteWord/' + wordID,
			success: function (data) {
				if (data != -1) {
					var url = new URL(window.location.href);
					var params = url.searchParams;
					params.set('wordID', data);
					window.location.href = window.location.origin + '/Dictionary/Word?' + params.toString();
				}
				else
					showSnackbar('Lỗi: Xóa từ vựng không thành công');
			},
			error: function (request, status, error) {
				showSnackbar('Lỗi: Đã xảy ra lỗi khi nhận yêu cầu xóa từ vựng này');
			}
		});
	}
}

function deleteExample(exampleID) {
	if (confirm('Bạn có chắc chắn muốn xóa ví dụ này không? Sau khi xóa đi thì không thể khôi phục lại được')) {
		$.ajax({
			method: 'GET',
			url: window.location.origin + '/api/DeleteExample/' + exampleID,
			success: function (data) {
				if (data) {
					location.reload();
				}
				else
					showSnackbar('Lỗi: Xóa ví dụ không thành công');
			},
			error: function (request, status, error) {
				showSnackbar('Lỗi: Đã xảy ra lỗi khi nhận yêu cầu xóa ví dụ này');
			}
		});
	}
}

function addNewWord(dictTypeID) {
	var word = $('#inputNewWord').val();
	if (confirm('Bạn có chắc chắn muốn thêm từ này không?')) {
		loaderOn();
		var data = new FormData();
		data.append('Word', word);
		data.append('WordType', 'Others');
		data.append('DictType', dictTypeID);

		$.ajax({
			method: 'POST',
			url: window.location.origin + '/api/InsertWord',
			data: data,
			cache: false,
			contentType: false,
			processData: false,
			success: function (data, text) {
				loaderOff();
				location.reload();
				showSnackbar('Thông báo: Thêm thành công vào cơ sở dữ liệu');
			},
			error: function (request, status, error) {
				loaderOff();
				showSnackbar('Lỗi: ' + request.responseText);
				console.error('Error: ', error);
			}
		});
	}
}

function goToSaveButton() {
	window.scrollTo({ top: 0, behavior: 'smooth' });

	var element = $('#btnSaveWord');
	setTimeout(function () {
		element.offsetWidth = element.offsetWidth;
		element.addClass('jump');
		element.addClass('start-now');
	}, 0);
}

function initializeAudio() {
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
		return false;
	}

	navigator.getUserMedia({ audio: true }, startUserMedia, function (e) {
		console.log('No live audio input: ' + e);
		alert('Vui lòng cho chép trang web này sử dụng microphone của bạn, sau đó tải lại trang để cập nhật trạng thái.');
		return false;
	});
	return true;
}

window.onload = function init() {
	if (!initializeAudio()) {
		audio_context = null;
	}
}

$(document).ready(function () {
	// Thêm sự kiện đổi loại từ điển
	$('#selectDictType').change(eventChangeDictType());

	$('#inputPageNumber').change(function () {
		var pageNumber = $(this).value;
		var dictTypeID = $('#selectDictType').get(0).value;
		if (pageNumber && dictTypeID) {
			window.location.href = window.location.origin + `/api/GoToWordPage/${dictTypeID}/${pageNumber}`;
		}
	});

	// Xử lý khi di chuyển từ
	var prevPage = $('#btnPrevWord');
	var nextPage = $('#btnNextWord');

	nextPage.click(() => goToNext($('#wordList a.active')));
	prevPage.click(() => goToPrevious($('#wordList a.active')));

	// Xử lý khi chọn hình ảnh từ tập tin
	$('#inputImage').on('change', showImagePreview());

	// Load audio từ tập tin
	inputAudioFile.addEventListener('change', e => validateAudio(e.target.files[0]));

	// Xử lý sự kiện submit form cập nhật từ
	$('#formUpdateWord').submit(function (e) {
		// Chuẩn bị dữ liệu
		e.preventDefault();
		var data = collectData(this);
		if (data !== null) {
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
					showSnackbar('Thông báo: Cập nhật từ vựng thành công vào cơ sở dữ liệu');
				},
				error: function (request, status, error) {
					loaderOff();
					showSnackbar('Lỗi: ' + request.responseText);
					console.error('Error: ', error);
				}
			});
		}
	});

	// Xử lý sự kiện submit form thêm ví dụ
	$('#formInsertExample').submit(function (e) {
		e.preventDefault();

		$('#addNewExampleModal').modal('hide');

		loaderOn();
		$.ajax({
			method: 'POST',
			url: $(this).attr('action'),
			data: $(this).serialize(),
			success: function (data, text) {
				loaderOff();
				showSnackbar('Thông báo: Thêm ví dụ thành công vào cơ sở dữ liệu');
				location.reload();
			},
			error: function (request, status, error) {
				loaderOff();
				showSnackbar('Lỗi: ' + request.responseText);
				console.error('Error: ', error);
			}
		});
	});
});
