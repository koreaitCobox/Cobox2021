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
                        <label for="ex_input">아이디</label>
                        <input type="text" id="ex_input" placeholder="ID">
                    </div>
                </li>
                <li>
                    <div class="textbox login_pw">
                        <label for="ex_input1">비밀번호</label>
                        <input type="password" id="ex_input1" placeholder="Password">
                    </div>
                </li>
                <li>
                    <span class="login_btn">
                        <input type="submit" title="Login" id="btnLogin" value="Login">
                    </span>
                </li>
            </ul>
			<p class="login_desc">본 사이트는 코박스 관계자만 로그인 할 수 있습니다.</p>
        </div>
		<p class="login_footer">
			<span class="copyright">Copyright ⓒ By Ministry of Food and Drug Safety. All rights Reserved</span>
		</p>
    </div>

<h3>Dropdown Menu inside a Navigation Bar</h3>
<p>Hover over the "Dropdown" link to see the dropdown menu.</p>

</body>
</html>
