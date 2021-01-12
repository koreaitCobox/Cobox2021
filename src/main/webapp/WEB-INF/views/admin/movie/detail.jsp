
<%@page import="com.koreait.cobox.model.domain.Movie"%>
<%@page import="com.koreait.cobox.model.domain.Rating"%>
<%@page import="com.koreait.cobox.model.domain.Genre"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%
Movie movie=(Movie)request.getAttribute("movie");
out.print("요청객체에 담겨진 movie_id"+movie.getMovie_id());
%>

<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<%@ include file="../inc/header.jsp"%>
<style>
input[type=text], select, textarea {
	width: 100%;
	padding: 12px;
	border: 1px solid #ccc;
	border-radius: 4px;
	box-sizing: border-box;
	margin-top: 6px;
	margin-bottom: 16px;
	resize: vertical;
}

input[type=button] {
	background-color: #4CAF50;
	color: white;
	padding: 12px 20px;
	border: none;
	border-radius: 4px;
	cursor: pointer;
}

input[type=button]:hover {
	background-color: #45a049;
}

.container {
	border-radius: 5px;
	background-color: #f2f2f2;
	padding: 20px;
}


.box {
	width: 100px;
	float: left;
	padding: 5px;
}

.box>img {
	width: 100%;
}

.close {
	color: red;
	cursor: pointer;
}
</style>
<!-- 달력 -->
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
<script src="//code.jquery.com/jquery.min.js"></script>
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>

<script type="text/javascript">
var genre=[];//선택한 장르사이즈를 담는 배열

	$(function(){
		CKEDITOR.replace("story");
		
		$($("input[type='button']")[0]).click(function(){
			edit();
		});
		
		$($("input[type='button']")[1]).click(function(){
			del();
		});
		
		//글수정 요청
		function edit(){
			$("form").attr({
				action:"/admin/movie/edit",
				method:"post"
			});
			$("form").submit();
		}
		//글삭제 요청
		function del(){
			if(confirm("삭제하시겠어요?")){
				$("form").attr({
					action:"/admin/movie/delete",
					method:"post"
				});
				$("form").submit();
			}
		}
		
		//체크박스 이벤트 구현 (영화장르 값 얻기)
		$("input[type='checkbox']").on("click", function(e) {
			var ch = e.target;//이벤트 일으킨 주체컴포넌트 즉 체크박스
			//체크박스의 길이 얻기 
			var ch = $("input[name='genre_name']");
			var len = $(ch).length; //반복문이용하려고..

			genre = [];//배열 초기화
			console.log("채우기 전 genre의 길이는",genre.length);
			
			for (var i = 0; i < len; i++) {
				//만일 체크가 되어있다면, 기존 배열을 모두 지우고, 체크된 체크박스 값만 배열에 넣자!!
				if ($($(ch)[i]).is(":checked")) {
					genre.push($($(ch)[i]).val());
				}
				//console.log(i,"번째 체크박스 상태는 ", $($(ch)[i]).is(":checked"));
				console.log("채우고 genre의 길이는",genre.length);
			}
			console.log("서버에 전송할 사이즈 배열의 구성은 ", genre);
		});
		
		
	});
	
	//달력생성
	$(function() {
		$("#datepicker1").datepicker({
			dateFormat : 'yy-mm-dd'
		});
	});
	
	
	
</script>



</head>

<body>
	<%@ include file="../inc/main_navi.jsp"%>

	<h3>영화 등록</h3>
	<div class="container">
		<form>
			<h4>장르선택(복수 가능)</h4>
			<input type="checkbox" id="genre_name" name="genre_name" value="hrror" />hrror
			<input type="checkbox" id="genre_name" name="genre_name" value="drama" />drama
			<input type="checkbox" id="genre_name" name="genre_name" value="SF" />SF
			<input type="checkbox" id="genre_name" name="genre_name" value="romance" />romance
			<input type="checkbox" id="genre_name" name="genre_name" value="comic" />comic
			<p>
			<input type="checkbox" id="genre_name" name="genre_name" value="ani" />ani
			<input type="checkbox" id="genre_name" name="genre_name" value="noir" />noir
			<input type="checkbox" id="genre_name" name="genre_name" value="docu" />docu
			<input type="checkbox" id="genre_name" name="genre_name" value="music" />music
			<input type="checkbox" id="genre_name" name="genre_name" value="mystery" />mystery
			<p>
			<input type="checkbox" id="genre_name" name="genre_name" value="crime" />crime
			<input type="checkbox" id="genre_name" name="genre_name" value="omnibus" />omnibus
			<input type="checkbox" id="genre_name" name="genre_name" value="thriller" />thriller
			<input type="checkbox" id="genre_name" name="genre_name" value="sports" />sports
			<input type="checkbox" id="genre_name" name="genre_name" value="saguk" />saguk
			<p>
			<input type="checkbox" id="genre_name" name="genre_name" value="child" />child
			<input type="checkbox" id="genre_name" name="genre_name" value="action" />action
			<input type="checkbox" id="genre_name" name="genre_name" value="adventure" />adventure
			<input type="checkbox" id="genre_name" name="genre_name" value="history" />history
			<input type="checkbox" id="genre_name" name="genre_name" value="war" />war
			

			<input type="text" name="movie_name" placeholder="영화명" value="<%=movie.getMovie_name()%>"> 

			<select name="rating_id">		
				<option >관람등급 선택</option>
				<option value="1">all</option>
				<option value="2">12</option>
				<option value="3">15</option>
				<option value="4">adult</option>
			</select>
			
		
			 <input type="text" name="director" value="<%=movie.getDirector()%>">
			 <input type="text" name="actor" value="<%=movie.getActor()%>">
			 <input type="text" name="release" id="datepicker1" value="<%=movie.getRelease()%>">
			<textarea id="story" name="story" style="height: 200px"><%=movie.getStory() %></textarea>
	
			<p>
				대표이미지: <input type="file" name="repImg" id="repImg">
			</p>

			<input type="button" value="글수정">
			<input type="button" value="글삭제">
			<input type="button" value="목록보기" onClick="location.href='/admin/movie/list'">
			
		</form>
	</div>

</body>
</html>