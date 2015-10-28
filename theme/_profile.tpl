<!--_profile.tpl-->
{if isset($smarty.session.ID)}
  <table class="table table-striped table-bordered table-hover">
    <tr class="success">
      <th >No</th>
      <th >Nama</th>
      <th >Alamat</th>
      <th ><span class="bg-danger"> Sekolah</span>-<span class="bg-info">Jurusan </span></th>
      <th >Telp</th>
      <th >Email</th>
       {if ($smarty.session.HAK == 11)}
      <th >Tgl Daftar</th>
      {/if}
      <th >Terakhir Login</th>
       {if ($smarty.session.HAK == 11)}
      <th >Hak</th>
      {/if}
      <th></th>
    </tr>
    {if isset($smarty.get.page)}
      {assign var="no" value=($smarty.get.page-1)*$smarty.const.LIMITDB}
    {else}
      {assign var="no" value=0*$smarty.const.LIMITDB}
    {/if}
   {foreach from=$users item=user }
    <tr> 
        <td >{$user@iteration+$no}</td>
        <td >{$user->nama|unescape:'htmlall'|capitalize:true}</td>
        <td >{$user->alamat|unescape:'htmlall'|capitalize:true} {$user->kota|unescape:'htmlall'|capitalize:true}<br>{$user->propinsi|unescape:'htmlall'|capitalize:true} </td>
        <td ><span class="bg-danger">{$user->sekolah|unescape:'htmlall'|capitalize:true} </span> - <span class="bg-info"> {$user->jurusan|unescape:'htmlall'|capitalize:true}</span></td> 
        <td >{$user->notelp}</td>
        <td >{$user->email}</td>
        {if ($smarty.session.HAK == 11)}
        <td >{$user->tgldaftar|date_format:"%d/%m/%Y"}</td>
        {/if}
        <td >{$user->tgllogin|date_format:"%d/%m/%Y-%H:%M:%S"}</td>
         {if ($smarty.session.HAK == 11)}
        <td >
          <form class="form-horizontal"   method="POST">
            <select name="hak" id="hak" onchange="this.form.submit()">
              {foreach from=$userhak item=hak}
                <option value="{$hak->hak}" {($user->hak==$hak->hak)? "selected":""}>{$hak->nama}</option>   
               {/foreach}
            </select>
            <input name="uid" type="hidden" value="{$user->id}">
          </form>
        </td>
        {/if}
        <td >
            <div class="btn-group">
              <button type="button" class="btn btn-sm btn-default dropdown-toggle" data-toggle="dropdown">
              <i class="glyphicon glyphicon-cog"></i> Aksi <span class="caret"></span>
              </button>
              <ul class="dropdown-menu" role="menu">
                <li><a href="{$SCRIPT_NAME}?l=profiledetail&id={$user->id}"><i class="glyphicon glyphicon-edit"></i> Lihat Detail</a></li>  
                <li><a href="{$SCRIPT_NAME}?l=profile_edit&id={$user->id}"><i class="glyphicon glyphicon-edit"></i> Edit</a></li>  
                <li class="delete-link"><a  href="{$SCRIPT_NAME}?l=profile&delid={$user->id}" ><i class="glyphicon glyphicon-remove"></i> Delete</a></li>
              </ul>
            </div>
        </td>
      </tr>
    {/foreach}
  </table>
         <!-- Paging-->
         {if ($smarty.session.HAK <=11)}
         <div class=" text-center"> 
         <nav>
          <ul class="pagination pagination-lg">
            <li {($page==1) ? "class='disabled'": "class=' '"}>
              <a href="{$SCRIPT_NAME}?l=profile&page=1" aria-label="Previous"><span aria-hidden="true" class="glyphicon glyphicon-fast-backward"> </span></a>
            </li>
            {if ($page > 1)} 
              <li><a href="{$SCRIPT_NAME}?l=profile&page={$page-1}" class="glyphicon glyphicon-backward"> </a></li>
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
                  <a href="{$SCRIPT_NAME}?l=profile&page={$hal}"> {$hal}<span class="sr-only"></span></a>
                 </li>
                {assign var="showPage" value=$hal}
              {/if}
            {/for}

            {if ($page < $totalpage)}
              <li><a href="{$SCRIPT_NAME}?l=profile&page={$page+1}" class="glyphicon glyphicon-forward"> </a></li>
            {/if}

            <li {($page==$totalpage) ? "class='disabled'": "class=' '"}>
              <a href="{$SCRIPT_NAME}?l=profile&page={$totalpage}" aria-label="Next">
                <span aria-hidden="true" class="glyphicon glyphicon-fast-forward"> </span>
              </a>
            </li>
          </ul>
        </nav>
        </div><!--/end Paging-->
        {/if}
{/if}
