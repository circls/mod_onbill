{% if m.kazoo[{ui_element_opened element="ap_general_settings_widget_opened"}] %}
{% with m.kazoo.kz_get_acc_doc as account_doc %}
<table class="table table-condensed table-hover table-centered">
    <thead>
        <tr>
            <th style="width: 40%;"class="text-center1">{_ Reseller's name _}</th>
            <th class="text-left">
              <span id="sender_name">
                    {% include "_show_field.tpl" type="account" doc_id="_no_need_" field_name=["sender_name"] account_id=account_id %}
              </span>
            </th>
        </tr>
        <tr>
            <th style="width: 40%;"class="text-center1">{_ VAT disposition _}</th>
            <th class="text-left">
             <span id="vat_disposition">
                {% include "_onbill_show_field_select.tpl" doc_id="onbill_global_variables" field_name="vat_disposition" select="select" options=["brutto","netto"] %}
             </span>
            </th>
        </tr>
        <tr>
            <th class="text-center1">{_ VAT rate, % _}</th>
            <th class="text-left">
             <span id="vat_rate">
                {% include "_onbill_show_field.tpl" doc_id="onbill_global_variables" field_name="vat_rate" %}
             </span>
            </th>
        </tr>
        <tr>
            <th class="text-center1">{_ Outbound routing _}</th>
            <th class="text-left">
             <span id="account_outbound_routing_selection">
                {% include "_account_outbound_routing_selection.tpl" %}
             </span>
            </th>
        </tr>
    </thead>
</table>
{% endwith %}
{% else %}
{% endif %}
