<%@ page contentType="text/html; charset=UTF-8"%>
<!doctype html>
<html>
<head>
<%@ include file="../inc/header.jsp"%>
<%@ include file="../inc/script.jsp"%>
<link type="text/css" rel="stylesheet" href="/resources/css/style.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<style>


* {
	box-sizing: border-box;
}

/* style the container */
#form_container {
	position: relative;
	border: solid 1px #2e292e;
	background-color: rgba(255, 255, 255, 0.8);
	padding: 20px 0 30px 0;
	margin: 0 auto;
	margin-top:100px;
	width:900px;
}


input:hover, .btn:hover {
	opacity: 1;
}

/* add appropriate colors to fb, twitter and google buttons */
.kakao {
	background-color: #EBD300;
	color: white;
}

.naver {
	background-color: #30BA14;
	color: white;
}

.fb {
	background-color: #3B5998;
	color: white;
}

/* style the submit button */
input[type=submit] {
	background-color: #4CAF50;
	color: white;
	cursor: pointer;
}

input[type=submit]:hover {
	background-color: #45a049;
}

/* #login_btn {
	color: black;
	background-color: rgb(222, 222, 222);
	width: 49.5%
} */
.btn-block {
    display: block;
    width: 50%;
    padding-right: 0;
    padding-left: 0;
}
.btn {
    padding: 6px 12px;
    margin-bottom: 0;
    font-size: 14px;
    font-weight: normal;
    line-height: 1.428571429;
    text-align: center;
    white-space: nowrap;
    vertical-align: middle!important;
    cursor: pointer;
    background-image: none;
    border: 1px solid transparent;
    border-radius: 4px;
    -webkit-user-select: none;
    -moz-user-select: none;
    -ms-user-select: none;
    -o-user-select: none;
    user-select: none;
}
 #join_btn {
	margin-top:10px;
} 

/* Two-column layout */
.col {
	float: left;
	width: 50%;
	margin: auto;
	padding: 0 50px;
	margin-top: 6px;
	
}
.login_box{
	float:right;
	width: 50%;
	padding-left:40px;
	height:200px;
}
.login_box > a{
	position:relative;
	margin:7px;
	width: 344px;	
	margin-top: 13px;
	top: 159px;
    left: 148px;
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
$(document).ready(function() {
	//카카오 로그인 키 삽입	
	Kakao.init('c89a17aca474ee70198a2cac61fe14e5');
	console.log(Kakao.isInitialized());	
});
	
function requestLogin() {
	$("#formtable").attr({
		action : "/client/member/login",
		method : "post"
	});
	$("#formtable").submit();
}

//카카오 로그인
function kakaoLogin(){
	Kakao.Auth.login({
		success:function(response){
			Kakao.API.request({
				url:'/v2/user/me',
				success:function(response){
					console.log(response);
				},
				fail:function(error){
					console.log(error)
				},
			});
		},
		fail:function(error){
			console.log(error);
		},
	});
}

//https://accounts.kakao.com/weblogin/account/info 여기서 로그인 해제 
//카카오 로그아웃
function kakaoLogout() {
    if (Kakao.Auth.getAccessToken()) {
      Kakao.API.request({
        url: '/v1/user/unlink',
        success: function (response) {
        	console.log(response)
        },
        fail: function (error) {
          console.log(error)
        },
      })
      Kakao.Auth.setAccessToken(undefined)
    }
  }  
	

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
					
						<p class="login-text">
						    <span class="fa-stack fa-lg">
						      <i class="fa fa-lock fa-2x" aria-hidden="true"></i>
						    </span>
					  	</p>
					
					<div class="vl">
						<span class="vl-innertext">or</span>
					</div>


					<div class="col">
						<div class="hide-md-lg">
							<p>Or</p>
						</div>
						<!-- 아이디를 입력하세요 -->
						<div class="form-group input-group">
							<span class="input-group-addon">
								<i class="fa fa-user-circle" aria-hidden="true">
								</i>
							</span>
							<input type="text" class="form-control" name="mid" placeholder="아이디를 입력해주세요" required>
						</div>
						<!-- 아이디 입력 끝 -->
						<!-- 비밀번호를 입력하세요 -->
						<div class="form-group input-group">
							<span class="input-group-addon">
								<i class="fa fa-key" aria-hidden="true"></i>
								 
							</span>
							<input type="password" class="form-control" name="password" placeholder=" 비밀번호를 입력해주세요" required>
						</div>
						<!-- 비밀번호 입력 끝  -->
						 
						<input id="login_btn" type="button" class="btn-block btn" value="Login" onClick="requestLogin()" > 
						
						<a href="/client/member/join"> 
							<input id="join_btn" type="button" class="btn-block btn" value="회원가입">
						</a>
					</div>

					<div class="login_box">
						<a href="javascript:kakaoLogin();" class="kakao btn"> <i class="fa fa-kakao fa-fw"></i>Login
							with Kakao
						</a> <a href="#" class="naver btn"> <i class="fa fa-github" aria-hidden="true"></i>
							Login with Github
						</a> <a href="#" class="fb btn"> <i class="fa fa-facebook fa-fw"></i>
							Login with Facebook
						</a>

					</div>
				</div>
			</form>
		</div>



		<!-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  여기에 필요한 코드 짜기  @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ -->
		<%@include file="../inc/footer.jsp"%>
	</div>
	<!-- Custom -->

</body>
</html>
