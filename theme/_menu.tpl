<!-- Brand and toggle get grouped for better mobile display -->
<div class="navbar-header col-xs-4 col-sm-1 col-md-1"> <a href="index.php"> <img src="images/hiluni.png" class="img-thumbnail" alt=" Hiluni PLO" width="100"></a></div>
<div class="navbar-header col-xs-4 col-sm-4 col-md-4">
   <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#collapse">
      <span class="sr-only">Toggle navigation</span>
      <span class="icon-bar"></span>
      <span class="icon-bar"></span>
      <span class="icon-bar"></span>
    </button>
     <a class="navbar-brand hidden-xs" href="index.php">HIMPUNAN ALUMNI STM 12/56-15/26 PLOEIT JAKARTA</a> 
</div>
<div class="navbar-header col-xs-3 col-sm-2 col-md-2 ">
    <form class="form-group spasi " >
      <div class="input-group">
        <input type="text" class="form-control" placeholder="C a r i  ...">
          <span class="input-group-btn ">
            <button class="btn btn-default" type="button"><span class="glyphicon glyphicon-search"> Cari </span></button>
          </span>
      </div><!-- /input-group -->
    </form>
</div>    
<!--menu navigasi  -->
<div class="navbar-collapse collapse col-xs-4 col-sm-4 col-md-4" id="collapse">
    <ul class="nav navbar-nav navbar-right  text-uppercase">
      <li {($basename == 'index') ? "class='active'" : " "} ><a href="index.php"><span class="glyphicon glyphicon-home"></span></a></li>
      <li {($basename == 'dataalumni') ? "class='active'" : " "} ><a href="dataalumni.php"><span class="glyphicon glyphicon-folder-open"> Data Alumni </span></a></li>
      {if isset($smarty.session.NAMA) }
      <li {($basename == 'userdashboard') ? "class='active'" : " "} ><a href="userdashboard.php"><span class="glyphicon glyphicon-user"> </span> {$smarty.session.NAMA} </a></li>
      {else}
        <li {($basename  == 'login') ? "class='active'" : " "} > <a href="login.php"> LOGIN </a></li>
        <li {($basename  == 'register') ? "class='active'" : " "} ><a href="register.php"> REGISTER </a></li>
      {/if}
      {if isset($smarty.session.HAK) AND $smarty.session.HAK != 44} <!--seller-->
      {/if}
      {if isset($smarty.session.NAMA) }
        <li {($basename  == 'logout') ? "class='active'" : " "} ><a href="logout.php"> LOGOUT </a></li>
      {/if}
    </ul>
</div><!--/.nav-collapse -->
