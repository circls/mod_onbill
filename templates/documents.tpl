{% extends "dashboard_base.tpl" %}

{% block header_title %}
  {% include "_account_page_title.tpl" title=_"Documents" %}
{% endblock %}

{% block service_description %}

<div class="pl-10 pr-10 col-md-6">
    {# Reports date picker #}
    {% include "onbill_widget_documents_datepicker.tpl" headline=_"Period" %}

    {# PDF calls reports #}
    {% wire action={connect signal={update_onbill_widget_calls_reports_tpl}
                    action={update target="onbill_widget_calls_reports_tpl" template="onbill_widget_calls_reports_lazy.tpl"}
                   }
    %}
    <span id="onbill_widget_calls_reports_tpl">
      {% include "onbill_widget_calls_reports.tpl" headline=_"Calls report" %}
    </span>
</div>

<div id="paytab" class="pl-10 pr-10 col-md-6">

    {# Invoices #}
    {% wire action={connect signal={update_onbill_widget_invoices_tpl}
                    action={update target="onbill_widget_invoices_tpl" template="onbill_widget_invoices_lazy.tpl"}
                   }
    %}
    <span id="onbill_widget_invoices_tpl">
        {% include "onbill_widget_invoices.tpl" headline=_"Invoices" %}
    </span>

    {# Crazy Russian Document - SchetFacturaZ #}
    {% wire action={connect signal={update_onbill_widget_vatinvoices_tpl}
                    action={update target="onbill_widget_vatinvoices_tpl" template="onbill_widget_vatinvoices_lazy.tpl"}
                   }
    %}
    <span id="onbill_widget_vatinvoices_tpl">
        {% include "onbill_widget_vatinvoices.tpl" headline=_"VAT Invoices" %}
    </span>

    {# Acts #}
    {% wire action={connect signal={update_onbill_widget_acts_tpl}
                    action={update target="onbill_widget_acts_tpl" template="onbill_widget_acts_lazy.tpl"}
                   }
    %}
    <span id="onbill_widget_acts_tpl">
        {% include "onbill_widget_acts.tpl" headline=_"Acts" %}
    </span>


</div>

{% print m.onbill[{crossbar_listing year=year month=month}] %}

{% endblock %}
