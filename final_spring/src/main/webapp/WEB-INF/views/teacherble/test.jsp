<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300&display=swap" rel="stylesheet">
<style type="text/css">

	.main{
	    width: 730px;
    	margin: 0px auto 50px auto;
	}
	
	.webcam-container{
        width: 620px;
	    height: 950px;
	    background-color: #deebd8;
	    background-size: auto 100%, cover;
	    display: inline-block;
	    position: absolute;
	    border-radius: 20px;
	    left: 0;
	    line-height: 40px;
	    font-size : 22px;
	}
	
	canvas{
        width: 550px;
	    height: 550px;
	    border-radius: 15px;
	    border: 3px solid gray;
	    margin : 30px;
	}


	.inner-bar-0{
		background-color: #1FB264;
		border-bottom: 4px solid #15824B;
		font-family: 'Poppins', sans-serif;
	    border-radius : 20px;
	    font-size: 17px;
	    font-weight: 600;
	    color: #000000;
    	text-shadow: 0 0 black;
    	display: inline-block;
	}
	
	.inner-bar-1{
		background-color: #d4e2ff;
		border-bottom: 4px solid #a0b9ed;
		font-family: 'Poppins', sans-serif;
	    border-radius : 20px;
	    font-size: 17px;
	    font-weight: 600;
	    color: #000000;
    	text-shadow: 0 0 black;
    	display: inline-block;
	}
	
	.inner-bar-2{
		background-color: #ffe98b;
		border-bottom:4px solid #e6d178;
		font-family: 'Poppins', sans-serif;
	    border-radius : 20px;
	    font-size: 17px;
	    font-weight: 600;
	    color: #000000;
    	text-shadow: 0 0 black;
    	display: inline-block;
	}
	
	.ipad {
	    height: 1032.810px;
	    width: 698.188px;
	    line-height: 1200px;
	    border-radius: 55px;
	    background-image: linear-gradient(rgba(0, 0, 0, 0), #111), url(https://cdn.pixabay.com/photo/2020/01/21/11/40/world-4782728_640.jpg);
	    display: inline-block;
	    color: #fff;
	    text-align: center;
	    font-family: "SF Pro Display", Helvetica Neue, Arial, sans-serif;
	    letter-spacing: -0.022em;
	    font-size: 25px;
	    text-shadow: 0 0 0.5em #000;
	    background-color: #000;
	    background-size: auto 100%, cover;
	    background-repeat: no-repeat, no-repeat;
	    border: 40px solid #111;
	    position: relative;
	    box-shadow: 0 0.5em 2em 0.2em rgb(0 0 0 / 33%), 0 0 0 0.5px #000 inset;
	    transition: all 0.1s linear, line-height 0s linear;
	    background-position: 50% 100%, center;
	    transform-origin: bottom center;
	    
	}
	
	
	.ipad-content{
		display: inline-block;
		width: 600px;
		height:900px;
	
	}
	 .ipad-content:hover {
		color: transparent;
		text-shadow: 0 0 0em transparent;
		background-position: 50% -100%, center center;
		transition: all .15s linear, line-height 5s linear;
		line-height: 0vmin;
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
	
	.wb-container{
        width: 550px;
	    height: 40px;
	    margin: 20px 20px 40px 20px;
	    display: block;
	}
	
	.classname{
	    display: inline-block;
	    margin: 0px 30px;
	    text-shadow: 0 0 BLACK;
	    color: black;
	    font-weight: 700;
	}
	
</style>
</head>
<body>

<jsp:include page="../main/header.jsp"></jsp:include>

	<div align="center" class="title">분리수거 도우미</div>

	<div class="main">
	 	<div class="ipad" onclick="init()">
		 	
	 		<div class="ipad-content">화면을 터치해서 잠금을 해제하세요.</div>
	 	</div>
 	</div>	
 	
		
		<script src="https://cdn.jsdelivr.net/npm/@tensorflow/tfjs@1.3.1/dist/tf.min.js"></script>
		<script src="https://cdn.jsdelivr.net/npm/@teachablemachine/image@0.8/dist/teachablemachine-image.min.js"></script>
		<script type="text/javascript">
		
		    // More API functions here:
		    // https://github.com/googlecreativelab/teachablemachine-community/tree/master/libraries/image
		
		    // the link to your model provided by Teachable Machine export panel
		    const URL = "https://teachablemachine.withgoogle.com/models/lRmi_M1M1/";
		
		    let model, webcam, labelContainer, maxPredictions, container, classes;
		
		    // Load the image model and setup the webcam
		    	async function init() {
	    		   try{
				        /* const modelURL = URL + "model.json";
				        const metadataURL = URL + "metadata.json"; */
				        const modelURL = URL + "model.json";
			            const metadataURL = URL + "metadata.json";

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
				        var aa = document.getElementsByClassName("ipad")[0];
				        var cam = document.createElement('div');
				        
				        cam.className="webcam-container";
				        
				        aa.appendChild(cam);
				        cam.appendChild(webcam.canvas);
				        
				        
				        recycle = ['glass', 'plastic', 'paper']
				        classes = new Array();
				        for(let i = 0; i < maxPredictions; i ++){
				        	var box = document.getElementsByClassName(recycle[i])[0];
				        	container = document.createElement('div');
			        	    container.className = "wb-container";
			        	    
				        	classes[i] = document.createElement('div');
				        	classes[i].className = 'inner-bar-' + i;
				        	
				        	var classname = document.createElement('div');
				        	classname.className = 'classname';
				        	classname.innerHTML = recycle[i];
				        	
				        	cam.appendChild(container);
				        	container.appendChild(classname);
				        	container.appendChild(classes[i]);
				        	
					        }
					    } 
	    		   catch(err){
	   		    	  console.log(err);
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
		        	console.log(prediction[i].className);
		          const classPrediction =
	                prediction[i].className + ": " + prediction[i].probability.toFixed(2);
		            classes[i].style.width = (prediction[i].probability.toFixed(4) * 100) + "%";
		            classes[i].style.height = "100%";
		            classes[i].innerHTML = (prediction[i].probability * 100).toFixed(2) + "%";
		        }
		    }
		</script>

	
	<jsp:include page="../main/footer.jsp"></jsp:include>

</body>
</html>