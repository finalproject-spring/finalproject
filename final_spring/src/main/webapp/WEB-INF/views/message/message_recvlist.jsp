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

	li { list-style: none; float: left; padding: 6px; }
	
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
	
	#muldel {background-color: gray; text-align:center; color:#fff; border:none; position:relative; font-size:15px; width: 70px; height: 37px;
	  cursor:pointer; transition:800ms ease all; outline:none; border-radius: 10px; }
	#muldel:hover { background:#fff; color:gray;} 
	#message_menu {padding-bottom: 30px;}
	#message_menu span { display:inline-block; width: 50%; height: 50px; line-height: 50px; text-align: center; border: 1px solid rgba(0,0,0,.1); cursor: pointer; }
		
</style>
</head>
<body>
 <jsp:include page="../main/header.jsp"></jsp:include>
 <br/>
 <div class="container">
	<div id="message_menu">
		<span onclick="location.href='message_recvList.do'" style="float: left; font-weight: 700;">받은 쪽지함</span>
		<span onclick="location.href='message_sendList.do'">보낸 쪽지함</span>
	</div>
	<div style="text-align: right;">
		<button id="createBtn" data-target="#myModal" data-toggle="modal">쪽지쓰기</button>
		<input type="button" id="muldel" value="삭제"/>
	</div>
	<br/>	
 <!-- Modal -->
<div class="modal fade" id="myModal" role="dialog">
	<div class="modal-dialog">
		<!-- Modal content-->
		<div class="modal-content" style="width:500px;">
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
						<td><textarea class="form-control-lg" id="message_content" style="resize: none; overflow: auto; height: 220px; width: 100%; border: 1px solid rgba(0, 0, 0, 0.1); font-size: 14px;"></textarea></td>
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
	<form action="message_multi_recvdel.do" method="get" id="multiDelete">
	<table class="table table-hover" style="table-layout:fixed" >
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
			<td>보낸시간</td>
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
					<td class="recvMsg" style="overflow:hidden;white-space:nowrap;text-overflow:ellipsis; max-width:450px; text-decoration: none;"><a href="message_recvDetail.do?message_no=${dto.message_no }">${dto.message_content }</a></td>
					<td>
						<fmt:formatDate value="${dto.message_senddate}" pattern="yy-MM-dd kk:mm" var="date"/>
					${date }</td>
				</tr>
				</c:forEach>
			</c:otherwise>
		</c:choose>
	</table>
	</form>
		<div id="paging">
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

<script type="text/javascript">
	$(document).ready(function(){

		$.ajax({
			url : "message_unReadMsgChk.do",
			type : "post",
			data : {"member_id" : $("#member_id").val()},
			success : function(res){
				for(var i = 0; i < parseInt(res); i++ ) {;
					$('.recvMsg > a').eq(i).css({"font-weight":"700","color":"#1AAB8A"});
				}
			},
			error : function(res){
				alert(error);
			}
		});
		
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
	 				$("#idchk3").css("display","none");
	 			return false;
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
	 						$("#idchk3").css("display","block");
	 		 				$("#idchk1").css("display","none");
	 		 				$("#idchk2").css("display","none");
	 					}
	 				},
	 				error : function(res){
	 					alert(error);
	 				}
	 			});
	 		}
	 	});
	 	
	 	$("#modalSubmit").click(function(){
	 		connectWS();
	 		
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
	 				 	
	 			 		send();
	 			 		
	 			 		$('#message_recvid').empty();
	 			 		$('#message_content').empty();
	 			 		$("#myModal").modal('toggle');
	 			 		alert("쪽지를 보냈습니다!");
	 					}
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
	
</script>
</body>
</html>