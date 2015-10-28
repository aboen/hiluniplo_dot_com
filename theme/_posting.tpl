<!--_posting.tpl-->
{if isset($smarty.session.ID)}
<div class="container">
<!--Navigasi user dashboard--> 
  <p> </p>
	<div class="row">
	<nav role="navigation">
	    <ul class="nav  nav-pills nav-justified">
	        <li role="presentation" {($GETsubURL==' ' || $GETsubURL == 'listpost') ? "class='active'" : " "}><a href="{$SCRIPT_NAME}?l=posting&s=listpost">List Posting</a></li>
          {if isset($editpost[0]->judul)} 
            <li role="presentation" {($GETsubURL =='postingbaru') ? "class='active'" : " "}><a href="{$SCRIPT_NAME}?l=posting&s=postingbaru&editid={$editpost[0]->id}">Edit Posting</a></li>
          {else} 
	           <li role="presentation" {($GETsubURL =='postingbaru') ? "class='active'" : " "}><a href="{$SCRIPT_NAME}?l=posting&s=postingbaru">Posting Baru</a></li>
          {/if}
          <li role="presentation" {($GETsubURL == 'komentar') ? "class='active'" : " "}><a href="{$SCRIPT_NAME}?l=posting&s=komentar">Komentar</a></li>
	        <li role="presentation" {($GETsubURL == 'media') ? "class='active'" : " "}><a href="{$SCRIPT_NAME}?l=posting&s=media">M e d i a</a></li>
	        {if ($smarty.session.HAK <= 22)}
	        <li role="presentation" {($GETsubURL == 'slideshow') ? "class='active'" : " "}><a href="{$SCRIPT_NAME}?l=posting&s=slideshow">Posting Slide Show</a></li>
	        {/if}

	    </ul>
	</nav >
	</div><!--/end row-->
<!--/Navigasi user dashboard-->
  <!--List Posting -->
  {if ($GETsubURL==' ' || $GETsubURL == 'listpost')}
    {include file='_listpost.tpl'}
  {/if}  
  <!--/List Posting-->
  {if ($GETsubURL=='postingbaru')}
    {include file='_postingbaru.tpl'}
  {/if}
  <!--/List komentar-->
  {if ($GETsubURL=='komentar')}
    {include file='_komentar.tpl'}
  {/if}
  <!--/List slideshow--> 
  {if ($smarty.session.HAK <= 22) && ($GETsubURL=='slideshow')}
    {include file='_slideshow.tpl'}
  {/if}
</div><!--/end container-fluid-->
{/if} <!--/end session.ID-->