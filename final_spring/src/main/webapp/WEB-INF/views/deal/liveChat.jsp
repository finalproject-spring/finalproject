<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Chatting</title>
<style type="text/css">

body{
    font-family: "Roboto", sans-serif;
}
.message .sent{
	text-align: right;
	border: 0px;
	padding: 0px;
}
.nomy{
	text-align: left;
	border: 0px;
	padding: 0px;
}

.back{
    width: 530px;
    height: 830px;
    position: relative;
    margin: 40px auto; 
    background-color:black;
    border-radius: 30px;
}

.conversation{
    top: 40px;
    width: 500px;
    height: 730px;
    position: relative;
    background: #efe7dd url(https://cloud.githubusercontent.com/assets/398893/15136779/4e765036-1639-11e6-9201-67e728e86f39.jpg) repeat;
    z-index: 0;
    margin: 40px auto;
}

#messages{
    height: 650px;
    box-shadow: inset 0 10px 10px -10px #000000;
    overflow-x: hidden;
    padding: 0 16px;
    margin: 0px auto;
    
}

.conversation ::-webkit-scrollbar {
  transition: all .5s;
  width: 11px;
  height: 1px;
  z-index: 10;
}

.conversation ::-webkit-scrollbar-track {
  background: transparent;
}

.conversation ::-webkit-scrollbar-thumb {
  background: #b3ada7;
}


div {
    display: block;
}

.message.sent:after {
    border-width: 0px 0 10px 10px;
    border-color: transparent transparent transparent #e1ffc7;
    top: 0;
    right: -10px;
}

.message:after {
    position: absolute;
    content: "";
    width: 0;
    height: 0;
    border-style: solid;
}

.message.sent {
    background: #e1ffc7;
    border-radius: 5px 0px 5px 5px;
    float: right;
}

.message:first-child {
    margin: 16px 0 8px;
}

.message {
    color: #000;
    clear: both;
    line-height: 18px;
    font-size: 15px;
    padding: 8px;
    position: relative;
    margin: 8px 0;
    max-width: 85%;
    word-wrap: break-word;
    z-index: -1;
}

.message.received {
    background: #cae5fedb;
    border-radius: 0px 5px 5px 5px;
    float: left;
}

.message.received:after {
    border-width: 0px 10px 10px 0;
    border-color: transparent #cae5fedb transparent transparent;
    top: 0;
    left: -10px;
}

.exit{
    width: 140px;
    margin-left: 20px;
}

.exit-btn{
    padding: 5px 8px;
    font-size: 15px;
    line-height: 1.33;
    border-radius: 6px;
    color: #fff;
    background-color: #428bca;
    border-color: #357ebd;
}

.message-input{
	margin: 0px auto;
    
    display: flex;
    flex-direction: row;
    align-items: flex-end;
    overflow: hidden;
    height: 50px;
    width: 100%;
    z-index: 2;
}

.input-msg{
    border: 0;
    flex: 1 1 auto;
    font-size: 16px;
    margin: 0;
    outline: none;
    min-width: 50px;
    height:33px;
}

.input-msg:after{
	border-width: 0px 10px 10px 0;
    border-color: transparent #fff transparent transparent;
    top: 0;
    left: -10px;
}

.send{
	background: transparent;
    border: 0;
    cursor: pointer;
    flex: 0 0 auto;
    margin-left: 8px;
    margin-right: 8px;
    padding: 0;
    position: relative;
    outline: none;
    height: 53px;
}

.circle{
	background: #428bca;
    border-radius: 50%;
    color: #fff;
    position: relative;
    width: 48px;
    height: 48px;
    display: flex;
    align-items: center;
    justify-content: center;
    cursor:pointer;
    box-shadow: 1px 2px 2px black;
}

.circle:active{
    background-color: #396f9e;
}



.circle i{
    font-size: 24px;
    display: inline-block;
    font: normal normal normal 14px/1 'Material-Design-Iconic-Font';
    font-size: inherit;
    text-rendering: auto;
    -webkit-font-smoothing: antialiased;
}

.circle i:before{
	content: '전송';
}



</style>
</head>
<body>
 <jsp:include page="../main/header.jsp"></jsp:include>
 	<div class="back">
	    <div class="conversation">
	        <div id="messages">
	    	</div>
	    	<div class="message-input">
	        	<div class="exit">
	        		<button class="exit-btn" type="button" onclick="closeSocket();">대화방 나가기</button>
	       		</div>
				<input type="text" id="sender" value="${id}" style="display: none;">
				<input type="text" id="room" value="${room}" style="display: none;">
				<input class="input-msg" type="text" id="messageinput" >
				<button class="send" onclick="send();">
	                <div class="circle">
	                   <i class="zmdi zmdi-mail-send"></i>
	                </div>
	            </button>
	   		</div>
	    </div>
	</div>
    <script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script type="text/javascript">
        var ws;
        var messages = document.getElementById("messages");
        $.ajax({
        	url: "getChat.do",
        	type: "post",
        	data: {
        		room: document.getElementById("room").value
        	},
        	success: function(list){
        		console.log(list)
        		var id = document.getElementById("sender").value;
        		for(let a = list.length-1; a >= 0; a--){
        			if (list[a].chat_id == id){
        				messages.innerHTML += "<div class='message sent'> \< 나 \> : " + list[a].message + "</div>";
        			} else{
        				messages.innerHTML += "<div class='message received'> \<\ " + list[a].chat_id + " \> : " + list[a].message + "</div>";
        			}
        		}
        	}
        	
        })
        
        window.onload = function() { // 페이지 로딩 후 함수 실행
            if(ws !== undefined && ws.readyState !== WebSocket.CLOSED ){
                writeResponse("웹 소켓 열 준비 완료");
                return;
            }
            //웹소켓 객체 만드는 코드 // webSocketHandler로 경로가 잡혀있다.
            var id = document.getElementById("sender").value;
            var room = document.getElementById("room").value;
            // 이 경로는 웹소켓 오픈용 경로로 일반적인 방법으로 확인 불가
            var host = $(location).attr('host');
            host = "ws://" + host + "/recycle/roomChat.do";
            ws = new WebSocket(host + "?id=" + id + "&room=" + room);
            
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
        	var conversation = document.querySelector('#messages');
        	
        	if (text.split(":")[0] == '<나> ') {
            	messages.innerHTML += "<div class='message sent'>" + text + "</div>";
        	} else {
            	messages.innerHTML += "<div class='message received'>" + text + "</div>";
        	}
        	
        	conversation.scrollTop = conversation.scrollHeight;
        }
        
  </script>
</body>
</html>