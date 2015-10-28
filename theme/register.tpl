<!-- register -->
{$link_file='register'}
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
   
    <div class="row">
          <div class="page-header text-center">
            {include file="_breadcrumb.tpl"} 
            {if isset($message)}
              <diV class="text-center"><h3> {$message} </h3></div>
            {/if}
            <h1>Form Registrasi / Pendaftaran Member</h1>
          </div>
        <div class="col-sm-4 col-md-4">
          <img src="images/hiluni.png"  class="img-thumbnail" >
        </div>    
        <div class="col-sm-8 col-md-8">

            <div class="row ">
                  <!--Form Login -->
                   <form class="form-horizontal " id="registration" method="POST" >
                    <div class="form-group">
                      <label for="inputNama" class="col-sm-3 control-label">Nama</label>
                      <div class="col-sm-6">
                        <input id="nama" name="nama" type="text" class="form-control"  placeholder="Nama" >
                      </div>
                    </div>
                    <div class="form-group">
                      <label for="inputEmail" class="col-sm-3 control-label">Email</label>
                      <div class="col-sm-6">
                        <input id="email" name="email" type="email" class="form-control" placeholder="Email"   >
                      </div>
                    </div>

                    <div class="form-group">
                      <label for="notelp" class="col-sm-3 control-label">No Telp</label>
                      <div class="col-sm-6">
                        <input id="notelp" name="notelp" type="text" class="form-control" id="notelp" placeholder="No Telp"  >
                      </div>
                    </div>
                    <div class="form-group">
                      <label  class="col-sm-3 control-label">TGL Lahir</label>
                      <div class="col-sm-6">
                        <input  name="datepicker" type="text" class="form-control" id="datepicker" placeholder="Tahun-Bulan-Tgl"   >
                    </div>

                    </div>
                    <div class="form-group">
                      <label for="alamat" class="col-sm-3 control-label">Alamat</label>
                      <div class="col-sm-6">
                       <textarea id="alamat" name="alamat" class="form-control" rows="5"  ></textarea>
                      </div>
                    </div>
                    <div class="form-group">
                      <label for="kodepos" class="col-sm-3 control-label">Kode Pos</label>
                      <div class="col-sm-4"> 
                        <input name="kodepos" id="kodepos" type="text"   class="form-control"  placeholder="Kode Post" >
                      </div>
                    </div>
                    
                    <div class="form-group">
                      <label for="inputJK" class="col-sm-3 control-label">Jenis Kelamin</label>
                          <div class="col-sm-6"  >
                            <select id="jeniskelamin" name="jeniskelamin" >
                              <option  value=""></option>
                              <option  value="1">Pria</option>
                              <option  value="2">Wanita</option>
                            </select>
                          </div>
                    </div><!-- /input-group -->

                    <div class="form-group">
                      <label for="inputPassword" class="col-sm-3 control-label">Password</label>
                      <div class="col-sm-6">
                        <input id="password" name="password" type="password" class="form-control"  placeholder="Password"  >
                      </div>
                    </div>
                        <div class="form-group">
                      <label for="inputPassword" class="col-sm-3 control-label">Konfirmasi Password </label>
                      <div class="col-sm-6">
                        <input id="password2" name="password2" type="password" class="form-control" >
                      </div>
                    </div>
                    <div class="form-group">
                      <div class="col-sm-offset-3 col-sm-5">
                        <input id="setuju" name="setuju" type="checkbox" >
                       Saya Menyetujui <a href="tos.php" target="_blank">Ketentuan Layanan</a><br><br>
                      </div>
                    </div> 
                    <div class="form-group">
                      <div class="col-sm-offset-3 col-sm-6">
                        <div class="col-sm-6"> 
                          <button name="submit" type="submit" value="daftar" class="btn btn-default"> D a f t a r </button>
                        </div>
                        <div class="col-sm-6"> <button  type="reset" class="btn btn-default"> R e s e t </button></div>
                      </div>

                    </div>
                  </form><!--/Form Login -->

            </div>
        </div>  <!--/mid-10-->
    </div> <!--/row-->       

  </div><!--/wrap-->

</div>

<script src='assets/js/jquery.validate.min.js'></script>
<script>
  $("#registration").validate({
      rules: {
        nama:{
          required: true,
          minlength: 3
        },
        notelp: {
          required: true,
          digits: true,
          minlength: 7
        },
        alamat: "required",   
        tgllahir: {
          required: true,
          dateISO: true
        },
        jeniskelamin: "required",

        kodepos: {
          required: true,
          digits: true,
          minlength: 5,
          maxlength: 5
        },
      
        password: {
          required: true,
          minlength: 6
        },
        password2: {
          required: true,
          minlength: 6,
          equalTo: "#password"
        },
        email: {
          required: true,
          email: true
        },

        setuju: "required"
      },
      messages: {
        nama: {
          required: "Nama perlu diisi",
          minlength: "Minimum 3 huruf"
        },
        notelp: {
          required: "No Telp perlu diisi ",
          digits: "No telp harus angka misal 021555511",
          minlength: "Minimal 7 angka"
        },
        alamat: "Alamat perlu diisi",
        tgllahir: {
          required: "Tanggal lahir perlu diisi",
          dateISO: " format tanggal YYYY-MM-DD atau YYYY/MM/DD"
        },
        jeniskelamin: "Pilih Jenis Kelamin",
        
        kodepos: {
          required: "Kode Pos perlu diisi",
          digits: "Kode Pos harus angka",
          minlength: "Kode pos minimal 5 angka",
          maxlength: "Kode pos maksimal 5 angka"
        },

        password: {
          required: "Password perlu diisi",
          minlength: "Panjang password minimal 6 karakter"
        },
        password2: {
          required: "Password perlu diisi",
          minlength: "Panjang password minimal 6 karakter",
          equalTo: "Konfirmasi Password harus sama dengan password diatas"
        },
        email: {
           required: "Format email harus benar contoh abcd@zxvf.com"
         },
        setuju: " <-- (Harap Tandai untuk setuju) "
      }
    });


</script>
<!-- /Wrap all page content here -->

{include file='_footer.tpl'}