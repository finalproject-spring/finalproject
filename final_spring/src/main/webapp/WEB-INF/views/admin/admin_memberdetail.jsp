<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">

	function memberDelete(){
		if(confirm("정말 탈퇴시키겠습니까?") == true) {
			$('#delete').submit();
		}
	}
</script>
</head>
<body>
 <jsp:include page="../main/header.jsp"></jsp:include>
	<div class="container">
		<header>
			<h1>회원 정보 수정</h1>
		</header>
		<form id="delete" action="admin_memberDelete.do" method="post">
			<div align="right">
				<input type="button" value="회원삭제" onclick="memberDelete();"/>
				<input type="hidden" value="${dto.member_no }" name="member_no"/>
			</div>
		</form>
		<div>
			<form id="form" action="admin_memberUpdate.do" method="post">
				<input type="hidden" value="${dto.member_no }" name="member_no"/>
				<div class="form-group">
					<label for="id">아이디</label>
					<input type="text" value="${dto.member_id }" name="member_id" class="form-control" readonly="readonly">
				</div>
				<div class="form-group">
					<label for="name">이름</label>
					<input type="text" value="${dto.member_name }" name="member_name" class="form-control" required="required">
				</div>
				<div class="form-group">
					<label for="email">이메일</label>
					<input type="text" value="${dto.member_email }" name="member_email" class="form-control" required="required">
				</div>
				<div class="form-group">
					<label for="phone">번호</label>
					<input type="text" value="${dto.member_phone }" name="member_phone" class="form-control" required="required">
				</div>
				<div class="form-group" >
					<label for="addr">주소</label>
					<input type="text" value="${dto.member_addr }" name="member_addr" class="form-control" required="required">
				</div>
				<div class="form-group" align="right">
					<input type="submit" value="수정하기"/>
					<input type="button" value="뒤로가기" onclick="history.back();"/>
				</div>
			</form>
		</div>
	</div>
	
	<div class="container">
	<header>
		<h4>작성 글</h4>
	</header>
	<table style="table-layout:fixed" class="table">
		<col width="90px">
		<col width="220px">
		<col width="400px">
		<col width="100px">
		<tr>
			<td>게시판</td>
			<td>제목</td>
			<td>내용</td>
			<td>작성일</td>
		</tr>
	<c:forEach items="${list }" var="list">
		<tr>
			<td>${list.board_category }</td>
			<td style="overflow:hidden;white-space:nowrap;text-overflow:ellipsis; max-width:300px;"><a href='admin_memberWrite.do?board_no=${list.board_no }'>${list.board_title }</a></td>
			<td style="overflow:hidden;white-space:nowrap;text-overflow:ellipsis; max-width:300px;"><a href='admin_memberWrite.do?board_no=${list.board_no }'>${list.board_content }</a></td>
			<td><fmt:formatDate value="${list.board_date }" pattern="yy-MM-dd hh:mm" var="date"/>${date }</td>
		</tr>
	</c:forEach>
	</table>	
	</div>
</body>
</html>