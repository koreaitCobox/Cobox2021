<%@ page contentType="text/html; charset=UTF-8"%>
<!doctype html>
<html>
<head>
<%@ include file="client/inc/header.jsp"%>
</head>
<body class="single-cin">
   <div class="wrapper">
   <%@ include file="client/inc/top.jsp" %>
   <!-- Main content -->
        <section class="cinema-container">
            <div class="cinema cinema--full">
                <p class="cinema__title">Cinema name</p>
                <div class="cinema__rating">5.0</div>
                <div class="cinema__gallery">
                    <div class="swiper-container">
                      <div class="swiper-wrapper">
                          <!--First Slide-->
                          <div class="swiper-slide"> 
                                <img alt='' src="/resources/images/cinema/cinema-inner1.jpg">
                          </div>
                          
                          <!--Second Slide-->
                          <div class="swiper-slide">
                                <img alt='' src="/resources/images/cinema/cinema-inner2.jpg">
                          </div>
                          
                          <!--Third Slide-->
                          <div class="swiper-slide"> 
                                <img alt='' src="/resources/images/cinema/cinema-inner3.jpg">
                          </div>

                          <!--Four Slide-->
                          <div class="swiper-slide"> 
                                <img alt='' src="/resources/images/cinema/cinema-inner4.jpg">
                          </div>
                          
                          <!--Five Slide-->
                          <div class="swiper-slide">
                                <img alt='' src="/resources/images/cinema/cinema-inner5.jpg">
                          </div>
                          
                          <!--Six Slide-->
                          <div class="swiper-slide"> 
                                <img alt='' src="/resources/images/cinema/cinema-inner6.jpg">
                          </div>

                          <!--Seven Slide-->
                          <div class="swiper-slide"> 
                                <img alt='' src="/resources/images/cinema/cinema-inner7.jpg">
                          </div>
                          
                          <!--Eight Slide-->
                          <div class="swiper-slide">
                                <img alt='' src="/resources/images/cinema/cinema-inner8.jpg">
                          </div>
                          
                          <!--Nine Slide-->
                          <div class="swiper-slide"> 
                                <img alt='' src="/resources/images/cinema/cinema-inner9.jpg">
                          </div>
                      </div>
                    </div>
                </div>
                <div class="cinema__info">
                    <p class="cinema__info-item"><strong>Address:</strong> Leicester Sq, London, WC2H 7LP</p>
                    <p class="cinema__info-item"><strong>Phone:</strong> 0871 224 0240</p>
                    <p class="cinema__info-item"><strong>Official website:</strong> <a href="#">www.myvue.com</a></p>
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