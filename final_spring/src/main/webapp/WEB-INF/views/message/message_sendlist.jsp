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
	
	#message_menu {padding-bottom: 30px;}
	#message_menu span { display:inline-block; width: 50%; height: 50px; line-height: 50px; text-align: center; border: 1px solid rgba(0,0,0,.1); cursor: pointer; }
	#muldel {background-color: gray; text-align:center; color:#fff; border:none; position:relative; font-size:15px; width: 70px; height: 37px;
	  cursor:pointer; transition:800ms ease all; outline:none; border-radius: 10px; }
	#muldel:hover { background:#fff; color:gray;} 

</style>
</head>
<body>
 <jsp:include page="../main/header.jsp"></jsp:include>
 <br/>
 <div class="container">
	<div id="message_menu">
		<span onclick="location.href='message_recvList.do'" style="float: left;">받은 쪽지함</span>
		<span onclick="location.href='message_sendList.do'" style="font-weight: 700;">보낸 쪽지함</span>
	</div>

	<div style="text-align: right;"><input type="button" id="muldel" value="삭제"/></div>
	<br/>
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
				<fmt:formatDate value="${dto.message_senddate}" pattern="yy-MM-dd kk:mm" var="date"/>
			${date }
			</td>
		</tr>
		</c:forEach>
		</c:otherwise>
		</c:choose>
	</table>
	</form>
		<div id="paging">
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

</body>
</html>