<table class="table table-hover table-centered table-condensed">
    <thead>
        <tr style="height: 10px; color: white!important; background-color: white!important;"><td colspan="5"></td></tr>
        <tr>
            <th colspan="5">
                <span id="arrows_{{ #dtid }}" style="cursor: pointer;">
                  {% wire id="arrows_"++#dtid type="click"
                          action={ toggle target="cards_list_body" }
                          action={ toggle target="arrow_right_"++#dtid }
                          action={ toggle target="arrow_down_"++#dtid }
                          action={ postback postback={trigger_innoui_widget arg="cards_list_body_opened" } delegate="mod_kazoo" }
                  %}
                  <i id="arrow_right_{{ #dtid }}" style="{% if m.kazoo[{ui_element_opened element="cards_list_body_opened"}] %}display: none;{% endif %}"
                                                  class="arrowpad fa fa-arrow-circle-right"></i>
                  <i id="arrow_down_{{ #dtid }}" style="{% if not m.kazoo[{ui_element_opened element="cards_list_body_opened"}] %}display: none;{% endif %}"
                                                 class="arrowpad fa fa-arrow-circle-down"></i>
                </span>
                <span style="color: FF9002;">
                  Saved cards
                </span>
                {% button id="cancel_add_card_btn" class="btn btn-xs btn-onnet pull-right display_none" text=_"cancel"
                          action={ hide target="arrow_right_"++#dtid }
                          action={ show target="arrow_down_"++#dtid }
                          action={ show target="cards_list_body" }
                          action={ toggle target="add_card_body" }
                          action={ update target="add_card_body" template="_make_payment_card_spinner.tpl" }
                          action={ toggle target="cancel_add_card_btn" }
                          action={ toggle target="add_card_btn" }
                 %}
                {% button id="add_card_btn" class="btn btn-xs btn-onnet pull-right" text=_"add card"
                          action={ show target="arrow_right_"++#dtid }
                          action={ hide target="arrow_down_"++#dtid }
                          action={ hide target="cards_list_body" }
                          action={ toggle target="add_card_body" }
                          action={ update target="add_card_body" template="_make_payment_add_card_div.tpl" }
                          action={ toggle target="cancel_add_card_btn" }
                          action={ toggle target="add_card_btn" }
                 %}
            </th>
        </tr>
    </thead>
    <tbody id="cards_list_body" style="{% if not m.kazoo[{ui_element_opened element="cards_list_body_opened"}] %}display: none;{% endif %}">
        {% include "_make_payment_cards_list.tpl" %}
    </tbody>
</table>
<div id="add_card_body" style="display: none; border-top: 1px solid#ddd;">
        {% include "_make_payment_card_spinner.tpl" %}
</div>
