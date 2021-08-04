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

	#paging li {list-style: none; float: left; padding: 6px;}
	#paging ul li a {color: #626262; font-size: 15px;}
	.search {margin: 20px 0px 0px 0px;}
	select {height: 30px; border: 1px solid #C8C7C6}
	#keywordInput {border: 1px solid #C8C7C6; height: 30px; border-radius: 0px;}
	#searchBtn {background-color: #71c55d; border: 1px solid #71c55d; width: 60px; height: 33px; color: white; border-radius: 15px; font-size: 15px;}
	#admin_mainBtn{background-color: #8ece7f; color:white; border: 1px solid #71c55d; width: 100px; height: 37px; border-radius: 10px; }
</style>
</head>
<body>
<jsp:include page="../main/header.jsp"></jsp:include>	
	<div class="container">
		<br/>
		<header>
			<h1>결제 내역</h1>
		</header>
		<br/>
		<div><a href="admin_payCancelList.do">결제 취소 요청 [${cancelCount }]건</a></div>
		<form method="get">
			<table class="table">
				<tr>
					<th>결제번호</th>
					<th>회원ID</th>
					<th>결제상품</th>
					<th>금액</th>
					<th>결제상태</th>
					<th>일자</th>
				</tr>
				<c:choose>
					<c:when test="${empty list}">
						<tr>
							<td colspan="4" align="center">결제 내역이 존재하지 않습니다.</td>
						</tr>
					</c:when>
					<c:otherwise>
						<c:forEach items="${list }" var="dto">
						<tr>
							<td>${dto.pay_num }</td>
							<td>${dto.pay_buyer }</td>
							<td><a href="funding_detail.do?funding_no=${dto.funding_no }">${dto.pay_product }</a></td>
							<td>
								<fmt:parseNumber var="total1" integerOnly="true" value="${dto.pay_count * dto.pay_price }"/>
								<fmt:formatNumber var="total2" value="${total1 }" pattern="#,###,###,###"/>
								${total2 }
							</td>
							<td>${dto.pay_status }</td>
							<fmt:formatDate  var="date" value="${dto.pay_date}" type="DATE" pattern="yyyy-MM-dd kk:mm"/>
							<td>${date }</td>
						</tr>
						</c:forEach>	
					</c:otherwise>
				</c:choose>
			</table>
			<div class="search">
			    <select name="searchType">
			      <option value="n"<c:out value="${scri.searchType == null ? 'selected' : ''}"/>>-----</option>
			      <option value="id"<c:out value="${scri.searchType eq 'id' ? 'selected' : ''}"/>>회원ID</option>
			      <option value="pd"<c:out value="${scri.searchType eq 'pd' ? 'selected' : ''}"/>>결제상품</option>
			      <option value="st"<c:out value="${scri.searchType eq 'st' ? 'selected' : ''}"/>>결제상태</option>
			   </select>
			
			    <input type="text" name="keyword" id="keywordInput" value="${scri.keyword}"/>
			
			    <button id="searchBtn" type="button">검색</button>
			    <script>
			      $(function(){
			        $('#searchBtn').click(function() {
			          self.location = "admin_payList.do" + '${pageMaker.makeQuery(1)}' + "&searchType=" + $("select option:selected").val() + "&keyword=" + encodeURIComponent($('#keywordInput').val());
			        });
			      });   
			    </script>
			  </div>
			<div id="paging">
		 	 <ul>
			    <c:if test="${pageMaker.prev}">
			    	<li><a href="admin_payList.do${pageMaker.makeSearch(pageMaker.startPage - 1)}">이전</a></li>
			    </c:if> 
			
			    <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
			    	<li><a href="admin_payList.do${pageMaker.makeSearch(idx)}">${idx}</a></li>
			    </c:forEach>
			
			    <c:if test="${pageMaker.next && pageMaker.endPage > 0}">
			    	<li><a href="admin_payList.do${pageMaker.makeSearch(pageMaker.endPage + 1)}">다음</a></li>
			    </c:if> 
			  </ul>
			</div>
		</form>
		<div align="right"><input type="button" value="관리자 메인" id="admin_mainBtn" onclick="location.href='admin_main.do'"/></div>
	</div>	
</body>
</html>