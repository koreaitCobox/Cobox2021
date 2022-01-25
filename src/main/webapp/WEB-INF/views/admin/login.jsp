<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>코박스 관리자 로그인</title>
<%@ include file="./inc/header.jsp" %>
		<link rel="stylesheet" type="text/css" href="/resources/admin/common.css" />
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>
<!--   메인 네비게이션 영역 : jsp는 이제 보안된폴더에 잇으므로,
웹사이트 루트를 기준으로한 경로는 막혀잇다..따라서 상대경로로 접근하자!!-->
<%-- <%@ include file="./inc/main_navi.jsp" %> --%>

    <div class="login_warp">
        <div class="login_box">
            <div class="login_top">
                <div class="login_img">
                <i class="fa fa-lock fa-5x" aria-hidden="true"></i>
                <span>ADMIN LOGIN</span>
                </div>
            </div>         
            <ul class="login_input">
                <li>
                    <div class="textbox login_id">
                        <!-- label 값과 id 값은 같아야 합니다 -->
                        <label for="username">아이디</label>
                        <input type="text" id="username" class="input--text" placeholder="ID">
                    </div>
                </li>
                <li>
                    <div class="textbox login_pw">
                        <label for="ex_input1">비밀번호</label>
                        <input type="password" id="password" class="input--text" placeholder="Password">
                    </div>
                </li>
                <li>
                    <span class="login_btn">
                        <input type="submit" title="Login" id="btnLogin" value="Login">
                    </span>
                </li>
            </ul>
			<p class="login_desc">본 사이트는 코박스 관계자만 로그인 할 수 있습니다.</p>
			<input type="hidden" name="sctoken" id="sctoken" value="<%=session.getAttribute("sctoken") %>">
        </div>
		<p class="login_footer">
			<span class="copyright">Copyright ⓒ By Ministry of Food and Drug Safety. All rights Reserved</span>
		</p>
    </div>

<h3>Dropdown Menu inside a Navigation Bar</h3>
<p>Hover over the "Dropdown" link to see the dropdown menu.</p>


	<div id="dialog-box">
		<div id="dialog-msg1" title="로그인 실패 메세지">
			<p class="dialog_msg">
				로그인 실패
			</p>
		</div>
		<div id="dialog-msg2" title="로그인 실패 메세지">
			<p class="dialog_msg">
				로그인 실패
			</p>
		</div>
		<div id="dialog-msg3" title="로그인 실패 메세지">
			<p class="dialog_msg">
				로그인 실패
			</p>
		</div>
		<div id="dialog-msg4" title="로그인 실패 메세지">
			<p class="dialog_msg">ID를 입력해 주세요.</p>
		</div>
		<div id="dialog-msg5" title="로그인 실패 메세지">
			<p class="dialog_msg">비밀번호를 입력해 주세요.</p>
		</div>
		<div id="dialog-msg6" title="로그인 실패 메세지">
			<p class="dialog_msg">
				로그인 실패
			</p>
		</div>
	</div>


</body>
<script type="text/javascript">
	$(document).ready(function(){
		
		var message = '${message}';
		if (message == 'fail') {
			alert('로그인 정보를 확인해 주세요');
		}
		
		//로그인 버튼 눌렀을 때 
		$('#btnLogin').click(function() {
			validation();
			
			var params = {
				 username : $("#username").val(),
				 password : $("#password").val(),
				 sctoken : $("#sctoken").val()
			}
			
			$.ajax({
				type:'POST',
				url:'/loginProcess',
				dataType:'json',
				data:params,
				success:function(data){
					if(data.result){ // result 에 true 를 담아놨음 (로그인 성공시)
						document.location.href = '/admin/movie/list'; //로그인 체크 완료 후 list로 이동
					}else{// (로그인 실패시)
						/* document.location.href = '/admin'; */
						$("#dialog-msg1").dialog({
							appendTo : "#dialog-box",
							resizable : false,
							modal : true,
							buttons : {
								"close" : function() {
									$(this).dialog("close");
								}
							},
							close : function(event, ui) {
								
							}
						});
						
						return false;
					}
				}
			});

		});
		

		/* 엔터키로 로그인 버튼 클릭 */
		$(this).keydown(function(e) {
			if (e.keyCode == 13) {
				e.cancelBubble = true;
				$("#btnLogin").click();
				return false;
			}
		});
	}); //document ready end 
	
	
	function validation(){
		
		if (!$("#username").val()) {

			// jquery dialog...
			$("#dialog-msg4").dialog({
				appendTo : "#dialog-box",
				resizable : false,
				modal : true,
				buttons : {
					"확인" : function() {
						$(this).dialog("close");
					}
				},
				close : function(event, ui) {
					$('#username').val('');
					$('#username').focus();
				}
			});

			return false;
		}else if(!$("#password").val()){
			console.log()
			// jquery dialog...
			$("#dialog-msg5").dialog({
				appendTo : "#dialog-box",
				resizable : false,
				modal : true,
				buttons : {
					"확인" : function() {
						$(this).dialog("close");
					}
				},
				close : function(event, ui) {
					$('#password').val('');
					$('#username').focus();
				}
			});

			return false;
		}else{
			var pw = $("#password").val();
			var rePw = pw.replace(/\<|\>|\"|\'|\%|\;|\(|\)|\&|\+|\-/g, ""); 
			$("#password").val(rePw);
			
			//validateEncryptedForm();
		}

	}



</script>
</html>






