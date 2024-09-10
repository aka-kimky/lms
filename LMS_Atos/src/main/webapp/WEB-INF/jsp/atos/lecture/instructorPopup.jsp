<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!DOCTYPE html>
<html lang="ko">
<head>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
	<link type="text/css" rel="stylesheet" href="<c:url value='/css/atos/lecture/lecture.css' />">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <meta charset="UTF-8">
    <title>강사 선택</title>
</head>
<body>
    <div class="popup-wrapper">
        <h4>강사 선택</h4>
    <form method="get" action="" class="form-inline mb-3">
		<table class="search-table">
<!--             <tr>
                <th>분류</th>
                <td colspan="2">
                    <select name="course" class="form-select search-select me-2">
                        <option value="all">대분류</option>
                    </select>
                    <select name="course" class="form-select search-select me-2">
                        <option value="all">중분류</option>
                    </select>
                </td>
            </tr> -->
            <tr>
                <th>검색</th>
                <td colspan="5">
                    <div class="d-flex">
		               <select name="searchCnd" title="검색 조건 선택" class="form-select search-select me-2">
		                	<option value="">선택</option>
		                    <option value="0" <c:if test="${searchVO.searchCnd == '0'}">selected="selected"</c:if>>아이디</option>
		                    <option value="1" <c:if test="${searchVO.searchCnd == '1'}">selected="selected"</c:if>>이름</option>
		                </select>
                        <input type="text" name="searchKeyword" class="form-control search-input me-2" placeholder="검색어를 입력하세요" />
                        <button type="submit" class="btn-search">검색</button>
                    </div>
                </td>
            </tr>
        </table>
    </form>
        
        <table class="table table-bordered course-table">
	        <colgroup>
		        <col style="width: 5%;">
		        <col style="width: 20%;">
		        <col style="width: 10%;">
		        <col style="width: 15%;">
		        <col style="width: 10%;">
		        <col style="width: 10%;">
		        <col style="width: 10%;">
	    	</colgroup>
            <thead>
                <tr>
                    <th>No</th>
                    <th>아이디</th>
                    <th>이름</th>
                    <th>전화번호</th>
                    <th>소속기관</th>
                    <th>소속</th>
                    <th>직책</th>
                </tr>
            </thead>
            <tbody>
                <!-- 예시 데이터, 실제 데이터는 서버에서 받아와야 함 -->
<%--                 <c:forEach var="course" items="${courseList}">
                    <tr>
                        <td>${course.id}</td>
                        <td><span class="badge badge-${course.online ? 'success' : 'danger'}">${course.online ? '온라인' : '오프라인'}</span></td>
                        <td><span class="badge badge-${course.category == '내일배움카드' ? 'primary' : 'warning'}">${course.category}</span></td>
                        <td>${course.courseName}</td>
                        <td>
                            <button type="button" class="btn btn-sm btn-success btn-select" onclick="selectCourse('${course.courseName}', '${course.id}')">선택</button>
                        </td>
                    </tr>
                </c:forEach> --%>
            </tbody>
        </table>

        <!-- 페이지네이션 예시 -->
        <nav aria-label="Page navigation example">
            <ul class="pagination">
                <li class="page-item"><a class="page-link" href="?page=1">&laquo;</a></li>
                <li class="page-item"><a class="page-link" href="?page=1">1</a></li>
                <li class="page-item"><a class="page-link" href="?page=2">2</a></li>
                <li class="page-item"><a class="page-link" href="?page=3">&raquo;</a></li>
            </ul>
        </nav>
    </div>

    <script>
    // 부모 창으로 데이터 전달
    function selectCourse(courseName, courseId) {
        // 부모 창에 값 설정
        window.opener.document.getElementById('selectedEduInfo').innerText = courseName;
        window.opener.document.getElementById('selectedEduInfo').value = courseId; // Hidden input에 id 전달 가능

        // 팝업창 닫기
        window.close();
    }
    </script>
</body>
</html>