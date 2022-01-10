<%@ page contentType="text/html; charset=UTF-8"%>
<!doctype html>
<html>
<title>회원가입 양식</title>
<!-- Custom -->
<!-- <script src="/resources/js/custom.js"></script> -->
<link type="text/css" rel="stylesheet" href="/resources/css/style.css">
<head>
<%@ include file="../inc/header.jsp"%>
<%@ include file="../inc/top.jsp"%>
<%@include file="../inc/script.jsp"%>

<style>

.form_wrapper {
	background: #fff;
	width: 400px;
	max-width: 100%;
	box-sizing: border-box;
	padding: 25px;
	margin: 4% auto 0;
	position: relative;
	z-index: 1;
}
	

#signup_btn{
	background: #f5ba1a!important;
    height: 35px;
    line-height: 35px;
    width: 100%;
    border: none;
    outline: none;
    cursor: pointer;
    color: #fff;
    font-size: 1.1em;
    margin-top:20px;
}

.form_wrapper input[type=text], .form_wrapper input[type=email], .form_wrapper input[type=password] {
    width: 80%;
    padding: 8px 10px 9px 35px;
    height: 35px;
    border: 1px solid #cccccc;
    box-sizing: border-box;
    outline: none;
    -webkit-transition: all 0.3s ease-in-out;
    -moz-transition: all 0.3s ease-in-out;
    -ms-transition: all 0.3s ease-in-out;
    transition: all 0.3s ease-in-out;
    margin-left: 25px;
}
    &[type="text"]:hover, &[type="email"]:hover, &[type="password"]:hover {
      background: #fafafa;
    }
    &[type="text"]:focus, &[type="email"]:focus, &[type="password"]:focus {
      -webkit-box-shadow: 0 0 2px 1px rgba(255, 169, 0, 0.5);
      -moz-box-shadow: 0 0 2px 1px rgba(255, 169, 0, 0.5);
      box-shadow: 0 0 2px 1px rgba(255, 169, 0, 0.5);
      border: 1px solid $yellow;
      background: #fafafa;
    }
    &[type="submit"] {
		background: $yellow;
		height: 35px;
		line-height: 35px;
		width: 100%;
		border: none;
		outline: none;
		cursor: pointer;
		color: #fff;
		font-size: 1.1em;
		margin-bottom: 10px;
		-webkit-transition: all 0.30s ease-in-out;
		-moz-transition: all 0.30s ease-in-out;
		-ms-transition: all 0.30s ease-in-out;
		transition: all 0.30s ease-in-out;
		&:hover {
			background: darken($yellow,7%);
		}
		&:focus {
			background: darken($yellow,7%);
		}
	}    
    &[type="checkbox"], &[type="radio"] {
      border: 0;
      clip: rect(0 0 0 0);
      height: 1px;
      margin: -1px;
      overflow: hidden;
      padding: 0;
      position: absolute;
      width: 1px;
    }
  }
}
.btn_box{
	background-color:orange;
}
.select_arrow {
  position: absolute;
  top: calc(50% - 4px);
  right: 15px;
  width: 0;
  height: 0;
  pointer-events: none;
  border-width: 8px 5px 0 5px;
  border-style: solid;
  border-color: #7b7b7b transparent transparent transparent;
}

@-webkit-keyframes check {
  0% { height: 0; width: 0; }
  25% { height: 0; width: 7px; }
  50% { height: 20px; width: 7px; }
}

@keyframes check {
  0% { height: 0; width: 0; }
  25% { height: 0; width: 7px; }
  50% { height: 20px; width: 7px; }
}

@-webkit-keyframes expand { 
	0% { -webkit-transform: scale3d(1,0,1); opacity:0; }
	25% { -webkit-transform: scale3d(1,1.2,1); }
	50% { -webkit-transform: scale3d(1,0.85,1); }
	75% { -webkit-transform: scale3d(1,1.05,1); }
	100% { -webkit-transform: scale3d(1,1,1);  opacity:1; }
}

@keyframes expand { 
	0% { -webkit-transform: scale3d(1,0,1); transform: scale3d(1,0,1);  opacity:0; }
	25% { -webkit-transform: scale3d(1,1.2,1); transform: scale3d(1,1.2,1); }
	50% { -webkit-transform: scale3d(1,0.85,1); transform: scale3d(1,0.85,1); }
	75% { -webkit-transform: scale3d(1,1.05,1); transform: scale3d(1,1.05,1); }
	100% { -webkit-transform: scale3d(1,1,1); transform: scale3d(1,1,1);  opacity:1; }
}


@-webkit-keyframes bounce { 
	0% { -webkit-transform: translate3d(0,-25px,0); opacity:0; }
	25% { -webkit-transform: translate3d(0,10px,0); }
	50% { -webkit-transform: translate3d(0,-6px,0); }
	75% { -webkit-transform: translate3d(0,2px,0); }
	100% { -webkit-transform: translate3d(0,0,0); opacity: 1; }
}

@keyframes bounce { 
	0% { -webkit-transform: translate3d(0,-25px,0); transform: translate3d(0,-25px,0); opacity:0; }
	25% { -webkit-transform: translate3d(0,10px,0); transform: translate3d(0,10px,0); }
	50% { -webkit-transform: translate3d(0,-6px,0); transform: translate3d(0,-6px,0); }
	75% { -webkit-transform: translate3d(0,2px,0); transform: translate3d(0,2px,0); }
	100% { -webkit-transform: translate3d(0,0,0); transform: translate3d(0,0,0); opacity: 1; }
}
@media (max-width: 600px) {
	.form_wrapper {
		.col_half {
			width: 100%;
			float: none;
		}
	}
	.bottom_row {
		.col_half {
			width: 50%;
			float: left;
		}
	}
	.form_container {
		.row {
			.col_half.last {
				border-left: none;
			}
		}
	}
	.remember_me {
		padding-bottom: 20px;
	}
}
.form_wrapper{
	border-top:5px solid #f5ba1a; 
}
</style>
<script>
//회원가입 버튼을 누르면
$(document).ready(function() {

	
});

//요청이 완료되는 시점에 프로그래스바를 감춘다
function regist() {
	//form 태그의 파라미터들을 전송할수있는 상태로 둬야  data키값에 form 자체를 넣을 수 있다.
	var formData = $("#formtable").serialize(); //전부 문자열화

	$.ajax({
		url : "/client/member/regist",
		type : "post",
		data : formData,
		success : function(responseData) {
			//데이터를 받으면 문구없애기
			console.log(responseData);
			var json = JSON.parse(responseData);
			if (json.result == 1) {
				alert("회원가입이 완료되었습니다.");
				location.href = "/client/member/formtable"; //로그인 페이지
			} else {
				alert("회원가입에 실패했습니다. \n 다시 시도해주세요.");
			}
		}
	});
}

//ID 입력 타당성 검사
function valid(x){
	var alphaDigit = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890";

	if(x.mid.value==""){
		alert("이메일ID를 입력해주세요.");
		x.mid.focus();
		return;
	}
	if(x.mid.value.length < 4 || x.mid.value.length > 15){
		alert("ID는 4~15자 이내여야 합니다.");
		x.mid.focus();
		return;
	}
	if(x.mid.value.indexOf(" ") >= 0){
		alert("ID에는 공백이 들어가면 안됩니다.");
		x.mid.focus();
		return;
	}
	for(i=0; i<x.mid.value.length; i++){
		if(alphaDigit.indexOf(x.mid.value.substring(i,i+1))==-1){
			alert("ID는 영문과 숫자의 조합만 사용할 수 있습니다.");
			x.mid.focus();
			return;
		}
	}
	
	//PW 입력 타당성 검사
	if(x.password.value==""){
		alert("비밀번호를 입력하셔야 합니다.");
		x.password.focus();
		return;
	}
	if(x.password.value.length<4){
		alert("비밀번호는 4자리 이상 입력하셔야 합니다.");
		x.password.value="";
		x.password.focus();
		return;
	}
	if(x.password2.value==""){
		alert("비밀번호를 확인 입력해 주셔야 합니다.");
		x.password2.focus();
	}
	if(x.password2.value != x.password.value){
		alert("비밀번호가 서로 일치하지 않습니다.");
		x.password.value=x.password2.value="";
		x.password.focus();
	}
	if(x.password.value.indexOf(" ") >= 0){
		alert("비밀번호에는 공백이 들어가면 안됩니다.");
		x.password.value = x.password2.value="";
		x.password.focus();
		return;
	}
	 for (i=0; i<x.password.value.length; i++) {
	      if (alphaDigit.indexOf(x.password.value.substring(i, i+1)) < 0) {
		      alert("비밀번호는 영문과 숫자의 조합만 사용할 수 있습니다.");
		      x.password.value=x.password2.value="";
		      x.password.focus();
		      return;
	      } 
    }
	//핸드폰 번호
		 let reg = /[0-9 ]/gim;//숫자 공백 모두 제거 
		 let phone = x.phone.value.replace(reg,"");
		 let birth = x.birth.value.replace(reg,"");
		 
		 if(x.phone.value.length!=13){ // 핸드폰 번호 길이가 13이 아닐때 
				 alert("핸드폰 번호를 다시 확인해주세요.");
				 x.phone.value.focus();
				 if(phone.length!=2){// - 2개가 없을 때 
					 alert("핸드폰 번호를 다시 확인해주세요.");
					 x.phone.value.focus();
				 }
				 return;
		 }	 
	// 생년월일 유효성 검사 8자여야 함, -가 2개 포함되야 함
		 if(x.birth.value.length!=8){
			 	alert("생년월일을 다시 확인해주세요.");
			 	x.birth.focus();
			 	 if(phone.length!=2){// - 2개가 없을 때 
					 alert("핸드폰 번호를 다시 확인해주세요.");
					 x.birth.value.focus();
				 }
			 	 return;
		 }
		//다 통과 됬으면 회원가입.
		regist();
}




</script>
</head>
<body>
	<div class="form_wrapper">
		<div class="form_container">
		
			<div class="row clearfix">
				<div class="input_field">
					<span style="width:300px; height:300px;">
					<i class="fa fa-address-book-o fa-5x" aria-hidden="true"></i>
				</span>
				</div>
					<form id="formtable">
						<div class="input_field">
							<span><i aria-hidden="true" class="fa fa-user-o fa-2x"></i></span>
								<input type="text" name="mid" placeholder="ID" required />
						</div>
						<div class="input_field">
						<span><i aria-hidden="true" class="fa fa-envelope fa-2x"></i></span>
							<input type="text" name="email_id" placeholder="이메일ID" required />
						</div>
						<div class="input_field">
						<span><i aria-hidden="true" class="fa fa-envelope fa-2x"></i></span>
							<input type="text" name="email_server" placeholder="ex) naver.com" required />
						</div>
						<div class="input_field">
							<span><i aria-hidden="true" class="fa fa-lock fa-2x"></i></span> <input
								type="password" name="password" placeholder=비밀번호 required />
						</div>
						<div class="input_field">
							<span><i aria-hidden="true" class="fa fa-lock fa-2x"></i></span> <input
								type="password" name="password2" placeholder="비밀번호 확인"
								required />
						</div>
						<div class="input_field">
							<span><i aria-hidden="true" class="fa fa-user fa-2x"></i></span> <input
								type="text" name="name" placeholder="이름" />
						</div>
						<div class="input_field">
							<span><i aria-hidden="true" class="fa fa-phone fa-2x"></i></span> <input
								type="text" name="phone" placeholder="핸드폰번호" />
							<p>'-' 포함 입력 ex) 010-1234-1234</p>
						</div>
						<div class="input_field">
							<span><i aria-hidden="true" class="fa fa-birthday-cake fa-2x"></i></span> <input
								type="text" name="birth" placeholder="생년월일" />
							<p>'-' 포함 입력 ex) yy-mm-dd</p>
						</div>
					    
						<div class="btn_box">
							<input class="button" id="signup_btn"  value="회원가입" onclick="valid(this.form);" style="text-align:center;" />
						</div>
					</form>
				
			</div>
		</div>		
	</div>




<!-- footer -->
	<%@include file="../inc/footer.jsp"%>
</body>
</html>
