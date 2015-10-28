<!--_editprofile.tpl-->
{if isset($smarty.session.ID)}
<!--upload  photo profile-->
<div class=" col-sm-12 text-center">
<div id="listimages"> </div>
<form method="POST">
  <div class="form-group">
    <label for="inputPassword" class="col-sm-4 control-label"></label>
      <div class="col-sm-3 text-center">
        <div id="queue"></div>
          <input class="form-control" id="file_upload" name="file_upload" type="file" multiple="true">
      </div>
  </div> 
</form>
</div> 

<!--/upload photo profile-->
<form class="form-horizontal" enctype="multipart/form-data"  method="POST">
  <div class="form-group has-success  ">
  
  	<div class="form-group">
    	<label for="inputPassword" class="col-sm-2 control-label">Nama</label>
    	<div class="col-sm-5">
      		<input type="text" class="form-control" name="nama" placeholder="Nama" value="{$users[0]->nama}">
          <input type="hidden" name="iduser" value="{$users[0]->id}">
   		 </div>
  	</div>
  	<div class="form-group">
    	<label for="inputPassword" class="col-sm-2 control-label">Email</label>
    	<div class="col-sm-5">
      		<input type="text" class="form-control" name="email" placeholder="Email" value="{$users[0]->email}">
   		 </div>
  	</div>
    <div class="form-group">
      <label for="inputPassword" class="col-sm-2 control-label">Nama Panggilan</label>
      <div class="col-sm-5">
          <input type="text" class="form-control" name="namapgl" placeholder="Nama Panggilan" value="{$users[0]->namapgl}">
       </div>
    </div>
    <div class="form-group">
      <label for="inputPassword" class="col-sm-2 control-label">Tgl Lahir</label>
      <div class="col-sm-5">
          <input id="datepicker" type="text" class="form-control" name="tgllahir" placeholder="Tgl Lahir" value="{$users[0]->tgllahir}" >
       </div>
    </div>

    <div class="form-group">
      <label for="inputPassword" class="col-sm-2 control-label">Pekerjaan</label>
      <div class="col-sm-5">
          <input type="text" class="form-control" name="pekerjaan" placeholder="Pekerjaan"
          value="{$users[0]->pekerjaan}">
       </div>
    </div>
    <div class="form-group">
      <label for="inputPassword" class="col-sm-2 control-label">Nama Perusahaan</label>
      <div class="col-sm-5">
          <input type="text" class="form-control" name="namaperusahaan" placeholder="Nama Perusahaan" value="{$users[0]->namaperusahaan}">
       </div>
    </div>
  	<div class="form-group">
    	<label for="inputPassword" class="col-sm-2 control-label">Alamat</label>
    	<div class="col-sm-5">
      	<textarea name="alamat" class="form-control" rows="3">{$users[0]->alamat}</textarea>
   		 </div>
  	</div>
    <div class="form-group">
      <label for="inputPassword" class="col-sm-2 control-label">Kode Pos</label>
      <div class="col-sm-5">
          <input type="text" class="form-control" name="kodepos" placeholder="Kode Pos" value="{$users[0]->kodepos}">
       </div>
    </div>
  	 <div class="form-group">
      <label for="inputPassword" class="col-sm-2 control-label">Kota</label>
      <div class="col-sm-5">
          <input type="text" class="form-control" name="kota" placeholder="Kota" value="{$users[0]->kota}">
       </div>
    </div>
  	<div class="form-group">
      <label for="inputPassword" class="col-sm-2 control-label">Propinsi</label>
      <div class="col-sm-5">
          <input type="text" class="form-control" name="propinsi" placeholder="Propinsi" value="{$users[0]->propinsi}">
       </div>
    </div>
   

  	<div class="form-group">
    	<label for="inputPassword" class="col-sm-2 control-label">Jenis Kelamin</label>
    	<div class="col-sm-3">
         <select id="jeniskelamin" name="jeniskelamin" >
         {html_options  options=$jenisk selected=$users[0]->jeniskelamin}
         </select>
        
   		 </div>
  	</div>
    <div class="form-group">
      <label for="inputPassword" class="col-sm-2 control-label">Tahun Lulus</label>
      <div class="col-sm-5">
          <input type="text" class="form-control" name="tahunlulus" placeholder="Tahun Lulus" value="{$users[0]->tahunlulus}" id="datepicker">
       </div>
    </div>
    <div class="form-group">
      <label for="inputPassword" class="col-sm-2 control-label">Jurusan</label>
      <div class="col-sm-5">
          <input type="text" class="form-control" name="jurusan" placeholder="Jurusan / Bidang Studi" value="{$users[0]->jurusan}">
       </div>
    </div>
    <div class="form-group">
      <label for="inputPassword" class="col-sm-2 control-label">Sekolah</label>
      <div class="col-sm-5">
          <input type="text" class="form-control" name="sekolah" placeholder="Sekolah" value="{$users[0]->sekolah}">
       </div>
    </div>
    <div class="form-group">
      <label for="inputPassword" class="col-sm-2 control-label">Basis</label>
      <div class="col-sm-5">
          <input type="text" class="form-control" name="basis" placeholder="Basis" value="{$users[0]->basis}">
       </div>
    </div>	
    <div class="form-group">
      <label for="inputPassword" class="col-sm-2 control-label">Facebook</label>
      <div class="col-sm-5">
          <input type="text" class="form-control" name="fb" placeholder="Url Facebook" value="{$users[0]->fb}">
       </div>
    </div>
    <div class="form-group">
      <label for="inputPassword" class="col-sm-2 control-label">Yahoo Messanger</label>
      <div class="col-sm-5">
          <input type="text" class="form-control" name="ym" placeholder="ID Yahoo Messanger" value="{$users[0]->ym}">
       </div>
    </div>
    <div class="form-group">
      <label for="inputPassword" class="col-sm-2 control-label">Tentang Anda</label>
      <div class="col-sm-5">
        <textarea name="aboutme" placeholder="Tuliskan Tentang diri Anda" class="form-control" rows="5">{$users[0]->aboutme}</textarea>
          
       </div>
    </div>

	<div class="form-group">
		<label for="inputPassword" class="col-sm-2 control-label"></label>
	  	<div class="col-sm-8">
	  		<button name="simpanedit" value="simpanedit" type="submit" class="btn btn-primary"> S i m p a n </button>
	  	</div>
	</div>
  </div>
</form>
<script>
      $(function() {
      $('#file_upload').uploadify({
        'formData'     : {
          'timestamp' : '{$timestamp}',
          'token'     : '{$md5salt}',
          'renamefile'     : '{$smarty.session.ID}',
          'profile'     : 'TRUE',
          'resize'    : 'TRUE',
          'newwidth' : '250',
          'newheight' : '250',
          'thumbnail' : 'false'
          
        },
        'fileSizeLimit' : '500KB',
        'swf'      : 'assets/plugins/uploadify/uploadify.swf',
        'uploader' : 'uploadimages.php',
        'onUploadSuccess' : function(file, data, response) {
            $("#listimages").html( data );
        }
      });
      $('#file_upload').uploadify('settings','buttonText','Upload Photo');
    });
 </script>     
{/if}