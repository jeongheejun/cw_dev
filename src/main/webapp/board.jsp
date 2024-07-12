<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Board</title>
<style>
body {
	font-family: Arial, sans-serif;
	background-color: #E0F7FA; /* 하늘색 계열 */
	color: #00796B;
}

.container {
	width: 90%;
	margin: 0 auto;
	padding: 20px;
	background-color: #ffffff;
	border: 1px solid #B2EBF2;
	border-radius: 8px;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.nav-tabs {
	display: flex;
	border-bottom: 1px solid #B2EBF2;
	list-style-type: none;
	padding: 0;
}

.nav-tabs .nav-item {
	margin-right: 10px;
}

.nav-tabs .nav-link {
	display: block;
	padding: 10px 15px;
	background-color: #E0F7FA;
	color: #00796B;
	text-decoration: none;
	border-radius: 8px 8px 0 0;
	cursor: pointer;
}

.nav-tabs .nav-link.active {
	background-color: #ffffff;
	border-bottom: 2px solid #00796B;
}

.tab-content {
	padding: 20px;
	border: 1px solid #B2EBF2;
	border-radius: 0 8px 8px 8px;
	background-color: #ffffff;
}

.tab-pane {
	display: none;
}

.tab-pane.active {
	display: block;
}

.table {
	width: 100%;
	border-collapse: collapse;
}

.table th, .table td {
	padding: 10px;
	text-align: left;
	border: 1px solid #B2EBF2;
}

.table th {
	background-color: #B2EBF2;
	color: #00796B;
	cursor: pointer;
}

.table input[type="text"] {
	width: 90%;
	padding: 5px;
	border: 1px solid #B2EBF2;
	border-radius: 4px;
}

.pagination {
	display: flex;
	justify-content: center;
	margin: 20px 0;
}

.pagination a {
	margin: 0 5px;
	padding: 8px 16px;
	text-decoration: none;
	color: #00796B;
	border: 1px solid #B2EBF2;
	border-radius: 4px;
	cursor: pointer;
}

.pagination a.active {
	background-color: #00796B;
	color: white;
	border: 1px solid #00796B;
}

.total-count {
	text-align: center;
	margin: 20px 0;
	color: #00796B;
}

.common-search {
	margin-bottom: 20px;
	display: flex;
	align-items: center;
}

.common-search select, .common-search input[type="date"], .common-search input[type="text"],
	.common-search button {
	margin-right: 10px;
	padding: 8px;
	border: 1px solid #B2EBF2;
	border-radius: 4px;
	background-color: #ffffff;
	color: #00796B;
}

.common-search button {
	cursor: pointer;
	background-color: #00796B;
	color: white;
}

.common-search button:hover {
	background-color: #004D40;
}

.tab-pane .search-form input[type="text"] {
	display: none;
}

.tab-pane.active .search-form input[type="text"] {
	display: block;
}

#tab2 .search-form input[type="text"] {
	display: none !important;
}

#tab2 .common-search #query-common {
	display: none;
}
</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
function getDateRange(option) {
    let today = new Date();
    let startDate, endDate;
    switch (option) {
        case '':
        case '오늘':
            startDate = endDate = today;
            break;
        case '어제~내일':
            startDate = new Date(today);
            startDate.setDate(today.getDate() - 1);
            endDate = new Date(today);
            endDate.setDate(today.getDate() + 1);
            break;
        case '이번주':
            startDate = new Date(today.setDate(today.getDate() - today.getDay() + 1));
            endDate = new Date(today.setDate(startDate.getDate() + 6));
            break;
        case '지난한주':
            startDate = new Date(today.setDate(today.getDate() - today.getDay() - 6));
            endDate = new Date(today.setDate(startDate.getDate() + 6));
            break;
        case '지난주':
            startDate = new Date(today.setDate(today.getDate() - today.getDay() - 7));
            endDate = new Date(today.setDate(startDate.getDate() + 6));
            break;
        case '이번달':
            startDate = new Date(today.getFullYear(), today.getMonth(), 1);
            endDate = new Date(today.getFullYear(), today.getMonth() + 1, 0);
            break;
        case '이전한달':
            startDate = new Date(today.getFullYear(), today.getMonth() - 1, 1);
            endDate = new Date(today.getFullYear(), today.getMonth(), 0);
            break;
        case '이번분기':
            let currentQuarter = Math.floor((today.getMonth() + 3) / 3);
            startDate = new Date(today.getFullYear(), (currentQuarter - 1) * 3, 1);
            endDate = new Date(today.getFullYear(), currentQuarter * 3, 0);
            break;
        case '지난분기':
            let previousQuarter = Math.floor((today.getMonth() + 3) / 3) - 1;
            startDate = new Date(today.getFullYear(), previousQuarter * 3 - 3, 1);
            endDate = new Date(today.getFullYear(), previousQuarter * 3, 0);
            break;
        case '상반기':
            startDate = new Date(today.getFullYear(), 0, 1);
            endDate = new Date(today.getFullYear(), 5, 30);
            break;
        case '하반기':
            startDate = new Date(today.getFullYear(), 6, 1);
            endDate = new Date(today.getFullYear(), 11, 31);
            break;
        case '올해':
            startDate = new Date(today.getFullYear(), 0, 1);
            endDate = new Date(today.getFullYear(), 11, 31);
            break;
        case '작년':
            startDate = new Date(today.getFullYear() - 1, 0, 1);
            endDate = new Date(today.getFullYear() - 1, 11, 31);
            break;
        case '이전3년':
            startDate = new Date(today.getFullYear() - 3, 0, 1);
            endDate = new Date(today.getFullYear() - 1, 11, 31);
            break;
        case '최근3개월':
            startDate = new Date(today.setMonth(today.getMonth() - 3));
            endDate = new Date();
            break;
        case '최근1년':
            startDate = new Date(today.setFullYear(today.getFullYear() - 1));
            endDate = new Date();
            break;
        case '최근3년':
            startDate = new Date(today.setFullYear(today.getFullYear() - 3));
            endDate = new Date();
            break;
        case '최근5년':
            startDate = new Date(today.setFullYear(today.getFullYear() - 5));
            endDate = new Date();
            break;
        default:
            startDate = endDate = today;
    }
    return { startDate, endDate };
}


    function updateDateRange(option) {
        let { startDate, endDate } = getDateRange(option);
        document.getElementById('startDate').value = startDate.toISOString().split('T')[0];
        document.getElementById('endDate').value = endDate.toISOString().split('T')[0];
    }

    function setDefaultDates() {
        let today = new Date();
        document.getElementById('startDate').value = today.toISOString().split('T')[0];
        document.getElementById('endDate').value = today.toISOString().split('T')[0];
    }

    $(document).ready(function () {
        setDefaultDates();

        $('#dateRangeSelect').on('change', function () {
            let selectedOption = $(this).val();
            updateDateRange(selectedOption);
        });

        $('.searchForm').on('submit', function (event) {
            event.preventDefault();
            let tab = $(this).data('tab');
            const sortFieldElement = document.getElementById('sortField-' + tab);
            const sortDirElement = document.getElementById('sortDir-' + tab);

            if (!sortFieldElement || !sortDirElement) {
                console.error(`Sort elements not found for tab: ${tab}`);
                return;
            }
            if (tab === 'tab2') {
                loadAssigneeCounts(0, document.getElementById('sortField-' + tab).value, document.getElementById('sortDir-' + tab).value);
            } else {
                loadTable(tab, 0, document.getElementById('sortField-' + tab).value, document.getElementById('sortDir-' + tab).value);
            }
        });

        $('input[type="text"]').on('keypress', function (event) {
            if (event.which == 13) {
                event.preventDefault();
                
                let tab = $(this).closest('form').data('tab');
                        
                if (tab === 'tab2') {
                    loadAssigneeCounts(0, document.getElementById('sortField-' + tab).value, document.getElementById('sortDir-' + tab).value);
                } else {
                	tab = 'tab1';
                    loadTable(tab, 0, document.getElementById('sortField-' + tab).value, document.getElementById('sortDir-' + tab).value);
                }
            }
        });

        loadTable('tab1', 0, document.getElementById('sortField-tab1').value || 'ts_issueid', document.getElementById('sortDir-tab1').value || 'asc');
        loadAssigneeCounts(0, 'ts_submitter', 'asc');

        // Tab switching
        $('.nav-link').on('click', function (event) {
            event.preventDefault();
            $('.nav-link').removeClass('active');
            $(this).addClass('active');

            $('.tab-pane').removeClass('active');
            let tabId = $(this).attr('href');
            $(tabId).addClass('active');
            
        	 // 탭에 따라 전체 검색 필드 가시성 제어
            if (tabId === '#tab2') {
                $('#query-common').hide();
                $('#query-common-button').hide();
            } else {
                $('#query-common').show();
                $('#query-common-button').show();
            }
        });
		
        
        $('#tab1-tab').trigger('click'); // Activate the first tab by default
    });

    function sortTable(tab, field) {
        let sortField = document.getElementById('sortField-' + tab).value;
        let sortDir = document.getElementById('sortDir-' + tab).value;
        let currentPage = parseInt(document.getElementById('currentPage-' + tab).value);
        if (sortField === field) {
            sortDir = (sortDir === 'asc') ? 'desc' : 'asc';
        } else {
            sortField = field;
            sortDir = 'asc';
        }
        if (tab === 'tab2') {
            loadAssigneeCounts(currentPage, sortField, sortDir);
        } else {
            loadTable(tab, currentPage, sortField, sortDir);
        }
    }

    function loadTable(tab, page, sortField, sortDir) {
        let query = $('#query-common').val() || '';
        let issueid = $('#issueid-' + tab).val() || '';
        let system = $('#system-' + tab).val() || '';
        let taskType = $('#taskType-' + tab).val() || '';
        let state = $('#state-' + tab).val() || '';
        let dueDate = $('#dueDate-' + tab).val() || '';
        let submitter = $('#submitter-' + tab).val() || '';
        let startDate = $('#startDate').val() || '';
        let endDate = $('#endDate').val() || '';
        
        if (!document.getElementById('sortField-' + tab) || !document.getElementById('sortDir-' + tab)) {
            console.error(`Element not found for tab: ${tab}`);
            return;
        }
        $.ajax({
            url: '/board/sort',
            type: 'GET',
            data: {
                query: query,
                issueid: issueid,
                system: system,
                taskType: taskType,
                state: state,
                dueDate: dueDate,
                submitter: submitter,
                startDate: startDate,
                endDate: endDate,
                page: page,
                size: '5',
                sortField: sortField || 'ts_issueid',
                sortDir: sortDir || 'asc'
            },
            success: function (data) {
                let tableBody = '';
                data.content.forEach(function (board) {
                    tableBody += '<tr>';
                    tableBody += '<td>' + board[0] + '</td>';
                    tableBody += '<td>' + board[1] + '</td>';
                    tableBody += '<td>' + board[2] + '</td>';
                    tableBody += '<td>' + board[3] + '</td>';
                    tableBody += '<td>' + board[4] + '</td>';
                    tableBody += '<td>' + board[6] + '</td>';
                    tableBody += '</tr>';
                });
                $('#boardTable-' + tab + ' tbody').html(tableBody);
                document.getElementById('sortField-' + tab).value = sortField;
                document.getElementById('sortDir-' + tab).value = sortDir;
                document.getElementById('currentPage-' + tab).value = page;
                updatePagination(tab, data.totalPages, page);
                updateTotalCount(tab, data.totalElements);
            }
        });
    }

    function loadAssigneeCounts(page, sortField, sortDir) {
        let submitter = $('#submitter-tab2').val() || '';
        let count = $('#count-tab2').val() || '';
        let startDate = $('#startDate').val() || '';
        let endDate = $('#endDate').val() || '';
        $.ajax({
            url: '/board/assigneeCounts',
            type: 'GET',
            data: {
                page: page,
                size: '5',
                sortField: sortField || 'ts_submitter',
                sortDir: sortDir || 'asc',
                submitter: submitter,
                count: count,
                startDate: startDate,
                endDate: endDate
            },
            success: function (data) {
                let tableBody = '';
                data.content.forEach(function (row) {
                    tableBody += '<tr>';
                    tableBody += '<td>' + row[1] + '</td>';
                    tableBody += '<td>' + row[2] + '</td>';
                    tableBody += '</tr>';
                });
                $('#assigneeCountsTable tbody').html(tableBody);
                document.getElementById('sortField-tab2').value = sortField;
                document.getElementById('sortDir-tab2').value = sortDir;
                document.getElementById('currentPage-tab2').value = page;
                updatePagination('tab2', data.totalPages, page);
                updateTotalCount('tab2', data.totalElements);
            }
        });
    }

    function updatePagination(tab, totalPages, currentPage) {
        let paginationHtml = '';
        for (let i = 0; i < totalPages; i++) {
            if (i === currentPage) {
                paginationHtml += '<a class="active">' + (i + 1) + '</a>';
            } else {
                if (tab === 'tab2') {
                    paginationHtml += '<a onclick="loadAssigneeCounts(' + i + ', \'' + document.getElementById('sortField-' + tab).value + '\', \'' + document.getElementById('sortDir-' + tab).value + '\')">' + (i + 1) + '</a>';
                } else {
                    paginationHtml += '<a onclick="loadTable(\'' + tab + '\', ' + i + ', \'' + document.getElementById('sortField-' + tab).value + '\', \'' + document.getElementById('sortDir-' + tab).value + '\')">' + (i + 1) + '</a>';
                }
            }
        }
        $('#pagination-' + tab).html(paginationHtml);
    }

    function updateTotalCount(tab, totalCount) {
        $('#total-count-' + tab).text('Total Count: ' + totalCount);
    }

    function applyDateSearch() {
        loadTable('tab1', 0, document.getElementById('sortField-tab1').value, document.getElementById('sortDir-tab1').value);
        loadAssigneeCounts(0, document.getElementById('sortField-tab2').value, document.getElementById('sortDir-tab2').value);
    }

    function applyFullSearch() {
        loadTable('tab1', 0, document.getElementById('sortField-tab1').value, document.getElementById('sortDir-tab1').value);
    }
</script>
</head>
<body>
	<h1 style="text-align: center; color: #00796B;">Board</h1>
	<div class="container mt-3 common-search">
		<form id="commonSearchForm" class="searchForm">
			<select id="dateRangeSelect" class="form-control">
				<option value="">기간 선택</option>
				<option value="오늘">오늘</option>
				<option value="어제~내일">어제~내일</option>
				<option value="이번주">이번주</option>
				<option value="지난한주">지난한주</option>
				<option value="지난주">지난주</option>
				<option value="이번달">이번달</option>
				<option value="이전한달">이전한달</option>
				<option value="이번분기">이번분기</option>
				<option value="지난분기">지난분기</option>
				<option value="상반기">상반기</option>
				<option value="하반기">하반기</option>
				<option value="올해">올해</option>
				<option value="작년">작년</option>
				<option value="이전3년">이전3년</option>
				<option value="최근3개월">최근3개월</option>
				<option value="최근1년">최근1년</option>
				<option value="최근3년">최근3년</option>
				<option value="최근5년">최근5년</option>
			</select>
			<input type="date" id="startDate" name="startDate">
			<span>~</span>
			<input type="date" id="endDate" name="endDate">
			<button type="button" onclick="applyDateSearch()">조회</button>
			<input type="text" id="query-common" name="query" placeholder="전체 검색">
			<button type="button" id="query-common-button" onclick="applyFullSearch()">전체검색</button>
		</form>
	</div>
	<ul class="nav nav-tabs" id="boardTabs" role="tablist">
		<li class="nav-item"><a class="nav-link active" data-toggle="tab" id="tab1-tab" href="#tab1" role="tab" aria-controls="tab1" aria-selected="true">Tab 1</a></li>
		<li class="nav-item"><a class="nav-link" id="tab2-tab" data-toggle="tab" href="#tab2" role="tab" aria-controls="tab2" aria-selected="false">Tab 2</a></li>
	</ul>
	<div class="tab-content" id="boardTabContent">
		<div class="tab-pane active" id="tab1" role="tabpanel" aria-labelledby="tab1-tab">
			<div class="container mt-3">
				<form id="searchForm-tab1" class="searchForm search-form" data-tab="tab1" action="/board/search" method="get">
					<input type="hidden" name="size" value="5">
					<input type="hidden" id="sortField-tab1" name="sortField" value="ts_issueid">
					<input type="hidden" id="sortDir-tab1" name="sortDir" value="asc">
					<input type="hidden" id="currentPage-tab1" name="currentPage" value="0">
				</form>
				<table id="boardTable-tab1" class="table table-bordered mt-3">
					<thead>
						<tr>
							<th onclick="sortTable('tab1', 'ts_issueid')">업무번호</th>
							<th onclick="sortTable('tab1', 'ts_system')">시스템</th>
							<th onclick="sortTable('tab1', 'ts_task_type')">업무구분</th>
							<th onclick="sortTable('tab1', 'ts_state')">단계명</th>
							<th onclick="sortTable('tab1', 'ts_due_date')">완료요구일자</th>
							<th onclick="sortTable('tab1', 'ts_submitter')">접수자</th>
						</tr>
						<tr>
							<td><input type="text" id="issueid-tab1" name="issueid" placeholder="업무번호 검색" onkeypress="if(event.keyCode==13) loadTable('tab1', 0, document.getElementById('sortField-tab1').value, document.getElementById('sortDir-tab1').value)"></td>
							<td><input type="text" id="system-tab1" name="system" placeholder="시스템 검색" onkeypress="if(event.keyCode==13) loadTable('tab1', 0, document.getElementById('sortField-tab1').value, document.getElementById('sortDir-tab1').value)"></td>
							<td><input type="text" id="taskType-tab1" name="taskType" placeholder="업무구분 검색" onkeypress="if(event.keyCode==13) loadTable('tab1', 0, document.getElementById('sortField-tab1').value, document.getElementById('sortDir-tab1').value)"></td>
							<td><input type="text" id="state-tab1" name="state" placeholder="단계명 검색" onkeypress="if(event.keyCode==13) loadTable('tab1', 0, document.getElementById('sortField-tab1').value, document.getElementById('sortDir-tab1').value)"></td>
							<td><input type="text" id="dueDate-tab1" name="dueDate" placeholder="완료요구일자 검색" onkeypress="if(event.keyCode==13) loadTable('tab1', 0, document.getElementById('sortField-tab1').value, document.getElementById('sortDir-tab1').value)"></td>
							<td><input type="text" id="submitter-tab1" name="submitter" placeholder="접수자 검색" onkeypress="if(event.keyCode==13) loadTable('tab1', 0, document.getElementById('sortField-tab1').value, document.getElementById('sortDir-tab1').value)"></td>
						</tr>
					</thead>
					<tbody></tbody>
				</table>
				<div class="pagination" id="pagination-tab1"></div>
				<div class="total-count" id="total-count-tab1"></div>
			</div>
		</div>
		<div class="tab-pane" id="tab2" role="tabpanel" aria-labelledby="tab2-tab">
			<div class="container mt-3">
				<form id="searchForm-tab2" class="searchForm search-form" data-tab="tab2" action="/board/assigneeCounts" method="get">
					<input type="hidden" name="size" value="5">
					<input type="hidden" id="sortField-tab2" name="sortField" value="ts_submitter">
					<input type="hidden" id="sortDir-tab2" name="sortDir" value="asc">
					<input type="hidden" id="currentPage-tab2" name="currentPage" value="0">
				</form>
				<table id="assigneeCountsTable" class="table table-bordered mt-3">
					<thead>
						<tr>
							<th onclick="sortTable('tab2', 'ts_submitter')">접수자</th>
							<th onclick="sortTable('tab2', 'count')">할당건수</th>
						</tr>
						<tr>
							<td><input type="text" id="submitter-tab2" name="submitter" placeholder="접수자 검색" onkeypress="if(event.keyCode==13) loadAssigneeCounts(0, document.getElementById('sortField-tab2').value, document.getElementById('sortDir-tab2').value)"></td>
							<td><input type="text" id="count-tab2" name="count" placeholder="할당건수 검색" onkeypress="if(event.keyCode==13) loadAssigneeCounts(0, document.getElementById('sortField-tab2').value, document.getElementById('sortDir-tab2').value)"></td>
						</tr>
					</thead>
					<tbody></tbody>
				</table>
				<div class="pagination" id="pagination-tab2"></div>
				<div class="total-count" id="total-count-tab2"></div>
			</div>
		</div>
	</div>
</body>
</html>
