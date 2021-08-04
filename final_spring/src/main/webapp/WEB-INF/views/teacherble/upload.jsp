<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style type="text/css">

	body {
	  font-family: sans-serif;
	  background-color: #eeeeee;
	}
	
	.file-upload {
	  width: 560px;
	  margin: 0 auto;
	}
	
	.file-upload-btn {
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
	
	.file-upload-btn:hover {
	  background: #1AA059;
	  color: #ffffff;
	  transition: all .2s ease;
	  cursor: pointer;
	}
	
	.file-upload-btn:active {
	  border: 0;
	  transition: all .2s ease;
	}
	
	.file-upload-content {
	  display: none;
	  text-align: center;
	}
	
	.file-upload-input {
	  position: absolute;
	  margin: 0;
	  padding: 0;
	  width: 100%;
	  height: 100%;
	  outline: none;
	  opacity: 0;
	  cursor: pointer;
	}
	
	.image-upload-wrap {
	  margin-top: 20px;
	  border: 4px dashed #1FB264;
	  position: relative;
	}
	
	.image-dropping,
	.image-upload-wrap:hover {
	  background-color: #1FB264;
	  border: 4px dashed #ffffff;
	}
	
	.image-title-wrap {
	  padding: 0 15px 15px 15px;
	  color: #222;
	}
	
	.drag-text {
	  text-align: center;
	}
	
	.drag-text h3 {
	  font-weight: 100;
	  text-transform: uppercase;
	  color: #15824B;
	  padding: 60px 0;
	}
	
	.file-upload-image {
	  max-height: 200px;
	  max-width: 200px;
	  margin: auto;
	  padding: 20px;
	}
	
	.remove-image {
	  width: 200px;
	  margin: 0;
	  color: #fff;
	  background: #cd4535;
	  border: none;
	  padding: 10px;
	  border-radius: 4px;
	  border-bottom: 4px solid #b02818;
	  transition: all .2s ease;
	  outline: none;
	  text-transform: uppercase;
	  font-weight: 700;
	}
	
	.remove-image:hover {
	  background: #c13b2a;
	  color: #ffffff;
	  transition: all .2s ease;
	  cursor: pointer;
	}
	
	.remove-image:active {
	  border: 0;
	  transition: all .2s ease;
	}
	
	#label-container div {
		width:100px;
	}
	
	.file-btn{
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
	    margin-top : 10px;
	}
	
	.box-container {
    width: 1100px;
    height: 800px;
    margin: 0px auto;
    border: 1px solid green;
	}
	
	.left-box {
    width: 400px;
    height: 500px;
    display: inline-block;
    margin: 25px;
	}
	
	.right-box {
    width: 560px;
    height: 500px;
    display: inline-block;
    position: absolute;
    margin: 25px;
	}
	
	.footer-box {
    width: 1000px;
    margin-left: 250px;
	}
	
	.glass, .plastic, .paper {
    display: inline-block;
    width: 200px;
    height: 175px;
    margin: 0px 70px 0px 0px;
	}
	
	.main {
	    width: 100%;
	    height: 100px;
	    margin: auto;
	    text-align: center;
	}
	
	.footer-box{
		width: 1000px;
	    margin-left: 250px;
		
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
	
	.wb-container{
		width: 150px;
		height:40px;
		margin: 15px auto;
		
	}
	
	.webcam-btn{
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
	


</style>

</head>
<body>

<jsp:include page="../main/header.jsp"></jsp:include>


	<script class="jsbin" src="https://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
	
	<div class="box-container">
	
		<div class="left-box">
			<img alt="man" src="https://i.pinimg.com/originals/40/6a/a2/406aa2aee1465be6404d7ebf0ffdab24.png">
		</div>
		
		<div class="right-box">
			<div class="main">
				<div class="main-text">분리수거를 도와주는 기능입니다.</div>
				<button class="webcam-btn" type="button" onclick="location.href='teacherble.do'">웹캠 방식</button>
				
				  <div class="file-upload">
				  <button class="file-upload-btn" type="button" onclick="$('.file-upload-input').trigger( 'click' )">Add Image</button>
				
				  <div class="image-upload-wrap">
				    <input class="file-upload-input" type='file' onchange="readURL(this);" accept="image/*" />
				    <div class="drag-text">
				      <h3>Drag and drop a file or select add Image</h3>
				    </div>
				  </div>
				  
				  <div class="file-upload-content">
				    <img class="file-upload-image" id="face-image" src="#" alt="your image" />
				    <div class="image-title-wrap">
				      <button type="button" onclick="removeUpload()" class="remove-image">Remove <span class="image-title">Uploaded Image</span></button>
				    </div>
				  </div>
				  <button class="file-btn" type="button" onclick="predict()">측정</button>
				</div>	
				
			</div>
		</div>
		
		<div class="footer-box">
			<div class="glass">
				<img alt="유리" src="https://image.flaticon.com/icons/png/512/1598/1598408.png" width="200" height="175"/>
			</div>
			
			<div class="plastic">
				<img alt="플라스틱" src="https://image.flaticon.com/icons/png/512/4380/4380438.png" width="200" height="175"/>
			</div>
			
			<div class="paper">
				<img alt="종이" src="https://image.flaticon.com/icons/png/512/889/889648.png" width="200" height="175"/>
			</div>
			
 		</div>
		
		
		<div id="webcam-container"></div>
		<div id="label-container"></div>
		
	</div>
	
	
	<script src="https://cdn.jsdelivr.net/npm/@tensorflow/tfjs@1.3.1/dist/tf.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/@teachablemachine/image@0.8/dist/teachablemachine-image.min.js"></script>
	<script type="text/javascript">
	    // More API functions here:
	    // https://github.com/googlecreativelab/teachablemachine-community/tree/master/libraries/image
	
	    // the link to your model provided by Teachable Machine export panel
	
	    let model, webcam, labelContainer, maxPredictions, container, classes;
	
	    // Load the image model and setup the webcam
	    window.onload = async function init() {
	        const modelURL = "resources/my_model/model.json";
	        const metadataURL ="resources/my_model/metadata.json";

	        // load the model and metadata
	        // Refer to tmImage.loadFromFiles() in the API to support files from a file picker
	        // or files from your local hard drive
	        // Note: the pose library adds "tmImage" object to your window (window.tmImage)
	        console.log(metadataURL)
	        model = await tmImage.load(modelURL, metadataURL);
	        console.log(model)
	        maxPredictions = model.getTotalClasses();
	        console.log(maxPredictions);
	
	       /*  labelContainer = document.getElementById("label-container");
	        for (let i = 0; i < maxPredictions; i++) { // and class labels
	            labelContainer.appendChild(document.createElement("div"));
	        } */
	        
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
	
	    // run the webcam image through the image model
	    async function predict() {
	        // predict can take in an image, video or canvas html element
	        var image = document.getElementById("face-image");
	        const prediction = await model.predict(image, false);
	        for (let i = 0; i < maxPredictions; i++) {
	            const classPrediction =
            	classes[i].style.width = (prediction[i].probability.toFixed(4) * 100) + "%";
	            classes[i].innerHTML = (prediction[i].probability * 100).toFixed(2) + "%";
	        }
	    }
	    
	</script>
	
	<script>
	
		function readURL(input) {
			  if (input.files && input.files[0]) {
	
			    var reader = new FileReader();
	
			    reader.onload = function(e) {
			      $('.image-upload-wrap').hide();
	
			      $('.file-upload-image').attr('src', e.target.result);
			      $('.file-upload-content').show();
	
			      $('.image-title').html(input.files[0].name);
			    };
	
			    reader.readAsDataURL(input.files[0]);
	
			  } else {
			    removeUpload();
			  }
			}
	
			function removeUpload() {
			  $('.file-upload-input').replaceWith($('.file-upload-input').clone());
			  $('.file-upload-content').hide();
			  $('.image-upload-wrap').show();
			}
			$('.image-upload-wrap').bind('dragover', function () {
					$('.image-upload-wrap').addClass('image-dropping');
				});
				$('.image-upload-wrap').bind('dragleave', function () {
					$('.image-upload-wrap').removeClass('image-dropping');
			});
				
	
	</script>
	

</body>
</html>