{if isset($smarty.session.NAMA)}
{if isset($readmore)} 
	<div class="modal fade  formkomentar-{$berita[0]->id}" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel">
	{else}
	<div class="modal fade  formkomentar-{$beritas@iteration}" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel">
	
{/if}	
 <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Komentar</h4>
      </div>
      	<form class="form-horizontal" id="formkomen"  method="POST" >
	      <div class="modal-body">
	        <div class="form-group">
			    <label for="komentar" class="col-sm-2 control-label">komentar</label>
			    <div class="col-sm-10">
			    	{if isset($readmore)} 
			    	<input type="hidden" name="idkomen" value="{$berita[0]->id}">
			    	{else}
			    	<input type="hidden" name="idkomen" value="{$beritas->id}">
			    	{/if}
			    	<input type="hidden" name="user" value="{$smarty.session.ID}">
			    	<textarea class="form-control" id="komentar" name="komentar"rows="5"></textarea>
			    </div>
			</div>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>

	        <button type="submit" name="postkomen" value="postkomen" class="btn btn-primary">Simpan</button>
	      </div>
  		</form>
    </div>
  </div>
</div>
{/if}
