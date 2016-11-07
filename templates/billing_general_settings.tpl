{% extends "dashboard_base.tpl" %}

{% block header_title %}
  {% include "_account_page_title.tpl" title=_"General settings" %}
{% endblock %}

{% block service_description %}

<div class="pl-10 pr-10 col-md-6">
        {% include "onbill_general_settings.tpl" headline=_"General settings" %}

        {% include "onbill_service_plans.tpl" headline=_"Service plans" %}
</div>
<div class="pl-10 pr-10 col-md-6">

  {% for carrier_id in m.onbill[{onbill_get_reseller reseller_id=m.session.kazoo_reseller_account_id}][1]["carriers"] %}
    {% include "onbill_carrier.tpl" carrier_id=carrier_id headline=_"Carrier"++" "++carrier_id %}
  {% endfor %}

</div>

{% endblock %}
