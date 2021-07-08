<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
		<!-- 합쳐지고 최소화된 최신 CSS -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
		<!-- 부가적인 테마 -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
		
		<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
li {list-style: none; float: left; padding: 6px;}

</style>
<script type="text/javascript">

// 체크 박스 선택 함수
$(function() {
	var chkObj = document.getElementsByName("RowCheck");
	var rowCnt = chkObj.length;
	
	$("input[name='allCheck']").click(function() {
		var chk_listArr = $("input[name='RowCheck']");
		for (var i=0; i<chk_listArr.length; i++){
			chk_listArr[i].checked = this.checked;
		}
	});
	$("input[name='RowCheck']").click(function() {
		if($("input[name='RowCheck']:checked").length == rowCnt){
			$("input[name='allCheck']")[0].checked = true;
		}
		else{
			$("input[name='allCheck']")[0].checked = false;
		}
	});
});

//선택된 게시물 controller로 보내서 삭제하기! 
function deleteValue() {
	var url = "event_selectdelete.do";
	var valueArr = new Array();
	var list = $("input[name='RowCheck']");
	for (var i=0; i<list.length; i++){
		if(list[i].checked){
			valueArr.push(list[i].value);
		}
	}
	if(valueArr.length == 0){
		alert("선택된 글이 없습니다.");
	}
	else{
		var chk = confirm("정말 삭제하시겠습니까?");
		$.ajax({
			url : url,
			type : 'POST',
			traditional : true,
			data :{
				valueArr : valueArr
			},
			success:function(jdata){
				if(jdata=1){
					alert("삭제 성공");
					location.replace("event_list.do")
				}
				else{
					alert("삭제 실패");
				}
			}		
			
		});
		
	}
}

</script>
<style type="text/css">
li {list-style: none; display:inline; padding: 6px;}
</style>

</head>
<body><ul>
	
	<li><a href="./event_insertform.do">글 작성</a></li>
	<li><a href="#">로그인</a></li>
</ul>
			<div class="container">
				<header>
						<h1>이벤트</h1>
				</header>
				<hr/>
				
				<section id="container">
					<form role="form" method="get">
							<table class="table table-hover">
								<thead>
									<tr>
										<th><input id="allCheck" type="checkbox" name="allCheck"/> </th>
										<th>번호</th>
										<th>제목</th>
										<th>작성자</th>
										<th>시작일</th>
										<th>종료일</th>
										<th>종료일 까지</th>
									</tr>
								</thead>
								
								<c:forEach items="${list }" var="dto">
									<tr>
										<td><input name="RowCheck" type="checkbox" value="${dto.event_no }"/></td>
										<td>${dto.event_no }</td>
										<td>
											<a href="event_view.do?event_no=${dto.event_no }">${dto.event_title }</a>
										</td>
										<td>admin</td>
										<td>${dto.event_start}</td>
										<td>${dto.event_end}</td>
										<td>
											<c:choose>
									<c:when test="${endDate-nowDate >= 0}">
										<div style="font-weight: bold;">${endDate-nowDate }일 남음</div>
									</c:when>
									<c:otherwise>
										<div>종료됨</div>
									</c:otherwise>
								</c:choose>
										
										
										</td>
						</tr>
								</c:forEach>
								
							</table>
							 <div class="search">
    <select name="searchType">
      <option value="n"<c:out value="${scri.searchType == null ? 'selected' : ''}"/>>-----</option>
      <option value="t"<c:out value="${scri.searchType eq 't' ? 'selected' : ''}"/>>제목</option>
      <option value="c"<c:out value="${scri.searchType eq 'c' ? 'selected' : ''}"/>>내용</option>
      <option value="tc"<c:out value="${scri.searchType eq 'tc' ? 'selected' : ''}"/>>제목+내용</option>
    </select>

    <input type="text" name="keyword" id="keywordInput" value="${scri.keyword}"/>

    <button id="searchBtn" type="button">검색</button>
    <script>
      $(function(){
        $('#searchBtn').click(function() {
        	// 버튼
          self.location = "event_list.do" + '${pageMaker.makeQuery(1)}' + "&searchType=" + $("select option:selected").val() + "&keyword=" + encodeURIComponent($('#keywordInput').val());
        });
      });   
    </script>
  </div>
	<div>
  <ul>
    <c:if test="${pageMaker.prev}">
    	<li><a href="event_list.do${pageMaker.makeQuery(pageMaker.startPage - 1)}">이전</a></li>
    </c:if> 
    <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
    	<li><a href="event_list.do${pageMaker.makeQuery(idx)}">${idx}</a></li>
    </c:forEach>
    <c:if test="${pageMaker.next && pageMaker.endPage > 0}">
    	<li><a href="event_list.do${pageMaker.makeQuery(pageMaker.endPage + 1)}">다음</a></li>
    </c:if> 
  </ul>
</div>
				<div>
					<button type="button" class="list_btn btn btn-primary" onclick="deleteValue();" >선택삭제</button>
				</div>
				
				</form>
			</section>
		</div>
	</body>
</html>