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

<!-- jquery --><!-- 
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script> -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<!-- popper js -->
<Script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/2.9.2/umd/popper.min.js"></Script>
<!-- Javascript -->
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"/>	
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
	

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
	 	
	 	var memberid = $("#member_id").val();
	 	
	 	$("#message_recvid").on("propertychange change keyup paste input", function(){
	 		if ($("#message_recvid").val() == memberid) {
	 			$("#idchk2").css("display","block");
	 			$("#idchk1").css("display","none");
	 			$("#idchk3").css("display","none");
	 			return false;
	 		} else if ($("#message_recvid").val() == "") {
	 				$("#idchk1").css("display","none");
	 				$("#idchk2").css("display","none");
	 			return false;
	 		} else {
	 			$.ajax({
	 				url : "message_idCheck.do",
	 				type : "post",
	 				data : {"member_id" : $("#message_recvid").val()},
	 				success : function(res){
	 					if (res == '0') {
	 						$("#idchk1").css("display","block");
	 					} else if(res == '1') {
	 						$("#idchk3").css("display","block");
	 					}
	 				},
	 				error : function(res){
	 					alert(error);
	 				}
	 			});
	 		}
	 	});
	 	
	 	$("#modalSubmit").click(function(){
	 		url = 'message_insert.do';
	 		
	 		if ($("#message_recvid").val() == memberid) {
	 			$("#idchk2").css("display","block");
	 			$("#idchk1").css("display","none");
	 			$("#idchk3").css("display","none");
	 			return false;
	 		} else if ($("#message_recvid").val() == "") {
	 				$("#idchk1").css("display","none");
	 				$("#idchk2").css("display","none");
	 				$("#idchk3").css("display","none");
	 			return false;
	 		} else if ($.trim($("#message_recvid").val()) == "" || $.trim($("#message_content").val()) == "") {
	 			alert("쪽지를 입력해주세요.");
	 		} else if ($("#message_recvid").val() == null || $.trim($("#message_content").val()) == null) {
	 			alert("쪽지를 입력해주세요.");
	 		} else {
	 			$.ajax({
	 				url : "message_idCheck.do",
	 				type : "post",
	 				data : {"member_id" : $("#message_recvid").val()},
	 				success : function(res){
	 					if (res == '0') {
	 						$("#idchk1").css("display","block");
	 						$("#idchk2").css("display","none");
	 						$("#idchk3").css("display","none");
	 					} else if(res == '1') {
	 						$("#idchk1").css("display","none");
	 						$("#idchk2").css("display","none");
	 						$("#idchk3").css("display","block");
	 						
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
	 				},
	 				error : function(res){
	 					alert(error);
	 				}
	 			});
	 		}
	 	});
	 	
	});	
	
	$(function(){
		$("#muldel").click(function(){
			if ($("input[type=checkbox]:checked").length == 0) {
				alert("삭제할 쪽지를 선택해주세요");
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

	<div>
		<div>받은 쪽지함</div>
		<div><a href='message_sendList.do'>보낸 쪽지함</a></div>
	</div>
	<div>
	
 <button id="createBtn" class="btn btn-info btn-sm" data-target="#myModal" data-toggle="modal">쪽지쓰기</button>
 <!-- Modal -->
<div class="modal fade" id="myModal" role="dialog">
	<div class="modal-dialog">
		<!-- Modal content-->
		<div class="modal-content">
			<div class="modal-header">
				<h4 id="modal-title" class="modal-title">쪽지 보내기</h4>
				<button type="button" class="close" data-dismiss="modal">&times;</button>
			</div>
			<div class="modal-body">
				<table class="table">
					<tr>
						<td>받는사람</td>
						<td>
							<input class="form-control" id="message_recvid" type="text">
							<div id="idchk1" style="display: none;">아이디가 존재하지 않습니다.</div>
							<div id="idchk2" style="display: none;">내 아이디로 보낼 수 없습니다.</div>
							<div id="idchk3" style="display: none;">OK !</div>
						</td>
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
	<div>
		

	</div>
	<input type="button" id="muldel" value="삭제"/>
	<form action="message_recvdel.do" method="get" id="multiDelete">
	<table style="table-layout:fixed" class="table table-hover">
		<col width="50"/>
		<col width="100"/>
		<col width="450"/>
		<col width="150"/>	
		<tr>
			<td>
				<input type="checkbox" id="allCheck"/>
			</td>
			<td>보낸사람</td>
			<td>내용</td>
			<td>받은시간</td>
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
					<td colspan="4" align="center">받은 쪽지가 없습니다.</td>
				</tr>
			</c:when>
		<c:otherwise>
		<c:forEach items="${list }" var="dto">
		<tr>
			<td>
				<input type="checkbox" id="chk" name="message_noList" value="${dto.message_no }"/>
			</td>
			<td>${dto.message_sendid }</td>
			<td style="overflow:hidden;white-space:nowrap;text-overflow:ellipsis; max-width:450px;"><a href="message_recvDetail.do?message_no=${dto.message_no }">${dto.message_content }</a></td>
			<td>
				<fmt:parseDate value="${dto.message_senddate }" pattern="yyyy/MM/dd" var="date"/>
				<fmt:formatDate value="${date}" pattern="yy-MM-dd hh:MM" var="time"/>
				${time }
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
		    	<li><a href="message_recvList.do${pageMaker.makeQuery(pageMaker.startPage - 1)}">이전</a></li>
		    </c:if> 
		
		    <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
		    	<li><a href="message_recvList.do${pageMaker.makeQuery(idx)}">${idx}</a></li>
		    </c:forEach>
		
		    <c:if test="${pageMaker.next && pageMaker.endPage > 0}">
		    	<li><a href="message_recvList.do${pageMaker.makeQuery(pageMaker.endPage + 1)}">다음</a></li>
		    </c:if> 
		  </ul>
		</div>
	</div>

</body>
</html>