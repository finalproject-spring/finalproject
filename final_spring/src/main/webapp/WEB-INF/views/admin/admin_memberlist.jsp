<%@page import="com.spring.recycle.model.biz.MemberBizImpl"%>
<%@page import="com.spring.recycle.model.biz.MemberBiz"%>
<%@page import="com.spring.recycle.model.dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
	#createBtn {   background:#1AAB8A;
	  text-align:center;
	  color:#fff;
	  border:none;
	  position:relative;
	  font-size:15px;
	  cursor:pointer;
	  transition:800ms ease all;
	  outline:none; }
  
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
	#paging li {list-style: none; float: left; padding: 6px;}
	#paging ul li a {color: #626262; font-size: 15px;}
	.search {margin: 20px 0px 0px 0px;}
	select {height: 30px; border: 1px solid #C8C7C6}
	#keywordInput {border: 1px solid #C8C7C6; height: 30px; border-radius: 0px;}
	#searchBtn {background-color: #71c55d; border: 1px solid #71c55d; width: 60px; height: 33px; color: white; border-radius: 15px; font-size: 15px;}
	#deleteBtn {background-color: #71c55d; border: 1px solid #71c55d; color: white; width: 90px; height: 38px; border-radius: 10px; font-size: 15px; }
	#deleteWrap { text-align: right;}
	.table {margin: 30px 0px 30px 0px;}
	#admin_mainBtn{background-color: #8ece7f; color:white; border: 1px solid #71c55d; width: 100px; height: 37px; border-radius: 10px; }
</style>
</head>
<body>
 <jsp:include page="../main/header.jsp"></jsp:include>
	<div class="container">
		<br/>
		<header>
			<h1>회원 관리</h1>
		</header>
		<br/>
		<div>전체 회원 ${count}명</div>
		<br/>
		<div>
			<input type="button" value="전체쪽지" id="createBtn" class="btn btn-info btn-sm" data-target="#myModal" data-toggle="modal"/>
		</div> 
		 <!-- Modal -->
		<div class="modal fade" id="myModal" role="dialog">
			<div class="modal-dialog">
				<!-- Modal content-->
				<div class="modal-content" style="width:500px;">
					<div class="modal-header">
						<h4 id="modal-title" class="modal-title">전체 쪽지 보내기</h4>
						<button type="button" class="close" data-dismiss="modal">&times;</button>
					</div>
					<div class="modal-body">
						<table class="table">
							<tr>
								<td>내용</td>
								<td><textarea class="form-control-lg" id="message_content" style="resize: none; overflow: auto; height: 220px; width: 100%; border: 1px solid rgba(0, 0, 0, 0.1); font-size: 14px;"></textarea></td>
							</tr>					
						</table>
					</div>
					<div class="modal-footer">
						<button id="modalSubmit" type="button" class="btn btn-success">보내기</button>
						<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
					</div>
				</div>
			</div>
		</div>	
		<div id="deleteWrap"><input type="button" value="회원탈퇴" id="deleteBtn" onclick="memberDelete();"/></div>
		<table class="table" style="table-layout:fixed">
			<col width="30px"/>
			<col width="40px"/>
			<col width="70px"/>
			<col width="50px"/>
			<col width="110px"/>
			<col width="80px"/>
			<col width="140px"/>
			<col width="45px"/>
			<tr>
				<td><input type="checkbox" id="allCheck"/></td>
				<th>번호</th>
				<th>아이디</th>
				<th>이름</th>
				<th>이메일</th>
				<th>전화번호</th>
				<th>주소</th>
				<th>탈퇴여부</th>
			</tr>
			<c:forEach items="${list }" var="dto">	
			<tr>
				<td><input type="checkbox" name="chks" value="${dto.member_no }"/></td>
				<td>${dto.member_no }</td>
				<td><a href='admin_memberDetail.do?member_no=${dto.member_no }'>${dto.member_id }</a></td>
				<td>${dto.member_name }</td>
				<td>${dto.member_email }</td>
				<td>${dto.member_phone }</td>
				<td style="overflow:hidden;white-space:nowrap;text-overflow:ellipsis; max-width:450px;">${dto.member_addr }</td>
				<td>
					<c:choose>
						<c:when test="${dto.member_delete eq '1'}">
						탈퇴
						</c:when>
						<c:otherwise></c:otherwise>
					</c:choose>
				</td>
			</tr>
			</c:forEach>
		</table>
		<div class="search">
			<select name="searchType">
		 	  	<option value="n"<c:out value="${scri.searchType == null ? 'selected' : ''}"/>>-----</option>
		  		<option value="na"<c:out value="${scri.searchType eq 'na' ? 'selected' : ''}"/>>회원이름</option>
		  		<option value="i"<c:out value="${scri.searchType eq 'i' ? 'selected' : ''}"/>>ID</option>
		 		<option value="e"<c:out value="${scri.searchType eq 'e' ? 'selected' : ''}"/>>이메일</option>
		   		<option value="p"<c:out value="${scri.searchType eq 'p' ? 'selected' : ''}"/>>전화번호</option>
		   		<option value="a"<c:out value="${scri.searchType eq 'a' ? 'selected' : ''}"/>>주소</option>
		    </select>
		    <input type="text" name="keyword" id="keywordInput" value="${scri.keyword}"/>
		    <button id="searchBtn" type="button">검색</button>
		</div>
		<div id="paging">
		  <ul>
		    <c:if test="${pageMaker.prev}">
		    	<li><a href="admin_memberList.do${pageMaker.makeSearch(pageMaker.startPage - 1)}">이전</a></li>
		    </c:if> 
		
		    <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
		    	<li><a href="admin_memberList.do${pageMaker.makeSearch(idx)}">${idx}</a></li>
		    </c:forEach>
		
		    <c:if test="${pageMaker.next && pageMaker.endPage > 0}">
		    	<li><a href="admin_memberList.do${pageMaker.makeSearch(pageMaker.endPage + 1)}">다음</a></li>
		    </c:if> 
		  </ul>
		</div>	
		<div align="right"><input type="button" value="관리자 메인" id="admin_mainBtn" onclick="location.href='admin_main.do'"/></div>
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
 		}  else {

 			 send();
 			 $('#message_recvid').empty();
 			 $('#message_content').empty();
 			 $('.modal-body').empty();
 			 $('.modal-footer').empty();
 		     $('.modal-body').html("<div>쪽지를 보냈습니다.</div>");
 			 $("#myModal").modal('toggle');
 		     window.setTimeout(function(){ window.location.reload()}, 950);
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

	var message_content = $('#message_content').val();

	sock.send("all," + message_content);
}

function memberDelete() {
	var url = "admin_memberSelectDelete.do";
	var Arr = new Array();
	var list = $("input[name='chks']");
	for(var i = 0; i<list.length; i++){
		if(list[i].checked){
			Arr.push(list[i].value);
		}
	}
	
	if (Arr.length == 0) {
		alert("선택된 회원이 없습니다.")
	} else {
		if (confirm("선택한 회원을 정말 탈퇴시키겠습니까?") == true) {
			$.ajax({
				url : url,
				type : 'POST',
				data : {Arr : Arr},
				traditional : true,
				success: function(data){

				},
				complete: function(data){
					alert("탈퇴가 완료되었습니다.");
					location.replace("admin_memberList.do");
				}
			});
		}
	}
}

	$("input:checkbox[id='allCheck']").click(function(){
		if($("input:checkbox[id='allCheck']").is(":checked") == true) {
			$("input[type=checkbox]").prop("checked", true);
 		} else {
 			$("input[type=checkbox]").prop("checked",false);
 		}
	});
	
    $(function(){
        $('#searchBtn').click(function() {
          self.location = "admin_memberList.do" + '${pageMaker.makeQuery(1)}' + "&searchType=" + $("select option:selected").val() + "&keyword=" + encodeURIComponent($('#keywordInput').val());
        });
      }); 
</script>
</body>
</html>