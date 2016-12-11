<div id="TableSpinner" class="text-center"><i class="fa fa-spinner fa-spin fa-3x"></i></div>

<table id="free_numbers_table" class="table display_none table-striped table-condensed">
    <thead>
        <tr>
            <th class="td-center">{_ Type _}</th>
            <th class="td-center">{_ Number _}</th>
            <th class="td-center">{_ Activation charge _}</th>
            <th class="td-center">{_ Monthly fee _}</th>
            <th class="td-center"></th>
        </tr>
    </thead>
    {% with m.kazoo.valid_card_exists, m.kazoo.is_service_plan_applied as card_exists, plan_applied %}
    <tbody id="mytbodyid">
        {% for number in free_numbers %}
            <tr>
               <td class="td-center">{{ number["friendly_name"] }}</td>
               <td class="td-center">{{ number["number"] }}</td>
               <td class="td-center">{{ m.config.mod_kazoo.local_currency_sign.value }}{{ number["activation_charge"]|format_price }}</td>
               <td class="td-center">{{ m.config.mod_kazoo.local_currency_sign.value }}2.00</td>
               {% if card_exists and plan_applied %}
               <td class="td-center">
                 <i id="purchase_number_{{ number["number"]|cleanout }}" class="fa fa-shopping-cart pointer" aria-hidden="true"></i>
                 {% wire id="purchase_number_"++number["number"]|cleanout 
                         action={confirm text=_"<br />Chosen number: <span style='color: #E86110;'>"
                                                ++number["number"]++
                                                "</span><br />
                                                <br />
                                                Number will be added to your account and will be ready 15 minutes after the purchase.
                                                <br />
                                                You will be immediately charged for recurring services. 
                                                <br />
                                                Charges will be pro-rated for your billing cycle.
                                                <br />
                                                <br />"
                                 action={mask target="mytbodyid" message=_"Processing number purchase..."}
                                 action={postback postback={allocate_number number} delegate="mod_kazoo" inject_args number=number["number"]}
                         }
                 %}
               </td>
               {% elseif not card_exists and plan_applied %}
               <td class="td-center">
                 <i id="purchase_number_{{ number["number"]|cleanout }}" class="fa fa-shopping-cart pointer" aria-hidden="true"></i>
                 {% wire id="purchase_number_"++number["number"]|cleanout 
                         action={confirm text=_"<br />Chosen number: <span style='color: #E86110;'>"
                                                ++number["number"]++
                                                "</span><br />
                                                <br />
                                                Number will be added to your account and will be ready 15 minutes after the purchase.
                                                <br />
                                                You will be immediately charged for recurring services.
                                                <br />
                                                Charges will be pro-rated for your billing cycle.
                                                <br />
                                                <br />
                                                Before proceeding, ensure that a valid credit card has been added 
                                                to the <a href='/finance_details'  target='_blank'>Payments</a> section.
                                                <br />
                                                <br />"
                                 action={mask target="mytbodyid" message=_"Processing number purchase..."}
                                 action={postback postback={allocate_number number} delegate="mod_kazoo" inject_args number=number["number"]}
                         }
                 %}
               </td>
               {% else %}
               <td class="td-center">
                 <i id="purchase_number_{{ number["number"]|cleanout }}" class="fa fa-shopping-cart pointer" aria-hidden="true"></i>
                 {% wire id="purchase_number_"++number["number"]|cleanout 
                         action={confirm text=_"<br />Chosen number: <span style='color: #E86110;'>"
                                                ++number["number"]++
                                                "</span><br />
                                                <br />
                                                Number will be added to your account and will be ready 15 minutes after the purchase.
                                                <br />
                                                You will be immediately charged for recurring services. 
                                                <br />
                                                Charges will be pro-rated for your billing cycle.
                                                <br />
                                                <br />
                                                If this is your first purchase, please be advised that a Hosted PBX fee of 10.00 GBP per month 
                                                will be applied to your account starting from today.
                                                <br />
                                                <br />
                                                Before proceeding, ensure that a valid credit card has been added 
                                                to the <a href='/finance_details'  target='_blank'>Payments</a> section.
                                                <br />
                                                <br />"
                                 action={mask target="mytbodyid" message=_"Processing number purchase..."}
                                 action={postback postback={allocate_number number} delegate="mod_kazoo" inject_args number=number["number"]}
                         }
                 %}
               </td>
               {% endif %}
            </tr>
        {% endfor %}
    </tbody>
    {% endwith %}
</table>

{% javascript %}
//var initSearchParam = $.getURLParam("filter");
var oTable = $('#free_numbers_table').dataTable({
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
$('#TableSpinner').hide();
$('#free_numbers_table').show();


{% endjavascript %}


