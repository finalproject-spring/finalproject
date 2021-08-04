<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<style type="text/css">

.container h2 {margin: 50px 0px 10px 0px;}
#board {width: 100%; border: 1px solid rgba(0, 0, 0, 0.1); height: 37px; vertical-align: middle;}

#writeBtn{
  border-radius:5px;
  background:#1AAB8A;
  color:#fff;
  border:none;
  position:relative;
  height:35px;
  width: 70px;
  font-size: 14px;
  padding:0 1em;
  cursor:pointer;
  transition:800ms ease all;
  outline:none;
  
}
#writeBtn:hover{
  background:#fff;
  color:#1AAB8A;
}

</style>
</head>
<body>
 <jsp:include page="../main/header.jsp"></jsp:include>

<div class="container">
	<h2>글 수정하기</h2>
	<form action="./updateDeal.do" method="post">
		<input type="hidden" value="${dto.board_no }" name="board_no">
		<div>
			<label for="title">제목</label>
			<div><input type="text" id="board" name="board_title" required="required" value="${dto.board_title }"></div>
		</div>
		<div>
			<label for="content">가격</label>
			<div><input type="text" id="board" value="${dto.board_price }" name="board_price" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" required="required"></div>
		</div>
		<div class="form-group">
			<label for="content">내용</label>
			<textarea required="required" name="board_content" style="resize: none; overflow: auto; height: 220px; width: 100%; border: 1px solid rgba(0, 0, 0, 0.1); font-size: 14px">${dto.board_content }</textarea> 
		</div>

		<div align="right">
			<button type="submit" id="writeBtn">수정</button>	
		</div>
	</form>
</div>
</body>
</html>