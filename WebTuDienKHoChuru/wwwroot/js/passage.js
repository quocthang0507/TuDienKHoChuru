function eventChangeDictType() {
	return function () {
		var id = $('#selectDictType').val();
		window.location.href = window.location.origin + `/Passage/${id}/1`;
	}
}

function insertPassage() {
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
	$.ajax({
		method: 'POST',
		url: window.location.origin + '/api/InsertPassage',
		cache: false,
		contentType: false,
		processData: false,
		data: data,
		success: function (data) {
			location.reload();
		},
		error: function (request, status, error) {
			loaderOff();
			showSnackbar('Lỗi: Đã xảy ra lỗi khi nhận yêu cầu chèn đoạn văn song ngữ này');
		}
	});
}

function updatePassage(passageID, passageType) {
	$('#ID').get(0).innerHTML = $(`#ID${passageID}`).get(0).innerHTML;
	$('[name="PassageType"]').get(0).value = passageType;
	$('[name="Source"]').get(0).value = $('#source' + passageID).get(0).innerHTML;
	$('[name="Destination"]').get(0).value = $('#destination' + passageID).get(0).innerHTML;
	btnInsert.style.display = 'none';
	btnSave.style.display = '';
}

function deletePassage(passageID) {
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

$(document).ready(function () {
	// Thêm sự kiện đổi loại từ điển
	$('#selectDictType').change(eventChangeDictType());
});