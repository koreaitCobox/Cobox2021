
<%@page import="com.koreait.cobox.model.domain.Movie"%>
<%@page import="java.util.List"%>
<%@page import="com.koreait.cobox.model.domain.Genre"%>

<%@ page contentType="text/html;charset=UTF-8"%>
<%
List<Movie> movieList = (List)request.getAttribute("movieList");
%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<%@ include file="../inc/header.jsp" %>
<script>
$(function(){
	$("button").click(function(){
		location.href="/admin/movie/registform"; //글쓰기 폼 요청
	});
});
</script>
</head>
<body>

<%@ include file="../inc/main_navi.jsp" %>

<h3>영화 리스트</h3>
<p>
	<table>
		<tr>
			<th>No</th>
			<th>이미지</th>
			<th>영화명</th>
			<th>관람등급</th>
			<th>감독</th>
			<th>배우</th>
			<th>개봉일</th>
			
		</tr>
		<%for(int i=0;i<movieList.size();i++){ %>
		<%Movie movie=movieList.get(i); %>
		<tr>
			<td><%=movie.getMovie_id() %></td>
			<td><img src="/resources/data/<%=movie.getMovie_id()%>.<%=movie.getPoster()%>" width="100px"></td>
			<td><a href="/admin/movie/detail?movie_id=<%=movie.getMovie_id()%>"><%=movie.getMovie_name() %></td>
			<td><%=movie.getRating_id() %></td>
			<td><%=movie.getDirector() %></td>
			<td><%=movie.getActor() %></td>
			<td><%=movie.getRelease() %></td>
			
			
		</tr>
		<%} %>
		<tr>
			<td colspan="7">
				<button>영화등록</button>
			</td>
		</tr>
	</table>	
</p>

</body>
</html>
