<%@ page contentType="text/html; charset=UTF-8"%>
<!-- Banner -->
<!-- <div class="banner-top">
    <img alt='top banner' src="/resources/images/banners/bra.jpg">
</div> -->

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
                    <a href="/client/movie/reservation">영화예매</a>
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
            <a href="/client/member/formtable" >로그인</a>
            <%}else{ %>
            <a href="/client/member/formtable" >로그아웃</a>
            <%} %>
            <!-- <span class="btn btn-md btn--warning btn--book login-window"></span> -->
            <a href="/client/member/join">회원가입</a>
        </div>

    </div>
</header>