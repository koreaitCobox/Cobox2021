<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="../inc/header.jsp"%>
</head>
<style>
</style>
<script>
$(document).on('click', '.number-spinner button', function () {    
   var btn = $(this),
      oldValue = btn.closest('.number-spinner').find('input').val().trim(),
      newVal = 0;
   
   if (btn.attr('data-dir') == 'up') {
      newVal = parseInt(oldValue) + 1;
   } else {
      if (oldValue > 1) {
         newVal = parseInt(oldValue) - 1;
      } else {
         newVal = 1;
      }
   }
   btn.closest('.number-spinner').find('input').val(newVal);
});
</script>
<body class="single-cin"> 
    <div class="wrapper">
    <%@include file="../inc/top.jsp"%>         
        <!-- Main content -->
        <section class="container">
            <div class="col-sm-12">
                <h2 class="page-heading">스낵</h2>
                <div class="col-sm-6">
                    <div class="tabs tabs--vertical">
                      <!-- Nav tabs -->
                      <ul class="nav nav-tabs" id="vTab">
                        <li><a href="#popcorn" data-toggle="tab">팝콘</a></li>
                        <li ><a href="#hotdog" data-toggle="tab">핫도그</a></li>
                        <li><a href="#drink" data-toggle="tab">음료</a></li>
                      </ul>

                      <!-- Tab panes -->
                      <div class="tab-content">
                        <div class="tab-pane active" id="popcorn">
                         <div class="row">
                         <div class="gallery-wrapper">
                             <div class="col-sm-6">
                                 <div class="gallery-item">
                                         <img alt='' src="/resources/images/client-photo/post-awards.jpg">
                                         <p style="font-size:20px">오리지널팝콘</p>
                                            <p style="font-size:20px">5000원</p>
                                         <td class="qty">
                                         <span class="qty-minus btn btn-primary btn-sm gallery-item__icon" onclick="var effect = document.getElementById('qty'); var qty = effect.value; if( !isNaN( qty ) &amp;&amp; qty &gt; 1 ) effect.value--;return false;"><i class="fa fa-minus" aria-hidden="true"></i></span>
                                         <input type="number" class="qty-text" id="qty" step="1" min="1" max="99" name="quantity" value="1" style="color:black">
                                         <span class="qty-plus btn btn-primary btn-sm gallery-item__icon" onclick="var effect = document.getElementById('qty'); var qty = effect.value; if( !isNaN( qty )) effect.value++;return false;"><i class="fa fa-plus" aria-hidden="true"></i></span>
                                 </td>
                                         <button type="button" class="btn btn-primary btn-sm gallery-item__icon"><i class="fa fa-shopping-cart"></i></button>
                                 </div>
                             </div>
                          </div>
                        </div>
                      </div>
                      
                      
                        <div class="tab-pane" id="hotdog">
                         <div class="row">
                         <div class="gallery-wrapper">
                             <div class="col-sm-6">
                                 <div class="gallery-item">
                                         <img alt='' src="/resources/images/client-photo/post-awards.jpg">
                                         <p style="font-size:20px">치즈핫도그</p>
                                            <p style="font-size:20px">5000원</p>
                                         <td class="qty">
                                         <span class="qty-minus btn btn-primary btn-sm gallery-item__icon" onclick="var effect = document.getElementById('qty'); var qty = effect.value; if( !isNaN( qty ) &amp;&amp; qty &gt; 1 ) effect.value--;return false;"><i class="fa fa-minus" aria-hidden="true"></i></span>
                                         <input type="number" class="qty-text" id="qty" step="1" min="1" max="99" name="quantity" value="1" style="color:black">
                                         <span class="qty-plus btn btn-primary btn-sm gallery-item__icon" onclick="var effect = document.getElementById('qty'); var qty = effect.value; if( !isNaN( qty )) effect.value++;return false;"><i class="fa fa-plus" aria-hidden="true"></i></span>
                                 </td>
                                         <button type="button" class="btn btn-primary btn-sm gallery-item__icon"><i class="fa fa-shopping-cart"></i></button>
                                 </div>
                             </div>
                          </div>
                        </div>
                      </div>
                      
                      
                        <div class="tab-pane" id="drink">
                         <div class="row">
                         <div class="gallery-wrapper">
                             <div class="col-sm-6">
                                 <div class="gallery-item">
                                         <img alt='' src="/resources/images/client-photo/post-awards.jpg">
                                         <p style="font-size:20px">콜라</p>
                                            <p style="font-size:20px">5000원</p>
                                         <td class="qty">
                                         <span class="qty-minus btn btn-primary btn-sm gallery-item__icon" onclick="var effect = document.getElementById('qty'); var qty = effect.value; if( !isNaN( qty ) &amp;&amp; qty &gt; 1 ) effect.value--;return false;"><i class="fa fa-minus" aria-hidden="true"></i></span>
                                         <input type="number" class="qty-text" id="qty" step="1" min="1" max="99" name="quantity" value="1" style="color:black">
                                         <span class="qty-plus btn btn-primary btn-sm gallery-item__icon" onclick="var effect = document.getElementById('qty'); var qty = effect.value; if( !isNaN( qty )) effect.value++;return false;"><i class="fa fa-plus" aria-hidden="true"></i></span>
                                 </td>
                                         <button type="button" class="btn btn-primary btn-sm gallery-item__icon"><i class="fa fa-shopping-cart"></i></button>
                                 </div>
                             </div>
                          </div>
                        </div>
                      </div>
                      
                      
                    </div>
                  </div>
            </div>
            </div>
        </section>
            <%@include file="../inc/footer.jsp"%>
        </div>
        <%@include file="../inc/script.jsp"%>
      <script type="text/javascript">
            $(document).ready(function() {
                init_MovieList();
            });
      </script>
</body>
</html>