<!--menu breadcrumb-->
<ol class="breadcrumb">
	{if ($basename == 'index')} 
		<li class='kotak  '><a href="index.php"> <span class="glyphicon glyphicon-home"> </span> Home </a> </li>
    	{if isset($smarty.get.kat)}
    		<span class="glyphicon glyphicon-arrow-right"> </span>
			<li class="active kotak  "}> {$smarty.get.kat|capitalize:true} </li>
		{/if}
		{if isset($smarty.get.r)}
			<span class="glyphicon glyphicon-arrow-right"> </span>
			<li class="active kotak  "}> {$berita[0]->judul|unescape:'htmlall'|capitalize:true} </li>
		{/if}	
	{else}
		<li class='active kotak  '> <a href="index.php"> <span class="glyphicon glyphicon-home"> </span> Home </a> </li>
	{/if}
    	
	{if ($basename == $link_file) && ($basename != "index")}
		<span class="glyphicon glyphicon-arrow-right"> </span>
		<li class="active kotak  "}> {$basename|capitalize:true} </li> 
	{/if} 


</ol>
