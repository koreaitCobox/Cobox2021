<%@ page contentType="text/html; charset=UTF-8"%>
<!doctype html>
<html>
<head>
<%@ include file="../inc/header.jsp"%>
</head>
<body class="single-cin">
	<div class="wrapper">
	<%@ include file="../inc/top.jsp" %>
	<!-- Main content -->
        <section class="container">
            <div class="overflow-wrapper">
                <div class="col-sm-12">
                
                    <h2 class="page-heading">공지사항</h2>
                    
                    <!-- News post article-->
                    <article class="post post--news">
                        <h1><a href="/movie/noticedetail" class="post__title-link">Donec eu mollis augue, ut egestas leo</a></h1>
                        <p class="post__date">29 October 2013 </p>

                        <div class="wave-devider"></div>

                        <p class="post__text">Mauris gravida ipsum vitae libero molestie eget dignissim ipsum egestas. Quisque in eros id velit molestie placerat a ut arcu. Etiam consequat, turpis ac commodo rhoncus, justo enim consequat tortor, vitae interdum odio tellus at sem. Aliquam lacus quam, lobortis sed lacus eget, commodo volutpat nunc. Text link sample. Proin accumsan diam vel nulla ultrices congue.</p> 

                        <div class="devider-huge"></div>
                    </article> 
                    <article class="post post--news">
                        <h1><a href="single-page-full.html" class="post__title-link">Donec eu mollis augue, ut egestas leo</a></h1>
                        <p class="post__date">29 October 2013 </p>

                        <div class="wave-devider"></div>

                        <p class="post__text">Mauris gravida ipsum vitae libero molestie eget dignissim ipsum egestas. Quisque in eros id velit molestie placerat a ut arcu. Etiam consequat, turpis ac commodo rhoncus, justo enim consequat tortor, vitae interdum odio tellus at sem. Aliquam lacus quam, lobortis sed lacus eget, commodo volutpat nunc. Text link sample. Proin accumsan diam vel nulla ultrices congue.</p> 

                        <div class="devider-huge"></div>
                    </article> 
                    <!-- end news post article-->
                     <div class="pagination">
                        <a href='#' class="pagination__prev">prev</a>
                        <a href='#' class="pagination__next">next</a>
                    </div>
                </div>
            </div>
        </section>
    <%@include file="../inc/footer.jsp" %>
	</div>
	<%@include file="../inc/script.jsp"%>
	<!-- Custom -->
	<script type="text/javascript">
		$(document).ready(function() {
			init_Home();
		});
	</script>
</body>
</html>
