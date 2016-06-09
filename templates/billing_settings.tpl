{% extends "dashboard_base.tpl" %}

{% block header_title %}
  {% include "_account_page_title.tpl" title=_"Billing settings" %}
{% endblock %}

{% block service_description %}

<div class="pl-10 pr-10 col-md-6">
  {% wire action={connect signal={update_onbill_general_settings_tpl}
                          action={update target="onbill_general_settings_tpl" template="onbill_general_settings.tpl" headline=_"General settings"}} %}
  <span id="onbill_general_settings_tpl">
        {% include "onbill_general_settings.tpl" headline=_"General settings" %}
  </span>

  {% wire action={connect signal={update_onbill_notifications_tpl}
                          action={update target="onbill_notifications_tpl" template="onbill_notifications.tpl" headline=_"Templates"}} %}
  <span id="onbill_notifications_tpl">
        {% include "onbill_notifications.tpl" headline=_"Notifications" %}
  </span>
</div>
<div class="pl-10 pr-10 col-md-6">
  {% wire action={connect signal={update_onbill_resources_tpl}
                          action={update target="onbill_resources_tpl" template="onbill_resources.tpl" headline=_"Outbound routing"}} %}
  <span id="onbill_resources_tpl">
        {% include "onbill_resources.tpl" headline=_"Outbound routing" %}
  </span>

  {% wire action={connect signal={update_rs_allocated_numbers_tpl} action={update target="rs_allocated_numbers_tpl"
                                                                                  template="rs_allocated_numbers.tpl"
                                                                                  headline=_"Account's allocated numbers"
                                                                                  account_id=account_id}}
  %}
</div>

{% print m.onbill[{onbill_get_doc doc_id="onbill_global_variables"}] %}

{% endblock %}

