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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
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
		$("#delete").click(function(){
				$("#deleteForm").submit();
		});
	});

</script>
<style type="text/css">
	.modal {
	        text-align: center;
	}
	 
	@media screen and (min-width: 768px) { 
	        .modal:before {
	                display: inline-block;
	                vertical-align: middle;
	                content: " ";
	                height: 100%;
	        }
	}
	 
	.modal-dialog {
	        display: inline-block;
	        text-align: left;
	        vertical-align: middle; 
	}
</style>
</head>
<body>
 <jsp:include page="../main/header.jsp"></jsp:include>
 <div class="container">
	<div>
		<a href='message_recvList.do'>받은 쪽지함</a>
		<a href='message_sendList.do'>보낸 쪽지함</a>
	</div>
	<div>받은 쪽지</div>

	<div>
		<form id="deleteForm" action="message_recvdel.do" method="get">
			<input type="hidden" value="${dto.message_no }" name="message_no"/>	
		</form>
	</div>
	 <button id="createBtn" class="btn btn-info btn-sm" data-target="#myModal" data-toggle="modal">답장하기</button>
	 <input type="button" id="delete" value="삭제"/>
	 <!-- Modal -->
	<div class="modal fade" id="myModal" role="dialog">
		<div class="modal-dialog">
			<!-- Modal content-->
			<div class="modal-content" style="width:500px;">
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
							<td><textarea class="form-control-lg" id="message_content" rows="30" style="resize: none; overflow: auto; height: 220px; width: 100%; border: 1px solid rgba(0, 0, 0, 0.1); font-size: 14px"></textarea></td>
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
	</div>
	<div class="container">
		<fmt:formatDate value="${dto.message_senddate}" pattern="yyyy-MM-dd hh:mm" var="date"/>
		<form>
			<div class="form-group">
				<label>보낸 사람</label>
				<input type="text" value="${dto.message_sendid }" class="form-control" readonly="readonly">
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