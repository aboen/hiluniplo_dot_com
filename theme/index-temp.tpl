{config_load file="default.conf" section="Customer"}
{include file="_header.tpl" title="index top"}

<div class="container-fluid page-header">
<div class="col-lg-12">
    <div  class="text-center">
        {(isset($message))? $message : "" }
    </div>
<form action="" method="post" class="form-horizontal" role="form">


<h2>Kustomer</h2>
<hr>
<div class="row">

    <div class="col-lg-1"></div>
    <div class="col-lg-8">
            <div class="form-group ">
                <label for="clientName" class="col-sm-2 control-label ">Nama Kustomer : </label>
                <div class="col-sm-10">
                    <input size="50" type="text" name="clientName" value="{(isset($customerlist[0]->clientName)) ? $customerlist[0]->clientName : ""}"/>
                    <input type="hidden" name="userId" value="{(isset($customerlist[0]->id)) ? $customerlist[0]->id : ""}"/>
                </div>
            </div>
            <div class="form-group">
                <label for="clientCompany " class="col-sm-2 control-label">Nama Perusahaan : </label>
                <div class="col-sm-10">
                    <input size="50" type="text" name="clientCompany" value="{(isset($customerlist[0]->clientCompany)) ? $customerlist[0]->clientCompany : ""}"/> 
                    
                </div>
            </div>
            <div class="form-group">
                <label for="clientAddress" class="col-sm-2 control-label">Alamat Perusahaan : </label>
                <div class="col-sm-10">
                    <textarea rows="4" cols="50" type="text" name="clientAddress" >{(isset($customerlist[0]->clientAddress))  ? $customerlist[0]->clientAddress : ""}
                    </textarea>
                </div>
            </div>       
            <div class="form-group">
                <label for="clientPostal" class="col-sm-2 control-label">Kota : </label>
                <div class="col-sm-10">
                    <input size="50" type="text" name="clientPostal"  value="{(isset($customerlist[0]->clientPostal))  ? $customerlist[0]->clientPostal : ""}"/>
                </div>
            </div>       
            <div class="form-group">
                <label for="clientPhone" class="col-sm-2 control-label">Telp : </label>
                <div class="col-sm-10">
                    <input size="30" type="text" name="clientPhone" value="{(isset($customerlist[0]->clientPhone))  ? $customerlist[0]->clientPhone : ""}"/>
                </div>
            </div>       
            <div class="form-group">
                <label for="clientEmail" class="col-sm-2 control-label">Email : </label>
                <div class="col-sm-10">
                    <input size="30" type="text" name="clientEmail" value="{(isset($customerlist[0]->clientEmail))  ? $customerlist[0]->clientEmail : ""}"/>
                </div>
            </div>                  

    </div>
<div class="col-lg-10"></div>

    
</div>
<hr/>
<div class="row">
    <div class="col-sm-offset-2 col-sm-5">
        <input id="saveInvoiceBtn" class="btn btn-primary" type="submit" name="saveData" value="Simpan">       
        <a href="user.php" id="" class="btn btn-danger pull-right"><i class="glyphicon glyphicon-chevron-left"></i> Batal</a>
      </div>              

</div>    
</form>
<hr>

<div class="row">

    <div class="container-fluid">
    <div class="col-lg-11">
        <table class="table table-striped table-condensed" id="itemsTable">

            <thead>
            <tr><th style="width: 2%">No</th>
               
                <th  style="width: 20%">Nama Kustomer</th>
                <th  style="width: 20%">Nama Perusahaan</th>
               <th  style="width: 20%">Alamat Perusahaan</th>
               <th  style="width: 15%">Kota</th>
               <th  style="width: 10%">Telp</th>
               <th  style="width: 10%">Email</th>
                <th  style="width: 3%"> </th>
            </tr>
            </thead>
            <tbody class="responsive">
                {if isset($customers)}
                {foreach from=$customers item=customer name=noUrut}
                    <tr class="item-row">
                        <td class="responsive">{$smarty.foreach.noUrut.iteration}</td>
                        <td class="responsive">{$customer->clientName}</td>
                        <td class="responsive">{$customer->clientCompany}</td>
                        
                        <td class="responsive">{$customer->clientAddress}</td>
                        <td class="responsive">{$customer->clientPostal}</td>
                        <td class="responsive">{$customer->clientPhone}</td>
                        <td class="responsive">{$customer->clientEmail}</td>
                        <td class="responsive">

                            <div class="btn-group">
                                <button type="button" class="btn btn-sm btn-default dropdown-toggle"
                                        data-toggle="dropdown">
                                    <i class="glyphicon glyphicon-cog"></i> Aksi <span class="caret"></span>
                                </button>
                                <ul class="dropdown-menu" role="menu">
                                    <li><a href="customer.php?userId={$customer->id}"><i
                                                    class="glyphicon glyphicon-edit"></i> Edit</a></li>
                                   
                                    <li><a href="customer.php?action=delete&userId={$customer->id}"
                                           onclick="return deleteConfirm('Are you sure you want to delete this?');"><i
                                                    class="glyphicon glyphicon-remove"></i> Delete</a></li>
                                </ul>
                            </div>


                        </td>
                    </tr>
                    
                {/foreach}
                {/if}
                </tbody>


            </tbody>
        </table>

       

      </div>  
    </div>
</div>

</div>

</div>

{include file='_footer.tpl'}