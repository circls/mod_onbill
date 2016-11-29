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
        <tr><th>{_ Account name _}</th>
            <th><span id="name">
                    {% include "_show_field.tpl" type="account" doc_id="_no_need_" field_name=["name"] account_id=account_id %}
                </span>
            </th>
        </tr>
        <tr>
            <th>{_ Account status1 _}</th>
            <th>{% if account_doc[1]["enabled"] %}<span class="zprimary">{_ Active _}</span>
                            {% else %}<span class="zalarm">{_ Blocked _}{% endif %}</span>
                <span class="pull-right" style="padding-right: 1em;">
                  {{ m.kazoo[{current_account_credit account_id=account_id}]|currency_sign }}
                </span>
            </th>
        </tr>
    </thead>
</table>
<span id="set_notify_level_tpl">
  {% set_balance_level_notify %}
</span>
{% rs_service_plans_manager %}
{% endwith %}
{% endblock %}
