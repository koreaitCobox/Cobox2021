<%@page import="java.util.List"%>
<%@page import="com.koreait.cobox.model.domain.Movie"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
List<Movie> movieList=(List)request.getAttribute("movieList"); 
%>

<!doctype html>
<html>
<head>
<%@ include file="client/inc/header.jsp"%>
<script> 


</script>

</head>
<body class="single-cin">
   <div class="wrapper" id="content">
   <%@ include file="client/inc/top.jsp" %>
   <!-- Main content -->
        <section class="cinema-container">
            <div class="cinema cinema--full">
                <p class="cinema__title">Cobox</p>
              <div class="cinema__rating">5.0</div>
                
                          <%for(int i=0;i<1;i++){ %> 
                          <%Movie movie=movieList.get(0); %>
                <div class="cinema__gallery">
                    <div class="swiper-container">
                      <div class="swiper-wrapper">
                          <!--First Slide-->
                          <div class="swiper-slide" id="content"> 
                                <img alt='' src="/resources/data/<%=movie.getMovie_id()%>.<%=movie.getPoster()%>">
                          </div>
                         
                      </div>
                    </div>
                </div>
                          <%} %>
              <div class="cinema__info">
                    <p class="cinema__info-item"><strong>주소:</strong> 강남구 강남대로20-1 위워크 </p>
                    <p class="cinema__info-item"><strong>연락처:</strong> 070 4532 5333</p>
                    <p class="cinema__info-item"><strong>gitHub:</strong> <a href="#">www.myvue.com</a></p>
                </div>
            </div>
            <div class="tabs tabs--horisontal">
            </div>
        </section>
    <%@include file="client/inc/footer.jsp" %>
   </div>
   <%@include file="client/inc/script.jsp"%>
   <!-- Custom -->
   <script src="/resources/js/custom.js"></script>
   <script type="text/javascript">
      $(document).ready(function() {
         init_Home();
      });
   </script>
</body>
</html>

