<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link type="text/css" rel="stylesheet" href="/resources/css/style.css">
<%@ include file="../inc/header.jsp" %>
<script type="text/javascript" src="/resources/js/chart.js"></script>
<script	src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.bundle.min.js"></script>
<title>Insert title here</title>


<script type="text/javascript">
$(document).ready(function(){
	//차트 생성
	chartInit();
	//접속했을 때 '팝콘' 클릭하도록 
	setTimeout(function(){
		$("#1").trigger("click");
	 },200);
	
	var infoBtn = $(".lnb > li ");//탭 클릭시 클릭한 div 색 넣기
	$(infoBtn).click(function(){
		var topcategory_id ;
	    $(infoBtn).not(this).removeClass('on');//클릭한 li를 제외하고 다른 li 는 class ="on" 삭제  
	
		$(this).toggleClass('on'); //클릭한 li에 class="on"   
		
		topcategory_id = $('.on').attr('id'); //스낵 분류 값 가져오기
		console.log(topcategory_id);
		var params = {
				topcategory_id : topcategory_id
		}
		
		$.ajax({
			type:'POST',
			url:'/admin/snack/ajaxList',
			dataType:'json',
			data:params,
			success:function(data){
				
				var snackList = data.snackList; 
				var htmlStr ='';
				
				
				$.each(snackList,function(idx,obj){
					htmlStr+='<div class="card_con">'
					console.log(obj.used_fl.indexOf('Y'));
					if(obj.used_fl.indexOf('Y')==-1){//만약 품절등록 되있으면 
						htmlStr+='<img src="https://eventimg.auction.co.kr/md/auction/08A7AD0E8F/soldout_col3.png?ver=0.2" id="img_'+obj.snack_id+'"/>'
					}else{//품절등록 안되있으면
				 		htmlStr+='<img src="/resources/data/'+obj.snack_id+'.'+obj.filename+'" id="img_'+obj.snack_id+'"/>'
					}
				 	htmlStr+='<div class="menu_detail">';
					htmlStr+='<table>';
					htmlStr+='<colgroup>';
					htmlStr+='<col width="23%;"/>';
					htmlStr+='<col width="23%;"/>';
					htmlStr+='<col width="23%;"/>';
					htmlStr+='<col width="23%;"/>';
					htmlStr+='</colgroup>';
					htmlStr+='<tr>';
					htmlStr+='<td>'+obj.snack_name+'</td>';
					htmlStr+='<td>재고 :'+ obj.amount+'</td>';
					htmlStr+='<td>'+obj.price+'원</td>';
					htmlStr+='<td><input type="button" value ="품절해제" class="soldout_btn" id="ns_'+obj.snack_id+'" onclick="soldin_btn(this, \''+obj.used_fl+'\');"/></td>';
					htmlStr+='</tr>';
					htmlStr+='<tr>';
					htmlStr+='<td>판매개수 : '+obj.sales_amount+'</td>';
					htmlStr+='<td>수익 : 100,000 원</td>';
					htmlStr+='<td>판매 등수 : 1 </td>';
					htmlStr+='<td><input type="button" value ="품절등록" class="soldout_btn" id="sn_'+obj.snack_id+'" onclick="soldout_btn(this, \''+obj.used_fl+'\');"/></td>'
					htmlStr+='</tr>';
					htmlStr+='</table>';
					htmlStr+='</div>';
					htmlStr+='<div class="del_chk" ><input type="checkbox" id="chkbox119_'+obj.snack_id+'" value="'+obj.snack_id+'"/></div>';
					htmlStr+='</div>'
				});
				
				$('.menu_1').empty().append(htmlStr);
		
			}
		});
		
	});
//  체크박스 체크된 항목 삭제 
$('#btnDelete').click(function(){
	if (window.confirm('삭제 하시겠습니까?')) {
		var checkedSeqs = '';
		
		$('input[type=checkbox]').each(function(){
			var checked = $(this).prop('checked');
			if(checked){//체크되있는 박스의 id를 다음으로 교체
				var seq = $(this).attr('id').replace('chkbox119_','');
				checkedSeqs += seq + ',';
				console.log(checkedSeqs);
			}
		});
	
		if(!checkedSeqs){
			alert("삭제할 스낵을 선택해주세요!");
			return;
		}
		
		var params = {
				checkedSeqs : checkedSeqs,
				
		}
		
		$.ajax({
			type:'POST',
			url:'/admin/snack/snackCheckDelete',
			dataType:'text',
			data:params,
			success:function(data){
				document.location.href = '/admin/snack/list';
			},
			error: function(e){
				alert("삭제오류");
			}
		});
	}

});
	
getSnack_stat();
});//document ready end

//스낵 통계 가져오기
function getSnack_stat(){
	
	$.ajax({
		type:'GET',
		url:'/admin/snack/selectSnackStat',
		dataType:'json',
		success:function(data){
			console.log(data);
			console.log(data.snackStatList);
			const snackStatList = data.snackStatList;
			const snack_name = [];
			const count = [];
			const label =['팝콘','핫도그','스낵','음료'];
			
			snackStatList.forEach(function(item){
				snack_name.push(item.topcategory_id);
				count.push(item.count);
		
			});
			
			console.log("snack_name : " + snack_name);
			console.log("count : " + count);
			
			stat.myChart.data.datasets[0].data = count; //차트에 데이터 심기
			console.log(stat.myChart.data.datasets[0].data);
			
		},
		error: function(e){
			alert("select 오류");
		}
	});
}


//품절 등록 버튼 눌렀을 떄 
function soldout_btn(_this, used_fl){
	
	if(_this.id.indexOf('sn')==0){ // 품절등록 버튼을 눌렀을 떄 
		var snack_id = _this.id.replace('sn_','');
	
		if(used_fl=='Y'){//품절 등록이 안되있으면 
			if (window.confirm('품절 등록 하시겠습니까?')) {
				used_fl='N'
				
				var params = {
						used_fl : used_fl,
						snack_id : snack_id
				}
				
				$.ajax({
					type:'POST',
					url:'/admin/snack/soldout',
					data : params,
					success : function(result){
						if(result.indexOf('1')){//품절등록 완료
							alert('품절등록 완료');
							/* $('#img_'+snack_id+'').attr("src","https://eventimg.auction.co.kr/md/auction/08A7AD0E8F/soldout_col3.png?ver=0.2");
							$('#sn_'+snack_id+'').css("display","none"); */
						}else{
							alert('품절 등록 실패');	
						}
						window.location.reload(true);
					}
				});
			}
		
	}else{//품절 등록이 되있으면 
		alert('이미 품절 등록 되었습니다.');
	}
	}
}
//품절 해제 버튼 눌렀을 떄 
function soldin_btn(_this, used_fl){
	
	if(_this.id.indexOf('ns')==0){ // 품절등록 버튼을 눌렀을 떄 
		var snack_id = _this.id.replace('ns_','');
	
		if(used_fl=='N'){//품절 등록이 되있으면 
			if (window.confirm('품절 해제 하시겠습니까?')) {
				used_fl='Y'
				
				var params = {
						used_fl : used_fl,
						snack_id : snack_id
				}
				
				$.ajax({
					type:'POST',
					url:'/admin/snack/soldout',
					data : params,
					success : function(result){
						if(result.indexOf('1')){//품절등록 완료
							alert('품절해제 완료');
						}else{
							alert('품절해제 실패');
						}
						window.location.reload(true);
					}
				});
			}
		
	}else{//품절 해제가 되있으면 
		alert('이미 품절해제 되었습니다.');
	}
	}
}


//초기 차트 생성
function chartInit(){
	var ctx = document.getElementById('myChart').getContext('2d');
	stat.myChart = new Chart(ctx, stat.chartConfig); // 초기생성
}



</script>


</head>
<body>
<%@ include file="../inc/main_navi.jsp" %>

<div class="snack_container">
<!-- navigation -->
			<nav id="navi">
				<ul>
					<li class="home"><a href="/admin/movie/list"><img
							src="/resources/images/common/ico_home.png" alt="네비 아이콘"></a></li>
					<li><a href="#">스낵 리스트 관리</a></li>
				</ul>
			</nav>
			<div class="t_header">
				<h3>스낵 리스트 관리</h3>
			</div>
	<div class="con_wrap">
		   <div class="aside">
		   		<ul class="lnb">
		   			<li class="" id="1"><a>팝콘</a></li>
		   			<li class="" id="2"><a>핫도그</a></li>
		   			<li class="" id="3"><a>스낵</a></li>
		   			<li class="" id="4"><a>음료</a></li>
		   		</ul>
		   </div>
   <div class="item_con">
   		<%-- <c:forEach items="${snackList}" var = "snackList"> --%>
	   		<div class="menu_1">
	   			<%-- <img src="/resources/images/HotDog.png"/>
	   			<div class="menu_detail">
	   				<table>
				        <colgroup>
				            <col width="23%;"/>
				            <col width="23%;"/>
				            <col width="23%;"/>
				            <col width="23%;"/>
				        </colgroup>
			   				<tr>
			   					<td>${snackList.snack_name}</td>
			   					<td>재고 : ${snackList.amount}</td>
			   					<td>${snackList.price}원</td>
			   					<td><input type="checkbox" /> 품절</td>
			   				</tr>
			   				<tr>
			   					<td>판매개수 : ${snackList.sales_amount} </td>
			   					<td>수익 : 100,000 원</td>
			   					<td>판매 등수 : 1 </td>
			   					<td></td>
			   				</tr>
	   				</table>
	   			</div>
	   				<div class="del_chk">
	   					<input type="checkbox"/>
	   				</div> --%>
	   		</div>
	   		
   		<%-- </c:forEach> --%>
   </div>
   
	</div>
		<!-- 삭제 / 등록 버튼 -->
	   	<div class="btn_con">
			<div class="tb_button_left">
				<button type="button" class="btn_delete" id="btnDelete">
					<span class="bs_text">삭제</span>
				</button>
			</div>
			<div class="tb_button_right">
				<button type="button" class="btn_write" id="btnWrite" onClick="location.href='/admin/snack/registform'">
					<span class="bs_text">등록</span>
				</button>
			</div>
		</div>
	 <div class="container__chart"> 
		<canvas id="myChart" width="230" height="100"></canvas>
	 </div> 
</div>	<!-- snack_container end  -->
  <!-- 차트 -->
 
</body>
</html>