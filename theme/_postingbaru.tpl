<!--_postingbaru.tpl-->
<form class="form-horizontal" id="posting"   method="POST" >
  <div class="form-group">
    <label >Judul</label>
    <input name="judul" id="judul" type="text" class="form-control"  placeholder="Judul" {if isset($editpost[0]->judul)} value="{$editpost[0]->judul}"" {/if} >
    {if isset($editpost[0]->token)}
      <input type="hidden" name="tokenedit" value="{$editpost[0]->token}"> 
    {else}
      <input type="hidden" name="tokenedit" value="{$md5salt}">
      
    {/if}
    <input type="hidden" name="userposting" value="{$smarty.session.NAMA}">
  </div>
  <div class="form-group">
   
    {if isset($editpost[0]->kategori) && ($editpost[0]->kategori==9999)}
    <input type="hidden" name="kategori" value="9999">
    {else} 
      <label >Kategori</label>
      <select name="kategori" id="kategori"  class="form-control" >
      {foreach from=$kategori item=kategoris}
        <option value='{$kategoris->id}' 
          {if isset($editpost[0]->kategori)} 
            {($kategoris->id==$editpost[0]->kategori) ? "selected" : ""} 
          {/if} >
          {$kategoris->kategori}
        </option> 
      {/foreach}
      </select> 
    {/if}
  </div>
  <div class="form-group">
    <label >Konten</label>
    <!-- wyswg -->
<textarea id="txtEditor" name="txtEditor" > 
</textarea>
<textarea id="txtEditorContent" name="txtEditorContent"  hidden="">
</textarea>
{if isset($editpost[0]->id)}
{assign var="konten" value=$editpost[0]->konten}
{assign var="token" value=$editpost[0]->token}
 {else}
{assign var="konten" value=""}
{assign var="token" value=$md5salt}
{/if}
<div id="txtEditor" ></div>
<!--/end wyswg-->

  </div>
  <div class="form-group text-center">
      <label  class="col-sm-2 control-label"></label>
      <div class="col-sm-4">
        {if isset($editpost[0]->id)}
          <input type="hidden" name="editid" value="{$editpost[0]->id}" >
          <input type="hidden" name="tglpost" value="{$editpost[0]->tglpost}" >
          <button type="submit" name="postberita" value="postberita" class="btn btn-primary" > Update </button>
        {else}
          <button type="submit" name="postberita" value="postberita" class="btn btn-primary" > Posting </button>
        {/if}
     </div>
     <div class="col-sm-4">
        <button  type="reset" class="btn btn-default"> R e s e t </button></div>
  </div>
    
</form>  
<!-- Image hasil u[load ditampilkan di sini -->  
  <div class="form-group">
    <div class="row">
        <label  >Gambar Terupload</label>  
        <div id="listimages"> </div>
        {if isset($listimage[0]->id)}
          {foreach from=$listimage item=images}
          <div class='col-md-2'>
            <div class='panel panel-default'>
              <div class='panel-heading '><p class='heading-images'>{$images->namaphoto}</p></div>
              <div class='panel-body'><a href="{$images->linkphoto}" ><img  class='img-thumbnail' src="{$images->thumbnail}" alt="{$images->namaphoto}"></a>
              </div>
            </div>
          </div>      
          {/foreach}
        {/if}
    </div>
  </div>
  <!-- Upload image-->

   <div class="form-group">
    <div class="row">
      <div class="col-sm-2"><label >Upload Gambar</label></div>
        <div class="col-sm-3">
          <form method="POST">
            <div id="queue"></div>
            <input id="file_upload" name="file_upload" type="file" multiple="true">
          </form> 
        
      </div>
    </div>
  </div>   
  <script src='assets/js/jquery.validate.min.js'></script>
<script src='assets/js/encoder.js'></script>
<script>
  $(document).ready( function() {
    $("#txtEditor").Editor();;
    $("button:submit").click(function(){
      $('#txtEditorContent').text($('#txtEditor').Editor("getText"));
    });

    var stxt =  "{$konten}";
    var decoded = Encoder.htmlDecode( stxt );
    $('#txtEditor').Editor("setText", decoded );  
         
  });

  $("#posting").validate({
      rules: {
        judul: "required"
      },
      messages: {
        judul: "Judul Tidak Boleh Kosong!!"
      }
    }); 

    $(function() {
      $('#file_upload').uploadify({
        'formData'     : {
          'timestamp' : '{$timestamp}',
          'token'     : '{$md5salt}',
          'tokenedit'     : '{$token}',
          'resize'    : 'TRUE',
          'newwidth' : '400',
          'newheight' : '600',
          'thumbnail' : 'TRUE',
          'thumbnewwidth' : '200',
          'thumbnewheight' : '200'
        },
        'fileSizeLimit' : '1000KB',
        'swf'      : 'assets/plugins/uploadify/uploadify.swf',
        'uploader' : 'uploadimages.php',
        'onUploadSuccess' : function(file, data, response) {
            $("#listimages").append( data + "</div></div></div> ");
        }
      });
      $('#file_upload').uploadify('settings','buttonText','Pilih Gambar');
    });
  </script>
<script>
    $(document).ready(function() {
      formmodified=0;
      $('form *').change(function(){
          formmodified=1;
      });
      window.onbeforeunload = confirmExit;
      function confirmExit() {
          if (formmodified == 1) {
              return "Data Belum di simpan, apakah yakin akan ke halaman lain ?  Bila ya maka data akan hilang.";
          }
      }
      $("button:submit[name='postberita']").click(function() {
          formmodified = 0;
      });
    });
</script>