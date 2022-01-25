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
System.out.println(movie);
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
	
	// 댓글 삭제

});//docuemnt ready end

function del_click(_this){
	var del_id = _this.id;
	
	if(confirm("삭제하시겠습니까?")){
		var seq = del_id.replace('bin_','');
		var movie_id=<%=movie.getMovie_id()%>
		var params = {
				checkedSeqs : seq,
				movie_id : movie_id
		};
		
		$.ajax({
			type : 'POST',
			url : '/client/comments/delete',
			data : params,
			success : function(result){
				
				var htmlStr = '';
				$.each(result, function(idx, obj){
					
					htmlStr += '<div class="comment-sets">';
					htmlStr += '<div class="comment">';
					htmlStr += '<div class="comment__images">';
					htmlStr += '<img src="/resources/images/comment/avatar.jpg">'; 
					htmlStr += '</div>';
					htmlStr += '<div class="msg">';
					htmlStr += obj.msg;
					htmlStr += '</div>';
					htmlStr += '<div class="btn_cont">';
					htmlStr += '<button class="btn-1 bnt-outline-danger del-icon" onclick="del_click(this);" id="bin_'+obj.comments_id+'">'
					htmlStr += '<span class="fa fa-trash-o"></span>'
					htmlStr += '</button>';
					htmlStr += '<button class="btn-1 bnt-outline-success" id="det_'+obj.comments_id+'">'
					htmlStr += '<span class="fa fa-pencil"></span>'
					htmlStr += '</button>'
					htmlStr += '</div>'
					htmlStr += '</div>';
					htmlStr += '</div>';
				});
					$('.comm_container').empty().append(htmlStr);
				
				},
			error: function(e){
				alert('댓글삭제 오류');
			}
			
		});
		
	}
}
function registComment(){
	
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
			
			/* alert("받은 결과"+result); */
			$('textarea').val(''); // 후기 작성 폼 clear
			var htmlStr = '';
			$.each(result, function(idx, obj){
				console.log(result);
				htmlStr += '<div class="comment-sets">';
				htmlStr += '<div class="comment">';
				htmlStr += '<div class="comment__images">';
				htmlStr += '<img src="/resources/images/comment/avatar.jpg">'; 
				htmlStr += '</div>';
				htmlStr += '<div class="msg">';
				htmlStr += obj.msg;
				htmlStr += '</div>';
				htmlStr += '<div class="btn_cont">';
				htmlStr += '<button class="btn-1 bnt-outline-danger del-icon" onclick="del_click(this);" id="bin_'+obj.movie_id+'">'
				htmlStr += '<span class="fa fa-trash-o"></span>'
				htmlStr += '</button>';
				htmlStr += '<button class="btn-1 bnt-outline-success" id="det_'+obj.movie_id+'">'
				htmlStr += '<span class="fa fa-pencil"></span>'
				htmlStr += '</button>'
				htmlStr += '</div>'
				htmlStr += '</div>';
				htmlStr += '</div>';
			});
			$('.comm_container').empty().append(htmlStr);
			
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
				<div class="comm_container">
					<div class="comment-sets">
					<c:forEach items="${commentsList}" var="commentsList">
						<div class="comment">
							<div class="comment__images">
								<img alt='' src="/resources/images/comment/avatar.jpg">
							</div>
							<div class="msg">
								<span>${commentsList.member.name}</span>
								${commentsList.msg}
							</div>
							<div class="btn_cont">
								<button class="btn-1 bnt-outline-danger del-icon" onclick="del_click(this);" id="bin_${commentsList.comments_id}">
									<span class="fa fa-trash-o"></span>
								</button>
								<button class="btn-1 bnt-outline-success" id="det_${commentsList.comments_id}">
									<span class="fa fa-pencil"></span>
								</button>
							</div>
						</div>
					</c:forEach>
				 </div>
				 </div>
			 
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