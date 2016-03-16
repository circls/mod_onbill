{% extends "dashboard_base.tpl" %}

{% block header_title %}
  {% include "_account_page_title.tpl" title=_"Payments" %}
{% endblock %}

{% block service_description %}

<script src="https://js.braintreegateway.com/v2/braintree.js"></script>
<div class="pl-10 pr-10 col-md-6">
    {# Account status #}
    {% include "onnet_widget_finance.tpl" headline=_"Account" %}

    {# Make payment #}
    {% wire action={connect signal={update_onnet_widget_make_payment_tpl} action={update target="onnet_widget_make_payment_tpl" template="onnet_widget_make_payment_lazy.tpl"}} %}
    <span id="onnet_widget_make_payment_tpl">
      {% include "onnet_widget_make_payment_lazy.tpl" %}
    </span>
</div>

<div id="paytab" class="pl-10 pr-10 col-md-6">
    {# Make invoce #}
    <span id="onnet_widget_make_invoice_tpl">
        {% include "onnet_widget_make_invoice.tpl" headline=_"Wire transfer" %}
    </span>

    {# Transactions list #}
    <span id="rs_widget_transactions_list_tpl">
        {% include "rs_widget_transactions_list.tpl" headline=_"Transactions list" %}
    </span>


</div>

{% endblock %}
