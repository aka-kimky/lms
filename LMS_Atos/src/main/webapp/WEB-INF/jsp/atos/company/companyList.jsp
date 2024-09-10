<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<link type="text/css" rel="stylesheet" href="<c:url value='/css/atos/company/company.css' />">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script>

/*
function fn_egov_select_linkPage(pageNo) {
    // 페이지 인덱스 설정
    document.companyForm.pageIndex.value = pageNo;
    // 요청 전송
    document.companyForm.action = "<c:url value='/company/companyList.do' />";
    document.companyForm.submit();
  
}
*/

 

	function fn_egov_select_linkPage(pageNo) {
	    document.companyForm.pageIndex.value = pageNo;
	    document.companyForm.statusCode.value = "${companySearchVO.statusCode}";
	    document.companyForm.searchCnd.value = "${companySearchVO.searchCnd}";
	    document.companyForm.searchWrd.value = "${companySearchVO.searchWrd}";
	    document.companyForm.action = "<c:url value='/company/companyList.do' />";
	    document.companyForm.submit();
	}

</script>
<div class="board company-management">
	<form name="companyForm" action="<c:url value='/company/companyList.do'/>" method="post">
 		<h3>업체 목록</h3>

		<!-- 검색 필터 부분 -->
		<div class="search_box">

			<div>
				<span>상태</span> <select id="status" name="statusCode">
					<option value="">선택</option>
					<c:forEach var="status" items="${status }">
						<option value="${status.statusCode }"
							<c:if test="${status.statusCode == companySearchVO.statusCode}">selected</c:if>>
							${status.statusName }</option>
					</c:forEach>
				</select>
			</div>
			<div>
				<span>검색</span> 
				<select name="searchCnd" title="검색 조건 선택">
					<option value="">선택</option>
					<option value="0" <c:if test="${companySearchVO.searchCnd == '0'}">selected="selected"</c:if>>회사명</option>
					<option value="1" <c:if test="${companySearchVO.searchCnd == '1'}">selected="selected"</c:if>>담당자명</option>
					<option value="2" <c:if test="${companySearchVO.searchCnd == '2'}">selected="selected"</c:if>>사업자등록번호</option>
				</select> <input type="text" id="searchText" name="searchWrd" title="검색 조건 입력" placeholder="텍스트를 입력해 주세요." value='<c:out value="${companySearchVO.searchWrd}"/>' maxlength="155">
				<button type="submit" class="s_btn">검색</button>
			</div>
		</div>
		
		 <input type="hidden" name="pageIndex" value="${companySearchVO.pageIndex}">
		 
	</form>


	<!-- 버튼 그룹 -->
   <div class="btn-group">
	<div class="left-group">
        </div>
	    <div class="right-group">
	        <button class="s_submit" id="statusUpdate">상태변경</button>
	        <button class="s_submit" id="excelDown">EXCEL</button>
	        <button class="s_submit" onclick="location.href='<c:url value='/company/CompanyRegistView.do' />'">등록</button>
	    </div>
    </div>

    <!-- 테이블 -->
    <table class="board_list">
        <thead>
            <tr>
                <th>번호</th>
                <th>등록일</th>
                <th class="board_th_link">회사명</th>
                <th>사업자등록번호</th>
                <th>회원수</th>
                <th>담당자</th>
                <th>상태</th>
                <th><input type="checkbox" id="checkAll"></th>
            </tr>
        </thead>
        <tbody>
        <c:forEach items="${resultList}" var="resultInfo" varStatus="status">
            <tr>
                <td><c:out value="${(companySearchVO.pageIndex-1) * companySearchVO.pageSize + status.count}"/></td>
                <td>${resultInfo.regDate }</td>
				<td><a href="<c:url value='/company/companyDetail.do?bizRegNo=${resultInfo.bizRegNo}'/>">
				${resultInfo.corpName} </a></td>
				<td>${resultInfo.bizRegNo }</td>
                <td>${resultInfo.empCount }</td>
                <td>${resultInfo.trainManager }</td>
                <td>${resultInfo.statusName }</td>
                <td><input type="checkbox" name="rowCheck" value="${resultInfo.bizRegNo }"></td>
            </tr>
        </c:forEach>
        <c:if test="${fn:length(resultList) == 0}">
        <tr>
            <td colspan="7">조회된 결과가 존재하지 않습니다.</td>
        </tr>
        </c:if>
        </tbody>
    </table>

	
	
    <!-- 페이지네이션 -->
    <div class="pagination justify-content-center">
        <ul>
            <ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_egov_select_linkPage"/>
        </ul>
    </div>
</div>

<div id="statusModal" class="modal fade" tabindex="-1" aria-labelledby="statusModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="statusModalLabel">상태 변경</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body" id="modalContent">
        <div class="form-check">
            <input class="form-check-input" type="radio" name="statusRadio" id="status1" value="1002" checked>
            <label class="form-check-label" for="status1">정상</label>
        </div>
        <div class="form-check">
            <input class="form-check-input" type="radio" name="statusRadio" id="status2" value="1001">
            <label class="form-check-label" for="status2">대기</label>
        </div>
        <div class="form-check">
            <input class="form-check-input" type="radio" name="statusRadio" id="status3" value="1004">
            <label class="form-check-label" for="status3">정지</label>
        </div>
        <div class="form-check">
            <input class="form-check-input" type="radio" name="statusRadio" id="status4" value="1003">
            <label class="form-check-label" for="status4">휴면</label>
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
        <button type="button" class="btn btn-primary" id="confirmChangeBtn">확인</button>
      </div>
    </div>
  </div>
</div>

<script>
$(document).ready(function() {
    // 전체 선택/해제 기능
    $('#checkAll').on('click', function() {
        $('tbody input[name="rowCheck"]').prop('checked', this.checked);
    });

    // 상태변경 버튼 클릭 시
    $('#statusUpdate').on('click', function() {
        var selectedBizNo = [];

        $('tbody input[name="rowCheck"]:checked').each(function() {
            var tr = $(this).closest('tr');
            var bizNo = tr.find('td:nth-child(4)').text(); // 사업자등록번호 (4번째 컬럼)
            selectedBizNo.push(bizNo);
        });

        if (selectedBizNo.length > 0) {
        	$('#statusModal').modal('show');
        } else {
            alert("선택된 항목이 없습니다.");
        }
    });

    // 확인 버튼 클릭 시 상태 변경 처리
    $('#confirmChangeBtn').on('click', function() {
        var selectedStatus = $('input[name="statusRadio"]:checked').val();
        var selectedBizNo = [];

        $('tbody input[name="rowCheck"]:checked').each(function() {
            var bizNo = $(this).closest('tr').find('td:nth-child(4)').text(); // 사업자등록번호
            selectedBizNo.push(bizNo);
        });

        if (selectedBizNo.length > 0) {
            // AJAX 요청으로 서버에 상태 변경 요청
            $.ajax({
                url: '/company/updateStatus', // 서버에서 상태를 업데이트하는 엔드포인트
                method: 'POST',
                contentType: 'application/json',
                data: JSON.stringify({
                    bizRegNo: selectedBizNo.join(','), // 선택된 사업자등록번호들을 전송
                    status: selectedStatus // 선택된 상태 값
                }),
                success: function(response) {
                    if (response.httpStatus === 'OK') {
                        alert('상태 변경이 완료되었습니다.');
                        location.reload(); // 페이지 새로고침하여 변경 사항 반영
                    } else {
                        alert('상태 변경에 실패했습니다.');
                    }
                },
                error: function() {
                    alert('서버와의 통신에 실패했습니다.');
                }
            });

            // 모달 닫기
            $('#statusModal').modal('hide');
        } else {
            alert("선택된 항목이 없습니다.");
        }
    });
});


$(document).ready(function() {
    $('#excelDown').on('click', function() {
        const companyForm = $('form[name="companyForm"]');
        const originalAction = companyForm.attr('action');

        companyForm.attr('action', '/company/companyListExcelDown');
        companyForm.submit();

        companyForm.attr('action', originalAction);
    });
});


</script>
