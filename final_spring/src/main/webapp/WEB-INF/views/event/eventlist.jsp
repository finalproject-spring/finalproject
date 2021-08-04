<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<!DOCTYPE html>
<html>
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet"/>
		
		<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="resources/css/deal-style.css">
<style type="text/css">
li {list-style: none; float: left; padding: 6px;}
.blinking{ -webkit-animation:blink 1s ease-in-out infinite alternate; -moz-animation:blink 1s ease-in-out infinite alternate; animation:blink 1s ease-in-out infinite alternate; } @-webkit-keyframes blink{ 0% {opacity:0;} 100% {opacity:1;} } @-moz-keyframes blink{ 0% {opacity:0;} 100% {opacity:1;} } @keyframes blink{ 0% {opacity:0;} 100% {opacity:1;} }

#button1{
  border-radius:5px;
  background:#1AAB8A;
  color:#fff;
  border:none;
  position:relative;
  height:35px;
  font-size:1.3em;
  padding:0 1em;
  cursor:pointer;
  transition:800ms ease all;
  outline:none;
  
}
#button1:hover{
  background:#fff;
  color:#1AAB8A;
}

.delinput {  border:0; background-color: transparent; color: #999;
font-size: 12px;line-height: 40px;width: 30px;height: 40px;text-align: center;
font-family: "Font Awesome 5 Free"; font-weight: 400; font-style: normal;
font-variant: normal;text-rendering: auto;
-webkit-font-smoothing: antialiased;}
input:focus {
	outline: none;
}
select:focus {
	outline: none;
}

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

function loginChk(){
	alert("로그인이 필요합니다.");
	location.href='login_loginform.do';
}

</script>
<style type="text/css">
li {list-style: none; display:inline; padding: 6px;}

</style>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script type="text/javascript">
var element = $(".blink");
var shown = true;
setInterval(toggle, 500);
function toggle() {

   if(shown) {

       element.hide();

       shown = false;

   } else {

       element.show();

       shown = true;

   }

}

</script>
</head>
<body>
 <jsp:include page="../main/header.jsp"></jsp:include>

			<div class="container">
				<header>
						<h1 style=" font-size: 19.8px; font-weight:600; color: #363636; float: left;">Event page</h1> 
						<em style=" font-style:normal;  font-size: 14.8px; font-weight:600;  color: #1AAB8A; padding: 3px 3px;  " >${count }</em>
						
						
				</header>
				<hr/>
				
				<section id="container">
					<form role="form" method="get">
							<table class="table table-hover">
								<thead>
									<tr>
										<th><input id="allCheck" type="checkbox" name="allCheck"/> </th>
										<th style=" font-size: 14px; font-weight: 680; font-size: 13px; color: #363636; ">글쓴이</th>
										<th style=" font-size: 14px; font-weight: 680; font-size: 13px; color: #363636; ">제목</th>
										<th style=" font-size: 14px; font-weight: 680; font-size: 13px; color: #363636; ">시작일</th>
										<th style=" font-size: 14px; font-weight: 680; font-size: 13px; color: #363636; ">종료일</th>
										<th style=" font-size: 14px; font-weight: 680; font-size: 13px; color: #363636; ">종료일 까지</th>
									</tr>
								</thead>
								<c:choose>
								<c:when test="${empty list }">
								해당 글이 존재 하지 않습니다.
								</c:when>
								
								<c:otherwise>
								<c:forEach items="${list }" var="dto">
									<tr>
										<td style=" font-size: 13px; font-weight:600; color: #36363666;"><input name="RowCheck" type="checkbox" value="${dto.event_no }"/></td>
										<td style=" font-size: 13px; font-weight:600; color: #36363666;">admin</td>
										<td >
											<a style=" font-size: 13px; font-weight: 680; font-size: 13px; color: #363636; " href="event_view.do?event_no=${dto.event_no }">${dto.event_title }</a>
										</td>
										
										<td style="font-size: 13px; font-weight:600; color: #36363666;">${dto.event_start}</td>
										<td style=" font-size: 13px; font-weight:600; color: #36363666;">${dto.event_end}</td>
										<td>
					<jsp:useBean id="today" class="java.util.Date" />
					<fmt:parseNumber value="${today.time / (1000*60*60*24)}" integerOnly="true" var="nowDate" scope="request" />
					<fmt:parseDate var="dateString" value="${dto.event_end}" pattern="yyyy-MM-dd" />
					<fmt:parseNumber value="${dateString.time / (1000*60*60*24)}" integerOnly="true" var="endDate" scope="request" />
												
												<c:choose>
						<c:when test="${endDate-nowDate > 0 &&  endDate-nowDate <=6 }">
							<div class="image blinking" style="font-weight: 680; font-size: 13px; color: #1AAB8A; ">D-${endDate-nowDate }</div></c:when>
							
							<c:when test="${endDate-nowDate < 0}">
							<div style="font-weight: 680; font-size: 13px; color: #999; ">종료됨</div>
							</c:when>
							
							<c:when test="${endDate-nowDate == 0}">
							<div class="image blinking" style="font-weight: bold; color: #1AAB8A;" >D-DAY</div>
							</c:when>
							
						<c:otherwise>
							<div style="font-weight: 680; font-size: 13px; color: #999; ">D-${endDate-nowDate }</div>
						</c:otherwise>
				</c:choose>
										
										</td>
						</tr>
								</c:forEach>
								</c:otherwise>
							</c:choose>	
							</table>
							
	<div class="search" style="font-weight: 680; font-size: 15px; color: #999; ">
    <select name="searchType" style="border-radius: 20px; border: 1px solid #999;">
      <option style="font-weight: 650; font-size: 13px; color: #999; " value="n"<c:out  value="${scri.searchType == null ? 'selected' : ''}"/>>전체보기</option>
      <option  style="font-weight: 650; font-size: 13px; color: #999; "value="t"<c:out value="${scri.searchType eq 't' ? 'selected' : ''}"/>>제목</option>
      <option  style="font-weight: 650; font-size: 13px; color: #999; "value="c"<c:out value="${scri.searchType eq 'c' ? 'selected' : ''}"/>>내용</option>
      <option  style="font-weight: 650; font-size: 13px; color: #999; "value="tc"<c:out value="${scri.searchType eq 'tc' ? 'selected' : ''}"/>>제목+내용</option>
    </select>
   
<input type="text" name="keyword" id="keywordInput" value="${scri.keyword}" style="border-radius: 20px; border: 1px solid #999;"/>
    <button id="searchBtn" type="button" style="border: 0; outline: 0; background-color:transparent;"><i class="fa fa-search" style="size: 30%; color: #999;"></i></button>
    
    
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
	<div align="right">
				<c:if test="${memberdto.member_role eq 0 }">
					<div align="right" id="post">
					<input type="button"  id="button1"  value="글 작성 "  onclick="location.href='event_insertform.do'"/>
					</div>
					<br/>
					<div>
						<button type="button" class="delinput"   onclick="deleteValue();" ><i class="fas fa-trash-alt"></i></button>
					</div>
				</c:if>
			</div>
  <ul>
    <c:if test="${pageMaker.prev}">
    	<li><a style=" font-size: 14px; font-weight: 680; font-size: 13px; color: #363636; " href="event_list.do${pageMaker.makeQuery(pageMaker.startPage - 1)}">이전</a></li>
    </c:if> 
    <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
    	<li><a style=" font-size: 14px; font-weight: 680; font-size: 13px; color: #363636; " href="event_list.do${pageMaker.makeQuery(idx)}">${idx}</a></li>
    </c:forEach>
    <c:if test="${pageMaker.next && pageMaker.endPage > 0}">
    	<li><a style=" font-size: 14px; font-weight: 680; font-size: 13px; color: #363636; " href="event_list.do${pageMaker.makeQuery(pageMaker.endPage + 1)}">다음</a></li>
    </c:if> 
  </ul>
</div>
				</form>
			</section>
		</div>
		
<script type="module" src="resources/js/app.js"></script>
		
	</body>
</html>