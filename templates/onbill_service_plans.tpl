{% extends "modkazoo_widget_dashboard.tpl" %}

{% block widget_headline %}
{% wire id="arrows_"++#dtid type="click"
        action={ toggle target="onbill_service_plan_widget_opened" }
        action={ toggle target="arrow_right_"++#dtid }
        action={ toggle target="arrow_down_"++#dtid }
        action={ postback postback={trigger_innoui_widget arg="onbill_service_plan_widget_opened" } delegate="mod_kazoo" }
%}
  <span id="arrows_{{ #dtid }}" style="cursor: pointer;">
    <i id="arrow_right_{{ #dtid }}" style="display: none;"
                                    class="arrowpad fa fa-arrow-circle-right"></i>
    <i id="arrow_down_{{ #dtid }}" style="display: none;"
                                   class="arrowpad fa fa-arrow-circle-down"></i>
  </span>
    {{ headline }}
    {% button class="btn btn-xs btn-onnet pull-right" text=_"create" id="add_json_service_plan" %}
    <span id="service_plan_buttons"></span>
    <div class="btn-group pull-right" style="margin-left: 3px;">
      <a class="btn btn-xs btn-onnet dropdown-toggle" data-toggle="dropdown" href="#">
        <i class="fa fa-calendar"></i>
        {_ choose service plan to edit _}
        <span class="caret"></span>
      </a>
      <ul class="dropdown-menu nav-list nav">
       {% wire name="service_plan_edit_event" action={update target="onbill_service_plan_widget_opened"
                                                             template="onbill_service_plan_lazy.tpl"
                                                     }
                                              action={update target="service_plan_buttons"
                                                             template="onbill_service_plans_buttons.tpl"
                                                     }   
       %}
        {% for service_plan_available in m.kazoo.kz_service_plans_available %}
          <li>
            <a href="#" onclick="z_event('service_plan_edit_event', { service_plan_id: '{{ service_plan_available["id"] }}' });">
                {{ service_plan_available["name"] }}
            </a>
          </li>
        {% endfor %}
      </ul>
    </div>

{% endblock %}

{% block widget_class %}{% if last %}last{% endif %}{% endblock %}

{% block widget_content %}
            
<div id="onbill_service_plan_widget_opened" style="display: none1;">
</div>
{% endblock %}
