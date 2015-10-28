{include file="_header.tpl" }
{$link_file='login'}
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

      {if !isset($smarty.session.NAMA)}
         <div class="page-header text-center">
          {include file="_breadcrumb.tpl"} 
            <h1>Login Member</h1>
                  {if isset($message)}
        <diV class="text-center"><h3> {$message} </h3></div>
      {/if}
          </div>  
        <div class="col-sm-3 col-md-3">
          <img src="images/hiluni.png"  class="img-thumbnail" >
        </div>    
        <div class="col-sm-7 col-md-7">
            <div class="row ">
                  <!--Form Login -->
                   <form class="form-horizontal " id="loginform" name="loginform" method="POST">
                    <div class="form-group">
                      <label for="inputEmail" class="col-sm-2 control-label">Email</label>
                      <div class="col-sm-7">
                        <input id="email" name="email" type="email" class="form-control"  placeholder="Email"   >
                      </div>
                    </div>
                    <div class="form-group">
                      <label for="inputPassword" class="col-sm-2 control-label">Password</label>
                      <div class="col-sm-7">
                        <input id="password" name="password" type="password" class="form-control"  placeholder="Password" >
                      </div>
                    </div>
                    
                    <div class="form-group">
                      <div class="col-sm-offset-2 col-sm-7">
                        <button type="submit" name="signin" value="signin" class="btn btn-default">Sign in</button>
                      </div>
                    </div>
                  </form><!--/Form Login -->

            </div>
        </div>  <!--/mid-7-->
         <div class="col-sm-2 col-md-2">
            <div class="form-group">
              <div class="col-sm-offset-2 col-sm-5">
                <a href="lupapassword.php">
                <button type="submit"   class="btn btn-default">Lupa Password</button>
                </a>
               </div>
            </div>
        </div>  
      {else}
     Nama Login : {$smarty.session.NAMA} 
      {/if}
    </div> <!--/row-->       

  </div><!--/wrap-->

</div>

<script src='assets/js/jquery.validate.min.js'></script>
<script>
  $("#loginform").validate({
      rules: {
        email: "required" ,
        password: {
          required: true,
          minlength: 6
        }
 
      },
      messages: {
        email: "Format email harus benar contoh abcd@zxvf.com",
        password: {
          required: "Password perlu diisi",
          minlength: "Panjang password minimal 6 karakter"
        }
      }  
    });
</script>
<!-- /Wrap all page content here -->
{include file='_footer.tpl'}