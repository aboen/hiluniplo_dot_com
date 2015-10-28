<!--_profiledetail.tpl-->
{if isset($smarty.session.ID)}
<div class="col-md-12">
  <table class="table table-striped table-bordered table-hover ">
    <tr >
      <td class="col-md-2" >Nama</td> <td class="col-md-10">{$users[0]->nama|unescape:'htmlall'|capitalize:true}</td>
    </tr>
    <tr >
      <td class="col-md-2" >Nama Panggilan</td> <td class="col-md-10">{$users[0]->namapgl|unescape:'htmlall'|capitalize:true}</td>
    </tr>
    <tr >
      <td class="col-md-2" >Pekerjaan</td> <td class="col-md-10">{$users[0]->pekerjaan|unescape:'htmlall'|capitalize:true}</td>
    </tr>
    <tr >
      <td class="col-md-2" >Perusahaan</td> <td class="col-md-10">{$users[0]->namaperusahaan|unescape:'htmlall'|capitalize:true}</td>
    </tr>
    <tr >
      <td class="col-md-2" >Tahun Lulus</td> <td class="col-md-10">{$users[0]->tahunlulus}</td>
    </tr>
   
    <tr>    
        <td >Sekolah </td><td>{$users[0]->sekolah|unescape:'htmlall'|capitalize:true} </td>
    </tr>
    <tr>    
       <td> Jurusan </td><td>{$users[0]->jurusan|unescape:'htmlall'|capitalize:true}</td> 
    </tr>
    <tr>    
       <td> Basis </td><td>{$users[0]->basis|unescape:'htmlall'|capitalize:true}</td> 
    </tr>
    <tr>
      <td> No Telp </td><td >{$users[0]->notelp}</td>
    </tr>
    <tr>
        <td> Email </td><td >{$users[0]->email}</td>
    </tr>
       <tr>
        <td> Facebook </td><td >{$users[0]->fb}</td>
    </tr>
    <tr>
        <td> Yahoo Messanger </td><td >{$users[0]->ym}</td>
    </tr>

    <tr> 
        <td >Alamat</td> <td >{$users[0]->alamat|unescape:'htmlall'|capitalize:true} <br>{$users[0]->kota|unescape:'htmlall'|capitalize:true} <br> {$users[0]->propinsi|unescape:'htmlall'|capitalize:true} </td>
    </tr>
    <tr>   
        {if ($smarty.session.HAK == 11)}
        <td> Tgl Daftar</td><td >{$users[0]->tgldaftar|date_format:"%d/%m/%Y"}</td>
        {/if}
    </tr>
    <tr>
        <td> Terakhir Login </td><td >{$users[0]->tgllogin|date_format:"%d/%m/%Y-%H:%M:%S"}</td>
    </tr>
 
    <tr>
        <td> Photo  </td><td ><img src="{$users[0]->photo}"></td>
    </tr>
    <tr>
        <td> Tentang Saya </td><td >{$users[0]->aboutme|unescape:'htmlall'|capitalize:true}</td>
    </tr>    
    <tr>    
         {if ($smarty.session.HAK == 11)}
        <td >{$users[0]->hakakses}</td>
        {/if}
    </tr>
    <tr class=" text-center"> 
        
        <td colspan="2" >
            <div class="btn-group text-center">
              <button type="button" class="btn btn-sm btn-default dropdown-toggle" data-toggle="dropdown">
              <i class="glyphicon glyphicon-cog"></i> Aksi <span class="caret"></span>
              </button>
              <ul class="dropdown-menu" role="menu">
                
                <li><a href="userdashboard.php?l=profile_edit&id={$users[0]->id}"><i class="glyphicon glyphicon-edit"></i> Edit</a></li>  
                <li><a href="userdashboard.php?l=delete&id={$users[0]->id}" onclick="return deleteConfirm('Are you sure you want to delete this?');"><i class="glyphicon glyphicon-remove"></i> Delete</a></li>
              </ul>
            </div>
        </td>
      </tr>

  </table>
</div>
{/if}