<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet"/>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">
	function qnaDelete() {
		if(confirm("삭제하시겠습니까?")) {
			$("#deleteForm").submit();
		}
	}

</script>
<style type="text/css">
	.listBtn {background-color: #71c55d; border: 1px solid #71c55d; color: white; width: 90px; height: 39px; border-radius: 13px; font-size: 15px;}
	#replyWriteBtn {background-color: #71c55d; border: 1px solid #71c55d; color: white; width: 68px; height: 38px; border-radius: 13px; font-size: 15px; }
	.updateBtn {background-color: #71c55d; border: 1px solid #71c55d; color: white; width: 65px; height: 39px; border-radius: 13px; font-size: 15px; }
	.deleteBtn {background-color: white; border: 2px solid #71c55d; color: #71c55d; width: 64px; height: 38px; border-radius: 13px; font-size: 15px; }
</style>
</head>
<body>
<jsp:include page="../main/header.jsp"></jsp:include>
	
	
<div class="container">
	<header>
		<h1>QnA</h1>
	</header>
	<hr />
	<c:choose>
		<c:when test="${dto.board_secret eq 'Y'}">

		<c:choose>
			<c:when test="${memberdto.member_role eq 0 || memberdto.member_id eq dto.board_id}">
				<section id="container">
					<form  id="deleteForm" action="qna_delete.do" method="post">
						<input type="hidden" id="board_no" name="board_no" value="${dto.board_no}" />
						<input type="hidden" id="page" name="page" value="${scri.page}"> 
						<input type="hidden" id="perPageNum" name="perPageNum" value="${scri.perPageNum}"> 
						<input type="hidden" id="searchType" name="searchType" value="${scri.searchType}"> 
						<input type="hidden" id="keyword" name="keyword" value="${scri.keyword}"> 
						<div class="form-group">
							<label for="title" class="col-sm-2 control-label">제목</label>
							<input type="text" id="title" name="board_title" value="${dto.board_title }" class="form-control" readonly="readonly"/>
						</div>
						<div class="form-group">
							<label for="writer" class="col-sm-2 control-label">작성자</label>
							<input type="text" id="id" name="board_id" value="${dto.board_id }" class="form-control" readonly="readonly"/>
						</div>
						<div class="form-group">
							<label for="content" class="col-sm-2 control-label">내용</label>
							<textarea class="form-control-lg" style="resize: none; overflow: auto; height: 220px; width: 100%; border: 1px solid rgba(0, 0, 0, 0.1); font-size: 14px" readonly="readonly">${dto.board_content }</textarea> 
						</div>
					</form>
					<div align="left" style="float:left;">
						<button type="button" class="listBtn" onclick="location.href='qna_list.do?page=${scri.page}&perPageNum=${scri.perPageNum}&searchType=${scri.searchType}&keyword=${scri.keyword}'">목록으로</button>
					</div>
					<c:if test="${memberdto.member_role eq 0 || memberdto.member_id eq dto.board_id}">
						<div align="right">	
							<button type="button" class="updateBtn" onclick="location.href='qna_updateform.do?board_no=${dto.board_no}'">수정</button>
							<button type="button" class="deleteBtn" onclick="qnaDelete();">삭제</button>	
						</div>
					</c:if>
					</section>
					<br/>
					<table>
						<c:forEach items="${replylist }" var="groupReply">
							<div style="line-height: 30px;">
								<div style="font-weight: 700; float: left;">[관리자] ${groupReply.reply_id }</div>
								<c:if test="${memberdto.member_role eq 0}">
									<div style="text-align: right; margin-right: 20px; cursor: pointer;"><i style="color:#CCC9C9" class="fas fa-times" onclick="location.href='qna_replyDelete.do?reply_no=${groupReply.reply_no}&board_no=${dto.board_no }'"></i></div>
								</c:if>
								<div style="font-size: 13px;"><fmt:formatDate value="${groupReply.reply_date}" pattern="yyyy-MM-dd hh:mm" /></div>
								<div style="color: black;">${groupReply.reply_content }</div>
							</div>
							<br/>
						</c:forEach>
					</table>
					<br/>

					<c:if test="${memberdto.member_role eq 0}">
					<form name="replyform" action="qna_reply.do" method="post">
					<input type="hidden" id="board_no" name="board_no" value="${dto.board_no}" />
					<input type="hidden" id="page" name="page" value="${scri.page}"> 
					<input type="hidden" id="perPageNum" name="perPageNum" value="${scri.perPageNum}"> 
					<input type="hidden" id="searchType" name="searchType" value="${scri.searchType}"> 
					<input type="hidden" id="keyword" name="keyword" value="${scri.keyword}"> 
					<input type="hidden" id="reply_id" name="reply_id" value="${memberdto.member_id }">
					<div class="form-group">	
						<label for="replycontent">댓글 작성</label>
						<textarea class="form-control-lg" style="resize: none; overflow: auto; height: 100px; width: 100%; border: 1px solid rgba(0, 0, 0, 0.1); font-size: 14px" id="reply_content"name="reply_content"></textarea>
					</div>
					<div>
						<button type="button" class="list_btn btn btn-primary" id="replyWriteBtn">작성</button>
					</div>
				</form>
				</c:if>
			</c:when>

			<c:otherwise>
				<div style="text-align: center; line-height: 250px;">
					<div><i class="fas fa-lock" style="color:gray;"></i> 비밀글은 작성자와 관리자만 볼 수 있습니다.</div>
					<div><button type="button" class="list_btn btn btn-primary" onclick="location.href='qna_list.do?page=${scri.page}&perPageNum=${scri.perPageNum}&searchType=${scri.searchType}&keyword=${scri.keyword}'">목록으로</button></div>
				</div>
			</c:otherwise>
		</c:choose>

		</c:when>
		
		<c:otherwise>
			<section id="container">
				<form  id="deleteForm" action="qna_delete.do" method="post">
					<input type="hidden" value="${dto.board_no }" name="board_no"/>
					<div class="form-group">
						<label for="title" class="col-sm-2 control-label">제목</label>
						<input type="text" id="title" name="board_title" value="${dto.board_title }" class="form-control" readonly="readonly"/>
					</div>
					<div class="form-group">
						<label for="writer" class="col-sm-2 control-label">작성자</label>
						<input type="text" id="id" name="board_id" value="${dto.board_id }" class="form-control" readonly="readonly"/>
					</div>
					<div class="form-group">
						<label for="content" class="col-sm-2 control-label">내용</label>
						<textarea class="form-control-lg" style="resize: none; overflow: auto; height: 220px; width: 100%; border: 1px solid rgba(0, 0, 0, 0.1); font-size: 14px" readonly="readonly">${dto.board_content }</textarea> 
					</div>
				</form>
				<div align="left" style="float:left;">
					<button type="button" class="listBtn" onclick="location.href='qna_list.do?page=${scri.page}&perPageNum=${scri.perPageNum}&searchType=${scri.searchType}&keyword=${scri.keyword}'">목록으로</button>
				</div>
				<c:if test="${memberdto.member_role eq 0 || memberdto.member_id eq dto.board_id}">
					<div align="right">	
						<button type="button" class="updateBtn" onclick="location.href='qna_updateform.do?board_no=${dto.board_no}'">수정</button>
						<button type="button" class="deleteBtn" onclick="qnaDelete();">삭제</button>	
					</div>
				</c:if>
				</section>
				<br/>
				<br/>
				<table>
					<c:forEach items="${replylist }" var="groupReply">
						<div style="line-height: 30px;">
							<div style="font-weight: 700; float: left;">[관리자] ${groupReply.reply_id }</div>
							<c:if test="${memberdto.member_role eq 0}">
								<div style="text-align: right; margin-right: 20px; cursor: pointer;"><i style="color:#CCC9C9" class="fas fa-times" onclick="location.href='qna_replyDelete.do?reply_no=${groupReply.reply_no}&board_no=${dto.board_no }'"></i></div>
							</c:if>
							<div style="font-size: 13px;"><fmt:formatDate value="${groupReply.reply_date}" pattern="yyyy-MM-dd kk:mm" /></div>
							<div style="color: black;">${groupReply.reply_content }</div>
						</div>
						<br/>
					</c:forEach>
				</table>
				<br/>
				<c:if test="${memberdto.member_role eq 0}">
				<form name="replyform" action="qna_reply.do" method="post">
					<input type="hidden" id="board_no" name="board_no" value="${dto.board_no }">
					<input type="hidden" id="reply_id" name="reply_id" value="${memberdto.member_id }">
					<div class="form-group">	
						<label for="replycontent">댓글 작성</label>
						<textarea class="form-control-lg" style="resize: none; overflow: auto; height: 100px; width: 100%; border: 1px solid rgba(0, 0, 0, 0.1); font-size: 14px" id="reply_content"name="reply_content"></textarea>
					</div>
					<div>
						<button type="button" id="replyWriteBtn">작성</button>
					</div>
				</form>
				</c:if>
		</c:otherwise>
	</c:choose>		
</div>
<br/>
<script type="text/javascript">
	$("#replyWriteBtn").on("click",function(){
		var formObj = $("form[name='replyform']").eq(0);
		formObj.submit();
	});
</script>


</body>
</html>