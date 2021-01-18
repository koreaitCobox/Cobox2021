<%@page import="com.koreait.cobox.model.common.Pager"%>
<%@page import="com.koreait.cobox.model.domain.Location"%>
<%@page import="com.koreait.cobox.model.domain.Genre"%>
<%@page import="com.koreait.cobox.model.domain.Movie"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
 List<Movie> movieList = (List)request.getAttribute("movieList");
out.print("movieList의 사이즈"+movieList.size());
Pager pager=new Pager();
pager.init(request,movieList); 

%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="../inc/header.jsp"%>

<script src="http://code.jquery.com/jquery-1.4.4.min.js"></script>
<script>
/* $(document).ready(function() {
	getTheaterList();
	}); */
	//0번째 셀렉트 -->지역선택
$(function(){
	$($("select")[0]).change(function(){
		getTheaterList(this);
	});
});
	//2번째 셀렉트-->장르선택
$(function(){
	$($("select")[2]).change(function(){
		getGenreMovieList(this);
		
	});
});
/* $(function(){
	$($("select")[3]).change(function(){
		showselectmovie(this);
		
	});
});	 */
	
	//지역선택-->영화관 선택
	function getTheaterList(obj){
		//alert($(obj).val());
		
		$.ajax({
			url:"/client/movie/theater",
			type:"get",
			data:{
				location_id:$(obj).val()	
			},
			success:function(result){
				//alert("결과는"+result);
				
				$($("select")[1]).empty();
				$($("select")[1]).append("<option>영화관</option>");
				
				
				for(var i=0;i<result.length;i++){
					var theater=result[i];
					$($("select")[1]).append("<option value=\""+theater.theater_id+"\">"+theater.theater_name+"</option>");
				}
				
			}
		});
	}
	//리턴값은 movie_id 가List로 날라온다
	//obj 는 genre_name 이므로 controller에넘겨준다
	function getGenreMovieList(obj){
		//alert($(obj).val());
	
	$.ajax({
		url:"/client/movie/genremovie",
		type:"get",
		data:{
			genre_name:$(obj).val()
		},
		success:function(result){
			//alert("결과는"+result);
			
			$($("select")[3]).empty();
			$($("select")[3]).append("<option>movie_id</option>");
			
			for(var i=0;i<result.length;i++){
				var genremovie=result[i];
				console.log("넘어온 movie_id 는"+genremovie.movie_id);
				$($("select")[3]).append("<option value=\""+genremovie.movie_id+"\">"+genremovie.movie_id+"</option>");
				
				
				
				
			}
			//genre_name에 맞는 movie_id가 넘어옴.
			//만약 셀렉 박스에서 romance 를 선택하면 
			//그에맞는 movie_id 가 목록에 뿌려져야 한다
			
			
		}
	});
	}

	
	
	
	
	
</script>
	

</head>
<body class="single-cin">
    <div class="wrapper">
    <%@include file="../inc/top.jsp"%>         
        <!-- Main content -->
        <section class="container">
            <div class="col-sm-12" id="movielist">
                <h2 class="page-heading">영화 목록</h2>
                <div class="select-area">
                    <form class="select" method='get'>
                    <!-- 도시 -->
                          지역선택 <select>
                            
                           
                           <option value="1">서울</option>
                           <option value="2">경기</option>
                           <option value="3">인천</option>
                           <option value="4">강원</option>
                           <option value="5">대구</option>
                           <option value="6">충청</option>
                           <option value="7">부산</option>
                           <option value="8">울산</option>
                           <option value="9">제주</option>
                           
                        </select>
                    </form>

					<!-- 영화관선택 -->
					 <form class="select" method='get'>
                  	 영화관 <select>
              	             <option>영화관</option>
                  	     </select>
                    </form>
					<!-- 관람연령선택 -->
					 <form class="select" method='get'>
                    장르 <select>
                          
                           <option value="All">전체</option>
                           <option value="hrror">호러</option>
                           <option value="drama">드라마</option>
                           <option value="SF">SF</option>
                           <option value="romance">로맨스</option>
                           <option value="comic">코믹</option>
                           
                           <option value="ani">애니메이션</option>
                           <option value="noir">느와르</option>
                           <option value="docu">다큐</option>
                           <option value="music">음악</option>
                           <option value="mystery">미스테리</option>
                           
                           <option value="crime">범죄</option>
                           <option value="omnibus">옴니버스</option>
                           <option value="thriller">스릴러</option>
                           <option value="sports">스포츠</option>
                           <option value="saguk">사극</option>
                           
                           <option value="child">어린이</option>
                           <option value="action">액션</option>
                           <option value="adventure">어드벤처</option>
                           <option value="history">역사</option>
                           <option value="war">전쟁</option>
                           
                        </select>
                      </form>    
                     선택한 장르의 movie_id<select></select>
                 
                    <!--날짜선택 -->
                   <form class="select" method='get'>
                    <div class="datepicker">
                      <span class="datepicker__marker"><i class="fa fa-calendar"></i>Date</span>
                      <input type="text" id="datepicker" value='01/18/2021' class="datepicker__input">
                    </div>
                    </form>
                </div>
                <!-- Movie preview item -->
        
				<%for(int i=0;i<3;i++){ %>
				<%Movie movie=movieList.get(i); %>
				<div class="movie">
                <div class="movie movie--preview movie--full release">
                    <div class="col-sm-3 col-md-2 col-lg-2">
                            <div class="movie__images">
                            
                                <img src="/resources/data/<%=movie.getMovie_id()%>.<%=movie.getPoster()%>" alt="">
                            </div>
                    </div>
			<!-- 영화정보 -->
                    <div class="col-sm-9 col-md-10 col-lg-10 movie__about">
                            <a href='/client/movie/detail?movie_id=<%=movie.getMovie_id()%>' class="movie__title link--huge"><%=movie.getMovie_name() %></a>

                            <p class="movie__time">영화정보</p>
                            
                            
                            
                            <p class="movie__option"><strong>개봉일:<%=movie.getRelease() %> </strong></p>               
                            <p class="movie__option"><strong>배우:<%=movie.getActor() %> </strong></p>
                         <div class="movie__btns">
                                <a href="#" class="btn btn-md btn--warning">book a ticket <span class="hidden-sm">for this movie</span></a>
                                <a href="#" class="watchlist">Add to watchlist</a>
                            </div>
                    </div>
                </div>
                </div>
                        <div class="clearfix"></div>
                <%} %>
                <!-- end movie preview item -->
                <div class="coloum-wrapper">
                    <div class="pagination paginatioon--full">
                            <a href='/client/movie/list?moviePage=1' class="pagination__prev">prev</a>
                            <a href='/client/movie/list?moviePage=2' class="pagination__next">next</a>
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