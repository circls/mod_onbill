{% extends "dashboard_base.tpl" %}

{% block header_title %}
  {% include "_account_page_title.tpl" title=_"Payments" %}
{% endblock %}

{% block service_description %}

<script src="https://js.braintreegateway.com/v2/braintree.js"></script>
<div class="pl-10 pr-10 col-md-6">
    {# Account status #}
    <span id="onnet_widget_finance_tpl">
      <div class="text-center p-3">
        {% ilazy class="fa fa-spinner fa-spin fa-3x" action={update target="onnet_widget_finance_tpl" template="onnet_widget_finance.tpl" cat="text" headline=_"Account"} %}
      </div>
    </span>
    {# Make payment #}
    <span id="onnet_widget_make_payment_tpl">
      <div class="text-center p-3">
        {% ilazy class="fa fa-spinner fa-spin fa-3x" action={update target="onnet_widget_make_payment_tpl"
                                                                    template="onnet_widget_make_payment.tpl" 
                                                                    cat="text" headline=_"Online payments"}
        %}
      </div>
    </span>
</div>

<div id="paytab" class="pl-10 pr-10 col-md-6">
    {# Make invoce #}
    <span id="onnet_widget_make_invoice_tpl">
      <div class="text-center p-3">
        {% ilazy class="fa fa-spinner fa-spin fa-3x" action={update target="onnet_widget_make_invoice_tpl" 
                                                                    template="onnet_widget_make_invoice.tpl" 
                                                                    cat="text" 
                                                                    headline=_"Wire transfer"}
        %}
      </div>
    </span>
    {# Payments List #}
    <span id="onnet_widget_payments_list_tpl">
        <div class="text-center p-3">
          {% ilazy class="fa fa-spinner fa-spin fa-3x" action={update target="onnet_widget_payments_list_tpl"
                                                       template="onnet_widget_payments_list.tpl" 
                                                       headline=_"Payments list"}
          %}
        </div>
    </span>
</div>

{% endblock %}
