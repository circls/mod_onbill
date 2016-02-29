{% extends "onnet_widget_dashboard.tpl" %}

{% block widget_headline %}
{% wire id="arrows_"++#dtid type="click"
        action={ toggle target="rs_payments_list_widget_opened" }
        action={ toggle target="arrow_right_"++#dtid }
        action={ toggle target="arrow_down_"++#dtid }
        action={ postback postback={trigger_innoui_widget arg="rs_payments_list_widget_opened" } delegate="mod_kazoo" }
%}
  <span id="arrows_{{ #dtid }}" style="cursor: pointer;">
    <i id="arrow_right_{{ #dtid }}" style="{% if m.kazoo[{ui_element_opened element="rs_payments_list_widget_opened"}] %}display: none;{% endif %}" 
                                    class="arrowpad fa fa-arrow-circle-right"></i>
    <i id="arrow_down_{{ #dtid }}" style="{% if not m.kazoo[{ui_element_opened element="rs_payments_list_widget_opened"}] %}display: none;{% endif %}" 
                                   class="arrowpad fa fa-arrow-circle-down"></i>
  </span>
    {{ headline }}
    {% button class="btn btn-xs btn-onnet pull-right" text=_"add credit" id="child_area_add_credit"
              action={dialog_open title=_"Add credit to "++child_account_doc[1]["name"] template="rs_add_credit.tpl" account_id=account_id}
    %}
{% endblock %}

{% block widget_class %}{% if last %}last{% endif %}{% endblock %}

{% block widget_content %}
<div id="rs_payments_list_widget_opened" style="{% if not m.kazoo[{ui_element_opened element="rs_payments_list_widget_opened"}] %}display: none;{% endif %}">
<table id="payments_lists_table" class="table display table-striped table-condensed">
    <thead>
        <tr>
            <th class="td-center">{_ Date _}</th>
            <th class="td-center">{_ Sum _}</th>
            <th class="td-center">{_ Status _}</th>
            <th class="td-center">{_ Paid by _}</th>
        </tr>
    </thead>
    <tbody>
            {% for transaction in m.kazoo[{kz_list_transactions account_id=account_id}] %}
                <tr id={{ transaction["id"] }} {% if transaction["subscription_id"] %}style="cursor: pointer;"{% endif %}>
                    <td class="td-center">{{ transaction["created_at"]|inno_iso_to_date|date:"Y-m-d H:i T":m.kazoo.get_user_timezone }}</td>
                    <td class="td-center">{% include "_currency_code_to_sign.tpl" code=transaction %}</td>
                    <td class="td-center">{{ transaction["status"] }}</td>
                    <td class="td-center">
                        {% include "_set_payment_system_sign.tpl" card_type=transaction["card"][1]["card_type"] %}
                        ***{{ transaction["card"][1]["last_four"] }}</td>
                </tr>
                {% if transaction["subscription_id"] %}
                  {% wire id=transaction["id"] action={ dialog_open title=_"Transaction details"
                                                                    template="_lazy_transaction_details.tpl"
                                                                    account_id=account_id
                                                                    transaction=transaction }
                  %}
                {% endif %}
            {% endfor %}
    </tbody>
</table>
</div>

{% javascript %}
//var initSearchParam = $.getURLParam("filter");
var oTable = $('#payments_lists_table').dataTable({
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


{% endblock %}

