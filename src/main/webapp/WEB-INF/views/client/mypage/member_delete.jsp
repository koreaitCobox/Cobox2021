<%@ page contentType="text/html; charset=UTF-8"%>
<!doctype html>
<html>
<head>
<%@ include file="../inc/header.jsp"%>
<%@include file="../inc/script.jsp"%>

<style>
body {
	font-family: Arial, Helvetica, sans-serif;
}

* {
	box-sizing: border-box;
}

/* style the container */
#form_container {
	position: relative;
	border: solid 5px #A9AD1C;
	border-radius: 10px;
	background-color: rgba(255, 255, 255, 0.8);
	padding: 20px 0 30px 0;
	margin: 150px;
}

/* style inputs and link buttons */
input, .btn {
	width: 100%;
	padding: 12px;
	border-radius: 5px;
	margin: 5px 0;
	opacity: 0.85;
	display: inline-block;
	font-size: 17px;
	line-height: 20px;
	text-decoration: none; /* remove underline from anchors */
	background-color: rgb(222, 222, 222);
	color: black;
}

input:hover, .btn:hover {
	opacity: 1;
}

/* add appropriate colors to fb, twitter and google buttons */


/* style the submit button */
input[type=submit] {
	background-color: #4CAF50;
	color: white;
	cursor: pointer;
}

input[type=submit]:hover {
	background-color: #45a049;
}

#login_btn {
	color: black;
	background-color: rgb(222, 222, 222);
	width: 49.5%
}

#join_btn {
	color: black;
	background-color: rgb(222, 222, 222);
	width: 49.5%
}

/* Two-column layout */
.col {
	float: left;
	width: 50%;
	margin: auto;
	padding: 0 50px;
	margin-top: 6px;
}

/* Clear floats after the columns */
.row:after {
	content: "";
	display: table;
	clear: both;
}

/* vertical line */
.vl {
	position: absolute;
	left: 50%;
	transform: translate(-50%);
	border: 2px solid #ddd;
	height: 175px;
}

/* text inside the vertical line */
.vl-innertext {
	position: absolute;
	top: 50%;
	transform: translate(-50%, -50%);
	background-color: #f1f1f1;
	border: 1px solid #ccc;
	border-radius: 50%;
	padding: 8px 10px;
}

/* hide some text on medium and large screens */
.hide-md-lg {
	display: none;
}

/* bottom container */
.bottom-container {
	text-align: center;
	background-color: #666;
	border-radius: 0px 0px 4px 4px;
}

/* Responsive layout - when the screen is less than 650px wide, make the two columns stack on top of each other instead of next to each other */
@media screen and (max-width: 650px) {
	.col {
		width: 100%;
		margin-top: 0;
	}
	/* hide the vertical line */
	.vl {
		display: none;
	}
	/* show the hidden text on small screens */
	.hide-md-lg {
		display: block;
		text-align: center;
	}
}
</style>
<script>
/*
 
$(function() {
	$("#login_btn").on("click", function() {
		requestLogin();
	});
});
  
	
	function requestLogin() {
		$("formtable").attr({
			method : "post",
			action : "/client/member/login"
		});
		$("formtable").submit();
	}
 */

	$(function() {
		$("#login_btn").on("click", function(){
			
			alert("확인용");
			//실행 잘 됨
			
			//문제부분
			$.ajax({
				url:"/client/member/login",
				type:"post", 
				data:{
					"mid":$("input[name='mid']").val() , 
					"password":$("input[name='password']").val()
				},
				success:function(result){
					
					if(result==undefined){//성공
						alert(result.name+"님 안녕하세요 ");
						location.href="/";
					}else{//실패
						alert(result.msg);				
					}
				}
			});		
		});
	});
	
</script>
</head>
<body class="single-cin">
	<div class="wrapper">
		<%@ include file="../inc/top.jsp"%>
		<!-- Main content -->
		<!-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  여기에 필요한 코드 짜기  @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ -->


		<div id="form_container">
			<form id="formtable" method="post">
				<div class="row">
					<div style="text-align: center; padding: 15px; font-size: 50px">로그인</div>
					<div class="vl">
						<span class="vl-innertext">or</span>
					</div>

						<div> 회원탈퇴를 원하시면 아이디와 비밀번호를 입력해주세요. </div>						 
						<input id="back" type="button" value="회원 탈퇴">
						<input id="login_btn" type="button" value="취소"> 
				</div>
			</form>
		</div>



		<!-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  여기에 필요한 코드 짜기  @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ -->
		<%@include file="../inc/footer.jsp"%>
	</div>
	<!-- Custom -->
	<script src="/resources/js/custom.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			init_Home();
		});
	</script>
</body>
</html>
