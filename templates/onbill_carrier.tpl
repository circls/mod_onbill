{% extends "modkazoo_widget_dashboard.tpl" %}

{% block widget_headline %}
{% wire id="arrows_"++#dtid type="click"
        action={ toggle target="onbill_carrier_"++carrier_id++"_widget_opened" }
        action={ toggle target="arrow_right_"++#dtid }
        action={ toggle target="arrow_down_"++#dtid }
        action={ postback postback={trigger_innoui_widget arg="onbill_carrier_"++carrier_id++"_widget_opened" } delegate="mod_kazoo" }
%}
  <span id="arrows_{{ #dtid }}" style="cursor: pointer;">
    <i id="arrow_right_{{ #dtid }}" style="{% if m.kazoo[{ui_element_opened element="onbill_carrier_"++carrier_id++"_widget_opened"}] %}display: none;{% endif %}"
                                    class="arrowpad fa fa-arrow-circle-right"></i>
    <i id="arrow_down_{{ #dtid }}" style="{% if not m.kazoo[{ui_element_opened element="onbill_carrier_"++carrier_id++"_widget_opened"}] %}display: none;{% endif %}"
                                   class="arrowpad fa fa-arrow-circle-down"></i>
  </span>
    {{ headline }}
    {% button class="btn btn-xs btn-onnet pull-right" text=_"save" id="save_json_"++carrier_id
              action={postback postback={onbill_set_doc_json doc_id=carrier_id} qarg="json_storage_"++carrier_id delegate="mod_onbill" } %}
    {% button class="btn btn-xs btn-onnet pull-right" text=_"restore" id="restore_json_"++carrier_id %}
    <div class="btn-group pull-right" style="margin-left: 3px;">
      <a class="btn btn-xs btn-onnet dropdown-toggle" data-toggle="dropdown" href="#">
        <i class="fa fa-calendar"></i>
        {_ choose template to edit _}
        <span class="caret"></span>
      </a>
      <ul class="dropdown-menu nav-list nav">
          {% wire name="carrier_template_edit_event" action={dialog_open title=_"Edit html template" template="_edit_carrier_template.tpl" carrier_id=carrier_id} %}
          <li><a href="#" onclick="z_event('carrier_template_edit_event', { template_id: 'invoice' });">{_ invoice _}</li></a>
          <li><a href="#" onclick="z_event('carrier_template_edit_event', { template_id: 'act' });">{_ act _}</li></a>
      </ul>
    </div>

{% endblock %}

{% block widget_class %}{% if last %}last{% endif %}{% endblock %}

{% block widget_content %}
            
<div id="onbill_carrier_{{ carrier_id }}_widget_opened"
     style="{% if not m.kazoo[{ui_element_opened element="onbill_carrier_"++carrier_id++"_widget_opened"}] %}display: none;{% endif %}"
>
    <div class="text-center p-3">
        {% ilazy class="fa fa-spinner fa-spin fa-3x" action={update target="onbill_carrier_"++carrier_id++"_widget_opened"
                                                                    template="onbill_carrier_table.tpl"
                                                                    carrier_id=carrier_id}
        %}
    </div>
</div>

{% endblock %}
