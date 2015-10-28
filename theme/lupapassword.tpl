{include file="_header.tpl" }
{$link_file='lupapassword'}
<script src="assets/js/jquery-ui.min.js" type="text/javascript"></script> 
</head>
<body>
<!-- register -->
  <!--menu Top Navigation-->
<nav class="navbar navbar-default navbar-fixed-top" role="navigation"> 
    <div class="container-fluid">
  {include file='_menu.tpl'}
    </div><!--/container-fluid responsive-->
</nav><!-- /End Nav header -->

<!-- Wrap all page content here -->
<div class="container">
  <div id="wrap">

    <div class="row">
      {if isset($message)}
        <diV class="text-center"><h3> {$message} </h3></div>
      {/if}
      {if isset($resetpass)}
        <div class="page-header text-center">
          {include file="_breadcrumb.tpl"} 
            <h1>Reset Password</h1>
          </div>  
          <div class="col-sm-4 col-md-4">
            <img src="images/hiluni.png"  class="img-thumbnail" >
           </div>    
          <div class="col-sm-8 col-md-8">
            <div class="row ">
                  <!--Form Login -->
                  {include file="_gantipassword.tpl"} 
                  <!--/Form Login -->

            </div>
          </div>  <!--/mid-8--> 
      {else}
        {if !isset($smarty.session.NAMA)}
           <div class="page-header text-center">
            {include file="_breadcrumb.tpl"} 
              <h1>Lupa / Reset Password</h1>
            </div>  
          <div class="col-sm-4 col-md-4">
            <img src="images/hiluni.png"  class="img-thumbnail" >
          </div>    
          <div class="col-sm-8 col-md-8">
              <div class="row ">
                    <!--Form Login -->
                     <form class="form-horizontal " id="lupapassword" name="lupapassword" method="POST">
                      <div class="form-group">
                        <label for="inputEmail" class="col-sm-2 control-label">Email</label>
                        <div class="col-sm-5">
                          <input id="email" name="email" type="email" class="form-control"  placeholder="Email"   >
                        </div>
                      </div>
                      
                      
                      <div class="form-group">
                        <div class="col-sm-offset-2 col-sm-5">
                          <button type="submit" name="lupapassword" value="lupapassword" class="btn btn-default">Reset  Password</button>
                        </div>
                      </div>
                    </form><!--/Form Login -->

              </div>
          </div>  <!--/mid-8-->    
        {/if}
             

      {/if}
    </div> <!--/row-->       

  </div><!--/wrap-->

</div>

<script src='assets/js/jquery.validate.min.js'></script>
<script>
  $("#loginform").validate({
      rules: {
        email: "required" 
      },
      messages: {
        email: "Format email harus benar contoh abcd@zxvf.com"  
      }  
    });

    $("#chgpass").validate({
        rules: {
            password: { 
                required: true,
                minlength: 6,
                maxlength: 10,
                   } , 

            password2: { 
                equalTo: "#password",
                minlength: 6,
                maxlength: 10
                   }
               }
           });
</script>
<!-- /Wrap all page content here -->
{include file='_footer.tpl'}