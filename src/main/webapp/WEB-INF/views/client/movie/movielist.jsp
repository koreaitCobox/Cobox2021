<%@page import="com.koreait.cobox.model.domain.Snack"%>
<%@page import="com.koreait.cobox.model.common.Pager"%>
<%@page import="com.koreait.cobox.model.domain.Location"%>
<%@page import="com.koreait.cobox.model.domain.Genre"%>
<%@page import="com.koreait.cobox.model.domain.Movie"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
List<Snack> snackList = (List)request.getAttribute("snackList");

%> 
<!DOCTYPE html>
<html>
<head>
<%@ include file="../inc/header.jsp"%>
<script type="text/javascript" src="./chart.js"></script>
<script src="http://code.jquery.com/jquery-1.4.4.min.js"></script>
<script>
 $(document).ready(function() {
	
	//달력 생성
	$("#datepicker").datepicker({
		dateFormat : 'yy-mm-dd'
	});
	 
	$("#datepicker").datepicker('setDate', 'today');
	
	
    $("#search_text01").keyup(function(){
		var v_ = this.value.split(" ").join("");
		this.value = v_;
		if(v_.length > 20){
			alert("검색어가 너무 깁니다.");
			this.value = v_.substr(0,10);
		}
	});	
	
	
 var page = 1;
 /* var pageSize = ('#selNum').val(); */
 var search = $('.search_input1').val();
 var searchSelect = searchSelect = $('select[name=searchSelect] option:selected').val();
 
 var params = {
		 page:parseInt(page, 10),
		 pageSize : parseInt(10, 10),
		 search : search,
 		 searchSelect : searchSelect
 }
 
 
/* 팝업창 닫기 */
$('#btn_close').click(function(){
	 if (!confirm("바로예매창을 닫겠습니까?")) {
	        // 취소(아니오) 버튼 클릭 시 이벤트
	 } else {
	 	$('#reserve_popup').dialog('close');
	 }
});


	//박스명 가져오기
 $.ajax({
		type:'POST',
		url:'/client/movie/getBoxList',
		dataType:'json',
		success:function(data){
			
			var boxList = data.boxList;
			var htmlStr='';
			
			
			$.each(boxList, function(idx,obj){
				htmlStr += '<option value="'+obj.box_id+'" id="box_sel">'+obj.box_name+'</option>'
				/* htmlStr += '<input type="hidden" id="boxId" value="'+obj.box_id+'">' */
			});
			$('#search_sel02').empty().append(htmlStr);
		}
	});

		

	//셀렉박스 선택하면 그에 맞는 가격이 input text 에 표출되도록
	//selectbox change event
	
		$("#search_sel02").change(function(){
			
			var params= {
				box_id : $("#search_sel02").val()
			};

			$.ajax({
				type:'POST',
				url:'/client/movie/getBoxPrice',
				dataType:'json',
				data:params,
				success:function(data){	
					var box_price = data.box_price;
					var htmlStr='';
					
					htmlStr += '<input type="text" value="'+box_price+' 원" class="text_box" readonly>'
					$('#box_price').empty().append(htmlStr);
					
				}
			});
		});
/* 탭 클릭시 이벤트 */	 
	
$(".gnb_m1").on("click","li",function(){
	
	var className = $(this).attr('class');
	 // 버튼 눌렀을 때 'active' 활성화
	$(".gnb_m1 > li").not(this).removeClass("active"); // 클릭한 li 제외하고 다른 li 에 있는 active 삭제
  	$(this).addClass("active");
	
	if(className.indexOf('08')>0){//영화목록 눌렀을때
		$('.m_container').show();
		$('.s_container').hide();
	}else{//스낵담기 눌렀을 때 
		$('.m_container').hide();
		$('.s_container').show();
		
			//스낵담기 눌렀을 때 스낵 전체 가져오기
				$.ajax({
				type:'POST',
				url:'/client/snack/snackList',
				dataType:'json',
				data:params,
				success:function(data){	
					
					var snackList = data.snackList;
					var htmlStr='';
	
					$.each(snackList, function(idx,obj){
					
					htmlStr+='<div class="snack_card">';
					if(obj.used_fl.indexOf('Y')==-1){//만약 품절등록 되있으면 
						htmlStr+='<img src="https://eventimg.auction.co.kr/md/auction/08A7AD0E8F/soldout_col3.png?ver=0.2" id="img_'+obj.snack_id+'"/>'
					}else{
						htmlStr+='<img src="/resources/data/'+obj.snack_id+'.'+obj.filename+'">';
					}
					htmlStr+='<div class="s_detail">';
					htmlStr+='<span>'+obj.snack_name+'</span></br>';
					htmlStr+='<span>'+obj.detail+'</span>';
					htmlStr+='<div class="updown">';
					htmlStr+='<span>수량 : </span>';
					htmlStr+='<span id = "numberUpDown" class="'+obj.snack_id+'">0</span>';
					if(obj.used_fl.indexOf('Y')!=-1){//만약 품절등록 되있으면 
						htmlStr+='<a href="#" onclick="inc_dec(\'inc\','+obj.snack_id+')" id="increaseQuantity class="'+obj.snack_id+'_in">▲</a>';
						htmlStr+='<a href="#" onclick="inc_dec(\'dec\','+obj.snack_id+');" id="decreaseQuantity class="'+obj.snack_id+'_de">▼</a>';
					}
					htmlStr+='</div>';
					htmlStr+='<div class="sum"><span class="'+obj.snack_id+'_p" >0원</span></div>';
					htmlStr+='<input type="hidden" id="'+obj.snack_id+'_price" value="'+obj.price+'">'
					htmlStr+='</div>'
					htmlStr+='</div>'
					
					$('.s_container').empty().append(htmlStr);
					
					});
				}
			});		
	}	
});

// schedule에 데이터 insert 하고  pay 페이지로 이동
$('#btn_pay').click(function(){
	
	<%for(int i=0;i<snackList.size();i++){%> 
		var snack_id = <%=snackList.get(i).getSnack_id()%>;	
		if($('.'+snack_id).text()>0){ // 1개 이상 구매 할 때 insert 및 update  
			//console.log(snack_id +'::'+ $('.'+snack_id).text());
			var sales_amount  = $('.'+snack_id).text();
			
			var params = {
				snack_id : snack_id,
				sales_amount : sales_amount
			}
			
			// 스낵 통계 insert  해당 snack에 대한 데이터가 이미 있으면 
			$.ajax({
				type:'POST',
				url:'/client/snack/insertSnackStat',
				dataType:'json',
				data:params,
				success:function(data){
					console.log('insert의 결과 : ' + data); // 데이터가 이미 있어서 insert가 안되면 0
				}
			});
			
			// 스낵 판매량 update 
			$.ajax({
				type:'POST',
				url:'/client/snack/updateSnackCnt',
				dataType:'json',
				data:params,
				success:function(data){
					console.log('update의 결과 : ' + data); // update 성공 시 1
				}
			});
		}
	<%}%>
	
	 if(window.confirm('결제하시겠습니까?')){
		//네
		var _total_price=$('#boxsnack_pri').text();
		var regax = /[^0-9]/g;
		
		var params = {
		
			  member_id:1,
			  box_id:$('#box_sel').val(),
			  time_table_id:$('#search_sel option:selected').val(),
			  movie_id:$('#movieId').val(),
			  use_day:$('#use_date').val(),
			  total_price : _total_price.replace(regax, "") // 숫자만 추출하기 
		
		};
		
		$.ajax({
			type : 'POST',
			url : '/client/movie/pay',
			async: false,
			dataType:'json',
			data : params,
			success : function(data) {
				//결제페이지로 넘기기
				location.href = "/client/movie/payPage?member_id="+params.member_id;
			}
		}); // ajax end
		
	}//window confirm end 

	
}); 
 
}); //document ready end

 
//스낵 개수 증감 
function inc_dec(choice,snack_id){

		var box_price = $('#box_price1').text();
		var stat = $('.'+snack_id).text();
		var num = parseInt(stat,10); //스낵개수
		var snack_price = $('#snack_price').text(); // 스낵 총 결제금액
	
	if(choice=='inc'){
		
		//클래스가 snack_id 인 것의 text를 num으로 변경 
		num++;
	
			if(num>5){
				alert('더이상 늘릴수 없습니다.');
				num=5;
			}
			
		$('.'+snack_id).text(num);	// 스낵 개수
		 var p = $('#'+snack_id+'_price').val(); //스낵 가격
		var total_p = p * num ; 
		
		$('.'+snack_id+'_p').text(total_p + '원'); //스낵 카드 안의 가격
		
		var snack_to = parseInt(snack_price,10) + parseInt(p,10); // 스낵 총 결제금액 + 개당 금액 
		$('#snack_price').text(snack_to + '원'); //스낵 총 결제금액
	
		var total = parseInt(box_price,10) + parseInt(snack_to,10);
		$('#boxsnack_pri').text('총 결제금액 : ' + total+'원');
		
	}else{
		
		
		num--;
		if(num<0){
			alert('더이상 줄일수 없습니다.');
			num =0;
		}else{
			$('.'+snack_id).text(num);
			var p = $('#'+snack_id+'_price').val(); 
			var snack_to = parseInt(snack_price,10) - parseInt(p,10); // 스낵 총 결제금액 - 개당 금액 
			var total_p = p * num;
			
			$('.'+snack_id+'_p').text(total_p + '원');//스낵카드안의 스낵 가격
			
			
			 if(snack_to < 0){
				$('#snack_price').text('0');
			}else{
				$('#snack_price').text(snack_to +'원'); // 스낵 총 결제금액
			} 
			 var total = parseInt(box_price,10) + parseInt(snack_to,10);
			$('#boxsnack_pri').text('총 결제금액 : ' + total+'원');
		} 
	}
	
	
}

/*  바로예매 눌렀을 때 */
function direct_reserve(movieList){
	 var chk_date = document.getElementById('datepicker').value; //이용날짜
	 var box = $("#search_sel02").val(); //box val
	 
	 /* console.log('선택한 movie_id는 : ' + movieList);
	 console.log('선택한 box는 : ' + box);
	 console.log('선택한 날짜는 : '+chk_date); */
	 
	 var param= {
				movie_id : movieList
			};
	
	
	 // movie_id 로 바로예매창에 뿌릴 내용 가져오기
	 $.ajax({
			type:'POST',
			url:'/client/movie/getM',
			dataType:'json',
			data:param,
			success:function(data){	
				var pop_movie = data;
				var genre = [];
				var rating = data.rating.rating_name;
				var genreList = data.genreList;
				
				//내용 자르기 (정규식으로 태그 모두 지우기)
				var story = data.story;
				var simple_s = story.replace(/(<([^>]+)>)/ig,"");
				
				var htmlStr='';
				
				
				genreList.forEach(function(item){
					genre.push(item.genre_list_name);
				});
			
		
				htmlStr+='<img src = "/resources/data/'+pop_movie.movie_id+'.'+pop_movie.poster+'" style="max-width:100%;">';
			 	htmlStr+='<div class="col-sm-8 col-md-9 m_info">'
				htmlStr+='<p class="movie__option">'
				htmlStr+='<strong>장르: </strong>'+genre
				htmlStr+='</p>'
				htmlStr+='<p class="movie__option">'
				htmlStr+='<strong>개봉일: </strong><a>'+pop_movie.playdate+'</a>'
				htmlStr+='</p>'
				htmlStr+='<p class="movie__option">'
				htmlStr+='<strong>감독: </strong><a>'+pop_movie.actor+'</a>'
				htmlStr+='</p>'	
				htmlStr+='<p class="movie__option">'
				htmlStr+='<strong>배우: </strong>'+pop_movie.actor
				htmlStr+='</p>'	
				htmlStr+='<p class="movie__option">'
				htmlStr+='<strong>관람연령: </strong><a>'+rating+'</a>'					
				htmlStr+='</p>'
				htmlStr+='<p class="movie__option">'
				htmlStr+='<strong>줄거리: </strong><a>'+simple_s+'...</a>'							
				htmlStr+='</p>' 
				htmlStr+='</div>'     
			 	htmlStr+='<input type="hidden" id="movieId" value='+pop_movie.movie_id+'>'
			
				$('.movie__images1').empty().append(htmlStr);
				
			}
		});
	 
	 //선택한 박스, 이용날짜, 이용시간 심기 
	 $.ajax({
			type:'POST',
			url:'/client/movie/getBoxList',
			dataType:'json',
			success:function(data){
				console.log(data);
				var boxList = data.boxList;
				var htmlStr='';
				
				
				$.each(boxList, function(idx,obj){
					htmlStr += '<option value="'+obj.box_id+'" id="box_sel">'+obj.box_name+'</option>'
					
				});
				$('#search_sel03').empty().append(htmlStr);
			}
	});
	
	 //조건검색에서 선택한 박스명으로 팝업창 띄우기
	 setTimeout(function(){
	 	$('#search_sel03').val(box).trigger('change');
	 },200);
	 
	 //이용날짜 값 넣기
	 $('#use_date').val(chk_date);
	 
	 //선택된 박스명에 맞는 가격 설정하기
	 var params= {
				box_id : box
			};

			$.ajax({
				type:'POST',
				url:'/client/movie/getBoxPrice',
				dataType:'json',
				data:params,
				success:function(data){	
					var box_price = data.box_price;
					var snack_price = $('#snack_price').text();
					var total = box_price + snack_price;
					console.log(box_price);
					console.log(snack_price);
					console.log(total);
					var htmlStr='';
					htmlStr +='<span>▶ 박스 결제금액 : </span>'
					htmlStr += '<span id="box_price1">'+ box_price + '</span><br/>'
					htmlStr +=' <span>▶ 스낵 총 가격 : </span>'
					htmlStr += '<span id="snack_price"> 0 </span><br/>'
					htmlStr += '<hr>'
					htmlStr += '<span id ="boxsnack_pri">▶ 총 결제금액 :'+ total + '원</span>'
					$('.total_pri').empty().append(htmlStr);
					
				}
			});

	 if (!confirm("선택하신 날짜와 박스로 예매할까요?")) {
	        // 취소(아니오) 버튼 클릭 시 이벤트
	    } else {
	        
	    	$('#reserve_popup').dialog({
	    		title:'바로예매',
	    		modal:true,
	    		width:'800',
	    		height:'650',
	    		resizable:false,
	    		overlay:{ opacity: 0., background: '#000000'},
	    	});	    	
	    }

} //팝업창 function end 





</script>
	
</head>
<body class="single-cin">
    <div class="wrapper">
    <%@include file="../inc/top.jsp"%>         
        <!-- Main content -->
        <section class="container">
                <h2 class="page-heading">영화 목록</h2>
            <div class="search_table" id="movielist">
        		<form id="movieListForm" action="/client/movie/list" method="post">
     			<table>
     			<colgroup>
     				<col style="width:20%;">
     				<col style="width:20%;">
     				<col style="width:30%;">
     				<col style="width:30%;">
     			</colgroup>
     			<tbody>
     				<tr>
     					<th scope="row">영화검색</th>
     					<td colspan="2"><label for="search_sel01">
     						<select  id="search_sel01" class="search_select" name="searchSelect">
	     						<option value="title" <c:if test="${searchValues.searchSelect eq 'title' }">selected</c:if>>제목</option>
	     						<option value="actor"<c:if test="${searchValues.searchSelect eq 'actor' }">selected</c:if>>배우</option>
	     						<option value="all"<c:if test="${searchValues.searchSelect eq 'all' }">selected</c:if>>전체</option>
     						</select>
     						</label>
     						<label for="search_text01"><span class="blind">검색어</span>
     							<input type="text" id="search_text01 search" class="search_input1 text_box" name="search" value="${search}">
     						</label>
     					</td>
     				</tr>
	     			<tr>
     					<th scope="row">예매날짜</th>
     					<td><label for="datepicker" class="datepicker">
     						<span class="blind"></span>
     						<input type="text" id="datepicker" class="datepicker text_box" readonly>
     					</label>
     					</td>
     					<th scope="row">박스명 / 가격</th>
     						<td colspan="1">
     						<select  id="search_sel02" class="search_select">
	     						<option value="" id="">전체</option>
     						</select>
     						<label for="search_sel02" id="box_price">
     							<input type="text" value="가격" class="text_box" readonly>
     						</label>
     					</td>
     				</tr>
     			</tbody>
     			</table>
     			<div class="search_bottom">
						<span class="btn_wrap"><input type="submit" value="검색" name="btnSearch" id="btn_search" class="btn_search"></span>
				</div>
				</form>
                <!--영화 리스트-->
        
			<div class="movie">
					<c:forEach items="${movieList}" var ="movieList">
		                <div class="movie movie--preview movie--full release">
		                    <div class="col-sm-3 col-md-2 col-lg-2">
		                            <div class="movie__images">
		                            
		                                <img src="/resources/data/${movieList.movie_id}.${movieList.poster}" alt="">
		                            </div>
		                    </div>
					<!-- 영화정보 -->
		                    <div class="col-sm-9 col-md-10 col-lg-10 movie__about">
		                            <a href='/client/movie/detail?movie_id=${movieList.movie_id}' class="movie__title link--huge">${movieList.movie_name}</a>
		                            <p class="movie__time">영화정보</p>
		                            <p class="movie__option"><strong>개봉일:${movieList.playdate} </strong></p>               
		                            <p class="movie__option"><strong>배우:${movieList.actor} </strong></p>
		                         <div class="movie__btns">
	                                <a href="#" class="btn btn-md btn--warning" onclick="direct_reserve(${movieList.movie_id})">바로 예매 <span class="hidden-sm"></span></a>
	                                <a href="#" class="watchlist">영화 담기</a>
	                             </div>
		                    </div>
		                </div> 
                </c:forEach>
                
                <!-- 바로예매 팝업창  -->
              <div id="reserve_popup"  style="z-index:999; display:none;">
					<section>
						<div class="gnb_bottom1">
							<ul class="gnb_m1">
								<li class="menu08 active" style="width: 385px;  ">영화예매</li>
								<li class="menu09" style="width: 358px;  ">스낵담기</li>
							</ul>
						</div>
						<!-- 영화 정보 페이지 -->
						<div class="m_container">
						<div class="movie__images1" >  
									<img src = "/resources/data/13.jtif" style="max-width:100%;">
										<div class="col-sm-8 col-md-9 m_info">
											<p class="movie__option">
											<strong>장르: </strong>로맨스
											</p>
											<p class="movie__option">
											<strong>개봉일: </strong><a>2021-12-23</a>
											</p>
											<p class="movie__option">
											<strong>감독: </strong><a>김수연</a>
											</p>
											<p class="movie__option">
											<strong>배우: </strong>송강
											</p>	
											<p class="movie__option">
											<strong>관람연령: </strong><a>12세관람가</a>					
											</p>
											<p class="movie__option">
											<strong>줄거리: </strong><a>내용</a>							
											</p>
										</div>
						</div> <!-- movie__images1  -->
							<div class="sel_box">
								<ul class="schbx">
									<li>
					                	<label>박스명</label>
					                	<select id="search_sel03" name="selectArea">
					                		<option value="0">전체</option>
					                		<option value="1">스윗</option>
					                		<option value="2">쿨</option>
					                		<option value="3">핫</option>
					                	</select>
					                </li>
					                 <li>
					                    <label>이용날짜</label>
					        			<span class="calendar">
					                        <input type="text"  id="use_date" class="dataPick text_box" readonly style="width:120px;"/>
					                    </span>
					                </li>
									<li>
					                	<label>이용시간</label>
					                	<select id="search_sel" name="selectArea">
					                		<option value="1">9-12시</option>
					                		<option value="2">13-16시</option>
					                		<option value="3">17-20시</option>
					                		<option value="4">21-24시</option>
					                		<option value="5">1-4시</option>
					                		<option value="6">5-8시</option>
					                	</select>
					                </li>
				                </ul>
							</div>
							</div>
							
							<!-- 스낵 분류  -->
							<div class="s_container" style="display:none;">
								<div class="snack_card">
									<img src="/resources/data/1.png">
									<div class="s_detail">
										<span>칠리핫도그 </span><br/>
										<span>품명 설명:달콤</span>
									
										<!-- 수량 변경 -->
										<div class="updown">
											<span>수량 : </span>
					                    	<span id="numberUpDown">1</span>
					                    	<a href="#" id="increaseQuantity">▲</a>
	    									<a href="#" id="decreaseQuantity">▼</a>
					                	</div>
				                		<div class="sum">40,000원</div>
			                		</div>
								</div>
	   						</div>
	   		
   				

							
							<div class="total_bottom">  
								<div class="total_pri">
									<span>박스 결제금액 : </span>
									<span>스낵 결제금액 : </span>
									<span>총 결제금액 : </span>
								</div>
								<div class="btn_popup ">
									<span class="btn_wrap"><input type="button" value="닫기" name="btnSearch" id="btn_close" class="btn_res" ></span>
									<span class="btn_wrap"><input type="button" value="결제하기" name="btnSearch" id="btn_pay" class="btn_res"></span>
								</div>
							</div> 
					</section>
					
				</div>  <!--  -->	
            
                
                <!-- end movie preview item -->
                <%-- <!-- <<<<prev 버튼 눌렀을 때 페이징 처리 -->
                
                <div class="coloum-wrapper">
                    <div class="pagination paginatioon--full">
                <%if((pager.getFirstPage()-1)>=1){ %>
                	<a href ='/client/movie/list?currrentPage=<%=pager.getFirstPage()-1 %>' class="pagination_prev">prev</a>
                            <%}else{ %>
                            <a href="javascript:alert('첫 페이지입니다.');" class="pagination__prev">prev</a>
                            <%} %>
                            
                    </div>
                </div>
                <!-- <<<<prev 버튼 눌렀을 때 페이징 처리 -->
                
                <!--페이징 숫자 눌렀을때 처리 -->
                <div class="pagination" align="center">
                	<%for(int i=pager.getFirstPage();i<=pager.getLastPage();i++){ %>
                		<%if(i>pager.getTotalPage())break; %>
                		<a <%if(pager.getCurrentPage()==i){ %> class="pageNum"<%} %> href="/client/movie/list?currentPage=<%=i %>">[<%=i %>]</a>  
                	<%} %>
                </div>
                
                <!--   >>>>next 버튼 눌렀을 때 페이징 처리  -->
                <div class="coloum-wrapper">
                    <div class="pagination paginatioon--full">
                <%if((pager.getLastPage()+1)<pager.getTotalPage()){ %>
   	             	<a href="/client/movie/list?currentPage=<%=pager.getLastPage()+1 %>" class="pagenation_next">next</a>
               	<%}else{ %>
                     <a href="javascript:alert('마지막 페이지입니다.');" class="pagination__next">next</a>
                     <%} %>
                	</div>
                </div>
                 --%>
       
                
            </div>
        </section>
    <%@include file="../inc/footer.jsp"%>
    </div>
    <%@include file="../inc/script.jsp"%>

</body>
</html>