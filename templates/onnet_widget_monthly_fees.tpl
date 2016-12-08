{% extends "onnet_widget_dashboard.tpl" %}

{% block widget_headline %}
{% wire id="arrows_"++#id type="click"
        action={ toggle target="current_services_widget_opened" }
        action={ toggle target="arrow_right_"++#id }
        action={ toggle target="arrow_down_"++#id }
        action={ postback postback={trigger_innoui_widget arg="current_services_widget_opened" } delegate="mod_kazoo" }
%}
  <span id="arrows_{{ #id }}" style="cursor: pointer;">
    <i id="arrow_right_{{ #id }}" style="{% if m.kazoo[{ui_element_opened element="current_services_widget_opened"}] %}display: none;{% endif %}" 
                                    class="arrowpad fa fa-arrow-circle-right"></i>
    <i id="arrow_down_{{ #id }}" style="{% if not m.kazoo[{ui_element_opened element="current_services_widget_opened"}] %}display: none;{% endif %}" 
                                   class="arrowpad fa fa-arrow-circle-down"></i>
  </span>
    {{ headline }}
{% endblock %}

{% block widget_class %}{% if last %}last{% endif %}{% endblock %}

{% block widget_content %}
<div id="current_services_widget_opened" style="{% if not m.kazoo[{ui_element_opened element="current_services_widget_opened"}] %}display: none;{% endif %}">
<table class="table table-condensed table-hover table-centered">
    <thead>
        <tr>
            <th>{_ Fee name _}</th>
            <th class="text-center">{_ Rate _}</th>
            <th class="text-center">{_ Quantity _}</th>
            <th class="text-center">{_ Discount _}</th>
            <th class="text-center">{_ Cost _}</th>
        </tr>
    </thead>
    <tbody>
      {% with m.kazoo.kz_current_service_plans as services %}
      {% for item in services[1]["items"][1] %}
        {% for service_type in item[2] %}
          {% for service in service_type %}
          {% if service[2][1]["quantity"] > 0 %}
          {% with service[2][1]["cumulative_discount"] * service[2][1]["cumulative_discount_rate"] + service[2][1]["single_discount_rate"] as discount %} 
          <tr>
             <td>{{ service[2][1]["name"]|pretty_freeforall }}</td>
             <td class="text-center">{{ m.config.mod_kazoo.local_currency_sign.value }}{{ service[2][1]["rate"]|format_price }}</td>
             <td class="text-center">{{ service[2][1]["quantity"] }}</td>
             <td class="text-center">{{ m.config.mod_kazoo.local_currency_sign.value }}{{ discount|format_price }}</td>
             <td class="text-center">{{ m.config.mod_kazoo.local_currency_sign.value }}{{ (service[2][1]["rate"] * service[2][1]["quantity"] - discount)|format_price }}</td>
          </tr>
          {% endwith %}
          {% endif %}
          {% endfor %}
        {% endfor %}
      {% endfor %}
      {% endwith %}
    </tbody>
</table>
</div>
{% endblock %}
