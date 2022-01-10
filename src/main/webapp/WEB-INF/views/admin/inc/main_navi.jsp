<%@ page contentType="text/html;charset=UTF-8"%>
<div class="navbar">
  <a href="/admin">Home</a>
  <div class="dropdown">
    <button class="dropbtn">스낵관리 
      <i class="fa fa-caret-down"></i>
    </button>
    <div class="dropdown-content">
      <a href="/admin/snack/registform">스낵등록</a>
      <a href="/admin/snack/list">스낵리스트</a>
    </div>
  </div> 
  <div class="dropdown">
    <button class="dropbtn">회원관리 
      <i class="fa fa-caret-down"></i>
    </button>
    <div class="dropdown-content">
      <a href="#">회원정보</a>
      <a href="#">회원예매정보관리</a>
    </div>
  </div> 
  <div class="dropdown">
    <button class="dropbtn">영화관리
      <i class="fa fa-caret-down"></i>
    </button>
    <div class="dropdown-content">
      <a href="/admin/movie/registform">영화등록</a>
      <a href="/admin/movie/list">영화리스트</a>
      <a href="#">영화댓글관리</a>
    </div>
  </div> 
  <div class="dropdown">
    <button class="dropbtn">게시판 
      <i class="fa fa-caret-down"></i>
    </button>
    <div class="dropdown-content">
      <a href="#">공지사항게시판</a>
      <a href="#">문의게시판</a>
    </div>
  </div> 
  
</div>