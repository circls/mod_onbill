{% extends "modkazoo_widget_dashboard.tpl" %}

{% block widget_headline %}
{% wire id="arrows_"++#dtid type="click"
        action={ toggle target="onbill_customer_"++customer_id++"_widget_opened" }
        action={ toggle target="arrow_right_"++#dtid }
        action={ toggle target="arrow_down_"++#dtid }
        action={ postback postback={trigger_innoui_widget arg="onbill_customer_"++customer_id++"_widget_opened" } delegate="mod_kazoo" }
%}
  <span id="arrows_{{ #dtid }}" style="cursor: pointer;">
    <i id="arrow_right_{{ #dtid }}" style="{% if m.kazoo[{ui_element_opened element="onbill_customer_"++customer_id++"_widget_opened"}] %}display: none;{% endif %}"
                                    class="arrowpad fa fa-arrow-circle-right"></i>
    <i id="arrow_down_{{ #dtid }}" style="{% if not m.kazoo[{ui_element_opened element="onbill_customer_"++customer_id++"_widget_opened"}] %}display: none;{% endif %}"
                                   class="arrowpad fa fa-arrow-circle-down"></i>
  </span>
    {{ headline }}
    {% button class="btn btn-xs btn-onnet pull-right" text=_"save" id="save_json_"++customer_id
              action={postback postback={onbill_set_doc_json doc_id=customer_id doc_type="customer"}
                               qarg="json_storage_"++customer_id
                               delegate="mod_onbill"
                     }
     %}
    {% button class="btn btn-xs btn-onnet pull-right" text=_"restore" id="restore_json_"++customer_id %}

{% endblock %}

{% block widget_class %}{% if last %}last{% endif %}{% endblock %}

{% block widget_content %}
            
<div id="onbill_customer_{{ customer_id }}_widget_opened"
     style="{% if not m.kazoo[{ui_element_opened element="onbill_customer_"++customer_id++"_widget_opened"}] %}display: none;{% endif %}"
>
    <div class="text-center p-3">
        {% ilazy class="fa fa-spinner fa-spin fa-3x" action={update target="onbill_customer_"++customer_id++"_widget_opened"
                                                                    template="onbill_customer_table.tpl"
                                                                    customer_id=customer_id}
        %}
    </div>
</div>
{% endblock %}
