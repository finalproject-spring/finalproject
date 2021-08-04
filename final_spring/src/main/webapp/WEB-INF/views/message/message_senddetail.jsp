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
		$("#deleteBtn").click(function(){
				$("#deleteForm").submit();
		});
	});

</script>
<style type="text/css">

	textarea.form-control { height: 100%; } 
	#deleteBtn {background-color: gray; text-align:center; color:#fff; border:none; position:relative; font-size:15px; width: 70px; height: 37px;
	  cursor:pointer; transition:800ms ease all; outline:none; border-radius: 10px; }
	#deleteBtn:hover { background-color:#fff; color:gray;} 
	#message_menu {padding-bottom: 30px;}
	#message_menu span { display:inline-block; width: 50%; height: 50px; line-height: 50px; text-align: center; border: 1px solid rgba(0,0,0,.1); cursor: pointer; }
	#msg_header {font-size: 22px; color: #505050}

</style>
</head>
<body>
 <jsp:include page="../main/header.jsp"></jsp:include>
 <br/>
 <div class="container">
	<div id="message_menu">
		<span onclick="location.href='message_recvList.do'" style="float: left;">받은 쪽지함</span>
		<span onclick="location.href='message_sendList.do'">보낸 쪽지함</span>
	</div>
	<div id="msg_header"><i class="fas fa-envelope-open-text"></i> 보낸 쪽지</div>
		<div>
		<form id="deleteForm" action="message_senddel.do" method="get">
			<input type="hidden" value="${dto.message_no }" name="message_no"/>	
		</form>
	</div>
	<div align="right"><input type="button" id="deleteBtn" value="삭제" /></div>
	<br/>
	<fmt:formatDate value="${dto.message_senddate}" pattern="yyyy-MM-dd kk:mm" var="date"/>
	<form>
		<div class="form-group">
			<label>받는 사람</label>
			<input type="text" value="${dto.message_recvid }" class="form-control" readonly="readonly">
		</div>
		<div class="form-group">
			<label>보낸시간</label>
			<input type="text" value="${date }" class="form-control" readonly="readonly">
		</div>
		<div class="form-group">
			<label>내용</label>
			<textarea rows="8" readonly="readonly" style="width: 100%; resize: none; border: 1px solid rgba(0, 0, 0, 0.1); font-size: 14px; border-radius: 0px; padding-left: 10px;">${dto.message_content }</textarea>
		</div>
	</form>
	</div>
</body>
</html>