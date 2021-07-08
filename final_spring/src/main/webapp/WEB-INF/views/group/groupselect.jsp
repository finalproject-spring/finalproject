<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>

<table>
	<tr>
		<th>작성자</th>
		<td>${dto.board_id }</td>
	</tr>
	
	<tr>
		<th>제목</th>
		<td>${dto.board_title }</td>
	</tr>
	<tr>
		<th>조회수</th>
		<td>${dto.board_views }</td>
	</tr>
	
	<tr>
		<th>내용</th>
		<td><textarea rows="10" cols="60" readonly="readonly">${dto.board_content }</textarea></td>
	</tr>
	<tr>
			<td colspan="2" align="right">
				<input type="button" value="수정" onclick="location.href='group_updateform.do?board_no=${dto.board_no}'"/>
				<input type="button" value="삭제" onclick="location.href='group_delete.do?board_no=${dto.board_no}'"/>
				<input type="button" value="목록" onclick="location.href='group_list.do'"/>
			</td>
		</tr>
	
	
			<c:forEach items="${replylist }" var="groupReply">
				<tr>
					<th>작성자</th>
					<td>${groupReply.reply_id }</td>
				</tr>
				<tr>
				
					<th>내용</th>
					<td>${groupReply.reply_content }</td>
				</tr>
				
				<tr>
					<th>날짜</th>
					<td><fmt:formatDate value="${groupReply.reply_date}" pattern="yyyy-MM-dd" /></td>
				</tr>
				
			</c:forEach>
</table>

<form name="replyform" method="post">
<input type="hidden" id="board_no" name="board_no" value="${dto.board_no }">

	<div>
		<label for="replywriter">댓글작성자</label>
		<input type="text" id="reply_id" name="reply_id">
		<br/>
		<br/>
		<label for="replycontent">댓글 내용</label>
		<textarea rows="10" cols="60" id="reply_content"name="reply_content"></textarea>
		<br/>
		<br/>
	</div>
	<div>
		<button type="button" class="replyWriteBtn">작성</button>
	</div>

</form>
<script type="text/javascript">
//댓글 작성 버튼
$(".replyWriteBtn").eq(0).on("click",function(){
	//alert("버튼");
	var formObj = $("form[name='replyform']").eq(0);
	formObj.attr("action", "./group_replywrite.do");
	formObj.submit();
})

</script>
</body>
</html>