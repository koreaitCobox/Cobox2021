<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="../inc/header.jsp"%>
<%@ include file="../inc/script.jsp"%>
<meta charset="UTF-8">
<title>로그아웃 처리</title>
</head>
<body>
<%
//Cookie user = new Cookie("id", "");
//session.invalidate();//세션의 모든 속성 제거
%>
<!-- 로그아웃 처리 완료 -->
</body>
<script>
$(document).ready(function() {
	alert("로그아웃 성공");
	document.location.href = '/';
});
</script>
</html>