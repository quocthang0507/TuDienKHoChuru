var audio_context;
var recorder;

function startUserMedia(stream) {
	var input = audio_context.createMediaStreamSource(stream);
	console.log('Media stream created.');

	recorder = new Recorder(input);
	console.log('Recorder initialized.');
}

function startRecording(button) {
	recorder && recorder.record();
	button.style.display = 'none';
	button.nextElementSibling.style.display = 'initial';
	console.log('Recording...');
}

function stopRecording(button, exampleID) {
	recorder && recorder.stop();

	button.style.display = 'none';
	button.previousElementSibling.style.display = 'initial';
	$(button).next().children().first().get(0).style.display = 'initial';

	recorder && recorder.exportWAV(blob => {
		validateAudio(blob, exampleID);
	});
	console.log('Stopped recording.');
	recorder.clear();
}

function validateAudio(blob, exampleID) {
	switch (blob.type) {
		case 'audio/wav':
		case 'audio/mpeg':
		case 'audio/ogg':
			break;
		default:
			alert('Không hỗ trợ các định dạng tập tin âm thanh khác, vui lòng chỉ chọn các tập tin có phần mở rộng là: *.mp3, *.wav, *.ogg');
			return;
	}

	var url = URL.createObjectURL(blob);
	var audio = document.getElementById('audioPreview' + exampleID);
	var source = document.getElementById('audioSource' + exampleID);
	source.src = url;

	audio.load();
}

function eventChangeDictType() {
	return function () {
		var id = $('#selectDictType').val();
		window.location.href = window.location.origin + `/api/GoToExamplePage/${id}/1`;
	}
}

function deleteAudio(exampleID) {
	if (confirm('Bạn có muốn loại bỏ âm thanh này khỏi ví dụ không?')) {
		loaderOn();
		$.ajax({
			method: 'GET',
			url: window.location.origin + '/api/DeleteAudioExample/' + exampleID,
			success: function (data) {
				location.reload();
			},
			error: function (request, status, error) {
				loaderOff();
				showSnackbar('Lỗi: Đã xảy ra lỗi khi nhận yêu cầu xoá âm thanh phát âm ví dụ này');
			}
		});
	}
}

function uploadAudio(exampleID) {
	var source = document.getElementById('audioSource' + exampleID);
	var url = source.src;
	if (url) {
		loaderOn();
		fetch(url).then(res => res.blob()).
			then(blob => {
				var data = new FormData();
				data.append('exampleID', exampleID);
				data.append('audio', blob);

				$.ajax({
					method: 'POST',
					url: window.location.origin + '/api/UpdateAudioExample',
					cache: false,
					contentType: false,
					processData: false,
					data: data,
					success: function (data) {
						location.reload();
					},
					error: function (request, status, error) {
						loaderOff();
						showSnackbar('Lỗi: Đã xảy ra lỗi khi nhận yêu cầu cập nhật âm thanh phát âm ví dụ này');
					}
				});
			});
	}
}

$(document).ready(function () {
	// Thêm sự kiện đổi loại từ điển
	$('#selectDictType').change(eventChangeDictType());

	$('#inputPageNumber').change(function () {
		var pageNumber = $(this).value;
		var dictTypeID = $('#selectDictType').get(0).value;
		if (pageNumber && dictTypeID) {
			window.location.href = window.location.origin + `/api/GoToExamplePage/${dictTypeID}/${pageNumber}`;
		}
	});

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
});