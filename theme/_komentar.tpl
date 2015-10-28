<!--_komentar.tpl-->
<p></p>
   {if !empty($totalpage)}
        <div class="table-responsive">
          <table class="table table-striped">
              <tr>
                <th class="warning"> No </th>
                <th class="warning">Nama</th>
                <th class="warning">Nama Panggilan</th>
                <th class="warning">Komentar</th>
                <th class="warning">Tanggal</th>
                <th class="warning">Link</th>
                <th class="warning"> </th>
                
              </tr>
              {foreach from=$listkomen item=komentar }
              <tr>
                <td >{$komentar@iteration}</td>
                <td >{$komentar->nama|upper}</td>
                <td >{$komentar->namapgl|upper}</td>
                <td >{$komentar->komentar}</td>
                <td >{$komentar->tglkomen}</td>
                <td ><a href="index.php?r={$komentar->idberita}#{$komentar->id}"> Lihat Link </a></td>
              
                <td ><form method="POST">
                		<button class="delete-link" type="submit" name="hapuskomen" value="{$komentar->id}">Hapus</button>
                	</form> 
            	</td>
              </tr>
              {/foreach}
          </table>   
        </div><!--/table-responsive-->  
          <!-- Paging-->
         <div class=" text-center"> 
         <nav>
          <ul class="pagination pagination-lg">
            <li {($page==1) ? "class='disabled'": "class=' '"}>
              <a href="{$SCRIPT_NAME}?l=posting&s=komentar&page=1" aria-label="Previous"><span aria-hidden="true" class="glyphicon glyphicon-fast-backward"> </span></a>
            </li>
            {if ($page > 1)} 
              <li><a href="{$SCRIPT_NAME}?l=posting&s=komentar&page={$page-1}" class="glyphicon glyphicon-backward"> </a></li>
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
                  <a href="{$SCRIPT_NAME}?l=posting&s=komentar&page={$hal}"> {$hal}<span class="sr-only"></span></a>
                 </li>
                {assign var="showPage" value=$hal}
              {/if}
            {/for}

            {if ($page < $totalpage)}
              <li><a href="{$SCRIPT_NAME}?l=posting&s=komentar&page={$page+1}" class="glyphicon glyphicon-forward"> </a></li>
            {/if}

            <li {($page==$totalpage) ? "class='disabled'": "class=' '"}>
              <a href="{$SCRIPT_NAME}?l=posting&s=komentar&page={$totalpage}" aria-label="Next">
                <span aria-hidden="true" class="glyphicon glyphicon-fast-forward"> </span>
              </a>
            </li>
          </ul>
        </nav>
        </div><!--/end Paging-->
      {/if}