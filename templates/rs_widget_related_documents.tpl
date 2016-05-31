{% extends "onnet_widget_dashboard.tpl" %}

{% block widget_headline %}
{% wire id="arrows_"++#rdid type="click"
        action={ toggle target="rs_related_documents_widget_opened" }
        action={ toggle target="arrow_right_"++#rdid }
        action={ toggle target="arrow_down_"++#rdid }
        action={ postback postback={trigger_innoui_widget arg="rs_related_documents_widget_opened" } delegate="mod_kazoo" }
%}
  <span id="arrows_{{ #rdid }}" style="cursor: pointer;">
    <i id="arrow_right_{{ #rdid }}" style="{% if m.kazoo[{ui_element_opened element="rs_related_documents_widget_opened"}] %}display: none;{% endif %}" 
                                    class="arrowpad fa fa-arrow-circle-right"></i>
    <i id="arrow_down_{{ #rdid }}" style="{% if not m.kazoo[{ui_element_opened element="rs_related_documents_widget_opened"}] %}display: none;{% endif %}" 
                                   class="arrowpad fa fa-arrow-circle-down"></i>
  </span>
    {{ headline }}
    {% button class="btn btn-xs btn-onnet" text=_"create" 
              action={postback postback={generate_rs_related_documents account_id}
                               delegate="mod_onbill"
                               qarg="related_documents_month_chosen"
                               inject_args account_id=account_id
                     }
    %}
    {% button class="btn btn-xs btn-onnet pull-right" text=_"send request" 
              action={postback postback={refresh_rs_related_documents account_id}
                               delegate="mod_onbill"
                               qarg="related_documents_month_chosen"
                               inject_args account_id=account_id
                     }
    %}
     <input id="related_documents_month_chosen" type="text" class="input-small-onnet pull-right" name="related_documents_month_chosen"
                                                    value="{% if related_documents_month_chosen %}{{ related_documents_month_chosen }}{% else %}{{ now|date: 'm/Y' }}{% endif %}"
                                                    data-date="{% if related_documents_month_chosen %}{{ related_documents_month_chosen }}{% else %}{{ now|date: 'm/Y' }}{% endif %}"
                                                    data-date-min-view-mode="months"
                                                    data-date-format="mm/yyyy"
                                                    data-date-autoclose="true"
                                                    data-date-language={{ z_language }}
                                                    data-date-start-date="-36m"
                                                    data-date-end-date="+0d"
                                                    readonly/>
    <span class="pull-right pr-05"> {_ Choose month _}: </span>
    {% javascript %}
        $('#related_documents_month_chosen').datepicker();
    {% endjavascript %}

{% endblock %}

{% block widget_class %}{% if last %}last{% endif %}{% endblock %}

{% block widget_content %}
<div id="rs_related_documents_widget_opened" style="{% if not m.kazoo[{ui_element_opened element="rs_related_documents_widget_opened"}] %}display: none;{% endif %}">
    <div class="text-center p-3">
        {% ilazy class="fa fa-spinner fa-spin fa-3x" action={update target="rs_related_documents_widget_opened"
                                                                    template="rs_widget_related_documents_lazy.tpl"
                                                                    account_id=account_id
                                                                    related_documents_month_chosen=related_documents_month_chosen
                                                                    year=year
                                                                    month=month
                                                                    headline=_"Related documents"
                                                            }
        %}
   </div>
</div>
{% endblock %}
