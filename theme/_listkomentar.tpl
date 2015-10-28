<!-- list komentar _listkomentar.tpl-->
{if isset($listkomentar)}
<h3><span class="label label-primary">Komentar</span></h3>
{foreach from=$listkomentar item=liskomen}

  <div class="kotak bg-warning">
    <strong>{$liskomen->namapgl|upper}</strong> <br>
    <small> {$liskomen->tglkomen|date_format:"%d/%b/%y"} </small><br>
      {assign var=readMoreText value=".. <a href='{$SCRIPT_NAME}?r={$liskomen->idberita}#{$liskomen->id}'> <small> Lihat </small></a>"} 
      {$liskomen->komentar|unescape:'htmlall'|truncate:80:$readMoreText}
  </div>
{/foreach}
{/if}                      