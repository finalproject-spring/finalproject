<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">

	.main{
		width:100%;
		height:100px;
		margin:auto;
		text-align:center;
	}
	
	#webcam-container{
		width: 560px;	
		height: 212px;
		margin-top: 20px;
		border: 4px dashed #1FB264;
	}
	
	canvas{
		margin: 2px;
		border-radius: 10px;
	}
	
	.wb-container{
		width: 150px;
		height:40px;
		margin: 15px auto;
		
	}
	
	.inner-bar-0, .inner-bar-1, .inner-bar-2{
		border-radius: 4px;
	    padding: 5px;
	    border: none;
	    outline: none;
	    text-transform: uppercase;
	    font-weight: 700;
	}
	
	.inner-bar-0{
		background-color: #1FB264;
		border-bottom: 4px solid #15824B;
	}
	
	.inner-bar-1{
		background-color: #d4e2ff;
		border-bottom: 4px solid #a0b9ed;
	}
	
	.inner-bar-2{
		background-color: #ffe98b;
		border-bottom:4px solid #e6d178;
	}
	
	.box-container{
		width : 1100px;
		height : 800px;
		border: 1px solid green;
		margin : 0px auto;
	}
	
	.left-box{
		width:400px;
		height:500px;
		display:inline-block;
		margin:25px;
	}
	
	.right-box{
		width:560px;
		height:500px;
		display:inline-block;
		position: absolute;
		margin:25px;
	}
	
	.webcam-start-btn {
	  width: 100%;
	  margin: 0;
	  color: #fff;
	  background: #1FB264;
	  border: none;
	  padding: 10px;
	  border-radius: 4px;
	  border-bottom: 4px solid #15824B;
	  transition: all .2s ease;
	  outline: none;
	  text-transform: uppercase;
	  font-weight: 700;
	}
	
	.webcam-start-btn:hover {
	  background: #1AA059;
	  color: #ffffff;
	  transition: all .2s ease;
	  cursor: pointer;
	}
	
	.webcam-start-btn:active {
	  border: 0;
	  transition: all .2s ease;
	}
	
	.footer-box{
		width: 1000px;
	    margin-left: 250px;
		
	}
	.glass, .plastic, .paper{
		display: inline-block;
		width : 200px;
		height: 175px;
		margin: 0px 70px 0px 0px;
	}
	
	.glass{
	}
	
	.plastic{
	}
	
	.paper{
	}
	
	.upload-btn{
		  margin: 10px;
		  color: #fff;
		  background: #1FB264;
		  border: none;
		  border-radius: 4px;
		  border-bottom: 4px solid #15824B;
		  transition: all .2s ease;
		  outline: none;
		  text-transform: uppercase;
		  font-weight: 700;
	}
	
	.title{
		font-size: 40px;
	    font-weight: 700;
	    height: 180px;
	    line-height: 180px;
	}
	
</style>
</head>
<body>

<jsp:include page="../main/header.jsp"></jsp:include>

	<div align="center" class="title">분리수거 도우미</div>

	<div class="box-container">
	
		<div class="left-box">
			<img alt="man" src="https://i.pinimg.com/originals/40/6a/a2/406aa2aee1465be6404d7ebf0ffdab24.png">
		</div>
		
		<div class="right-box">
			<div class="main">
				<div class="main-text">분리수거를 도와주는 기능입니다.</div>
				<button class="upload-btn" type="button" onclick="location.href='upload.do'">업로드 방식</button>
				<button class="webcam-start-btn" type="button" onclick="init()">Start</button>
				
				<div id="webcam-container"></div>
			</div>
		</div>
		
		<div class="footer-box">
			<div class="glass">
			</div>
			
			<div class="plastic">
				<img alt="플라스틱" src="https://image.flaticon.com/icons/png/512/4380/4380438.png" width="200" height="175"/>
			</div>
			
			<div class="paper">
				<img alt="종이" src="https://image.flaticon.com/icons/png/512/889/889648.png" width="200" height="175"/>
			</div>
			
 		</div>
	
		
		<div id="label-container"></div>
		
		<script src="https://cdn.jsdelivr.net/npm/@tensorflow/tfjs@1.3.1/dist/tf.min.js"></script>
		<script src="https://cdn.jsdelivr.net/npm/@teachablemachine/image@0.8/dist/teachablemachine-image.min.js"></script>
		<script type="text/javascript">
		
		    // More API functions here:
		    // https://github.com/googlecreativelab/teachablemachine-community/tree/master/libraries/image
		
		    // the link to your model provided by Teachable Machine export panel
		    const URL = "./resources/my_model/";
		
		    let model, webcam, labelContainer, maxPredictions, container, classes;
		
		    // Load the image model and setup the webcam
		    async function init() {
		        /* const modelURL = URL + "model.json";
		        const metadataURL = URL + "metadata.json"; */
		        const modelURL = "resources/my_model/model.json";
		        const metadataURL ="resources/my_model/metadata.json";
		
		        // load the model and metadata
		        // Refer to tmImage.loadFromFiles() in the API to support files from a file picker
		        // or files from your local hard drive
		        // Note: the pose library adds "tmImage" object to your window (window.tmImage)
		        model = await tmImage.load(modelURL, metadataURL);
		        maxPredictions = model.getTotalClasses();
		
		        // Convenience function to setup a webcam
		        const flip = true; // whether to flip the webcam
		        webcam = new tmImage.Webcam(200, 200, flip); // width, height, flip
		        await webcam.setup(); // request access to the webcam
		        await webcam.play();
		        window.requestAnimationFrame(loop);
		
		        // append elements to the DOM
		        document.getElementById("webcam-container").appendChild(webcam.canvas);
		        // labelContainer = document.getElementById("label-container");
		        for (let i = 0; i < maxPredictions; i++) { // and class labels
		        //    labelContainer.appendChild(document.createElement("div"));
		        }
		        
		        recycle = ['glass', 'plastic', 'paper']
		        classes = new Array();
		        for(let i = 0; i < maxPredictions; i ++){
		        	var box = document.getElementsByClassName(recycle[i])[0];
		        	container = document.createElement('div');
	        	    container.className = "wb-container";
		  	       
		        	classes[i] = document.createElement('div');
		        	classes[i].className = 'inner-bar-' + i;
		        	
		        	//$("body").append(container)
		        	box.appendChild(container);
		        	container.appendChild(classes[i]);
		        }
		        
		    }
		
		    async function loop() {
		        webcam.update(); // update the webcam frame
		        await predict();
		        window.requestAnimationFrame(loop);
		    }
		
		    // run the webcam image through the image model
		    async function predict() {
		        // predict can take in an image, video or canvas html element
		        const prediction = await model.predict(webcam.canvas);
		        for (let i = 0; i < maxPredictions; i++) {
		            const classPrediction =
	                prediction[i].className + ": " + prediction[i].probability.toFixed(2);
		           // labelContainer.childNodes[i].innerHTML = classPrediction;
		            classes[i].style.width = (prediction[i].probability.toFixed(4) * 100) + "%";
		            classes[i].innerHTML = (prediction[i].probability * 100).toFixed(2) + "%";
		        }
		    }
		</script>
	</div>

	
	<jsp:include page="../main/footer.jsp"></jsp:include>

</body>
</html>