
<%@page import="com.koreait.cobox.model.domain.Rating"%>
<%@page import="com.koreait.cobox.model.domain.Genre"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8"%>


<!DOCTYPE html>
<html>
<head>
<link type="text/css" rel="stylesheet" href="/resources/css/style.css">
<link type="text/css" rel="stylesheet" href="/resources/css/common.css">
<meta name="viewport" content="width=device-width, initial-scale=1">
<%@ include file="../inc/header.jsp"%>
<style>
input[type=text], select, textarea {
	width: 34em!important;
	padding: 12px;
	border: 1px solid #ccc;
	border-radius: 4px;
	box-sizing: border-box;
	margin-top: 6px;
	margin-bottom: 16px;
	resize: vertical;
	margin-left: 6px;
}

input[type=button] {
	
	background-color: #4CAF50;
	color: white;
	padding: 12px 20px;
	border: none;
	border-radius: 4px;
	cursor: pointer;
}

input[type=button]:hover {
	background-color: #45a049;
}

.container {
	border-radius: 5px;
	border: 1px solid black;
	padding: 20px;
	display:contents;
	
}
.basic_table{
	padding:30px 30px 78px 30px; 
}


.box {
	width: 100px;
	float: left;
	padding: 5px;
}

.box>img {
	width: 100%;
}

.close {
	color: red;
	cursor: pointer;
}

#snack_name{
	width:50%;
}
#snack_id{
	width:50%;
}
#snack_price{
	width:50%;
}
#amount{
	width:50%;
}
#add{font-size:15px;}
#minus{font-size:15px;}
.t_header{
	overflow: hidden;
    position: relative;
    left:0 !important;
}
form p{
	margin:10px;
}
</style>
<!-- 달력 -->
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
<script src="//code.jquery.com/jquery.min.js"></script>
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>

<script type="text/javascript">

$(document).ready(function(){
	CKEDITOR.replace("detail"); //editor 이름 부여
	//달력 생성
	$("#playdate").datepicker({
		dateFormat : 'yy-mm-dd'
	});
	

	
// ===========================

	
	
	
	
	
	
});//document ready end

	
	//스낵 등록
function regist(){
		//form 안의 name 값이 컬럼명과 같아야한다. 
		var formData=new FormData($("form")[0]);
		//폼데이터에 에디터값 추가하기
		formData.append("detail",CKEDITOR.instances["detail"].getData());
		/*비동기 업로드*/
		$.ajax({
			url:"/admin/snack/regist",
			data:formData,
			contentType:false,
			processData:false,
			type:"post",
			success:function(responseData){
				var json = JSON.parse(responseData);//string-->json
			if(json.result==1){
				alert(json.msg);//메시지 뿌리고 
				location.href="/admin/snack/list" // 등록된 페이지 뿌려주기
			}else{
				alert(json.msg);
			}
				
			}
		});

	}

</script>

</head>

<body>
	<%@ include file="../inc/main_navi.jsp"%>
		<nav id="navi">
				<ul>
					<li class="home"><a href="/admin/movie/list"><img
							src="/resources/images/common/ico_home.png" alt="네비 아이콘"></a></li>
					<li><a href="#">스낵관리</a></li>
					<li><strong>스낵 등록</strong></li>
				</ul>
		</nav>
	<div class="basic_table">
			<div class="t_header">
				<h3>스낵 등록</h3>
			</div>
		<div class="container">
			<form>
				<p>
				<span>스낵 분류</span>
				<select id="snack_id" name="topcategory_id">		
					<option >스낵 분류 선택</option>
					<option value="1">팝콘</option>
					<option value="2">핫도그</option>
					<option value="3">스낵</option>
					<option value="4">음료</option>
				</select>
				<p>
				<span>스낵 이름</span>
					<input type="text"  id="snack_name" name="snack_name" placeholder="스낵명"><br>
				<span> 스낵 가격</span>	 
					<input type="text"  id="snack_price" name="price" placeholder="가격">
				<p>
				<span>수량(재고)</span>	
					<input type="text"  name="amount" id="amount" placeholder="수량(재고)" >
				<p>
				<!-- <input type="button"  id="add" value='+' onclick = 'count("add")'>
				<input type="button"  id="minus" value='-' onclick = 'count("minus")' > -->
				
				 <h4>스낵 설명</h4>
				<textarea id="detail" name="detail"  style="height: 200px"></textarea>
	
				
				<p>
					대표이미지: <input type="file" name="repImg" id="repImg">
				</p>
	
				<input type="button" value="스낵등록" onClick="regist()" id="registBtn"> 
				<input type="button" value="목록보기" onClick="location.href='/admin/snack/list'">
			</form>
		</div>
	</div>
</body>
</html>