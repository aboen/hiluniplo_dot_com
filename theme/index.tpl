{include file="_header.tpl" }
{$link_file='index'}
<script type='text/javascript'>
    $(document).ready(function() {
        $('.carousel').carousel({
        interval: 5000
        })
    });
</script> 
<script src="assets/js/jquery-ui.min.js" type="text/javascript"></script> 
</head>
<body>
  <!--menu Top Navigation-->
<nav class="navbar navbar-default navbar-fixed-top" role="navigation">  
    <div id="gradient" class="container-fluid vertical">
  {include file='_menu.tpl'}
    </div><!--/container-fluid responsive-->
</nav>
<!-- Wrap all page content here -->
<div class="kosong"> </div>
<div class="container-fluid ">
<div id="wrap">
  <div class="col-xs-2 col-sm-1 col-md-1" >
    <!--Menu sisi -->
    {include file="_sidemenu.tpl"}
  </div>    
  <div class="col-xs-10 col-sm-11 col-md-11">
    <div class="row">
      <div class="container-fluid ">
        {include file="_breadcrumb.tpl"}
        {include file="_jumbotron.tpl"}
        {if isset($message)}
           <div class="text-center"><h3 class="text-danger"> {$message} </h3></div>
        {/if}
 <!--first row -->                  
        <div class="responsive">
          <div class="row">
            <div class="col-sm-12 col-md-12">
              <!--list data-->
              <!--read more-->
              {if isset($readmore)}
               {include file="_komentarform.tpl"} 
                <div class="panel panel-info">
                  <div class="panel-heading">
                    <h3 class="panel-title">
                      <div class="media">
                        <div class="media-left">
                          {if !empty($berita[0]->photo)}
                            <img height="64" class="media-object" src="{$berita[0]->photo}" >
                          {/if}
                        </div>
                        <div class="media-body">
                          <strong>
                          {$berita[0]->judul|unescape:'htmlall'|capitalize:true}</strong><br>
                          <small><strong>Ditulis oleh {$berita[0]->namapgl|upper} pada  {$berita[0]->tglpost|date_format:$config.date} <br> 
                            {if ($berita[0]->kategori != 9999)}
                            Kategori : <a href="{$SCRIPT_NAME}?kat={$berita[0]->namakategori}">{$berita[0]->namakategori}</a> <br> 
                            {/if}
                            Sudah dilihat : 
                            {foreach from=$vhits item=hits}
                              {if $berita[0]->id == $hits->idberita}
                                {$hits->hits} kali
                              {/if}
                            {/foreach} </strong></small>
                        </div>
                      </div>
                    </h3>
                  </div>
                  <div class="panel-body ">
                    {if !empty($berita[0]->images)}                  
                        <a href='#images-modal-lg{$berita[0]->thumb|regex_replace:"/[^A-Za-z0-9_]/" : "-"} ' >
                          <img data-toggle="modal" data-target='.images-modal-lg{$berita[0]->thumb|regex_replace:"/[^A-Za-z0-9_]/" : "-"} ' class="img-thumbnail" src="{$berita[0]->thumb}" alt="{$berita[0]->judul}">
                        </a>

                        <div class='modal fade images-modal-lg{$berita[0]->thumb|regex_replace:"/[^A-Za-z0-9_]/" : "-"} ' tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel">
                          <div class="modal-dialog modal-lg">
                            <div class="modal-content">
                               <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                <h4 class="modal-title" id="myModalLabel">{$berita[0]->judul}</h4>
                              </div>
                              <div class="modal-body text-center">
                                <img src="{$berita[0]->images}"  alt="{$berita[0]->judul}">
                              </div>
                            </div>
                          </div>
                        </div>
                    {/if}


                      {foreach from=$listimage item=images}
                        {if $berita[0]->token == $images->token}
                        <a href="#images-modal-lg{$images@iteration}" >
                          <img data-toggle="modal" data-target=".images-modal-lg{$images@iteration}" class="img-thumbnail" src="{$images->thumbnail}" alt="{$images->namaphoto}">
                        </a>

                        <div class="modal fade images-modal-lg{$images@iteration}" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel">
                          <div class="modal-dialog modal-lg">
                            <div class="modal-content">
                               <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                <h4 class="modal-title" id="myModalLabel">{$images->namaphoto}</h4>
                              </div>
                              <div class="modal-body text-center">
                                <img src="{$images->linkphoto}"  alt="{$images->namaphoto}">
                              </div>
                            </div>
                          </div>
                        </div>
                        {/if}
                      {/foreach} 

                        {$berita[0]->konten|unescape:'htmlall'|replace:"<img " : "<img width='25%'  "}
                      </div>
                      <p></p>
                       <!--komentar-->
                       <button class="btn btn-primary" type="button" data-toggle="modal" data-target=".formkomentar-{$berita[0]->id}"  ><span class="glyphicon glyphicon-pencil" container: 'body' data-toggle="tooltip" data-placement="right" title="Silakan Login Untuk mengisi komentar"> Komentar </span>
                        </button>
                      {foreach from=$listkomentar item=komentar}
                        {if $berita[0]->id == $komentar->idberita}
                          <div class="media bg-warning responsive" id="{$komentar->id}">
                            <div class="media-left">
                              {if !empty($komentar->photo)}
                                <img height="64" class="media-object img-responsive" src="{$komentar->photo}">
                              {/if}
                            </div>
                            <div class="media-body">
                              <strong>{$komentar->namapgl|upper}</strong><small>{$komentar->tglkomen|date_format:$config.date}</small><br>
                              {$komentar->komentar|unescape:'htmlall'} 
                            </div>
                          </div>
                        {/if}
                      {/foreach}
                       <!--/end komentar-->
                  </div>
                </div>

<!--/read more-->
              {else}

              {foreach from=$berita item=beritas }
               {include file="_komentarform.tpl"} 
                <div class="panel panel-info" />
                  <div class="panel-heading" />
                    <h3 class="panel-title" />
                      <div class="media" />
                        <div class="media-left" />
                          {if !empty($beritas->photo)}
                            <img height="64" class="media-object" src="{$beritas->photo}" >
                          {/if}
                        </div>
                        <div class="media-body" />
                          <strong>
                          <a href="{$SCRIPT_NAME}?r={$beritas->id}">{$beritas->judul|unescape:'htmlall'|capitalize:true}</a>
                          </strong><br>
                          <small><strong>Ditulis oleh {$beritas->namapgl|upper} pada  {$beritas->tglpost|date_format:$config.date} <br> 

                            Kategori : <a href="{$SCRIPT_NAME}?kat={$beritas->namakategori}">{$beritas->namakategori}</a> <br> 
                           
                            Sudah dilihat : 
                            {foreach from=$vhits item=hits}
                              {if $beritas->id == $hits->idberita}
                                {$hits->hits} kali
                              {/if}
                            {/foreach}
                          </strong></small>
                        </div>
                      </div>
                    </h3>
                  </div>
                  <div class="panel-body " />
                    {if !empty($beritas->images)}
                        <a href='#images-modal-lg{$beritas->thumb|regex_replace:"/[^A-Za-z0-9_]/" : "-"} ' >
                          <img data-toggle="modal" data-target='.images-modal-lg{$beritas->thumb|regex_replace:"/[^A-Za-z0-9_]/" : "-"} ' class="img-thumbnail" src="{$beritas->thumb}" alt="{$beritas->judul}">
                        </a>

                        <div class='modal fade images-modal-lg{$beritas->thumb|regex_replace:"/[^A-Za-z0-9_]/" : "-"} ' tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel">
                          <div class="modal-dialog modal-lg">
                            <div class="modal-content">
                               <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                <h4 class="modal-title" id="myModalLabel">{$beritas->judul}</h4>
                              </div>
                              <div class="modal-body text-center">
                                <img src="{$beritas->images}"  alt="{$beritas->judul}">
                              </div>
                            </div>
                          </div>
                        </div>

                    {/if}
                      {foreach from=$listimage item=images}
                        {if $beritas->token == $images->token}
                        <a href="#images-modal-lg{$images@iteration}" >
                          <img data-toggle="modal" data-target=".images-modal-lg{$images@iteration}" class="img-thumbnail" src="{$images->thumbnail}" alt="{$images->namaphoto}">
                        </a>

                        <div class="modal fade images-modal-lg{$images@iteration}" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel">
                          <div class="modal-dialog modal-lg">
                            <div class="modal-content">
                               <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                <h4 class="modal-title" id="myModalLabel">{$images->namaphoto}</h4>
                              </div>
                              <div class="modal-body text-center">
                                <img src="{$images->linkphoto}"  alt="{$images->namaphoto}">
                              </div>
                            </div>
                          </div>
                        </div>

                        {/if}
                      {/foreach} 
                      <div class="full-left" />
                        {assign var=readMoreText value=".. <a href='{$SCRIPT_NAME}?r={$beritas->id}'><strong>Baca Selanjutnya</strong></a>"} 
                        {*$beritas->konten|unescape:'htmlall'|truncate:500:$readMoreText*}
                        {$beritas->konten|unescape:'htmlall'}
                      </div>
                      <p></p>
                      <!--komentar--> 
                        <button class="btn btn-primary" type="button" data-toggle="modal" data-target=".formkomentar-{$beritas@iteration}"  ><span class="glyphicon glyphicon-pencil" container: 'body' data-toggle="tooltip" data-placement="right" title="Silakan Login Untuk mengisi komentar"> Komentar </span>
                        </button>
                      {foreach from=$listkomentar item=komentar }
                        {if $beritas->id == $komentar->idberita}
                           <div class="media  bg-warning responsive">
                            <div class="media-left ">
                              
                              {if !empty($komentar->photo)}
                                <img height="64" class="media-object" src="{$komentar->photo}">
                              {/if}
                            </div>
                            <div class="media-body" />
                              <strong>{$komentar->namapgl|upper}</strong> <small> [{$komentar->tglkomen|date_format:$config.date}] </small><br>
                              {assign var=readMoreText value=".. <a href='{$SCRIPT_NAME}?r={$beritas->id}#{$komentar->id}'><strong>Baca Komentar</strong></a>"} 
                              {$komentar->komentar|unescape:'htmlall'|truncate:100:$readMoreText} 
                            </div>
                          </div>
                        {/if}   
                      {/foreach}
                    <!--/end komentar-->

                  </div>
                </div>

              {/foreach}

              <!-- Paging-->
              <div class=" text-center"> 
              <nav>
                <ul class="pagination pagination-lg">
                  <li {($page==1) ? "class='disabled'": "class=' '"}>
                    <a href={$SCRIPT_NAME}?{(isset($smarty.get.kat)) ? "kat={$smarty.get.kat}&": ""}page=1 aria-label="Previous"><span aria-hidden="true" class="glyphicon glyphicon-fast-backward"> </span></a>
                  </li>
                  {if ($page > 1)} 
                    <li><a href={$SCRIPT_NAME}?{(isset($smarty.get.kat)) ? "kat={$smarty.get.kat}&": ""}page={$page-1} class="glyphicon glyphicon-backward"> </a></li>
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
                        <a href={$SCRIPT_NAME}?{(isset($smarty.get.kat)) ? "kat={$smarty.get.kat}&": ""}page={$hal}> {$hal}<span class="sr-only"></span></a>
                       </li>
                      {assign var="showPage" value=$hal}
                    {/if}
                  {/for}

                  {if ($page < $totalpage)}
                    <li><a href={$SCRIPT_NAME}?{(isset($smarty.get.kat)) ? "kat={$smarty.get.kat}&": ""}page={$page+1} class="glyphicon glyphicon-forward"> </a></li>
                  {/if}

                  <li {($page==$totalpage) ? "class='disabled'": "class=' '"}>
                    <a href={$SCRIPT_NAME}?{(isset($smarty.get.kat)) ? "kat={$smarty.get.kat}&": ""}page={$totalpage} aria-label="Next">
                      <span aria-hidden="true" class="glyphicon glyphicon-fast-forward"> </span>
                    </a>
                  </li>
                </ul>
              </nav>
              </div>
              <!--/end Paging-->
              {/if} <!--/end if readmore-->
              <!--/list data-->
            </div>
          </div><!--/row-->
        </div>
        <div class="row">
          <div class="col-sm-2 col-md-2">
            <div class="thumbnail">
              <img src="images/hiluni.png" class="img-thumbnail" alt="...">
                <div class="caption">
                  <h4 class="media-heading"><strong>Thumbnail label</strong></h4>
                  <p> </p>
                  <p><a href="#" class="btn btn-primary" role="button">Beli</a> <a href="#" class="btn btn-default" role="button">Lihat</a></p>
                </div>
            </div>
          </div>
        <div class="col-sm-2 col-md-2">
          <div class="thumbnail">
            <img src="images/hiluni.png" class="img-thumbnail" alt="...">
              <div class="caption">
                <h4 class="media-heading"><strong>Thumbnail label</strong></h4>
                <p>...</p>
                <p><a href="#" class="btn btn-primary" role="button">Beli</a> <a href="#" class="btn btn-default" role="button">Lihat</a></p>
              </div>
          </div>
        </div>
        <div class="col-sm-2 col-md-2">
          <div class="thumbnail">
            <img src="images/hiluni.png" class="img-thumbnail" alt="...">
              <div class="caption">
                <h4 class="media-heading"><strong>Thumbnail label</strong></h4>
                <p>...</p>
                <p><a href="#" class="btn btn-primary" role="button">Beli</a> <a href="#" class="btn btn-default" role="button">Lihat</a></p>
              </div>
          </div>
        </div>
        <div class="col-sm-2 col-md-2">
          <div class="thumbnail">
            <img src="images/hiluni.png" class="img-thumbnail" alt="...">
              <div class="caption">
                <h4 class="media-heading"><strong>Thumbnail label</strong></h4>
                <p>...</p>
                <p><a href="#" class="btn btn-primary" role="button">Beli</a> <a href="#" class="btn btn-default" role="button">Lihat</a></p>
              </div>
          </div>
        </div>
        <div class="col-sm-2 col-md-2">
          <div class="thumbnail">
            <img src="images/hiluni.png" class="img-thumbnail" alt="...">
            <div class="caption">
              <h4 class="media-heading"><strong>Thumbnail label</strong></h4>
              <p>...</p>
              <p><a href="#" class="btn btn-primary" role="button">Beli</a> <a href="#" class="btn btn-default" role="button">Lihat</a></p>
            </div>
          </div>
        </div>
        <div class="col-sm-2 col-md-2">
          <div class="thumbnail">
            <img src="images/hiluni.png" class="img-thumbnail" alt="...">
              <div class="caption">
                <h4 class="media-heading"><strong>Thumbnail label</strong></h4>
                <p>...</p>
                <p><a href="#" class="btn btn-primary" role="button">Beli</a> <a href="#" class="btn btn-default" role="button">Lihat</a></p>
              </div>
            </div>
          </div>
      </div>
      </div>  <!--/row-->
    </div>  <!--/bloc-center-->
      </div>
    </div>
  </div>  <!--/mid-10-->       
</div><!--/wrap-->
</div><!--/container-->
<!-- /Wrap all page content here -->


 <script src='assets/js/jquery.validate.min.js'></script>
<script>
$(function () {
  $('[data-toggle="tooltip"]').tooltip()
})
$("#formkomen").validate({
      rules: {
        komentar: "required"
      },
      messages: {
        komentar: "Komentar Tidak boleh Kosong !!"
      }
    }); 
</script>

{include file='_footer.tpl'}