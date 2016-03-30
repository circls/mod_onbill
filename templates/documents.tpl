{% extends "dashboard_base.tpl" %}

{% block header_title %}
  {% include "_account_page_title.tpl" title=_"Documents" %}
{% endblock %}

{% block service_description %}

<div class="pl-10 pr-10 col-md-6">
    {# Reports date picker #}
    {% include "onbill_widget_documents_datepicker.tpl" headline=_"Period" %}

    {# PDF calls reports #}
    <span id="onnet_widget_calls_reports">
      {% include "onbill_widget_calls_reports.tpl" headline=_"Calls report" %}
    </span>
</div>

<div id="paytab" class="pl-10 pr-10 col-md-6">

    {# Invoices #}
    <div id="update_invoices_widget">
        {% include "onbill_widget_invoices.tpl" headline=_"Invoices" %}
    </div>

    {# Crazy Russian Document - SchetFacturaZ #}
    <div id="update_vatinvoices_widget">
        {% include "onbill_widget_vatinvoices.tpl" headline=_"VAT Invoices" %}
    </div>

    {# Acts #}
    <div id="update_acts_widget">
        {% include "onbill_widget_acts.tpl" headline=_"Acts" %}
    </div>


</div>

{% print m.onbill.crossbar_listing %}

{% endblock %}
