<!-- register -->
{if isset($smarty.session.NAMA)}
<!--arahkan ke halamn awal -->

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
</head>
<body>
  <!--menu Top Navigation-->
<nav class="navbar navbar-default navbar-fixed-top" role="navigation"> 
    <div class="container-fluid">
  {include file='_menu.tpl'}
    </div><!--/container-fluid responsive-->
</nav><!-- /End Nav header -->

<!-- Wrap all page content here -->
<div class="container">
  <div id="wrap">  
    {if isset($message)}
    <diV class="text-center"><h3> {$message} </h3></div>
      {/if}
    <div class="row">  
          <div class="page-header text-center">
            <h1>Form Registrasi / Pendaftaran Member</h1>
          </div>
        <div class="col-sm-4 col-md-4">
          <img src="images/logo_koprasi.jpg"  class="img-thumbnail" >
        </div>    
        <div class="col-sm-8 col-md-8">

            <div class="row ">
                  <!--Form Login -->

                   <form class="form-horizontal " id="registration-form" method="POST" >
                    <div class="form-group">
                      <label for="inputNama" class="col-sm-3 control-label">Nama</label>
                      <div class="col-sm-6">
                        <input name="nama" type="text" class="form-control"  placeholder="Nama" data-validation="length alphanumeric" data-validation-length="3-20" data-validation-help="Hanya Boleh Angka dan Huruf, min 3 dan max 20 karakter ">
                      </div>
                    </div>
                    <div class="form-group">
                      <label for="inputEmail" class="col-sm-3 control-label">Email</label>
                      <div class="col-sm-6">
                        <input name="email" type="email" class="form-control" id="inputEmail" placeholder="Email"   data-validation="email" data-validation-error-msg="Format email salah ">
                      </div>
                    </div>

                    <div class="form-group">
                      <label for="notelp" class="col-sm-3 control-label">No Telp</label>
                      <div class="col-sm-6">
                        <input name="notelp" type="text" class="form-control" id="notelp" placeholder="No Telp"  data-validation="number" data-validation-allowing="-" data-validation-help="Hanya Boleh diisi Angka dan tanda - " >
                      </div>
                    </div>
                    <div class="form-group">
                      <label  class="col-sm-3 control-label">TGL Lahir</label>
                      <div class="col-sm-6">
                        <input name="tgllahir" type="text" class="form-control" id="datepicker" placeholder="Tahun-Bulan-Tgl"  data-validation="required" >
                    </div>

                    </div>
                    <div class="form-group">
                      <label for="alamat" class="col-sm-3 control-label">Alamat</label>
                      <div class="col-sm-6">
                       <textarea  name="alamat" class="form-control" rows="4"  data-validation="required"></textarea>
                      </div>
                    </div>
                    <div class="form-group">
                      <label for="kodepos" class="col-sm-3 control-label">Kode Pos</label>
                      <div class="col-sm-4"> 
                        <input name="kodepos" id="kodepos" type="text"   class="form-control"  placeholder="Kode Post" minlength="5"   data-validation="custom" data-validation-regexp="^([0-9]+)$" data-validation-help="Hanya Boleh diisi Angka ">
                      </div>
                    </div>
                    
                    <div class="form-group">
                      <label for="inputJK" class="col-sm-3 control-label">Jenis Kelamin</label>
                          <div class="col-sm-6"  >
                            <select  name="jeniskelamin" data-validation="required">
                              <option  value="1">Pria</option>
                              <option  value="2">Wanita</option>
                            </select>
                          </div>
                    </div><!-- /input-group -->

                    <div class="form-group">
                      <label for="inputPassword" class="col-sm-3 control-label">Password</label>
                      <div class="col-sm-6">
                        <input name="password_confirmation" type="password" class="form-control" id="inputPassword" placeholder="Password"  name="pass_confirmation" data-validation="strength"   data-validation-strength="2">
                      </div>
                    </div>
                        <div class="form-group">
                      <label for="inputPassword" class="col-sm-3 control-label">Konfirmasi Password </label>
                      <div class="col-sm-6">
                        <input name="password" type="password" class="form-control"  data-validation="confirmation">
                      </div>
                    </div>
                    <div class="form-group">
                      <div class="col-sm-offset-3 col-sm-5">
                        <input type="checkbox" data-validation="required" data-validation-error-msg="Anda Harus Menyetujui Ketentuan Layanan Kami">
                       Saya Menyetujui <a href="tos.php" target="_blank">Ketentuan Layanan</a><br><br>
                      </div>
                    </div> 
                    <div class="form-group">
                      <div class="col-sm-offset-3 col-sm-6">
                        <div class="col-sm-6"> <button name="submit" type="submit" value="submit" class="btn btn-default"> D a f t a r </button></div>
                        <div class="col-sm-6"> <button  type="reset" class="btn btn-default"> R e s e t </button></div>
                      </div>

                    </div>
                  </form><!--/Form Login -->

            </div>
        </div>  <!--/mid-10-->
    </div> <!--/row-->       

  </div><!--/wrap-->

</div>

<!-- <script src="//cdnjs.cloudflare.com/ajax/libs/jquery-form-validator/2.2.0/jquery.form-validator.min.js"></script>-->
<script src="assets/js/form-validator/jquery.form-validator.min.js"></script>
<script>
var $messages = $('#error-message');
  $.validate({
      modules : 'security',
    onModulesLoaded : function() {
 
      // Show strength of password
      $('input[name="password_confirmation"]').displayPasswordStrength();

    }

  });
</script>
<!-- /Wrap all page content here -->

{include file='_footer.tpl'}
{/if}