<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Chatting</title>
<style type="text/css">
.my{
text-align: right;
border: 0px;
padding: 0px;
}
.nomy{
text-align: left;
border: 0px;
padding: 0px;
}
#messages{
width: 50%
}

</style>
</head>
<body>
    <div>
    	<div>
        	<button type="button" onclick="closeSocket();">대회방 나가기</button>
        </div>
        <div>
			<input type="text" id="sender" value="${sessionScope.id}" style="display: none;">
			<input type="text" id="room" value="${room}" style="display: none;">
			메세지 입력 : <input type="text" id="messageinput"><input type="button" value="메세지 전송" onclick="send();">
        </div>
    </div>
    <div id="messages">
    </div>
    <script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script type="text/javascript">
        var ws;
        var messages = document.getElementById("messages");
        
        window.onload = function() { // 페이지 로딩 후 함수 실행
            if(ws !== undefined && ws.readyState !== WebSocket.CLOSED ){
                writeResponse("웹 소켓 열 준비 완료");
                return;
            }
            //웹소켓 객체 만드는 코드 // webSocketHandler로 경로가 잡혀있다.
            var id = document.getElementById("sender").value;
            var room = document.getElementById("room").value;
            // 이 경로는 웹소켓 오픈용 경로로 일반적인 방법으로 확인 불가
            ws = new WebSocket("ws://localhost:8787/recycle/roomChat.do?id=" + id + "&room=" + room);
            
            ws.onopen = function(event){
                if(event.data === undefined){
              		return;
                }
                writeResponse(event.data);
            };
            
            ws.onmessage = function(event){
                console.log('writeResponse');
                console.log(event.data)
                writeResponse(event.data);
            };
            
            ws.onclose = function(event){
                writeResponse("대화 종료");
            }
            
        }
        
        function send(){
            //var text = document.getElementById("messageinput").value + "," + document.getElementById("sender").value;
            var message = document.getElementById("messageinput").value;
            var sender = document.getElementById("sender").value;
            var room = document.getElementById("room").value;
            ws.send(message + "," + sender);
            document.getElementById("messageinput").value = "";
            var data = {
            	message: message,
				sender: sender,
				room: room
            }
            $.ajax({
                url: "insertChat.do",
                type: "POST",
                data: {
                	message: message,
                	sender: sender,
                	room: room
                }
            });
        }
        
        function closeSocket(){
            ws.close();
            history.back();
        }
        
        function writeResponse(text){
        	// messages 에 html을 넣는다
        	// 넘어온 text에 <나> 가 포함된다면 class가 my 또는 nomy 가 붙어 출력된다.
        	if (text.split(":")[0] == '<나>') {
            	messages.innerHTML += "<div class='my'>" + text + "</div>";
        	} else {
            	messages.innerHTML += "<div class='nomy'>" + text + "</div>";
        	}
        }
        
  </script>
</body>
</html>