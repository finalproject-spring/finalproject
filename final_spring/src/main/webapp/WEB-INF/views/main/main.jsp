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

<a href="admin_memberList.do">관리자 - 회원 조회</a><br/><br/>

	--상단 메뉴 구성--<br/>
	정보안내 - 인겸님 게시판들 (티쳐블 등), 친환경식당(지도) <br/>
	공지 및 이벤트 - 공지,이벤트, QNA <br/><br/>
	-- 네비게이션바 -- <br/>
	챗봇

 <jsp:include page="footer.jsp"></jsp:include>

	
</body>
</html>