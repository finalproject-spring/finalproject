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


	<table border="1">
		<col width="6">
		<col width="50" />
		<col width="100" />
		<col width="500" />
		<col width="150" />
		<col width="60" />
		
		<thead>
			<tr>
				<th><input id="allCheck" type="checkbox" name="allCheck"/> </th>
				<th>번호</th>
				<th>작성자</th>
				<th>제목</th>
				<th>작성일</th>
				<th>조회수</th>
			</tr>
			
			<c:choose>
				<c:when test="${empty list }">
					<tr>
						<td colspan="6" align="center">--------작성된 글이 없습니다--------</td>
					</tr>
				</c:when>

				<c:otherwise>
					<c:forEach items="${list }" var="dto">
						<tr>
							<td><input name="RowCheck" type="checkbox" value="${dto.board_no }"/></td>
							<td>${dto.board_no }</td>
							<td>${dto.board_id }</td>
							<td><a href="group_view.do?board_no=${dto.board_no }">${dto.board_title }</a></td>
							<td><fmt:formatDate value="${dto.board_date}"
									pattern="yyyy-MM-dd" /></td>
							<td>${dto.board_views }</td>
						</tr>
					</c:forEach>
				</c:otherwise>
			</c:choose>
		</thead>
		
		<tr>
			<td colspan="6" align="right"><input type="button" value="글작성"
				onclick="location.href='group_insertform.do'" />
				<input type="button" value="선택삭제"
				onclick="deleteValue();" />
			</td>
				
		</tr>
	</table>
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
	var url = "group_selectdelete.do";
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
					location.replace("group_list.do")
				}
				else{
					alert("삭제 실패");
				}
			}		
			
		});
		
	}
}




</script>
</body>
</html>