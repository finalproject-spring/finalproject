<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">

	#submitBtn{ background:#1AAB8A;
	  text-align:center;
	  color:#fff;
	  border:none;
	  position:relative;
	  font-size:15px;
	  width: 90px;
	  height: 35px;
	  cursor:pointer;
	  transition:800ms ease all;
	  outline:none;
	  border-radius: 10px; }
	  
	  #submitBtn:hover { background:#fff; color:#1AAB8A;}

</style>
</head>
<body>
 <jsp:include page="../main/header.jsp"></jsp:include>		
	<div class="container">
		<header>
			<h1>결제 취소 요청</h1>
		</header>
		<br/>
		<form action="admin_paycancel.do" method="post">
			<table class="table">
				<tr>
					<th> </th>
					<th>결제번호</th>
					<th>회원ID</th>
					<th>결제상품</th>
					<th>금액</th>
					<th>일자</th>
				</tr>
				<c:choose>
					<c:when test="${empty list}">
						<tr>
							<td colspan="4" align="center">결제 취소 신청이 존재하지 않습니다.</td>
						</tr>
					</c:when>
					<c:otherwise>
						<c:forEach items="${list }" var="dto">
						<tr>
							<td>
								<input type="checkbox" id="chk" name="pay_num" value="${dto.pay_num }"/>
							</td>
							<td>${dto.pay_num }</td>
							<td>${dto.pay_buyer }</td>
							<td><a href="funding_detail.do?funding_no=${dto.funding_no }">${dto.pay_product }</a></td>
							<td>
								<fmt:parseNumber var="total1" integerOnly="true" value="${dto.pay_count * dto.pay_price }"/>
								<fmt:formatNumber var="total2" value="${total1 }" pattern="#,###,###,###"/>
								${total2 }
							</td>
							<fmt:formatDate  var="date" value="${dto.pay_date}" type="DATE" pattern="yyyy-MM-dd kk:mm"/>
							<td>${date }</td>
						</tr>
						</c:forEach>	
					</c:otherwise>
				</c:choose>
			</table>
			<input type="submit" id="submitBtn" value="결제취소"/>
		</form>
	</div>	
</body>
</html>