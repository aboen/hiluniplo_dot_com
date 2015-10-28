<!--dataalumni.tpl-->
{include file="_header.tpl" }
{$link_file='dataalumni'}
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
<div class="kosong"> </div>
<div class="container-fluid">
  <div id="wrap">  
    <div class="col-sm-12 col-md-12 ">
      <div class="row">
       
  <div class=" text-center"> 
     {include file="_breadcrumb.tpl"}
  <div class="container">
    <form method="POST">
    <div class="input-group">
      <input type="text" class="form-control"   name="carialumni" aria-label="...">
      <div class="input-group-btn">
        <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Cari Berdasarkan <span class="caret"></span></button>
        <ul class="dropdown-menu dropdown-menu-right">
          <li><a href=""> <button type="submit" name="submit" value="Sekolah">Sekolah</button></a></li>
          <li><a href=""> <button type="submit" name="submit" value="TahunLulus">Tahun Lulus</button></a></li>
          <li><a href=""> <button type="submit" name="submit" value="Basis">Basis</button></a></li>
          <li><a href=""> <button type="submit" name="submit" value="Jurusan">Jurusan</button></a></li>
          <li><a href=""> <button type="submit" name="submit" value="Nama">Nama</button></a>

        </ul>
      </div><!-- /btn-group -->
    </div><!-- /input-group -->
  </form>
  </div><!-- /.col-lg-6 -->
  </div>
    <p></p>
          <!-- cek session NAMA bila sudah aktif tampilkan data user-->
        {if isset($smarty.session.NAMA)}

        {/if}

        {if !empty($totalpage)}
        <div class="table-responsive">
          <table class="table table-striped">
              <tr>
                <th class="warning"> No </th>
                <th class="warning">Nama</th>
                <th class="warning">Nama Pangilan</th>
                <th class="warning">No Telp</th>
                <th class="warning">Email</th>
                <th class="warning">Pekerjaan</th>
                <th class="warning">Sekolah</th>
                <th class="warning">Tahun lulus</th>
                <th class="warning">Jurusan</th>
                <th class="warning">Basis</th>
              </tr>
              {if isset($smarty.get.page)}
                {assign var="no" value=($smarty.get.page-1)*$smarty.const.LIMITDB}
              {else}
                {assign var="no" value=0*$smarty.const.LIMITDB}
              {/if}
              {foreach from=$users item=datauser}
              <tr>
                <td >{$datauser@iteration+$no}</td>
                <td >{$datauser->nama}</td>
                <td >{$datauser->namapgl}</td>
                {if isset($smarty.session.ID)}
                <td >{$datauser->notelp}</td>
                <td >{$datauser->email}</td>
                {else}
                {assign var="masktelp" value=$datauser->notelp|substr:-4}
                <td >{$datauser->notelp|replace:$masktelp:'****'}</td>
                {assign var="bar_at" value=$datauser->email|strpos:"@"}
                {assign var="sub_str" value=$datauser->email|substr:$bar_at}
                {assign var="jml_char" value=$sub_str|count_characters}
                {assign var="maskemail" value=$datauser->email|substr:-($jml_char+3):3}
                <td >{$datauser->email|replace:$maskemail:'***'}</td>
                {/if}
                <td >{$datauser->pekerjaan}</td>
                <td >{$datauser->sekolah}</td>
                <td >{$datauser->tahunlulus}</td>
                <td >{$datauser->jurusan}</td>
                <td >{$datauser->basis} </td>
              </tr>
              {/foreach}
             
               
          </table>   
        </div><!--/table-responsive-->  
          <!-- Paging-->
        {if !isset($cari)} 
         <div class=" text-center"> 
         <nav>
          <ul class="pagination pagination-lg">
            <li {($page==1) ? "class='disabled'": "class=' '"}>
              <a href="{$SCRIPT_NAME}?page=1" aria-label="Previous"><span aria-hidden="true" class="glyphicon glyphicon-fast-backward"> </span></a>
            </li>
            {if ($page > 1)} 
              <li><a href="{$SCRIPT_NAME}?page={$page-1}" class="glyphicon glyphicon-backward"> </a></li>
            {/if}
            {assign var="showPage" value=0}
            {for $hal=1 to $totalpage }
              {if ((($hal>=$page-3) && ($hal<=$page+3)) || ($hal == 1) || ($hal == $totalpage))}
                
                {if (($showPage == 1) && ($page != 2))} 
                  <li  class='disabled '><a href='#' class="glyphicon glyphicon-option-horizontal"> </a> </li>
                {/if}
                {if (($showPage != ($totalpage - 1)) && ($hal == $totalpage)) }
                  <li  class=' disabled '><a href='#' class="glyphicon glyphicon-option-horizontal"> </a> </li>
                {/if}
                  <li {($page==$hal) ? " class='active'" : " "}>
                  <a href="{$SCRIPT_NAME}?page={$hal}"> {$hal}<span class="sr-only"></span></a>
                 </li>
                {assign var="showPage" value=$hal}
              {/if}
            {/for}

            {if ($page < $totalpage)}
              <li><a href="{$SCRIPT_NAME}?page={$page+1}" class="glyphicon glyphicon-forward"> </a></li>
            {/if}

            <li {($page==$totalpage) ? "class='disabled'": "class=' '"}>
              <a href="{$SCRIPT_NAME}?page={$totalpage}" aria-label="Next">
                <span aria-hidden="true" class="glyphicon glyphicon-fast-forward"> </span>
              </a>
            </li>
          </ul>
        </nav>
        </div><!--/end Paging-->
        {/if}<!--/end cari-->
      {/if}
      </div> <!--/row-->       
    </div> <!--/col-sm-12 col-md-12-->
  </div><!--/wrap-->
</div><!--/container-fluid-->

<!-- /Wrap all page content here -->
{include file='_footer-user.tpl'}