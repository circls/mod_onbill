<table id="rs_proforma_invoice_table" class="table display table-striped table-condensed">
   <thead>
        <tr>
            <th>{_ Type _}</th>
            <th>{_ Counterparty _}</th>
            <th>{_ Date _}</th>
            <th>{_ Sum _}</th>
            <th>{_ VAT _}</th>
            <th>{_ Total _}</th>
        </tr>
    </thead>
    <tbody>
      {% for doc in m.onbill[{crossbar_listing account_id=account_id year=year month=month}] %}
        <tr>
            <td><a target="_blank" href="{{ m.onbill[{attachment_download_link doc_id=doc["id"] year=year month=month}] }}">{{ doc["type"] }}</a></td>
            <td><a target="_blank" href="{{ m.onbill[{attachment_download_link doc_id=doc["id"] year=year month=month}] }}">{{ doc["oper_name_short"] }}</a></td>
            <td>{{ doc["doc_date"] }}</td>
            <td>{{ doc["total_netto"] }}</td>
            <td>{{ doc["total_vat"] }}</td>
            <td>{{ doc["total_brutto"] }}</td>
        </tr>
      {% endfor %}
    </tbody>
</table>

{% javascript %}
//var initSearchParam = $.getURLParam("filter");
var oTable = $('#rs_proforma_invoice_table').dataTable({
"pagingType": "simple",
"bFilter" : true,
"aaSorting": [[ 0, "desc" ]],
"aLengthMenu" : [[5, 15, -1], [5, 15, "All"]],
"iDisplayLength" : 5,
"oLanguage" : {
        "sInfoThousands" : " ",
        "sLengthMenu" : "_MENU_ {_ lines per page _}",
        "sSearch" : "{_ Filter _}:",
        "sZeroRecords" : "{_ Nothing found, sorry _}",
        "sInfo" : "{_ Showing _} _START_ {_ to _} _END_ {_ of _} _TOTAL_ {_ entries _}",
        "sInfoEmpty" : "{_ Showing 0 entries _}",
        "sInfoFiltered" : "({_ Filtered from _} _MAX_ {_ entries _})",
        "oPaginate" : {
                "sPrevious" : "{_ Back _}",
                "sNext" : "{_ Forward _}"
        }
},

});

{% endjavascript %}

