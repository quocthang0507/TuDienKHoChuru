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
		button.style.display = 'none';
		btnStop.style.display = 'initial';
		console.log('Recording...');
	}
}

function stopRecording(button) {
	recorder && recorder.stop();

	button.style.display = 'none';
	btnStart.style.display = 'initial';

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

function eventChangeDictType() {
	return function () {
		var id = $('#selectDictType').val();
		window.location.href = window.location.origin + `/Passage/${id}/1`;
	}
}

function insertPassage() {
	loaderOn();
	var passageID = $('#ID').get(0).innerHTML;
	var dictTypeID = $('#selectDictType').get(0).value;
	var passageType = $('[name="PassageType"]').get(0).value;
	var source = $('[name="Source"]').get(0).value;
	var destination = $('[name="Destination"]').get(0).value;
	var data = new FormData();

	if (!isNumeric(passageID))
		data.append('ID', 0);
	else
		data.append('ID', passageID);
	data.append('DictType', dictTypeID);
	data.append('PassageType', passageType);
	data.append('Source', source);
	data.append('Destination', destination);
	data.append('AudioFile', audioBlob);
	$.ajax({
		method: 'POST',
		url: window.location.origin + '/api/InsertPassage',
		data: data,
		cache: false,
		contentType: false,
		processData: false,
		success: function (data, text) {
			location.reload();
		},
		error: function (request, status, error) {
			loaderOff();
			showSnackbar('Lỗi: Đã xảy ra lỗi khi nhận yêu cầu chèn đoạn văn song ngữ này');
		}
	});
	loaderOff();
}

function updatePassage(passageID, passageType) {
	$('#ID').get(0).innerHTML = $(`#ID${passageID}`).get(0).innerHTML;
	$('[name="PassageType"]').get(0).value = passageType;
	$('[name="Source"]').get(0).value = $('#source' + passageID).get(0).innerHTML;
	$('[name="Destination"]').get(0).value = $('#destination' + passageID).get(0).innerHTML;
	$('[name="PronouncePath"]').get(0).value = $('#pronounce' + passageID).get(0).innerHTML;
	btnInsert.style.display = 'none';
	btnSave.style.display = '';
}

async function deletePassage(passageID) {
	if (confirm("Bạn có muốn xóa đoạn văn song ngữ này không?")) {
		loaderOn();
		$.ajax({
			method: 'GET',
			url: window.location.origin + '/api/DeletePassage/' + passageID,
			success: function (data) {
				location.reload();
			},
			error: function (request, status, error) {
				loaderOff();
				showSnackbar('Lỗi: Đã xảy ra lỗi khi nhận yêu cầu xoá đoạn văn song ngữ này');
			}
		});
	}
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
});
