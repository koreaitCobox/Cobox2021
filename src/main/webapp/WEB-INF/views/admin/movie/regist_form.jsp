
<%@page import="com.koreait.cobox.model.domain.Rating"%>
<%@page import="com.koreait.cobox.model.domain.Genre"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%
List<Genre> genreList = (List) request.getAttribute("genreList");
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
	border: 1px solid black;
	padding: 20px;
	width:50%;
	display:inline-block;
	
}
.basic_table{
	text-align:center;
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

#movie_name{
	width:50%;
}
#rating_id{
	width:50%;
}
#director{
	width:50%;
}
#actor{
	width:50%;
}
#playdate{
	width:50%;
}
</style>
<!-- 달력 -->
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
<script src="//code.jquery.com/jquery.min.js"></script>
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>

<script type="text/javascript">

$(document).ready(function(){
	CKEDITOR.replace("story"); //editor 이름 부여
	//달력 생성
	$("#playdate").datepicker({
		dateFormat : 'yy-mm-dd'
	});
	
	
	// db에 담겨져있는 장르정보 가져오기
	$.ajax({
		type:'POST',
		url:'/admin/movie/genre',
		dataType:'json',
		success:function(data){
			var genreList = data.genreList;
			var htmlStr='';
			
			$.each(genreList, function(idx,obj){
				htmlStr += '<input type="checkbox" id="genre_list_name" name="genre_list_name" onclick="getGenre(this);" value="'+obj.genre_name+'">'+obj.genre_name+'</input>';
				if(idx%5==0&&idx!=0){
					htmlStr+='<p>'
				}
			});
			
			$('.genre_box').empty().append(htmlStr);
		}
	});
	
// ===========================

});//document ready end

var genre = []; 
//const genre = new Set();
function getGenre(e){
	// 영화 장르 
	genre=[];
	var ch = $("input[name='genre_list_name']");
	var len = ch.length; //반복문이용하려고, 25개 
	
	
	for(var i=0; i<len; i++){
		if($($(ch)[i]).is(":checked")){
			genre.push($($(ch)[i]).val());
		}
	}
	console.log("서버에 전송할 사이즈 배열의 구성은 ", genre);
}

	
	//영화 등록
function regist(){
		
		var formData=new FormData($("form")[0]);
		//폼데이터에 에디터값 추가하기
		formData.append("story",CKEDITOR.instances["story"].getData());
		for(var i=0;i<genre.length;i++){
			formData.append("genreList["+i+"].genre_list_name",genre[i]);
			//키값, val
		}
		/*비동기 업로드*/
		$.ajax({
			url:"/admin/movie/regist",
			data:formData,
			contentType:false,
			processData:false,
			type:"post",
			success:function(responseData){
				var json = JSON.parse(responseData);//string-->json
			if(json.result==1){
				alert(json.msg);//메시지 뿌리고 
				location.href="/admin/movie/list" // 등록된 페이지 뿌려주기
			}else{
				alert(json.msg);
			}
				
			}
		});

	}
	
</script>



</head>

<body>
	<%@ include file="../inc/main_navi.jsp"%>
	<div class="basic_table">
		<h3>영화 등록</h3>
		<div class="container">
			<form>
				<h4>장르선택(복수 가능)</h4>
				<div class="genre_box">
					<input type="checkbox" id="genre_list_name" name="genre_list_name" value="hrror" />hrror
				</div>
	
				<input type="text" id="movie_name" name="movie_name" placeholder="영화명"> 
	
				<select id="rating_id" name="rating_id">		
					<option >관람등급 선택</option>
					<option value="1">all</option>
					<option value="2">12</option>
					<option value="3">15</option>
					<option value="4">adult</option>
				</select>
				
				 <input type="text" id="director" name="director" placeholder="감독">
				 <input type="text" id="actor" name="actor" placeholder="배우">
				 <input type="text" id="playdate" name="playdate" placeholder="개봉일" >
				 <h4>줄거리</h4>
				<textarea id="story" name="story" placeholder="영화 줄거리" style="height: 200px"></textarea>
	
				
				<p>
					대표이미지: <input type="file" name="repImg" id="repImg">
				</p>
	
				<input type="button" value="글등록" onClick="regist()" id="registBtn"> 
				<input type="button" value="목록보기" onClick="location.href='/admin/movie/list'">
				
			</form>
		</div>
	</div>
</body>
</html>