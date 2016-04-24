<table class="table table-condensed table-centered">
    <thead>
        <tr><th colspan="3">
            {% wire id="arrows_"++#rspinvid type="click"
                    action={ toggle target="rs_proforma_invoice_table_opened" }
                    action={ toggle target=#mypi }
                    action={ toggle target="arrow_right_"++#rspinvid }
                    action={ toggle target="arrow_down_"++#rspinvid }
                    action={ postback postback={trigger_innoui_widget arg="rs_proforma_invoice_table_opened" } delegate="mod_kazoo" }
            %}
              <span id="arrows_{{ #rspinvid }}" style="cursor: pointer; padding-left: 0.7em;">
                <i id="arrow_right_{{ #rspinvid }}" style="{% if m.kazoo[{ui_element_opened element="rs_proforma_invoice_table_opened"}] %}display: none;{% endif %}" 
                                                class="arrowpad fa fa-arrow-circle-right"></i>
                <i id="arrow_down_{{ #rspinvid }}" style="{% if not m.kazoo[{ui_element_opened element="rs_proforma_invoice_table_opened"}] %}display: none;{% endif %}" 
                                               class="arrowpad fa fa-arrow-circle-down"></i>
              </span>
               {_ Proforma invoices _}
            </th>
        </tr>
        <tr id="{{ #mypi }}" style="{% if not m.kazoo[{ui_element_opened element="rs_proforma_invoice_table_opened"}] %}display: none;{% endif %}"><th colspan="3"></th></tr>
    </thead>
</table>
<span id="rs_proforma_invoice_table_opened" style="{% if not m.kazoo[{ui_element_opened element="rs_proforma_invoice_table_opened"}] %}display: none;{% endif %}">
     <div class="text-center p-3">
        {% ilazy class="fa fa-spinner fa-spin fa-3x" action={update target="rs_proforma_invoice_table_opened"
                                                                    template="rs_widget_proforma_invoice_table.tpl"
                                                                    account_id=account_id
                                                                    year=year
                                                                    month=month
                                                                    payments_month_chosen=payments_month_chosen}
        %}
      </div>
</span>
