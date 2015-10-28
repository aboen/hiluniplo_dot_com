<!--menu navigasi  -->
{if isset($smarty.session.NAMA) }
<div class="row text-uppercase">
	
    <ul class="nav nav-pills  nav-stacked">
      <li {($basename == 'index') ? "class='active kotak '" : "class='kotak hijau '"}><a href="#">LOGIN</a></li>
      <li {($basename == 'register') ? "class='active kotak '" : "class='kotak hijau' "}><a href="#">REGISTER</a></li>
      <li {($basename == 'seller') ? "class='active kotak'" : "class='kotak hijau' "}><a href="#">SELLER</a></li>
    </ul>
</div><!--/row  -->
{/if}
