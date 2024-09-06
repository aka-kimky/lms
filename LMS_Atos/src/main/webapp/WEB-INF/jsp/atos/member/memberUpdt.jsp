<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<link type="text/css" rel="stylesheet" href="<c:url value='/css/atos/member/memberUpdt.css' />">
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<div class="content">
    <h1>회원 수정</h1>
    <form id="updateMember">
        <table class="info-table">
            <tr>
                <th>아이디</th>
                <td><input type="text" name="id" value="${member.id }" class="input-field" readonly /></td>
                <th>생년월일</th>
                <td><input type="date" name="birthdate" value="${member.birthdate }" class="input-field"  /></td>
            </tr>
            <tr>
                <th>이름</th>
                <td><input type="text" name="name" value="${member.name }" class="input-field" /></td>
                <th>주소</th>
                <td>
                    <div style="display: flex; align-items: center;">
                        <input type="text" id="zipcode" name="zipcode" value="${member.zipcode }" class="left-input-address" placeholder="우편번호" readonly />
                        <button type="button" class="btn btn-primary" id="addressSearchButton" style="margin-bottom:10px;">주소 검색</button>
                    </div>
                    <input type="text" id="address" name="addr1" class="left-input-address" value="${member.addr1 }" placeholder="주소를 검색해주세요" readonly />
                    <br /> 
                    <input type="text" id="detailedAddress" name="addr2" class="left-input-address detail-addr" value="${member.addr2 }" placeholder="상세주소를 입력하세요" />
                </td>
            </tr>
            <tr>
                <th>전화번호</th>
                <td><input type="text" name="phoneNo" value="${member.phoneNo }" class="input-field" /></td>
                <th>이메일</th>
                <td><input type="email" name="email" value="${member.email }" class="input-field"  /></td>
            </tr>
            <tr>
                <th>소속부서</th>
                <td><input type="text" name="department" value="${member.department }" class="input-field" /></td>
                <th>직책</th>
                <td><input type="email" name="position" value="${member.position }" class="input-field"  /></td>
            </tr>
            <tr>
                <th>소속기업</th>
                <td colspan="3">
                    <select id="group" name="bizRegNo" class="right-input" required>
                        <option value="">선택</option>
                        <c:forEach var="company" items="${company }">
                            <option value="${company.corpBiz }" <c:if test="${company.corpBiz == member.bizRegNo}">selected</c:if>>
                                ${company.corpName }
                            </option>
                        </c:forEach>
                    </select>
                </td>
            </tr>
        </table>

        <h1>회사정보</h1>
        <table class="info-table">
            <tr>
                <th>사업자등록번호</th>
                <td><input type="text" id="businessRegistrationNumber" name="businessRegistrationNumber" value="${member.companybizRegNo }" class="input-field" readonly /></td>
                <th>대표전화번호</th>
                <td><input type="text" id="phoneNo" name="companyPhoneNo" value="${member.companyPhoneNo }" class="input-field" readonly /></td>
            </tr>
            <tr>
                <th>사업장명</th>
                <td><input type="text" id="businessName" name="businessName" value="${member.corpName }" class="input-field" readonly /></td>
                <th>대표자명</th>
                <td><input type="text" id="representativeName" name="representativeName" value="${member.repName }" class="input-field" readonly /></td>
            </tr>
            <tr>
                <th>업태</th>
                <td><input type="text" id="industryType" name="industryType" value="${member.bizType }" class="input-field" readonly /></td>
                <th>종목</th>
                <td><input type="text" id="businessCategory" name="businessCategory" value="${member.bizItem }" class="input-field" readonly /></td>
            </tr>
            <tr>
            	<th>사업장주소</th>
            	<td colspan="4"><input type="text" id="businessAddress" name="businessAddress" value="${member.companyAddr1 } ${member.companyAddr2}" class="input-field"  readonly /></td>
            </tr>
        </table>

        <div class="button-container">
            <button type="submit" class="btn btn-primary" id="submitBtn">저장</button>
            <button type="button" class="cancel-btn btn btn-danger" onclick="history.back();">취소</button>
        </div>
    </form>
</div>

<script>
$(document).ready(function() {
	$('#addressSearchButton').on('click', function() {
	    new daum.Postcode({
	        oncomplete: function(data) {
	            $('#zipcode').val(data.zonecode); // 우편번호
	            $('#address').val(data.address); // 기본 주소
	            $('#detailedAddress').focus();
	        }
	    }).open();
	});
	$('#group').change(function() {
	    var selectedCorpBiz = $(this).val();
	
	    if (selectedCorpBiz) {
	    	
	        myFetch({
	            url: '/member/companyDetail', 
	            data: { corpBiz: selectedCorpBiz }, 
	            success: function(response) {
	            	const resultData = response.result[0];
	            	
	                $('#businessRegistrationNumber').val(resultData.bizRegNo);
	                $('#businessName').val(resultData.corpName);
	                $('#representativeName').val(resultData.repName);
	                $('#phoneNo').val(resultData.phoneNo);
	                $('#industryType').val(resultData.bizType);
	                $('#businessCategory').val(resultData.bizItem);
	                $('#businessAddress').val(resultData.addr1 + " " + resultData.addr2);
	            },
	            error: function(error) {
	                console.error('AJAX 오류:', error);
	            }
	        });
	    } else {
	        $('#businessRegistrationNumber, #phoneNo, #businessName, #representativeName, #industryType, #businessCategory, #businessAddress').val('');
	    }
	});
	
    $('#submitBtn').click(function() {
    	const memId = '<c:out value="${member.id }" />';
    	
        myFetch({
            url: '/member/memberUpdate', 
            data: 'updateMember',
            success: function(response) {
                alert(response.message);
                window.location.href = "<c:url value='/member/memberDetail.do'/>?id=" + memId;
            },
            error: function(error) {
                console.error('수정 중 오류 발생:', error);
                alert('수정에 실패하였습니다.');
            }
        });
    });
	
});
</script>