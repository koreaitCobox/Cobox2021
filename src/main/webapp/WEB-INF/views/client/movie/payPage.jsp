<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!doctype html>
<html>
<head>
<%@ include file="../inc/header.jsp"%>
<style>
input[type=checkbox] {
	-ms-transform: scale(2); /* IE */
	-moz-transform: scale(2); /* FF */
	-webkit-transform: scale(2); /* Safari and Chrome */
	-o-transform: scale(2); /* Opera */
	padding: 10px;
	margin-left:10px;
	
}
#paychk{
	width:50px;
	font-size:20px;
}

</style>
<script src="http://code.jquery.com/jquery-1.4.4.min.js"></script>
<script>
// 총 결제금액 
let total_total = 0; 
let len = 0;
function getCheckVal(event,total_price){
	var ch = $("input[name='ticket_chk']");
	len = $(ch).length;
	
	schedule = [];
	
	for(var i=0; i<len; i++){
		if($($(ch)[i]).is(":checked")){
			schedule.push($($(ch)[i]).val());
		}
		
	}
	console.log("서버에 전송할 배열 구성:" + schedule);
	len = schedule.length;
	if(event.target.checked){ // 체크 되있으면 결제할 가격에 +
		//result = event.target.value;
		total_total += total_price;
		
	}else{ // 체크 안되있으면 결제할 가격에 - 
		//result = '';
		total_total -= total_price
	}
	
	//document.getElementById('ticket_chk').innerText = result;
	//console.log(result);
	
	$('#total_total').text(total_total + '원'); 
	
}
$(document).ready(function() {
	let schedule = [];
/* 	$("input[type='ticket_chk']").on("click", function(e) {

	}); */
	
	
	$('#purchase').click(function(e){
		if(window.confirm(total_total +'원을 결제하시겠습니까?')){
			//네
			console.log(len);
			if(len>1){
				alert('하나씩 결제해주세요.');
			}else{
			
			var params = {
					schedule_id : $('#ticket_chk').val(),
					p_method_id : 1,
					total_price : total_total
			}
			//p_summary에 insert
 			$.ajax({
				type : 'POST',
				url : '/client/movie/payfinal',
				async : false,
				dataType : 'json',
				data : params,
				success : function(){
					alert('결제완료');
					location.href = "/client/movie/list";
					//console.log("insert 성공!");
				}
			});	  
			}
		}
	});
	
	
	
});//document end 


</script>


</head>
<body class="single-cin">
	<div class="wrapper">
		<%@include file="../inc/top.jsp"%>
		<!-- Main content -->		
 	<section class="container">
 	<h2 class="page-heading">결제 진행</h2>
       <div class="order-step-area">
           <!-- <div class="order-step first--step order-step--disable ">1.영화/상영관/날짜</div> -->
           <div class="order-step second--step order-step--disable">1.영화선택</div>
           <div class="order-step third--step">2.결제하기</div>
       </div>

       <div class="col-sm-12">
           <div class="checkout-wrapper">
               <h2 class="page-heading">결제 내용</h2>
         <!--       <ul class="book-result">
               	   <li class="book-result__item">영화제목: <span class="book-result__count booking-ticket">제목</span></li>
                   <li class="book-result__item">박스: <span class="book-result__count booking-ticket">스윗</span></li>
               	   <li class="book-result__item">사용날짜: <span class="book-result__count booking-ticket">2021-12-25</span></li>
               	   <li class="book-result__item">사용시간: <span class="book-result__count booking-ticket">12-3시</span></li>
                   <li class="book-result__item">Total: <span class="book-result__count booking-cost">30,000 원</span></li>
               </ul> -->
               <!--  -->
               <c:forEach items="${scheduleList}" var= "scheduleList">
                   <div class="ticket">
                    <div class="ticket-position">
                        <div class="ticket__indecator indecator--pre"><div class="indecator-text pre--text">online ticket</div> </div>
                        <div class="ticket__inner">

                            <div class="ticket-secondary">
                                <span class="ticket__item">Ticket number <strong class="ticket__number">a126bym4</strong></span>
                                <span class="ticket__item ticket__date">영화명 : ${scheduleList.movie_name}</span>
                                <span class="ticket__item ticket__time">이용시간 : ${scheduleList.user_time} 시</span>
                                <span class="ticket__item">박스명 <span class="ticket__cinema">${scheduleList.box_name}</span></span>
                                <span class="ticket__item ticket__price">총 결제금액: <strong class="ticket__cost">${scheduleList.total_price}</strong></span>
                            </div>

                            <div class="ticket-primery">
                                <span class="ticket__item ticket__item--primery ticket__film">영화<br><strong class="ticket__movie">${scheduleList.movie_name}</strong></span>
                                <span class="ticket__item ticket__item--primery">상영시간 : <span class="ticket__place">150분</span></span>
                            </div>
                        </div>
                        <div class="ticket__indecator indecator--post"><div class="indecator-text post--text">online ticket</div></div>
                    </div>
                    <span id="paychk">결제여부<input type="checkbox" name="ticket_chk" id="ticket_chk" value="${scheduleList.schedule_id}" onclick ='getCheckVal(event,${scheduleList.total_price})'></span>
                </div>
				</c:forEach>
				<h1> 총 결제 금액 : <span id="total_total">0 원</span></h1>
               <h2 class="page-heading">지불방법</h2>
               <div class="payment">
                   <a href="#" class="payment__item">
                       <img alt='paypal' src="/resources/images/payment/pay1.png">
                   </a>
                   <a href="#" class="payment__item">
                       <img alt='cash' src="/resources/images/payment/pay3.png">
                   </a>
                   <a href="#" class="payment__item">
                       <img alt='visa' src="/resources/images/payment/pay5.png">
                   </a>
               </div>

               <h2 class="page-heading">연락처</h2>
       
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
               <a href="#" class="btn btn-md btn--warning btn--wide" id="purchase">결제하기</a>
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
