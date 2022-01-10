<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link type="text/css" rel="stylesheet" href="/resources/css/style.css">
<%@ include file="../inc/header.jsp" %>
<title>Insert title here</title>


<script type="text/javascript">
$(document).ready(function(){
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
					console.log(idx);
				 	htmlStr += '<img src="/resources/data/'+obj.snack_id+'.'+obj.filename+'"/>'
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
					htmlStr+='<td><input type="button" value ="품절해제"/></td>';
					htmlStr+='</tr>';
					htmlStr+='<tr>';
					htmlStr+='<td>판매개수 : '+obj.sales_amount+'</td>';
					htmlStr+='<td>수익 : 100,000 원</td>';
					htmlStr+='<td>판매 등수 : 1 </td>';
					htmlStr+='<td><input type="button" value ="품절등록"/></td>'
					htmlStr+='</tr>';
					htmlStr+='</table>';
					htmlStr+='</div>';
					htmlStr+='<div class="del_chk"  ><input type="checkbox" id="chkbox119_" value="'+obj.snack_id+'"/></div>';
				});
				
				$('.menu_1').empty().append(htmlStr);
				
				
				
			}
		});
		
	});
//  체크박스 체크된 항목 삭제 
$('#btnDelete').click(function(){
	var checkedSeqs = '';
	
	$('input[type=checkbox]').each(function(){
		var checked = $(this).prop('checked');
		if(checked){//체크되있는 박스의 id를 다음으로 교체
			var seq = $(this).attr('id').replace('chkbox119_','');
			checkedSeqs += seq + ',';
			console.log(checkedSeqs);
		}
	});

	if(!checkSeqs){
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
	
	
	
	
	
});
	
	
	
	
	
	
});//document ready end





</script>


</head>
<body>
<%@ include file="../inc/main_navi.jsp" %>


<div class="snack_container">

	<h3>스낵 리스트</h3>
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
</div>	<!-- snack_container end  -->

</body>
</html>