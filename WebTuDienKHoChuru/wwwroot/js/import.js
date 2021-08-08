function checkCsvExt(filePath) {
	var allowedExtensions = /(\.csv)$/i;
	return allowedExtensions.exec(filePath);
}

function onInputChange(dictTypeID) {
	var filePath = inputCSV.value;

	if (inputCSV.files && inputCSV.files[0]) {
		if (!checkCsvExt(filePath)) {
			showSnackbar('Cảnh báo: Chỉ chấp nhận tập tin CSV!');
			inputCSV.value = '';
		} else {
			captionInput.innerHTML = filePath.replace(/.*[\/\\]/, '');
			var reader = new FileReader();
			reader.onload = function (e) {
				showCsvFile(e.target.result);

				btnUpload.addEventListener('click', function (e) {
					submitCsvFile(inputCSV.files[0], dictTypeID);
				});
			};
			reader.readAsText(inputCSV.files[0]);
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
				if (checkCsvExt(file.name)) {
					file.text().then(text => showCsvFile(text));
					captionInput.innerHTML = file.name;

					btnUpload.addEventListener('click', function (e) {
						submitCsvFile(file, dictTypeID);
					});
				} else
					showSnackbar('Cảnh báo: Tập tin đã thả vào đây không phải là tập tin có phần mở rộng CSV');
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

function showCsvFile(data) {
	$('table').remove();
	var parsedCSV = d3.csvParseRows(data);
	// Thêm bảng vào thẻ div có id csvTable
	var table = d3.select('#csvTable').append('table').attr('class', 'table table-hover table-bordered table-sm tableFixHead').attr('id', 'previewCSV');
	var thead = table.append('thead').attr('scope', 'col');
	var tbody = table.append('tbody');
	// Dòng header bảng thêm một ô có tên STT
	parsedCSV[0].unshift('STT');
	// Đổ dữ liệu vào các cột header
	var header = thead.append('tr')
		.selectAll('th')
		.data(parsedCSV[0])
		.enter()
		.append('th')
		.text(function (d) { return d });
	// Thêm STT tăng dần vào các dòng dữ liệu
	parsedCSV.shift();
	parsedCSV.forEach((item, i) => {
		item.unshift(i + 1);
	});
	// Đổ dữ liệu vào các dòng
	var rows = tbody.selectAll('tr')
		.data(parsedCSV).enter()
		.append('tr');
	// Đổ dữ liệu vào các ô
	var cells = rows.selectAll('td')
		.data(function (d) { return d; }).enter()
		.append('td')
		.text(function (d) { return d });
	// In ra thông tin số lượng các dòng
	totalRows.innerHTML = `Có tổng cộng ${parsedCSV.length} dòng`;
	csvTable.style.display = '';
	return table;
}

function parseCsvPath(pathToCSV) {
	d3.csv(pathToCSV, function (error, data) {
		if (error) {
			showSnackbar('Lỗi định dạng tập tin CSV!');
			return;
		}
		showCsvFile(data);
		$('html, body').animate({
			scrollTop: $("#previewCSV").offset().top
		}, 2000);
	});
}

function highlightRow(arr) {
	var tbl = document.getElementById('previewCSV');
	var rows = tbl.rows;
	totalRows.innerHTML += ` và ${arr.length} dòng bị lỗi. Vui lòng chỉnh sửa lại các dòng này và thử tải lên tập tin này một lần nữa`;
	for (var i = 0; i < arr.length; i++) {
		rows[arr[i] + 1].classList.add('table-danger');
	}
	$('html, body').animate({
		scrollTop: $("#previewCSV").offset().top
	}, 1000);
}

function submitCsvFile(fileObj, dictTypeID) {
	if (confirm('Bạn có muốn nhập các từ này vào hệ thống không? Lưu ý: Các từ có thể bị trùng sau khi nhập')) {
		loaderOn();
		var data = new FormData();
		data.append('csvFile', fileObj);
		data.append('dictTypeID', dictTypeID);
		$.ajax({
			method: 'POST',
			url: window.location.origin + '/api/Import',
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
				console.error('Error: ', error);
			}
		});
	}
}