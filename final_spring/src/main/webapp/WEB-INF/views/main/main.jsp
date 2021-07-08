<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script type="text/javascript">
</script>
<style type="text/css">
	#test { color:black; text-decoration: none; }
</style>
</head>
<body>
 <jsp:include page="header.jsp"></jsp:include>

	<div><a href="group_list.do">글작성</a></div>
	<a href="funding_list.do" id="test">펀딩 list</a>
	<a href="funding_insertform.do">펀딩 insert</a>
	<a href="funding_test.do">펀딩 test</a>
	<a href="message.do">쪽지</a>
	<a href="event_list.do">이벤트</a>
 <jsp:include page="footer.jsp"></jsp:include>
	정보안내 - 인겸님 게시판들 (티쳐블 등), 친환경식당(지도)
	회원거래
	펀딩
	소모임
	공지 - 공지,이벤트, QNA
	
	로그인, 회원가입 / 로그아웃
	쪽지
	마이페이지
</body>
</html>