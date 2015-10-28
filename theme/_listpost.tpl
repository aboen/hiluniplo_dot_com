<!--_listpost.tpl -->
 <table class="table table-striped table-bordered table-hover">
    <tr class="success" >
      <th class="text-center" >No</th>
      {($smarty.session.HAK <= 22) ? "<th class='text-center' >Kontributor</th>": ""}
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
   {foreach from=$listpost item=list}
    <tr> 
        <td >{$list@iteration+$no}</td>
         {($smarty.session.HAK <= 22) ? " <td >{$list->nama|unescape:'htmlall'|capitalize:true} [ {$list->namapgl|unescape:'htmlall'|capitalize:true} ] </td>": ""}
        <td >{$list->tglpost|date_format:"%d/%m/%Y"}</td>
        <td >{$list->judul|unescape:'htmlall'|capitalize:true}</td> 
        <td >{$list->kategori}</td>
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