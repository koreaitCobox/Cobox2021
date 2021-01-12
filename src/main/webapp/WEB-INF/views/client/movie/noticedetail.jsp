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
            <div class="col-sm-12">
                <h2 class="page-heading">Single post</h2>

                <div class="post">
                    <div class="post__preview">

                        <a class="arrow-left no-hover" href="#"><span class="slider__info"></span></a> 
                        <a class="arrow-right" href="#"><span class="slider__info"></span></a>
                    
                    </div>

                    <h1>Donec eu mollis augue, ut egestas leo (h1)</h1>
                    <p class="post__date">29 October 2013 </p>

                    <div class="wave-devider"></div>




                    <h2>Etiam mi tortor, suscipit in blandit vitae, dignissim vel magna (h2)</h2>
                    <p>Donec viverra mi sit amet massa commodo, ullamcorper sollicitudin quam laoreet. Aliquam cursus porta porttitor. Donec faucibus risus vitae porta tincidunt. Sed egestas elementum quam sed fermentum. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Quisque posuere suscipit tristique. </p>


                    <h3>Lorem ipsum dolor sit amet, consectetur adipiscing elit (h3)</h3>
                    <p>In lobortis ac neque in eleifend. Maecenas magna justo, malesuada ac aliquet at, egestas et nibh. Fusce rutrum ligula tortor, a eleifend nisi lobortis sit amet. Morbi vulputate mollis nibh, quis malesuada enim eleifend egestas. Maecenas tincidunt dapibus lacus, id dapibus quam bibendum venenatis.</p>


                    <h4>Proin felis lorem, posuere ut nunc et, dapibus dapibus augue (h4)</h4>

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
