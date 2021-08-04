<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
let a = ${res}
if(a == 0){
	alert("취소 신청 실패")
} else if(a == 1){
	alert("취소 신청 성공")
}

 function deletePay(pay_num){
	 if(confirm("결제 취소 신청 하시겠습니까?")){
		 location.href="paymentDelete.do?pay_num=" + pay_num;
	 }
 }
</script>
</head>
<body>
<jsp:include page="../main/header.jsp"></jsp:include>

<div class="container">
	<header>
		<h1>구매내역</h1>
	</header>
	<hr/>
	
	<table class="table" style="table-layout:fixed; font-size: 15px;">
		<col width="150px"/>
		<col width="110px"/>
		<col width="110px"/>
		<col width="80px"/>
		<col width="140px"/>
		<col width="150px"/>
		<tr>
			<th>구매상품</th>
			<th>카테고리</th>
			<th>가격</th>
			<th>수량</th>
			<th>결제</th>
			<th>결제일자</th>
		</tr>
		<c:choose>
			<c:when test="${empty paylist }">
				<tr>
					<td>구매내역이 없습니다</td>
				</tr>
			</c:when>
			<c:otherwise>
				<c:forEach items="${paylist }" var="dto">
					<fmt:formatDate var="formatCreateDate" value="${dto.pay_date }" pattern="yyyy.MM.dd HH:MM:SS"/>
					<tr>
						<td>${dto.pay_product }</td>
						<td>${dto.pay_category }</td>
						<td>${dto.pay_price }</td>
						<td>${dto.pay_count }</td>
						<td>
						  <c:choose>
							<c:when test="${dto.pay_status == '결제완료' }">
								<input type="button" value="결제 취소 하기" onclick="deletePay(${dto.pay_num})">
							</c:when>
							<c:when test="${dto.pay_status == '결제취소' }">
								<input type="button" value="결제 취소됨" disabled="disabled">
							</c:when>
							<c:otherwise>
								<input type="button" value="결제 취소 진행중" disabled="disabled">
							</c:otherwise>
						</c:choose>
						</td>
						<td>${formatCreateDate }</td>
					</tr>
				</c:forEach>
			</c:otherwise>
		</c:choose>
		<tr>
		</tr>
	</table>
</div>
</body>
</html>