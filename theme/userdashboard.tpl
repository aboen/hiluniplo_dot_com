{include file="_header.tpl" }
<script src="assets/js/jquery-ui.min.js" type="text/javascript"></script> 
<script>
  $(function() {
    $( "#datepicker" ).datepicker({
      dateFormat: "yy-mm-dd",
      changeMonth: true,
      changeYear: true
    });
  });
</script>
<!--upload-images-->
<script src="assets/plugins/uploadify/jquery.uploadify.min.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="assets/plugins/uploadify/uploadify.css">
<!-- text wswyg-->

<link href="theme/font-awesome/css/font-awesome.min.css" rel="stylesheet">
<link href="assets/plugins/linecontrol/editor.css" rel="stylesheet">
<script src="assets/plugins/linecontrol/editor.js"></script>
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
<div class="kosong"> </div>
<div class="container-fluid">
  <div id="wrap">  
    <div class="col-sm-12 col-md-12">
      <div class="row">
          <!-- cek session NAMA bila sudah aktif tampilkan data user-->
        {if isset($smarty.session.NAMA)}
          <div class="text-center  text-uppercase">
            <h3>Selamat datang  {$smarty.session.NAMA} </h3>
              {if !empty($users[0]->photo)}
                 {if ($smarty.session.HAK==11)} <img class="img-thumbnail" src="{$photo[0]->photo}">
                  {else} <img class="img-thumbnail" src="{$users[0]->photo}"> 
                 {/if}<br>
                {else} Photo Profilr belum ada, silakan upload photo<br>
              {/if}
              Level : 
              {if ($smarty.session.HAK==11)} Superadmin
                {elseif ($smarty.session.HAK==22)} Admin
                {elseif ($smarty.session.HAK==33)} Kontributor
                {elseif ($smarty.session.HAK==44)} Penjual
                {else} User
              {/if}
              {if isset($message)}
                <div class="text-center"><h3> {$message} </h3>
                  <div class="alert-danger" >
                    {if isset($gagaluploadphoto)} {$gagaluploadphoto} {/if} 
                  </div> 
                </div>
              {/if}
          </div>
          <!--Navigasi user dashboard--> 
          <nav role="navigation">
            <ul class="nav nav-tabs nav-justified">
              <li role="presentation" {($GETURL==' ' || $GETURL == 'profile') ? "class='active'" : " "}><a href="{$SCRIPT_NAME}?l=profile">Profile</a></li>
              <li role="presentation" {($GETURL =='profile_edit') ? "class='active'" : " "}><a href="?l=profile_edit">Edit Profile</a></li>
              <li role="presentation" {($GETURL == 'posting') ? "class='active'" : " "}><a href="{$SCRIPT_NAME}?l=posting">Posting</a></li>
              <li role="presentation" {($GETURL == 'messages') ? "class='active'" : " "}><a href="{$SCRIPT_NAME}?l=messages">Messages</a></li>
               <li role="presentation" {($GETURL == 'gantipassword') ? "class='active'" : " "}><a href="{$SCRIPT_NAME}?l=gantipassword">Ganti Password</a></li>
            </ul>
          </nav >
          <!--/Navigasi user dashboard-->
          <div class="row">
            <!--profile-->
            {if $GETURL=='profile' OR $GETURL==' '}
              {include file='_profile.tpl'}
            {/if} 
            <!--/profile-->
            <!--profile Detail-->
            {if $GETURL=='profiledetail'}
              {include file='_profiledetail.tpl'}
            {/if}  
            <!--/profile Detail-->
            <!--profile edit-->
            {if $GETURL=='profile_edit'}
              {include file='_editprofile.tpl'}
            {/if}
            <!--/profile edit-->
            <!--messages-->
            {if $GETURL=='messagesprofile'}
              {include file='_messagesprofile.tpl'}
            {/if} 
            <!--/messages-->
            <!--profile posting-->
            {if $GETURL=='posting'}
              {include file='_posting.tpl'}
            {/if} 
            <!--/profile_edit_hak-->
            <!--Ganti password-->
            {if $GETURL=='gantipassword'}
              {include file='_gantipassword.tpl'}
            {/if}
            <!--/Ganti password-->
            
          </div><!--/row-->
        {/if}
      </div> <!--/row-->       
    </div> <!--/col-sm-12 col-md-12-->
  </div><!--/wrap-->
</div><!--/container-fluid-->

<script>
$(".delete-link").on("click", null, function(){
        return confirm("Yakin Akan di Hapus ? semua data yang berhubungan dengan ini akan ikut terhapus !!!");
    });
</script>
<!-- /Wrap all page content here -->
{include file='_footer-user.tpl'}