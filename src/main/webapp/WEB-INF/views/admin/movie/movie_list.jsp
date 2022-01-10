
<%@page import="com.koreait.cobox.model.domain.Rating"%>
<%@page import="com.koreait.cobox.model.common.Pager"%>
<%@page import="com.koreait.cobox.model.domain.Movie"%>
<%@page import="java.util.List"%>
<%@page import="com.koreait.cobox.model.domain.Genre"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<%@ page contentType="text/html;charset=UTF-8"%>


<!DOCTYPE html>
<html>
<head>
<link type="text/css" rel="stylesheet" href="/resources/css/style.css">
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<meta name="viewport" content="width=device-width, initial-scale=1">

 <%@ include file="../inc/header.jsp"%>


<script>
	$(document).ready(function() {
			//페이지 수 변경
			$('#selectNum').on('change',function() {

							$("#selNum").val($(this).val());

							var page = 1;
							var total_page = $(".tot_page")
									.html();
							if (page > total_page * 1
									|| page <= 0) {
								return;
							}
							var pageSize = $('#selNum').val();

							var params = {
								page : parseInt(page, 10),
								pageSize : parseInt(pageSize,
										10)
							};

							$.ajax({
										type : 'POST',
										url : '/admin/movie/ajaxMovieList',
										dataType : 'json',
										data : params,
										success : function(data) {

											var movieList = data.movieList;
											var htmlStr = '';
											console.log(movieList);
											$.each(movieList,function(idx,obj) {
																htmlStr += '<tr>';
																htmlStr += '<th scope="row">'
																htmlStr += '<span class="checkWrap type02">'
																htmlStr += '<input type="checkbox" name="chkbox119" id="chkbox119" class="check">'
																htmlStr += '<label for="chkbox119"></label>'
																htmlStr += '</span>'
																htmlStr += '</th>'
																htmlStr += '<td>'+ obj.movie_id+ '</td>';
																htmlStr += '<td><img src="/resources/data/'+obj.movie_id+'.'+obj.poster+'" width="100px"></td>'
																htmlStr += '<td><a href="/admin/movie/detail?movie_id="'+ obj.movie_id+ '>'
																		+ obj.movie_name+ '</a></td>'
																htmlStr += '<td>'+ obj.rating.rating_name	+ '</td>';
																htmlStr += '<td>'+ obj.director	+ '</td>';
																htmlStr += '<td>'+ obj.actor+ '</td>'
																htmlStr += '<td>'+ obj.playdate+ '</td>'
																htmlStr += '<td style="width:150px;" class="text-center">'
																htmlStr += '<button class="btn-1 bnt-outline-danger del-icon">'
																htmlStr += '<span class="fa fa-trash-o"></span>'
																htmlStr += '</button>'
																htmlStr += '<button class="btn-1 bnt-outline-success">'
																htmlStr += '<span class="fa fa-pencil"></span>'
																htmlStr += '</button>'
																htmlStr += '</td>'
																htmlStr += '</tr>'
															});
											$('#movie_table tbody').empty().append(htmlStr);

											var pageMaker = data.pageMaker;
											var pre = "";
											var next = "";
											var page;
											$(".tot_page")	.html(pageMaker.endPage);
											$(".tot_cnt").html(pageMaker.totalCount	+ '개');
											var pageHtmlStr = '';

											pageHtmlStr += '<ul>';
											if (pageMaker.page == 1)
												pre = 'disabled';
											pageHtmlStr += '<li class="first '+ pre +'">';
											pageHtmlStr += '<a href="#'
													+ (1)
													+ '">처음으로</a>'
											pageHtmlStr += '</li>'
											pageHtmlStr += '<li class="pre '+ pre +'">';
											pageHtmlStr += '<a href="#'
													+ (pageMaker.page - 1)
													+ '">이전으로</a>'
											pageHtmlStr += '</li>'

											for (var i = pageMaker.startPage; i <= pageMaker.endPage; i++) {
												if (i == pageMaker.startPage) {
													if (pageMaker.page == i) {
														pageHtmlStr += '<li class="first_num active">';
														page = i;
													} else {
														pageHtmlStr += '<li class="first_num">';
													}
												} else if (i == pageMaker.endPage) {
													if (pageMaker.page == i) {
														pageHtmlStr += '<li class="last_num active">';
														page = i;
													} else {
														pageHtmlStr += '<li class="last_num">';
													}
												} else {
													if (pageMaker.page == i) {
														pageHtmlStr += '<li class="active">';
														page = i;
													} else {
														pageHtmlStr += '<li class="">';
													}
												}
												pageHtmlStr += '<a href="#' + i + '">'
														+ i
														+ '</a>'
												pageHtmlStr += '</li>';
											}
											if (pageMaker.endPage == page
													&& (pageMaker.endPage * pageMaker.perPageNum) >= pageMaker.totalCount)
												next = 'disabled';
											pageHtmlStr += '<li class="next '+next+'">';
											pageHtmlStr += '<a href="#'
													+ (page + 1)
													+ '">다음으로</a>'
											pageHtmlStr += '</li>'
											pageHtmlStr += '<li class="last '+next+'">';
											pageHtmlStr += '<a href="#'
													+ (pageMaker.endPage)
													+ '">마지막으로</a>'
											pageHtmlStr += '</li>'
											pageHtmlStr += '</ul>';

											$('.pagenation').empty().append(pageHtmlStr);
										},
										error : function(e) {
											console.log(e);
										}
									});//ajax end

							});

						//delete
						$('#btnDelete').click(function() {
											if (window.confirm('삭제 하시겠습니까?')) {

												var checkedSeqs = '';
												$('#movie_table tr input[type=checkbox]').each(function() {
														var checked = $(this).prop('checked');

														if (checked) {
															var seq = $(this).attr('id').replace('chkbox119_','');
																		checkedSeqs += seq+ ',';
																	}
																	console.log(checkedSeqs);
																});

												if (!checkedSeqs) {
													alert("삭제할 영화를 선택해주세요!")
													return;
												}

												/* var params = {
														checkedSeqs : checkedSeqs
												}; */

												var params = {
													checkedSeqs : checkedSeqs,
												};

												$.ajax({
															type : 'POST',
															url : '/admin/movie/CheckDelete',
															dataType : 'text',
															data : params,
															success : function(data) {
																document.location.href = '/admin/movie/list';
															},
															error : function(e) {
																alert("삭제오류");
															}
														});

											}
										});

						
	// 등록버튼 
		$("#regist_btn").click(function() {
			location.href = "/admin/movie/registform"; //글쓰기 폼 요청
		});
	
	// 휴지통 아이콘 (삭제)
		$(".bnt-outline-danger").click(function(){
			if(confirm("삭제하시겠습니까?")){
			 	var seq = $(this).attr('id').replace('bin_','');
			
		 	
				var params = {
						checkedSeqs : seq
				};

				$.ajax({
							type : 'POST',
							url : '/admin/movie/CheckDelete',
							dataType : 'text',
							data : params,
							success : function(data) {
								document.location.href = '/admin/movie/list';
							},
							error : function(e) {
								alert("삭제오류");
							}
						});
			}
			 
		});// click function end
		
		//수정페이지 가기
		$(".bnt-outline-success").click(function(){
			var movie_id = $(this).attr('id').replace('det_','');
			location.href ="/admin/movie/detail?movie_id="+ movie_id;
		});
	
	
	
	
});//docuemtns ready end
		
function regist() {
	var formData = new FormData($("form")[0]);//<form>태그와는 틀리다..전송할때 파라미터들을 담을수있지만 이 자체가 폼태그는 아니다!!
	/*비동기 업로드*/
	$.ajax({
		url : "/admin/movie/excel/regist",
		data : formData,
		contentType : false, /* false일 경우 multipart/form-data*/
		processData : false, /* false일 경우 query-string으로 전송하지 않음*/
		type : "post",
		success : function(responseData) {
			console.log(responseData);
			//var json = JSON.parse(responseData); //string --> json 으로 파싱..
			//alert(json);
		}
	});
}

	
</script>
</head>
<body>

	<%@ include file="../inc/main_navi.jsp"%>
	<section id="movie_container">
		<div class="con_wrap">
			<!-- navigation -->
			<nav id="navi">
				<ul>
					<li class="home"><a href="/admin/movie/list"><img
							src="/resources/images/common/ico_home.png" alt="네비 아이콘"></a></li>
					<li><strong>영화 리스트 관리</strong></li>
				</ul>
			</nav>
			<!-- navigation end  -->
			<!-- contents -->
			<div class="con_main">
				<!-- <form action="/vibrioman/management/logList" method="post"> -->
				<!-- content title -->
				<div class="t_header">
					<h3>영화 리스트 관리</h3>
				</div>
				
			<!-- searchbox -->
			<div class="search_table">
				<table>
					<colgroup>
						<col style="width: 10%;">
						<col style="width: 40%;">
						<col style="width: 10%;">
						<col style="width: 40%;">
					</colgroup>
					<tbody>
						<tr>
							<th scope="row">영화명</th>
							<td><input type="text" id="movie_name" name="movie_name" class="inputarea_name" value=""></td>
							<th scope="row">감독</th>
							<td><input type="text" id="director" name="director" class="" value=""></td>
						</tr>
						<tr>
							<th scope="row">배우</th>
							<td><input type="text" id="actor" name="actor" class="" value=""></td>
							<th scope="row">개봉일</th>
							<td><label for="relday" class="datepickerWrap">
                                    <span class="blind">개봉일</span>
                                    <input type="text" id="relday" name="relday" onkeyup="auto_date_format( event, this );"  class="input cal_input"
                                           value="" readonly>
								</label></td>
						</tr>
					</tbody>
				</table>
				<div class="search_bottom">
					<span class="btn_wrap"><input type="submit" value="검색" name="btnSearch" id="btn_search" class="btn_search"></span>
				</div>
			</div>
			<!-- //searchbox -->

				<div class="tb_top">
					<div class="tb_page">
						총 <span class="tot_cnt">${totalCount}개</span> <span
							class="division"></span>
						<div style="display: none">
							<em>${page}</em>/<span class="tot_page">${totalPage}</span> 페이지
						</div>
						<input type="hidden" name="selNum" id="selNum" value="${selNum}">
					</div>
					<!-- <div class="btn_basic type02">
                   <button type="button" class="btn_excel_download"><span class="bs_text">Excel 다운로드</span></button>
               </div> -->
					<div class="tb_number">
						<label for=""> <span class="blind">개수 선택</span> <select
							id="selectNum" name="selectNum"
							class="search_select tb_num_sel pagesize" aria-disabled="false">
								<option value="10" <c:if test="${selNum eq 10 }">selected</c:if>>10개씩
									보기</option>
								<option value="20" <c:if test="${selNum eq 20 }">selected</c:if>>20개씩
									보기</option>
								<option value="50" <c:if test="${selNum eq 50 }">selected</c:if>>50개씩
									보기</option>
						</select>
						</label>
					</div>
				</div>

				<p>
				<table id="movie_table">
					<caption>영화 리스트</caption>
					<thead>
						<tr>
							<th scope="row"><span class="checkWrap type02"> <input
									type="checkbox" name="check_comboard" id="check_all" value="1"
									class="check_all"> <label for="check_all"></label>
							</span></th>
							<th>No</th>
							<th>이미지</th>
							<th>영화명</th>
							<th>관람등급</th>
							<th>감독</th>
							<th>배우</th>
							<th>개봉일</th>
							<th><i class="fa fa-cog fa-2x" aria-hidden="true"></i></th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${movieList}" var="movieList">
							<tr>
								<th scope="row"><span class="checkWrap type02"> <input
										type="checkbox" name="chkbox119_${movieList.movie_id}"
										id="chkbox119_${movieList.movie_id}" class="check"> <label
										for="chkbox119_${movieList.movie_id}"></label>
								</span></th>
								<td>${movieList.movie_id}</td>
								<td><img
									src="/resources/data/${movieList.movie_id}.${movieList.poster}"
									width="100px"></td>
								<td><a
									href="/admin/movie/detail?movie_id=${movieList.movie_id}">${movieList.movie_name}</a></td>
								<td>${movieList.rating.rating_name}</td>
								<td>${movieList.director}</td>
								<td>${movieList.actor}</td>
								<td>${movieList.playdate}</td>
								<td style="width: 150px;" class="text-center">
									<button class="btn-1 bnt-outline-danger del-icon" id="bin_${movieList.movie_id}">
										<span class="fa fa-trash-o"></span>
									</button>
									<button class="btn-1 bnt-outline-success" id="det_${movieList.movie_id}">
										<span class="fa fa-pencil"></span>
									</button>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>

				<!-- 페이징 -->
				<div class="tb_bottom">
					<div class="pagenation">
						<c:if test="${pageMaker.endPage != 0 }">
							<!-- pagenation 시작 class="first_num" -->
							<ul>
								<li class="first <c:if test="${page == 1}">disabled</c:if>">
									<!-- disabled : 비활성화, 활성화 시 disabled 제거 --> <a href="1">처음으로</a>
								</li>
								<li class="pre <c:if test="${page == 1}">disabled</c:if>">
									<!-- disabled : 비활성화, 활성화 시 disabled 제거 --> <a
									href="${page - 1}">이전으로</a>
								</li>
								<c:forEach begin="${pageMaker.startPage}"
									end="${pageMaker.endPage}" var="idx">
									<li
										class="<c:if test="${idx eq pageMaker.startPage}">first_num</c:if>
	                                           <c:if test="${idx eq pageMaker.endPage}">last_num</c:if>
	                                           <c:if test="${idx eq page}">active</c:if>"><a
										href="#${idx}">${idx}</a></li>
								</c:forEach>
								<li
									class="next <c:if test="${pageMaker.endPage == page}">disabled</c:if>">
									<!-- disabled : 비활성화, 활성화 시 disabled 제거 --> <a
									href="${pageMaker.startPage +1}">다음으로</a>
								</li>
								<li
									class="last <c:if test="${pageMaker.endPage == page}">disabled</c:if>">
									<!-- disabled : 비활성화, 활성화 시 disabled 제거 --> <a
									href="${pageMaker.endPage }">마지막으로</a>
								</li>
							</ul>
						</c:if>
					</div>
					<div class="tb_button_right">
						<button id="regist_btn">영화등록</button>
					</div>
					<div class="tb_button_left">
						<button type="button" class="btn_delete" id="btnDelete">
							<span class="bs_text">삭제</span>
						</button>
					</div>
				</div>
				<!-- </form> -->
			</div>
			<!--con_main end -->
		</div>
		<!-- con_wrap end -->
	</section>

</body>
</html>
