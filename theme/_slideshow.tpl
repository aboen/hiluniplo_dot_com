<!--_slideshow.tpl (jumbotron/slideshow)-->
{if ($smarty.session.HAK <= 22)}
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
    <input type="hidden" name="kategori" value="9999">
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
 <table class="table table-striped table-bordered table-hover">
    <tr class="success" >
      <th class="text-center" >No</th>
      <th class='text-center' >Kontributor</th>
      <th class="text-center" >Tgl Posting</th>
      <th class="text-center" >Judul</th>
      <th class="text-center" >Kategori</th>
      <th class='text-center' >Status</th>
      <th class="text-center" ></th>
    </tr>
    {if isset($smarty.get.page)}
      {assign var="no" value=($smarty.get.page-1)*$smarty.const.LIMITDB}
    {else}
      {assign var="no" value=0*$smarty.const.LIMITDB}
    {/if}
   {foreach from=$listslideshow item=list}
    <tr> 
        <td >{$list@iteration+$no}</td>
         {($smarty.session.HAK <= 22) ? " <td >{$list->nama|unescape:'htmlall'|capitalize:true} [ {$list->namapgl|unescape:'htmlall'|capitalize:true} ] </td>": ""}
        <td >{$list->tglpost|date_format:"%d/%m/%Y"}</td>
        <td >{$list->judul|unescape:'htmlall'|capitalize:true}</td> 
        <td >{($list->kategori==9999) ? "Slide Show" : " "}</td>
        <td >
          {if ($smarty.session.HAK >= 33)}
            {if ($list->approve == 1)}
            <form class="form-horizontal"   method="POST">
              <select name="approve" id="approve" onchange="this.form.submit()">
                <option selected> Publish </option>
                <option value='0'> Unpublish </option>
              </select>
               <input name="bid" type="hidden" value="{$list->id}">
            </form>
            {else}
            Unpublish
            {/if} 

          {else}
          <form class="form-horizontal"   method="POST">
            <select name="approve" id="approve" onchange="this.form.submit()">
               {html_options  options=$publish selected=$list->approve}
            </select>
             <input name="bid" type="hidden" value="{$list->id}">
          </form>
          {/if}
        </td>
        <td >
            <div class="btn-group">
              <button type="button" class="btn btn-sm btn-default dropdown-toggle" data-toggle="dropdown">
              <i class="glyphicon glyphicon-cog"></i> Aksi <span class="caret"></span>
              </button>
              <ul class="dropdown-menu" role="menu">
                <li><a href="{$SCRIPT_NAME}?l=listpost&listid={$list->id}"><i class="glyphicon glyphicon-edit"></i> Lihat Detail</a></li>  
                <li><a href="{$SCRIPT_NAME}?l=posting&s=postingbaru&editid={$list->id}"><i class="glyphicon glyphicon-edit"></i> Edit</a></li> 
                <li class="delete-link" ><a href="{$SCRIPT_NAME}?l=posting&s=listpost&delid={$list->id}&t={$list->token}"><i class="glyphicon glyphicon-remove"></i> Delete</a></li>
              </ul>
            </div>
        </td>
      </tr>
    {/foreach}
  </table>
            <!-- Paging-->

         <div class=" text-center"> 
         <nav>
          <ul class="pagination pagination-lg">
            <li {($page==1) ? "class='disabled'": "class=' '"}>
              <a href="{$SCRIPT_NAME}?l=posting&s=listpost&page=1" aria-label="Previous"><span aria-hidden="true" class="glyphicon glyphicon-fast-backward"> </span></a>
            </li>
            {if ($page > 1)} 
              <li><a href="{$SCRIPT_NAME}?l=posting&s=listpost&page={$page-1}" class="glyphicon glyphicon-backward"> </a></li>
            {/if}
            {assign var="showPage" value=0}
            {for $hal=1 to $totalpage }
              {if ((($hal>=$page-3) && ($hal<=$page+3)) || ($hal == 1) || ($hal == $totalpage))}
                
                {if (($showPage == 1) && ($page != 2))} 
                  <li  class='disabled '><a href='' class="glyphicon glyphicon-option-horizontal"> </a> </li>
                {/if}
                {if (($showPage != ($totalpage - 1)) && ($hal == $totalpage)) }
                  <li  class=' disabled '><a href='' class="glyphicon glyphicon-option-horizontal"> </a> </li>
                {/if}
                  <li {($page==$hal) ? " class='active'" : " "}>
                  <a href="{$SCRIPT_NAME}?l=posting&s=listpost&page={$hal}"> {$hal}<span class="sr-only"></span></a>
                 </li>
                {assign var="showPage" value=$hal}
              {/if}
            {/for}

            {if ($page < $totalpage)}
              <li><a href="{$SCRIPT_NAME}?l=posting&s=listpost&page={$page+1}" class="glyphicon glyphicon-forward"> </a></li>
            {/if}

            <li {($page==$totalpage) ? "class='disabled'": "class=' '"}>
              <a href="{$SCRIPT_NAME}?l=posting&s=listpost&page={$totalpage}" aria-label="Next">
                <span aria-hidden="true" class="glyphicon glyphicon-fast-forward"> </span>
              </a>
            </li>
          </ul>
        </nav>
        </div><!--/end Paging-->

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
        'formData'    : {
          'timestamp' : '{$timestamp}',
          'token'     : '{$md5salt}',
          'tokenedit' : '{$token}',
          'slideshow' : 'TRUE',
          'katslidew' : '900',
          'katslideh' : '750'
        },
        'fileSizeLimit' : '5000KB',
        'swf'      : 'assets/plugins/uploadify/uploadify.swf',
        'uploader' : 'uploadimages.php',
        'uploadLimit' : 1,
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
{/if}        