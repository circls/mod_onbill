{%  with m.kazoo[{kz_account_doc_field field1="topup"}] as topup %}
<table class="table table-hover table-centered table-condensed">
    <thead>
        <tr style="height: 10px; color: white!important; background-color: white!important;"><td colspan="5"></td></tr>
        <tr>
            <th colspan="4">
                <span id="arrows_{{ #topup }}" style="cursor: pointer;">
                  {% wire id="arrows_"++#topup type="click"
                          action={ toggle target="top_up_settings" }
                          action={ toggle target="arrow_right_"++#topup }
                          action={ toggle target="arrow_down_"++#topup }
                  %}
                  <i id="arrow_right_{{ #topup }}" style="padding-right: 0.5em;" class="fa fa-arrow-circle-right"></i>
                  <i id="arrow_down_{{ #topup }}" style="padding-right: 0.5em; display: none;" class="fa fa-arrow-circle-down"></i>
                </span>
                <span style="color: FF9002;">
                  Auto Recharge
                </span>
            </th>
            {% if topup %}
            <th>
                  <span class="pull-right" style="padding-right: 1em;">
                  <span class="onnet-07em">{{ m.config.mod_kazoo.local_currency_sign.value }}</span>{{ topup[1]["threshold"] }}
                      / 
                    <span class="onnet-07em">{{ m.config.mod_kazoo.local_currency_sign.value }}</span>{{ topup[1]["amount"] }}
                </span>
            </th>
            {% else %}
            <th>
                {% wire id="topup_toggle_off" type="click"
                        action={ toggle target="top_up_settings" }
                        action={ toggle target="arrow_right_"++#topup }
                        action={ toggle target="arrow_down_"++#topup }
                %}
                <span id="topup_toggle_off" class="pull-right" style="padding-right: 2em; cursor: pointer;"><i class="fa fa-toggle-off"></i></span>
            </th>
            {% endif %}
        </tr>
    </thead>
    <tbody id="top_up_settings" style="display: none;">
        <tr>
            <td class="td-center" colspan="5">
               When balance falls below {{ m.config.mod_kazoo.local_currency_sign.value }}
               <input class="input-card-field" type="text" id="threshold" name="threshold" maxlength="3" size="3" value="{{ topup[1]["threshold"] }}" />
               add {{ m.config.mod_kazoo.local_currency_sign.value }}
               <input class="input-card-field" type="text" id="amount" name="amount" maxlength="3" size="3" value="{{ topup[1]["amount"] }}" />
                {% button id="topup_disable_btn" class="btn btn-xs btn-onnet pull-right" text=_"disable"
                    action={postback postback="topup_disable_btn" delegate="mod_kazoo"}
                %}
                {% button id="topup_submit_btn" class="btn btn-xs btn-onnet pull-right" text=_"submit"
                    action={postback postback="topup_submit_btn" delegate="mod_kazoo" qarg="threshold" qarg="amount" }
                %}
            </td>
        </tr>
    </tbody>
</table>
{% endwith %}
