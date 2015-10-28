<html>
<!-- from rekapharian_pdf.php -->
<body>
<style type="text/css">
    body {
        background-color: transparent;
        color: black;
        font-family: "verdana", "sans-serif";
        margin: 0px;
        padding: 0px 0px -15px 0px;
        font-size: .63em;
    }

    .header_row th {
        background-color: transparent;
        border-bottom: 0.9px solid #ddd; /* 0.9 so table borders take precedence */
        padding-top: 15px;
        padding-bottom: 3px;
    }

     .zebra tr:nth-child(even) {
    background-color: #99FF99;
    padding: 5px 15px 5px 15px;

    }

    .zebra tr:nth-child(odd) {
   background-color: transparent;
    padding: 5px 15px 5px 15px;
   
    }

</style>

<table style="width: 100%; margin-bottom: 5px; margin-top:-50px;">
    <tr>
        <td style="text-align: center;">
             <h2 > <u><strong>LAPORAN PENJUALAN HARIAN</strong></u></h2>  
             <h3 class="text-center"> Laporan Penjualan Harian dari Tanggal Tutup Buku </h3>
                <h4 class="text-center">Kustomer : {$kustomer}<br>
                Dari Tanggal : {$fdate|date_format:"%d %b %Y"}, Sampai Tanggal : {$edate|date_format:"%d %b %Y"}<br>
                </h4>           
        </td>
        
    </tr>
</table>
<table class="zebra" style="width: 100%; border-bottom: 0.9px solid #190707; border-collapse:collapse;">
     <thead style=" border-bottom: 0.9px solid #190707;border-top: 0.9px solid #190707;"> 
        <tr>
            <th style="width: 5%">No</th>
            <th style="width: 10%">Tanggal </th>
            <th style="width: 10%">No Faktur</th>  
            <th style="width: 10%">No. PO</th> 
            <th style="width: 30%">Nama Barang</th>
            <th style="text-align: left; width: 10%;">Ukuran</th>
            <th style="text-align: left; width: 4%;">Qty</th>
            <th style="text-align: left; width: 5%;">Satuan</th>
            <th style="text-align: center; width: 5%;">Disc</th>
            <th style="text-align: center; width: 10%;">Harga Satuan</th>
            <th style="text-align: center; width: 15%">Total</th>
        </tr>
    </thead>
    <tbody >
        {assign var="sum" value=0}
        {assign var="invId" value=0}
        {assign var="tax" value=0}
        {assign var="total" value=0}
        {foreach from=$rekapinvoices key=k item=rinvoice name=noUrut}
        <tr >
            <td >{$smarty.foreach.noUrut.iteration}</td>
            <td >{$rinvoice->date|date_format:"%d/%m/%Y"}</td>
            <td style="text-align: right;" >{$rinvoice->number}</td>
            <td style="text-align: center;">{$rinvoice->poNumber}</td> 
            <td >{$rinvoice->itemName}</td> 
            <td style="text-align: right;">{$rinvoice->itemUkuran} {$rinvoice->itemSize}</td>
            <td style="text-align: right;">{$rinvoice->qty}</td>
            <td style="text-align: right;">{$rinvoice->satuan}</td>
            <td style="text-align: right;">{$rinvoice->itemDisc} {if !empty($rinvoice->itemDisc)} % {/if}</td>
            <td style="text-align: right;">Rp. {$rinvoice->itemPrice|number_format}</td>
                {assign var="tax" value="`$rinvoice->subTotal*$rinvoice->tax*0.01`"} 
                {assign var="total" value="`$rinvoice->subTotal + $tax`"}
            <td style="text-align: right;">Rp. {$total|number_format}</td>

        </tr>
            {assign var="sum" value="`$sum+$rinvoice->subTotal`"}                          
            {assign var="invId" value="`$rinvoice->invId`"}
        {/foreach}
         <tr>
            <td style="background-color: transparent;" colspan="12"><hr> </td>
         </tr>

        <tr >
            <td style="background-color: transparent;" colspan="8">  </td>
            <td style="background-color: transparent;" colspan="2">Mulai</td>
            <td style="background-color: transparent;" colspan="2">: {$fdate|date_format:"%d-%b-%Y"} </td>
        </tr>
        <tr >
            <td style="background-color: transparent;" colspan="8">  </td>
            <td style="background-color: transparent;" colspan="2">Sampai</td>
            <td style="background-color: transparent;" colspan="2">: {$edate|date_format:"%d-%b-%Y"}  </td>
        </tr>
        <tr >
            <td style="background-color: transparent;" colspan="8">  </td>
            <td style="background-color: transparent;" colspan="2">Nama Kustomer</td>
            <td style="background-color: transparent;" colspan="2">: {$kustomer}  </td>
        </tr>
        <tr >
            <td style="background-color: transparent;" colspan="8">  </td>
            <td style="background-color: #FFA3A3;padding: 1px 10px 1px 10px;" colspan="2" ><h4> Grand Total </h4></td>
            <td style="background-color: #FFA3A3; text-align: right;padding: 1px 10px 1px 10px;" colspan="2"  ><h4>Rp. {$sum|number_format}</h4></td>
        </tr>
               
    </tbody>

</table>

</body>
</html>