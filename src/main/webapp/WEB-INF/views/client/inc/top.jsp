<%@ page contentType="text/html; charset=UTF-8"%>
<html>
<head>
<%@ include file="../inc/header.jsp"%>
<%@ include file="../inc/script.jsp"%>
</head>
<script>
function click_logout(){
	if(confirm("로그아웃 하시겠습니까?")){ // 확인
		location.href="/client/member/logout";
	}
}
</script>
<title>top_header</title>
<!-- Header section -->
<header class="header-wrapper">
    <div class="container">
        <!-- Logo link-->
        <a href='/' class="logo">
            <img alt='logo' src="/resources/images/cobox1.jpeg">
        </a>
        
        <!-- Main website navigation-->
        <nav id="navigation-box">
            <!-- Toggle for mobile menu mode -->
            <a href="#" id="navigation-toggle">
                <span class="menu-icon">
                    <span class="icon-toggle" role="button" aria-label="Toggle Navigation">
                      <span class="lines"></span>
                    </span>
                </span>
            </a>
            
            <!-- Link navigation -->
            <ul id="navigation">
                <li>
                    <span class="sub-nav-toggle plus"></span>
                    <a href="/client/movie/list">영화</a>
                </li>
                <li>
                    <span class="sub-nav-toggle plus"></span>
                    <a href="/client/movie/payPage?member_id=1">영화예매</a>
                </li>
                <li>
                    <span class="sub-nav-toggle plus"></span>
                    <a href="/client/movie/snack">스낵</a>
                </li>
                <li>
                    <span class="sub-nav-toggle plus"></span>
                    <a href="/client/movie/notice">공지사항</a>
                </li>
            </ul>
        </nav>
        
        <!-- Additional header buttons / Auth and direct link to booking-->
        <div class="control-panel">
        	<!-- <span class="btn btn--sign login-window"></span> -->
        	
        <% if(session.getAttribute("member")==null){%>
            <a href="/client/member/formtable" style="margin-right:10px;">로그인</a>
            <a href="/client/member/join">회원가입</a>
            <%}else{ %>
            <a href="#" class="log_out" onclick="click_logout();">로그아웃</a>
            <a href="#">My page</a>
            <%} %>
            <!-- <span class="btn btn-md btn--warning btn--book login-window"></span> -->
           
        </div>

    </div>
</header>
</html>