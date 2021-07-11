<%@page import="com.spring.recycle.model.biz.MemberBizImpl"%>
<%@page import="com.spring.recycle.model.biz.MemberBiz"%>
<%@page import="com.spring.recycle.model.dto.MemberDto"%>
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

	function memberDelete() {
		var url = "admin_memberSelectDelete.do";
		var Arr = new Array();
		var list = $("input[name='chks']");
		for(var i = 0; i<list.length; i++){
			if(list[i].checked){
				Arr.push(list[i].value);
			}
		}
		
		if (Arr.length == 0) {
			alert("선택된 회원이 없습니다.")
		} else {
			if (confirm("선택한 회원을 정말 탈퇴시키겠습니까?") == true) {
				$.ajax({
					url : url,
					type : 'POST',
					data : {Arr : Arr},
					traditional : true,
					success: function(data){

					},
					complete: function(data){
						alert("탈퇴가 완료되었습니다.");
						location.replace("admin_memberList.do");
					}
				});
			}
		}
	}

</script>
</head>
<body>
 <jsp:include page="../main/header.jsp"></jsp:include>
	<div class="container">
		<header>
			<h1>회원 조회</h1>
		</header>
		<div>전체 회원 ${count}명</div>
		<div align="right"><input type="button" value="회원 삭제" onclick="memberDelete();"/></div>
		<table class="table" style="table-layout:fixed">
			<col width="30px"/>
			<col width="40px"/>
			<col width="50px"/>
			<col width="50px"/>
			<col width="110px"/>
			<col width="80px"/>
			<col width="160px"/>
			<col width="48px"/>
			<tr>
				<td><input type="checkbox" id="allCheck"/></td>
				<th>번호</th>
				<th>아이디</th>
				<th>이름</th>
				<th>이메일</th>
				<th>전화번호</th>
				<th>주소</th>
				<th>탈퇴여부</th>
			</tr>
			<c:forEach items="${list }" var="dto">	
			<tr>
				<td><input type="checkbox" name="chks" value="${dto.member_no }"/></td>
				<td>${dto.member_no }</td>
				<td><a href='admin_memberDetail.do?member_no=${dto.member_no }'>${dto.member_id }</a></td>
				<td>${dto.member_name }</td>
				<td>${dto.member_email }</td>
				<td>${dto.member_phone }</td>
				<td style="overflow:hidden;white-space:nowrap;text-overflow:ellipsis; max-width:450px;">${dto.member_addr }</td>
				<td>
					<c:choose>
						<c:when test="${dto.member_delete eq '1'}">
						탈퇴
						</c:when>
						<c:otherwise></c:otherwise>
					</c:choose>
				</td>
			</tr>
			</c:forEach>
		</table>
<script type="text/javascript">
	$("input:checkbox[id='allCheck']").click(function(){
		if($("input:checkbox[id='allCheck']").is(":checked") == true) {
			$("input[type=checkbox]").prop("checked", true);
 		} else {
 			$("input[type=checkbox]").prop("checked",false);
 		}
	});
</script>
	
	</div>
</body>
</html>