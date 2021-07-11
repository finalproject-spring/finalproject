<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">

$(function(){
	$("#muldel").click(function(){
		if ($("input[type=checkbox]:checked").length == 0) {
			alert("삭제할 쪽지를 선택해주세요!");
			return false;
		} else {
			$("form").submit();
		}
	});
});

</script>
<style type="text/css">

	textarea { resize: none; }
	
	li { list-style: none; float: left; padding: 6px; }
	
</style>
</head>
<body>
 <jsp:include page="../main/header.jsp"></jsp:include>
 <div class="container">
	<div>
		<a href='message_recvList.do'>받은 쪽지함</a></div>
		<div>보낸 쪽지함</div>
	<div>

	<div><input type="button" id="muldel" value="삭제"/></div>
	<form action="message_multi_senddel.do" method="get" id="multiDelete">
	<table class="table table-hover" style="table-layout:fixed">
		<col width="50"/>
		<col width="100"/>
		<col width="450"/>
		<col width="150"/>	
		<tr>
			<td>
				<input type="checkbox" id="allCheck"/>
			</td>
			<td>받는사람</td>
			<td>내용</td>
			<td>보낸 시간</td>
		</tr>
		<script type="text/javascript">
	 	$("input:checkbox[id='allCheck']").click(function(){
			if($("input:checkbox[id='allCheck']").is(":checked") == true) {
				$("input[type=checkbox]").prop("checked", true);
	 		} else {
	 			$("input[type=checkbox]").prop("checked",false);
	 		}
	 	});
		</script>
		<c:choose>
			<c:when test="${empty list }">
				<tr>
					<td colspan="4" align="center">보낸 쪽지가 없습니다.</td>
				</tr>
			</c:when>
		<c:otherwise>
		<c:forEach items="${list }" var="dto">
		<tr>
			<td>
				<input type="checkbox" id="chk" name="message_noList" value="${dto.message_no }"/>
			</td>
			<td>${dto.message_recvid }</td>
			<td style="overflow:hidden;white-space:nowrap;text-overflow:ellipsis; max-width:450px;"><a href="message_sendDetail.do?message_no=${dto.message_no }">${dto.message_content }</a></td>
			<td>
				<fmt:formatDate value="${dto.message_senddate}" pattern="yy-MM-dd hh:mm" var="date"/>
			${date }
			</td>
		</tr>
		</c:forEach>
		</c:otherwise>
		</c:choose>
	</table>
	</form>
		<div>
		  <ul>
		    <c:if test="${pageMaker.prev}">
		    	<li><a href="message_sendList.do${pageMaker.makeQuery(pageMaker.startPage - 1)}">이전</a></li>
		    </c:if> 
		
		    <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
		    	<li><a href="message_sendList.do${pageMaker.makeQuery(idx)}">${idx}</a></li>
		    </c:forEach>
		
		    <c:if test="${pageMaker.next && pageMaker.endPage > 0}">
		    	<li><a href="message_sendList.do${pageMaker.makeQuery(pageMaker.endPage + 1)}">다음</a></li>
		    </c:if> 
		  </ul>
		</div>
	</div>
</div>	
</body>
</html>