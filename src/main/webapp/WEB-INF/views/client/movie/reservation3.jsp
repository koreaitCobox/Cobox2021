<%@ page contentType="text/html; charset=UTF-8"%>
<!doctype html>
<html>
<head>
<%@ include file="../inc/header.jsp"%>
</head>
<body class="single-cin">
	<div class="wrapper">
		<%@include file="../inc/top.jsp"%>
		<!-- Main content -->		
 	<section class="container">
 	<h2 class="page-heading">Reservation</h2>
       <div class="order-step-area">
           <div class="order-step first--step order-step--disable ">1.영화/상영관/날짜</div>
           <div class="order-step second--step order-step--disable">2.좌석선택</div>
           <div class="order-step third--step">3.결제하기</div>
       </div>

       <div class="col-sm-12">
           <div class="checkout-wrapper">
               <h2 class="page-heading">price</h2>
               <ul class="book-result">
                   <li class="book-result__item">Tickets: <span class="book-result__count booking-ticket">3</span></li>
                   <li class="book-result__item">One item price: <span class="book-result__count booking-price">$20</span></li>
                   <li class="book-result__item">Total: <span class="book-result__count booking-cost">$60</span></li>
               </ul>

               <h2 class="page-heading">Choose payment method</h2>
               <div class="payment">
                   <a href="#" class="payment__item">
                       <img alt='' src="/resources/images/payment/pay1.png">
                   </a>
                   <a href="#" class="payment__item">
                       <img alt='' src="/resources/images/payment/pay2.png">
                   </a>
                   <a href="#" class="payment__item">
                       <img alt='' src="/resources/images/payment/pay3.png">
                   </a>
                   <a href="#" class="payment__item">
                       <img alt='' src="/resources/images/payment/pay4.png">
                   </a>
                   <a href="#" class="payment__item">
                       <img alt='' src="/resources/images/payment/pay5.png">
                   </a>
                   <a href="#" class="payment__item">
                       <img alt='' src="/resources/images/payment/pay6.png">
                   </a>
                   <a href="#" class="payment__item">
                       <img alt='' src="/resources/images/payment/pay7.png">
                   </a>
               </div>

               <h2 class="page-heading">Contact information</h2>
       
               <form id='contact-info' method='post' novalidate="" class="form contact-info">
                   <div class="contact-info__field contact-info__field-mail">
                       <input type='email' name='user-mail' placeholder='Your email' class="form__mail">
                   </div>
                   <div class="contact-info__field contact-info__field-tel">
                       <input type='tel' name='user-tel' placeholder='Phone number' class="form__mail">
                   </div>
               </form>
           </div>
           <div class="order">
               <a href="book-final.html" class="btn btn-md btn--warning btn--wide">purchase</a>
           </div>
       </div>
   </section>

   <div class="booking-pagination">
           <a href="book2.html" class="booking-pagination__prev">
               <p class="arrow__text arrow--prev">prev step</p>
               <span class="arrow__info">좌석선택</span>
           </a>
   </div>
	<%@include file="../inc/footer.jsp" %>
	</div>
	<%@include file="../inc/script.jsp"%>
</body>
</html>
