<%@page import="com.koreait.cobox.model.domain.Comments"%>
<%@page import="java.util.List"%>
<%@page import="com.koreait.cobox.model.domain.GenreList"%>
<%@page import="com.koreait.cobox.model.domain.Member"%>
<%@page import="com.koreait.cobox.model.domain.Genre"%>
<%@page import="com.koreait.cobox.model.domain.Movie"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
Movie movie=(Movie)request.getAttribute("movie");
//Member member=(Member)request.getAttribute("member");
%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<style>
.reply-list{
	background:yellow;

}

</style>
<script src="//code.jquery.com/jquery-1.10.2.js"></script>
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
<script src="http://cdn.ckeditor.com/4.15.1/standard/ckeditor.js"></script>
<script>
//온로드 하자마자 댓글 가져오기
$(document).ready(function() {
	//alert("온로드");
	$('.comment-form__btn').on("click", function(){
		console.log('asdasd');
	});
	
});

//예매하기 클릭하면 팝업창 띄우기
function showPopup(){
	
	
}


//댓글 목록 가져오기
function getCommentsList(){
	
	$.ajax({
		url:"/client/comments/list",
		type:"get",
		data:{
			movie_id:<%=movie.getMovie_id()%>
		},
		success:function(result){
			console.log(result);
			
			var htmlStr = '';
			$.each(result, function(idx, obj){
				htmlStr += '<div class="comment-sets">';
				htmlStr += '<div class="comment">';
				htmlStr += '<div class="comment__images">';
				/* htmlStr += '<img alt='' src=\"/resources/images/comment/avatar.jpg\">'; */
				htmlStr += '</div>';
				htmlStr += '<div class="msg">';
				htmlStr += obj.msg;
				htmlStr += '</div>';
				htmlStr += '</div>';
				htmlStr += '</div>';
			});
			$('.m_detail tbody').empty().append(htmlStr);
		}
	});
}

//if(session.getAttribute("member")==null
//이면 "로그인을 해주세요"

//else if()!=null
//이면 "댓글등록"

//댓글등록 요청
function registComment(){
	console.log('asd');
	var msg=$("textarea[name='msg']").val();
	var movie_id=<%=movie.getMovie_id()%>
	
	var params = {
		msg : msg,	
		movie_id : movie_id,
		//member_id : 1,
	}
	
	$.ajax({
		url:"/client/comments/json",
		type:"post",
		data:params,
		success:function(result){
			alert("받은 결과"+result);
			$('textarea').val('');
			if(result==1){// result 를 잘 받아왔다면, 
				getCommentsList(); 
			}else{ 
				getCommentsList(); 
			}
		},
		error: function(e){
			alert('댓글등록 오류');
		}
	});
}



</script>


<%@ include file="../inc/header.jsp"%>
</head>
<body class="single-cin">
	<div class="wrapper">
		<%@include file="../inc/top.jsp"%>
		<!-- Main content -->
		<section class="container">
			<div class="col-sm-12 m_detail">
				<div class="movie">
					<h2 class="page-heading"><%=movie.getMovie_name() %></h2>

					<div class="movie__info">
						<div class="col-sm-4 col-md-3 movie-mobile">
							<div class="movie__images">
								<img alt='' src="/resources/data/<%=movie.getMovie_id()%>.<%=movie.getPoster()%>">
							</div>
						</div>

						<div class="col-sm-8 col-md-9">
							<p class="movie__time">169 min</p>

							<p class="movie__option">
							
								<strong>장르: </strong><%for(GenreList genre:movie.getGenreList()){ %><a><%=genre.getGenre_list_name() %>,</a>
							<%} %> 
							</p>
							<p class="movie__option">
								<strong>개봉일: </strong><a ><%=movie.getPlaydate() %></a>
							</p>
							<p class="movie__option">
								<strong>감독: </strong><a><%=movie.getDirector() %></a>
							</p>
							<p class="movie__option">
								<strong>배우: </strong><%=movie.getActor() %>
							</p>
							<p class="movie__option">
								<strong>관람연령: </strong><a ><%=movie.getRating().getRating_name()%></a>
							</p>
							<p class="movie__option">
								<strong>줄거리: </strong><a><%=movie.getStory() %></a>							
							</p>
							
						<a href="#" onclick="showPopup();" class="btn btn-md btn--warning"><%=movie.getMovie_name() %> 예매하기</a>
							<p>
							<a href="#" class="comment-link">Comments: 15</a>
						</div>
					</div>
				</div>
				
				<div class="clearfix"></div>
				<h2 class="page-heading">영화 후기 (15)</h2>
				
				<div class="comment-wrapper">
					<form id="comment-form" class="comment-form" method='post'>
						<textarea class="comment-form__text"
							placeholder='후기를 작성하세요' name="msg" id="msg"></textarea>
						<input type="button" class="btn btn-md btn--danger comment-form__btn"  onclick="registComment();" value="댓글등록">
					</form>
				</div>	
				<tbody>
					<div class="comment-sets">
					<c:forEach items="${commentsList}" var="commentsList">
						<div class="comment">
							<div class="comment__images">
								<img alt='' src="/resources/images/comment/avatar.jpg">
							</div>
							<div class="msg">
								${commentsList.msg}
							</div>
						</div>
					</c:forEach>
				 </div>
			 </tbody>
			<div class="comment-more">
				<a href="#" class="watchlist">Show more comments</a>
			</div>
			</div>
	</section>
 	<!-- 발현율 팝업 -->
        	<div id="reserve_popup"  style="z-index:999; display:none;" >
        	
			  	java 초급<br>
			    java 중급<br>
			    java 고급<br>
			    강좌가 새롭게 업로드되었습니다.

			</div> 
			
	<%@include file="../inc/footer.jsp"%>
	</div>
	<%@include file="../inc/script.jsp"%>
</body>
</html>