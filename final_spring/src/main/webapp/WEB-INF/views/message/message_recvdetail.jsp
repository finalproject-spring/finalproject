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
<style type="text/css">
	.modal { text-align: center; }
	 
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
	
	#createBtn { background:#1AAB8A; text-align:center; color:#fff; border:none; position:relative; font-size:15px; width: 90px; height: 37px;
	  cursor:pointer; transition:800ms ease all; outline:none; border-radius: 10px; }
	#createBtn:hover { background:#fff; color:#1AAB8A;} 
	#createBtn:before,#createBtn:after{
	  content:'';
	  position:absolute;
	  top:0;
	  right:0;
	  height:2px;
	  width:0;
	  background: #1AAB8A;
	  transition:400ms ease all;
	}
	#createBtn:after{
	  right:inherit;
	  top:inherit;
	  left:0;
	  bottom:0;
	}
	#createBtn:hover:before,#createBtn:hover:after{
	  width:100%;
	  transition:800ms ease all;
	}
	
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
	<div id="msg_header"><i class="fas fa-envelope-open-text"></i> 받은 쪽지</div>

	<div>
		<form id="deleteForm" action="message_recvdel.do" method="get">
			<input type="hidden" value="${dto.message_no }" name="message_no"/>	
		</form>
	</div>
	<div style="text-align: right;">
		<button id="createBtn" data-target="#myModal" data-toggle="modal">답장하기</button>
		<input type="button" id="deleteBtn" value="삭제"/>
	</div>
	<br/>
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
		<fmt:formatDate value="${dto.message_senddate}" pattern="yyyy-MM-dd kk:mm" var="date"/>
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
	 		connectWS();
	 		
	 		if ($.trim($("#message_content").val()) == "" || $.trim($("#message_content").val()) == null) {
	 			alert("내용을 입력해주세요.");
	 		} else {
	 			
				send();	

				$('#message_content').empty();
			 	$("#myModal").modal('toggle');
 			 	alert("쪽지를 보냈습니다!");
	 	}  			 		
	});
});	
	
    var socket = null;
    var sock = new SockJS("<c:url value="/message_ws"/>");
    socket = sock;
    
    function connectWS(){
        sock.onopen = function(e) {

        };
        sock.onmessage = function(e) {
        	            var splitdata =e.data.split(":");
            if(splitdata[0].indexOf("msgNum") > -1)
            	if(splitdata[1] != '0') {
            		$("#msgNum").empty();
            		$("#msgNum").append(" ["+splitdata[1]+"통의 쪽지가 왔습니다.]");
           	} 
        }
        sock.onclose = function(){
        	
        }
	
        sock.onerror = function (err) {console.log('Errors : ' , err)};
	}

	
    
	function send(){

		var message_recvid = $('#message_recvid').val();
		var message_content = $('#message_content').val();
		
		sock.send(message_recvid + "," + message_content);
	}	
	
	$(function(){
		$("#deleteBtn").click(function(){
				$("#deleteForm").submit();
		});
	});

</script>
</body>
</html>