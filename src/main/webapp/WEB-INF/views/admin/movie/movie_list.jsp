
<%@page import="com.koreait.cobox.model.domain.Rating"%>
<%@page import="com.koreait.cobox.model.common.Pager"%>
<%@page import="com.koreait.cobox.model.domain.Movie"%>
<%@page import="java.util.List"%>
<%@page import="com.koreait.cobox.model.domain.Genre"%>

<%@ page contentType="text/html;charset=UTF-8"%>
<%
//List<Movie> movieList = (List)request.getAttribute("movieList");
Pager pager=(Pager)request.getAttribute("pager");
List<Movie>movieList=(List)pager.getList();
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
function regist(){
	var formData = new FormData($("form")[0]);//<form>태그와는 틀리다..전송할때 파라미터들을 담을수있지만 이 자체가 폼태그는 아니다!!
	/*비동기 업로드*/
	$.ajax({
		url:"/admin/movie/excel/regist",
		data:formData,
		contentType:false, /* false일 경우 multipart/form-data*/
		processData:false, /* false일 경우 query-string으로 전송하지 않음*/
		type:"post",
		success:function(responseData){
			console.log(responseData);
			//var json = JSON.parse(responseData); //string --> json 으로 파싱..
			//alert(json);
		}
	});
}

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
			
			<td><%=movie.getRating().getRating_name()%></td>
			<td><%=movie.getDirector() %></td>
			<td><%=movie.getActor() %></td>
			<td><%=movie.getRelease() %></td>
			
			
		</tr>
		<%} %>
		<tr>
			<td colspan="7">
				<button>영화등록</button>
				<form>
				<p>엑셀파일 선택: <input type="file"  name="dump">
				 <input type="button" value="데이터 등록" onClick="regist()"></p>
			  </form>
			</td>
		</tr>
	</table>	


</body>
</html>
