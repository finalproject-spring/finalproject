<%@page import="com.spring.recycle.model.dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- font Awesome -->
 <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"/>

<!-- jquery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<!-- popper js -->
<Script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/2.9.2/umd/popper.min.js"></Script>
<!-- Javascript -->
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<script type="text/javascript">

	$(document).ready(function(){
		
		var action = '';
		var url = '';
		var type = '';
	 	$("#createBtn").click(function(){
			action='create';
			type = 'POST';
	 		$("#myModal").modal();
	 	});

	
	 	$("#modalSubmit").click(function(){
	 		url = 'message_insert.do';
	 		
	 		if ($.trim($("#message_content").val()) == "" || $.trim($("#message_content").val()) == null) {
	 			alert("내용을 입력해주세요.");
	 		} else {
	 				
	 		var data = {
	 				"message_recvid" : $("#message_recvid").val(),
	 				"message_content" : $("#message_content").val()
	 		};
	 		
	 		$.ajax({
	 			url : url,
	 			type : 'POST',
	 			data : data,
	 			success: function(data){ $("#myModal").modal('toggle');
	 				},
	 			complete: function(data){ 
	 				$('.modal-body').empty();
	 				$('.modal-footer').empty();
	 				$('.modal-body').html("<div>쪽지를 보냈습니다.</div>");
	 				window.setTimeout(function(){
	 					window.location.reload()
	 				}, 950); }
	 		});
	 	}  		
	 		
	});

});	
	
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
	<div>받은 쪽지</div>

	<div>
		<form action="message_recvdel.do" method="get">
			<input type="hidden" value="${dto.message_no }" name="message_noList"/>	
		</form>
	</div>
	 <button id="createBtn" class="btn btn-info btn-sm" data-target="#myModal" data-toggle="modal">답장하기</button>
	 <input type="button" id="muldel" value="삭제"/>
	 <!-- Modal -->
	<div class="modal fade" id="myModal" role="dialog">
		<div class="modal-dialog">
			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<h4 id="modal-title" class="modal-title">답장 보내기</h4>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>
				<div class="modal-body">
					<table class="table">
						<tr>
							<td>받는사람</td>
							<td><input class="form-control" id="message_recvid" value="${dto.message_sendid }" type="text" readonly="readonly"></td>
						</tr>
						<tr>
							<td>내용</td>
							<td><textarea class="form-control" id="message_content" rows="10"></textarea></td>
						</tr>					
					</table>
					<%
					MemberDto dto = (MemberDto) request.getSession().getAttribute("dto");
					String member_id = dto.getMember_id();
					%>
					<input type="hidden" value="<%=member_id%>" id="member_id"/>
				</div>
				<div class="modal-footer">
					<button id="modalSubmit" type="button" class="btn btn-success">보내기</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>
	
	<div>보낸 사람 ${dto.message_sendid } </div>
	<div>보낸 시간 			
				<fmt:parseDate value="${dto.message_senddate }" pattern="yyyy/MM/dd" var="date"/>
				<fmt:formatDate value="${date}" pattern="yyyy-MM-dd hh시 MM분" var="time"/>
				${time }
			</div>
	<div>내용 ${dto.message_content }</div>
	
</body>
</html>