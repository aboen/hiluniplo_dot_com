<!--_gantipassword.tpl-->
{if isset($smarty.session.ID)}
<form id="chgpass" name="chgpass" class="form-horizontal "  method="POST">
  <div class="form-group has-success  ">
  	<div class="form-group">
  		<p> </p>
  	</div>
  	<div class="form-group">
    	<label for="inputPassword" class="col-sm-2 control-label">Password Baru</label>
    	<div class="col-sm-5">
      		<input id="password" type="password" class="form-control" name="password" placeholder="Password Baru" required>
   		 </div>
  	</div>
  	<div class="form-group">
    	<label for="inputPassword" class="col-sm-2 control-label">Ulangi Password Baru</label>
    	<div class="col-sm-5">
      		<input id="password2" type="password" class="form-control" name="password2" placeholder="Ulangi Password Baru diatas" required >
   		 </div> 
       {if isset($smarty.session.ID)}
   		 <input  type="hidden" name ="idpasswd" value="{$smarty.session.ID}" >
       {/if}
  	</div>
  		<div class="form-group">
		<label for="inputPassword" class="col-sm-2 control-label"></label>
	  	<div class="col-sm-5">
	  		<button name="savepass" type="submit" class="btn btn-primary" value="ok"> G a n t i </button>
	  	</div>
	  	<div class="col-sm-5"> <button  type="reset" class="btn btn-default"> B a t a l  </button></div>
	</div>
 </form>

<script src='assets/js/jquery.validate.min.js'></script>
<script>
    $("#chgpass").validate({
        rules: {
            password: { 
                required: true,
                minlength: 6,
                maxlength: 10,
                   } , 

            password2: { 
                equalTo: "#password",
                minlength: 6,
                maxlength: 10
                   }
               }
           });
</script>
{/if}