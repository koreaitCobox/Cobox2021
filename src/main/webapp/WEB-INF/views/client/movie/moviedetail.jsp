<%@page import="com.koreait.cobox.model.domain.Member"%>
<%@page import="com.koreait.cobox.model.domain.Genre"%>
<%@page import="com.koreait.cobox.model.domain.Movie"%>
<%@ page contentType="text/html; charset=UTF-8"%>
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
<script src="http://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="http://cdn.ckeditor.com/4.15.1/standard/ckeditor.js"></script>
<script>
//온로드 하자마자 댓글 가져오기
$(document).ready(function() {
	//alert("온로드");
	
	getCommentsList();
	});
	
//댓글 목록 가져오기
function getCommentsList(){
	$.ajax({
		url:"/client/comments/list",
		type:"get",
		data:{
			movie_id:<%=movie.getMovie_id()%>
		},
		success:function(result){
			
			$("#list-area").html("");
			
			//alert("List사이즈"+result);
			
			var tag="";
			for(var i=0;i<result.length;i++){
			var json=result[i];	
			
			
			tag+="<p style=\"width:70%\">"+json.msg+"</p>";
			tag+="<p style=\"width:20%\">"+json.cdate+"</p>";
			//tag+="<p style=\"width:10%\">"+json.member_id+"</p>";
			
			}
			$("#list-area").html(tag); 
		}
	});
}

//if(session.getAttribute("member")==null
//이면 "로그인을 해주세요"

//else if()!=null
//이면 "댓글등록"

//댓글등록 요청
function registComment(){
	$.ajax({
		url:"/client/comments/json",
		type:"post",
		data:{
			msg:$("textarea[name='msg']").val(),
			movie_id:<%=movie.getMovie_id()%>
			<%-- member_id:<%=member.getMember_id()%> --%>
		},
		success:function(result){
			
			//alert("받은 결과"+result);
			$('textarea').val('');
			if(result==1){
				result(result);
				getCommentsList(); 
			}else{ //1이 안넘어오는것 같아서
				getCommentsList(); 
			}
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
			<div class="col-sm-12">
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
							
								<strong>장르: </strong><%for(Genre genre:movie.getGenreList()){ %><a><%=genre.getGenre_name() %>,</a>
							<%} %> 
							</p>
							<p class="movie__option">
								<strong>개봉일: </strong><a ><%=movie.getRelease() %></a>
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
							
						<a href="#" class="btn btn-md btn--warning"><%=movie.getMovie_name() %> 예매하기</a>
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
						
						
						<input type="button" class="btn btn-md btn--danger comment-form__btn" onClick="registComment()" value="댓글등록">
					</form>
				</div>	

					<div class="comment-sets">
	
						<div class="comment">
							<div class="comment__images">
								<img alt='' src="/resources/images/comment/avatar.jpg">
							</div>
							<div>
						<div id="list-area">
														
						</div>
						
						</div>

					
					
						
						

						

						<div class="comment-more">
							<a href="#" class="watchlist">Show more comments</a>
						</div>
					</div>
				</div>
			</div>
	</section>

	<%@include file="../inc/footer.jsp"%>
	</div>
	<%@include file="../inc/script.jsp"%>

	<script type="text/javascript">
		$(document).ready(function() {
			init_MovieList();
		});
	</script>
</body>
</html>