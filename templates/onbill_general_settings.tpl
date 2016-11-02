{% extends "modkazoo_widget_dashboard.tpl" %}

{% block widget_headline %}
{% wire id="arrows_"++#dtid type="click"
        action={ toggle target="onbill_general_settings_widget_opened" }
        action={ toggle target="arrow_right_"++#dtid }
        action={ toggle target="arrow_down_"++#dtid }
        action={ postback postback={trigger_innoui_widget arg="onbill_general_settings_widget_opened" } delegate="mod_kazoo" }
%}
  <span id="arrows_{{ #dtid }}" style="cursor: pointer;">
    <i id="arrow_right_{{ #dtid }}" style="{% if m.kazoo[{ui_element_opened element="onbill_general_settings_widget_opened"}] %}display: none;{% endif %}"
                                    class="arrowpad fa fa-arrow-circle-right"></i>
    <i id="arrow_down_{{ #dtid }}" style="{% if not m.kazoo[{ui_element_opened element="onbill_general_settings_widget_opened"}] %}display: none;{% endif %}"
                                   class="arrowpad fa fa-arrow-circle-down"></i>
  </span>
    {{ headline }}
    {% button class="btn btn-xs btn-onnet pull-right" text=_"save" id="save_json_onbill_reseller_variables"
              action={postback postback={onbill_set_doc_json doc_id="who_cares" doc_type="reseller"}
                               qarg="json_storage_onbill_reseller_variables"
                               delegate="mod_onbill"
                     }
    %}
    {% button class="btn btn-xs btn-onnet pull-right" text=_"restore" id="restore_json_onbill_reseller_variables" %}
{% endblock %}

{% block widget_class %}{% if last %}last{% endif %}{% endblock %}

{% block widget_content %}
            
<div id="onbill_general_settings_widget_opened" style="{% if not m.kazoo[{ui_element_opened element="onbill_general_settings_widget_opened"}] %}display: none;{% endif %}">
    <div class="text-center p-3">
        {% ilazy class="fa fa-spinner fa-spin fa-3x" action={update target="onbill_general_settings_widget_opened"
                                                                    template="onbill_general_settings_list_table.tpl"}
        %}
    </div>
</div>

{% endblock %}
