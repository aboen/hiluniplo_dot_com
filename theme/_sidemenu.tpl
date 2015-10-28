<!--menu navigasi  -->
<div data-spy=" " >
<div class="row text-uppercase  hidden-xs">
    <ul class="nav nav-pills  nav-stacked "> 
    	<li {($basename == 'index') ? "class='active kotak '" : "class='kotak hijau '"}><a href="index.php"> HOME </a></li>
    	<li {($basename == 'dataalumni') ? "class='active kotak '" : "class='kotak hijau '"}><a href="dataalumni.php"> Data Alumni </a></li>
      	<li {($basename == 'login') ? "class='active kotak '" : "class='kotak hijau '"}><a href="login.php"> LOGIN </a></li>
      	<li {($basename == 'register') ? "class='active kotak '" : "class='kotak hijau ' "}><a href="register.php"> REGISTER </a></li>
    </ul>
    
   	<ul class="nav nav-pills nav-stacked">
    <li role="presentation" class="dropdown" {($basename == 'kategori') ? "class='active kotak '" : "class='kotak hijau ' "}>
    		<a  class="dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">
    		 Kategori <span class="caret"></span>
    		</a>
			    <ul class="dropdown-menu ">
			    {foreach from=$listkat item=kategori} 
			     <li class=""><a href="{$SCRIPT_NAME}?kat={$kategori->namakategori}">{$kategori->namakategori} <span class="badge">{$kategori->jmlkat}</span></a></li>
			    {/foreach} 
			    </ul>
  		</li>
  	</ul>
  
</div><!--/row  -->

</div><!--/affix  -->


<div class="row text-uppercase   visible-xs-block">
    <ul class="nav nav-pills  nav-stacked "> 
    	<li {($basename == 'index') ? "class='active kotak '" : "class='kotak hijau '"}><a href="index.php"> HOME </a></li>
    	<li {($basename == 'dataalumni') ? "class='active kotak '" : "class='kotak hijau '"}><a href="dataalumni.php"> Data Alumni </a></li>
      	<li {($basename == 'login') ? "class='active kotak '" : "class='kotak hijau '"}><a href="login.php"> LOGIN </a></li>
      	<li {($basename == 'register') ? "class='active kotak '" : "class='kotak hijau ' "}><a href="register.php"> REGISTER </a></li>
    </ul>
    
   	<ul class="nav nav-pills nav-stacked">
    <li role="presentation" class="dropdown" {($basename == 'kategori') ? "class='active kotak '" : "class='kotak hijau ' "}>
    		<a  class="dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">
    		 Kategori <span class="caret"></span>
    		</a>
			    <ul class="dropdown-menu ">
			    {foreach from=$listkat item=kategori} 
			     <li class=""><a href="{$SCRIPT_NAME}?kat={$kategori->namakategori}">{$kategori->namakategori} <span class="badge">{$kategori->jmlkat}</span></a></li>
			    {/foreach} 
			    </ul>
  		</li>
  	</ul>
  
</div>
<div class="row clearfix">
 {include  file="_listkomentar.tpl"}
</div>