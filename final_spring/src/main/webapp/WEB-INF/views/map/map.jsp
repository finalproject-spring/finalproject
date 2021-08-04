<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
#mapDiv{
width: 100%;
height: 90%;
}
#Div{
height: 600px;
}
#map{
margin: auto !important;
}
#title{
width: 100%;
text-align: center;
}


#button1{
  border-radius:5px;
  background:#1AAB8A;
  color:#fff;
  border:none;
  position:relative;
  height:29px;
  font-size: 14px;
  padding:0 1em;
  cursor:pointer;
  transition:800ms ease all;
  outline:none;
  
}
#button1:hover{
  background:#fff;
  color:#1AAB8A;
}

</style>
</head>
<body>
<jsp:include page="../main/header.jsp"></jsp:include>

<div id="Div">
	<div>
		<h1 id="title">안심식당 지도</h1>
		<br/>
		<div align="center">코로나 방역 수칙을 준수하는 안심 식당을 찾아보세요 !</div>
		<br/>
		<div align="center">
			<select id="si">
				<option value="">시도 선택</option>
				<option value="강원도">강원도</option>
				<option value="경기도">경기도</option>
				<option value="경상남도">경상남도</option>
				<option value="경상북도">경상북도</option>
				<option value="광주광역시">광주광역시</option>
				<option value="대구광역시">대구광역시</option>
				<option value="대전광역시">대전광역시</option>
				<option value="부산광역시">부산광역시</option>
				<option value="서울특별시">서울특별시</option>
				<option value="세종특별자치시">세종특별자치시</option>
				<option value="울산광역시">울산광역시</option>
				<option value="인천광역시">인천광역시</option>
				<option value="전라남도">전라남도</option>
				<option value="전라북도">전라북도</option>
				<option value="제주특별자치도">제주특별자치도</option>
				<option value="충청남도">충청남도</option>
				<option value="충청북도">충청북도</option>
			</select>
			<select id="sido">
				<option value="">시군구 선택</option>
			</select>
			<input type="button" id="button1" onclick="getMark()" value="매장 찾기">
		</div>
	</div>
	<br/><br/>
	<div id="mapDiv">
		<div id="map" style="width:60%;height:100%; "></div>
	</div>
	<br/>
</div>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=0de40a60d12f258f54d00b3ac0d3780b&libraries=services,clusterer"></script>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script type="text/javascript">
/* var 재선언, 재할당 가능
 * let 재할당 가능, 재선언 불가능
 * const 재할당, 재선언 불가능 */
let container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
let options = { //지도를 생성할 때 필요한 기본 옵션
	center: new kakao.maps.LatLng(37.564214, 127.001699), //지도의 중심좌표.
	level: 5 //지도의 레벨(확대, 축소 정도)
};
let map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴

if (navigator.geolocation) {
	navigator.geolocation.getCurrentPosition(function(position) {
		var lat = position.coords.latitude; // 위도
		var lon = position.coords.longitude; // 경도
		options['center'] = new kakao.maps.LatLng(lat, lon);
		map = new kakao.maps.Map(container, options);
	})
}

// si 옵션 변경시 실행
$("#si").change(function() {
	let si = $("#si").val();
	// sido 옵션 초기화
	$("#sido option").remove();
	// sido 기본틀 잡기
	$("#sido").append("<option value=''>시군구 선택</option>");
	// si 선택에 따라 sido 설정
	switch(si){
	case "강원도":
		var list = ["강릉시", "고성군", "동해시", "삼척시", "속초시", "양구군", "양양군", "영월군", "원주시", "인제군", "정선군", "철원군", "춘천시", "태백시", "평창군", "홍천군", "화천군", "횡성군"];
		for(var a = 0; a < list.length; a++){
			$("#sido").append("<option value='" + list[a] + "'>" + list[a] + "</option>");
		}
		break;
	case "경기도":
		var list = ["가평군", "고양시", "과천시", "광명시", "광주시", "구리시", "군포시", "김포시", "남양주시", "동두천시", "부천시", "성남시", "수원시", "시흥시", "안산시", "안성시", "안양시", "양주시", "양평군", "여주시", "연천군", "오산시", "용인시", "의왕시", "의정부시", "이천시", "파주시", "평택시", "포천시", "하남시", "화성시"];
		for(var a = 0; a < list.length; a++){
			$("#sido").append("<option value='" + list[a] + "'>" + list[a] + "</option>");
		}
		break;
	case "경상남도":
		var list = ["거제시", "거창군", "고성군", "김해시", "남해군", "밀양시", "사천시", "산청군", "양산시", "의령군", "진주시", "창녕군", "창원시", "통영시", "하동군", "함안군", "함양군", "합천군"];
		for(var a = 0; a < list.length; a++){
			$("#sido").append("<option value='" + list[a] + "'>" + list[a] + "</option>");
		}
		break;
	case "경상북도":
		var list = ["경산시", "경주시", "고령군", "구미시", "군위군", "김천시", "문경시", "봉화군", "상주시", "성주군", "안동시", "영덕군", "영양군", "영주시", "영천시", "예천군", "울릉군", "울진군", "의성군", "청도군", "청송군", "칠곡군", "포항시"];
		for(var a = 0; a < list.length; a++){
			$("#sido").append("<option value='" + list[a] + "'>" + list[a] + "</option>");
		}
		break;
	case "광주광역시":
		var list = ["광산구", "남구", "동구", "북구", "서구"];
		for(var a = 0; a < list.length; a++){
			$("#sido").append("<option value='" + list[a] + "'>" + list[a] + "</option>");
		}
		break;
	case "대구광역시":
		var list = ["남구", "달서구", "달성군", "동구", "북구", "서구", "수성구", "중구"];
		for(var a = 0; a < list.length; a++){
			$("#sido").append("<option value='" + list[a] + "'>" + list[a] + "</option>");
		}
		break;
	case "대전광역시":
		var list = ["대덕구", "동구", "서구", "유성구", "중구"];
		for(var a = 0; a < list.length; a++){
			$("#sido").append("<option value='" + list[a] + "'>" + list[a] + "</option>");
		}
		break;
	case "부산광역시":
		var list = ["강서구", "금정구", "기장군", "남구", "동구", "동래구", "부산진구", "북구", "사상구", "사하구", "서구", "수영구", "연제구", "영도구", "중구", "해운대구"];
		for(var a = 0; a < list.length; a++){
			$("#sido").append("<option value='" + list[a] + "'>" + list[a] + "</option>");
		}
		break;
	case "서울특별시":
		var list = ["강동구", "강서구", "관악구", "광진구", "구로구", "도봉구", "동작구", "마포구", "서대문구", "서초구", "성동구", "성북구", "양천구", "영등포구", "은평구", "종로구", "중구", "중랑구"];
		for(var a = 0; a < list.length; a++){
			$("#sido").append("<option value='" + list[a] + "'>" + list[a] + "</option>");
		}
		break;
	case "세종특별자치시":
		var list = ["세종시"];
		for(var a = 0; a < list.length; a++){
			$("#sido").append("<option value='" + list[a] + "'>" + list[a] + "</option>");
		}
		break;
	case "울산광역시":
		var list = ["남구", "동구", "북구", "울주군", "중구"];
		for(var a = 0; a < list.length; a++){
			$("#sido").append("<option value='" + list[a] + "'>" + list[a] + "</option>");
		}
		break;
	case "인천광역시":
		var list = ["강화군", "계양구", "남동구", "동구", "미추홀구", "부평구", "서구", "연수구", "옹진군", "중구"];
		for(var a = 0; a < list.length; a++){
			$("#sido").append("<option value='" + list[a] + "'>" + list[a] + "</option>");
		}
		break;
	case "전라남도":
		var list = ["강진군", "고흥군", "곡성군", "광양시", "구례군", "나주시", "담양군", "목포시", "무안군", "보성군", "순천시", "신안군", "여수시", "영광군", "영암군", "완도군", "장성군", "장흥군", "진도군", "함평군", "해남군", "화순군"];
		for(var a = 0; a < list.length; a++){
			$("#sido").append("<option value='" + list[a] + "'>" + list[a] + "</option>");
		}
		break;
	case "전라북도":
		var list = ["고창군", "군산시", "김제시", "남원시", "무주군", "부안군", "순창군", "완주군", "익산시", "임실군", "장수군", "전주시", "정읍시", "진안군"];
		for(var a = 0; a < list.length; a++){
			$("#sido").append("<option value='" + list[a] + "'>" + list[a] + "</option>");
		}
		break;
	case "제주특별자치도":
		var list = ["서귀포시", "제주시"];
		for(var a = 0; a < list.length; a++){
			$("#sido").append("<option value='" + list[a] + "'>" + list[a] + "</option>");
		}
		break;
	case "충청남도":
		var list = ["계룡시", "공주시", "금산군", "논산시", "당진시", "보령시", "부여군", "서산시", "서천군", "아산시", "예산군", "천안시", "청양군", "태안군", "홍성군"];
		for(var a = 0; a < list.length; a++){
			$("#sido").append("<option value='" + list[a] + "'>" + list[a] + "</option>");
		}
		break;
	case "충청북도":
		var list = ["괴산군", "단양군", "보은군", "영동군", "옥천군", "음성군", "제천시", "증평군", "진천군", "청주시", "충주시"];
		for(var a = 0; a < list.length; a++){
			$("#sido").append("<option value='" + list[a] + "'>" + list[a] + "</option>");
		}
		break;
	}
})
// 인포윈도우를 표시하는 클로저를 만드는 함수입니다 
function makeOverListener(map, marker, infowindow) {
    return function() {
        infowindow.open(map, marker);
    };
}

// 인포윈도우를 닫는 클로저를 만드는 함수입니다 
function makeOutListener(infowindow) {
    return function() {
        infowindow.close();
    };
}

function getMark(){
	// 값 가져오기
	let si = $("#si").val();
	let sido = $("#sido").val();
	// 유효성 검사
	if(si == " " || si == "" || si == null){
		alert("시도를 선택해 주세요.");
		return;
	}
	if(sido == " " || sido == "" || sido == null){
		alert("시군구를 선택해 주세요.");
		return;
	}
	
	var data = {"si" : si, "sido" : sido};
	$.ajax({
		url:'data.do',
		type: 'post',
		data: data,
		dataType: 'json',
		success: function(datas){
			var markers = new Array(); // 마커 변수
			var geocoder = new kakao.maps.services.Geocoder(); // 카카오에서 지원하는 라이브러리
			var clusterer = new kakao.maps.MarkerClusterer({
				map: map, // 마커들을 클러스터로 관리하고 표시할 지도 객체 
				averageCenter: true, // 클러스터에 포함된 마커들의 평균 위치를 클러스터 마커 위치로 설정 
				minLevel: 5 // 클러스터 할 최소 지도 레벨 
			});
			for(let a = 0; a < datas.length; a++){ // 마커 저장
				// &libraries=services 를 추가해 받아와야 사용 가능
				geocoder.addressSearch(datas[a]['addr'], function(result, status) {
					if (status === kakao.maps.services.Status.OK) { // 정상적으로 검색이 완료됐으면 
						var latlng = new kakao.maps.LatLng(result[0].y, result[0].x);
						var marker = new kakao.maps.Marker({
							map: map,
							position: latlng
						});
						markers.push(marker); // let 형태의 markers에 마커 담기
						clusterer.addMarkers(markers); // 클러스터에 마커들 표시하기
						
						// 인포윈도우로 장소에 대한 설명을 표시합니다
						var infowindow = new kakao.maps.InfoWindow({
							content: '<div style="width:150px;text-align:center;padding:6px 0;">'  + datas[a]['name'] + '</div>'
						});
					    kakao.maps.event.addListener(marker, 'mouseover', makeOverListener(map, marker, infowindow));
					    kakao.maps.event.addListener(marker, 'mouseout', makeOutListener(infowindow));
				    } 
				});
			};
		}, error: function(){
			alert('통신실패!');
		}
	})
}

















</script>

</body>
</html>