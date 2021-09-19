const maxSizePreview = 50; //KB

function checkTsvExt(filePath) {
	var allowedExtensions = /\.(tsv|txt)$/i;
	return allowedExtensions.exec(filePath);
}

function onInputChange(dictTypeID) {
	var filePath = inputTSV.value;

	if (inputTSV.files && inputTSV.files[0]) {
		if (!checkTsvExt(filePath)) {
			showSnackbar('Cảnh báo: Chỉ chấp nhận tập tin .txt hoặc .tsv!');
			inputTSV.value = '';
		} else {
			var size = inputTSV.files[0].size / 1024; // in KB
			captionInput.innerHTML = filePath.replace(/.*[\/\\]/, '');
			btnUpload.style.display = 'initial';
			if (size <= maxSizePreview) {
				loaderOn();
				var reader = new FileReader();
				reader.onload = function (e) {
					showTsvFile(e.target.result);
					loaderOff();
				};
				reader.readAsText(inputTSV.files[0]);
			}
			btnUpload.addEventListener('click', function (e) {
				submitTsvFile(inputTSV.files[0], dictTypeID);
			});
		}
	}
}

function dropHandler(e, dictTypeID) {
	// Prevent default behavior (Prevent file from being opened)
	e.preventDefault();
	if (e.dataTransfer.items) {
		if (e.dataTransfer.items.length != 1)
			showSnackbar('Chỉ nhận một tập tin thả vào đây thôi!');
		else {
			// Use DataTransferItemList interface to access the file
			// If dropped items aren't files, reject them
			if (e.dataTransfer.items[0].kind === 'file') {
				var file = e.dataTransfer.items[0].getAsFile();
				if (checkTsvExt(file.name)) {
					var size = file.size / 1024; // in KB
					if (size <= maxSizePreview) {
						loaderOn();
						file.text().then(text => {
							showTsvFile(text);
							loaderOff();
						});
					}
					btnUpload.style.display = 'initial';
					captionInput.innerHTML = file.name;

					btnUpload.addEventListener('click', function (e) {
						submitTsvFile(file, dictTypeID);
					});
				} else
					showSnackbar('Cảnh báo: Tập tin đã thả vào đây không phải là tập tin có phần mở rộng .tsv hay .txt');
			}
		}
	}
}

function dragOverHandler(e) {
	dropZone.style.backgroundColor = '#c8dadf';
	// Prevent default behavior (Prevent file from being opened)
	e.preventDefault();
}

function dropLeaveHandler(e) {
	dropZone.style.backgroundColor = '#ffffff';
	e.preventDefault();
}

function showTsvFile(data) {
	$('table').remove();
	var parsedTSV = d3.tsvParseRows(data);
	// Thêm bảng vào thẻ div có id tsvTable
	var table = d3.select('#tsvTable').append('table').attr('class', 'table table-hover table-bordered table-sm tableFixHead').attr('id', 'previewTSV');
	var thead = table.append('thead').attr('scope', 'col');
	var tbody = table.append('tbody');
	// Dòng header bảng thêm một ô có tên STT
	parsedTSV[0].unshift('STT');
	// Đổ dữ liệu vào các cột header
	var header = thead.append('tr')
		.selectAll('th')
		.data(parsedTSV[0])
		.enter()
		.append('th')
		.text(function (d) { return d });
	// Thêm STT tăng dần vào các dòng dữ liệu
	parsedTSV.shift();
	parsedTSV.forEach((item, i) => {
		item.unshift(i + 1);
	});
	// Đổ dữ liệu vào các dòng
	var rows = tbody.selectAll('tr')
		.data(parsedTSV).enter()
		.append('tr');
	// Đổ dữ liệu vào các ô
	var cells = rows.selectAll('td')
		.data(function (d) { return d; }).enter()
		.append('td')
		.text(function (d) { return d });
	// In ra thông tin số lượng các dòng
	totalRows.innerHTML = `Có tổng cộng ${parsedTSV.length} dòng`;

	tsvTable.style.display = 'initial';
	return table;
}

function highlightRow(arr) {
	var tbl = document.getElementById('previewTSV');
	var rows = tbl.rows;
	totalRows.innerHTML += ` và ${arr.length} dòng bị lỗi. Vui lòng chỉnh sửa lại các dòng này và thử tải lên tập tin này một lần nữa`;
	for (var i = 0; i < arr.length; i++) {
		rows[arr[i] + 1].classList.add('table-danger');
	}
	$('html, body').animate({
		scrollTop: $("#previewTSV").offset().top
	}, 1000);
}

function submitTsvFile(fileObj, dictTypeID) {
	if (confirm('Bạn có muốn nhập các từ này vào hệ thống không? Lưu ý: Các từ có thể bị trùng sau khi nhập')) {
		loaderOn();

		if (pageName == 'Dictionary')
			url = window.location.origin + '/api/ImportDictionary';
		else if (pageName == 'Passage')
			url = window.location.origin + '/api/ImportPassage';
		else
			return;

		var data = new FormData();
		data.append('tsvFile', fileObj);
		data.append('dictTypeID', dictTypeID);

		$.ajax({
			method: 'POST',
			url: url,
			data: data,
			cache: false,
			contentType: false,
			processData: false,
			success: function (data, text) {
				loaderOff();
				showSnackbar('Thông báo: Thêm thành công vào cơ sở dữ liệu');
			},
			error: function (request, status, error) {
				loaderOff();
				if (request.responseJSON) {
					highlightRow(request.responseJSON);
				}
				else {
					showSnackbar("Lỗi: " + request.responseText);
					console.error('Error: ', error);
				}
			}
		});
	}
}