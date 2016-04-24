<table id="rs_proforma_invoice_table" class="table display table-striped table-condensed">
   <thead>
        <tr>
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
            <td><a href="{{ m.onbill[{attachment_download_link doc_id=doc["id"] year=year month=month}] }}">{{ doc["name"] }}</a></td>
            <td><a href="{{ m.onbill[{attachment_download_link account_id=account_id  doc_id=doc["id"] year=year month=month}] }}">{{ doc["id"] }}</a></td>
            <td><a href="/kzattachment/id/{{ doc["id"] }}">{{ year }}</a></td>
            <td><a href="/kzattachment/id/{{ doc["id"] }}">{{ month }}</a></td>
            <td><a href="/kzattachment/id/{{ doc["id"] }}">{{ doc["name"] }}</a></td>
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

