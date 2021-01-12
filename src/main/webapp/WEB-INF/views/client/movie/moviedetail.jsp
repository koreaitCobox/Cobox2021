<%@page import="com.koreait.cobox.model.domain.Movie"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
Movie movie=(Movie)request.getAttribute("movie"); 


%>
<!DOCTYPE html>
<html>
<head>
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
								<strong>장르: </strong><a>장르 테이블에서 꺼내기</a>
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
								<strong>관람연령: </strong><a ><%=movie.getRating_id() %></a>
							</p>
							<p class="movie__option">
								<strong>줄거리: </strong><a><%=movie.getStory() %></a>							
							</p>
							
						<a href="#" class="btn btn-md btn--warning"><%=movie.getMovie_name() %> 예매하기</a>
							<p>
							<a href="#" class="comment-link">Comments: 15</a>
						</div>
					</div>
						<div class="clearfix"></div>
					<h2 class="page-heading">줄거리 요약</h2>

					<p class="movie__describe">영화 상세내용 올곳(json??)</p>
				</div>
				<div class="clearfix"></div>
				<h2 class="page-heading">영화 후기 (15)</h2>

				<div class="comment-wrapper">
					<form id="comment-form" class="comment-form" method='post'>
						<textarea class="comment-form__text"
							placeholder='Add you comment here'></textarea>
						<label class="comment-form__info">250 characters left</label>
						<button type='submit'
							class="btn btn-md btn--danger comment-form__btn">add
							comment</button>
					</form>

					<div class="comment-sets">

						<div class="comment">
							<div class="comment__images">
								<img alt='' src="/resources/images/comment/avatar.jpg">
							</div>

							<a href='#' class="comment__author"><span
								class="social-used fa fa-facebook"></span>Roberta Inetti</a>
							<p class="comment__date">today | 03:04</p>
							<p class="comment__message">아주 재밌어요</p>
							<a href='#' class="comment__reply">Reply</a>
						</div>

						<div class="comment">
							<div class="comment__images">
								<img alt='' src="/resources/images/comment/avatar-olia.jpg">
							</div>

							<a href='#' class="comment__author"><span
								class="social-used fa fa-vk"></span>Olia Gozha</a>
							<p class="comment__date">22.10.2013 | 14:40</p>
							<p class="comment__message">짱짱 울었어요</p>
							<a href='#' class="comment__reply">Reply</a>
						</div>

						<div class="comment comment--answer">
							<div class="comment__images">
								<img alt='' src="/resources/images/comment/avatar-dmitriy.jpg">
							</div>

							<a href='#' class="comment__author"><span
								class="social-used fa fa-vk"></span>Dmitriy Pustovalov</a>
							<p class="comment__date">today | 10:19</p>
							<p class="comment__message">진짜여???</p>
							<a href='#' class="comment__reply">Reply</a>
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