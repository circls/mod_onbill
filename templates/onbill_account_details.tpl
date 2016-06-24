{% extends "modkazoo_widget_dashboard.tpl" %}

{% block widget_headline %}
    {{ headline }}
    {% button class="btn btn-xs btn-onnet pull-right" text=_"refresh" id="child_area_refresh"
              action={update target="billing_children_area" template="billing_children.tpl" headline=_"Account details" zotonic_dispatch="billing_accounts"}
    %}
    {% button class="btn btn-xs btn-onnet pull-right" text=_"send message" id="child_area_send_message"
              action={dialog_open title=_"Send message to customer" template="rs_kz_customer_update.tpl" account_id=account_id}
    %}
{% endblock %}

{% block widget_class %}{% if last %}last{% endif %}{% endblock %}

{% block widget_content %}
{% with m.kazoo[{kz_get_acc_doc_by_account_id account_id=account_id}] as account_doc %}
<table class="table table-condensed table-centered">
    <thead>
        <tr>
            <th>{_ Account status _}</th>
            <th>{% if account_doc[1]["enabled"] %}<span class="zprimary">{_ Active _}</span>
                            {% else %}<span class="zalarm">{_ Blocked _}{% endif %}</span>
                <span class="pull-right" style="padding-right: 1em;">
                  {{ m.config.mod_kazoo.local_currency_sign.value }}{{ m.kazoo[{current_account_credit account_id=account_id}]|format_price }}
                </span>
            </th>
        </tr>
    </thead>
</table>
<span id="set_notify_level_tpl">
  {% set_balance_level_notify %}
</span>
{% rs_service_plans_manager %}
<table class="table table-condensed table-centered">
    <tbody>
        <tr style="height: 10px; color: white!important; background-color: white!important;"><td colspan="2"></td></tr>
        <tr><th colspan="2">
            {% wire id="arrows_"++#id type="click"
                    action={ toggle target="onbill_account_details_widget_opened" }
                    action={ toggle target="arrow_right_"++#id }
                    action={ toggle target="arrow_down_"++#id }
                    action={ postback postback={trigger_innoui_widget arg="onbill_account_details_widget_opened" } delegate="mod_kazoo" }
            %}
              <span id="arrows_{{ #id }}" style="cursor: pointer; padding-left: 0.7em;">
                <i id="arrow_right_{{ #id }}" style="{% if m.kazoo[{ui_element_opened element="onbill_account_details_widget_opened"}] %}display: none;{% endif %}" 
                                                class="arrowpad fa fa-arrow-circle-right"></i>
                <i id="arrow_down_{{ #id }}" style="{% if not m.kazoo[{ui_element_opened element="onbill_account_details_widget_opened"}] %}display: none;{% endif %}" 
                                               class="arrowpad fa fa-arrow-circle-down"></i>
              </span>
               {_ Details _}:
            </th>
        </tr>
    </tbody>
    <tbody id="onbill_account_details_widget_opened" style="border-top: 0px;{% if not m.kazoo[{ui_element_opened element="onbill_account_details_widget_opened"}] %}display: none;{% endif %}">
        <tr><td>{_ Account name _}</td>
            <td><span id="name">
                    {% include "_show_field.tpl" type="account" doc_id="_no_need_" field_name=["name"] account_id=account_id %}
                </span>
            </td>
        </tr>
    </tbody>
</table>
{% endwith %}
{% endblock %}
