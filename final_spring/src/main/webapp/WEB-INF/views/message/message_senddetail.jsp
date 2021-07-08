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
				$("form").submit();
		});
	});

</script>
</head>
<body>

	<div>
		<a href='message_recvList.do'>받은 쪽지함</a>
		<a href='message_sendList.do'>보낸 쪽지함</a>
	</div>
	<div>보낸 쪽지</div>
		<div>
		<form action="message_senddel.do" method="get">
			<input type="hidden" value="${dto.message_no }" name="message_noList"/>	
		</form>
	</div>
	<input type="button" id="muldel" value="삭제"/>
	

	
	<div>받는 사람 ${dto.message_recvid }</div>
	<div>보낸 시간 			
				<fmt:parseDate value="${dto.message_senddate }" pattern="yyyy/MM/dd" var="date"/>
				<fmt:formatDate value="${date}" pattern="yyyy-MM-dd hh시 MM분" var="time"/>
				${time }
	</div>

	<div>내용${dto.message_content }</div>

</body>
</html>