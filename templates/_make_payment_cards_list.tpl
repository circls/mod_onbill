        <tr>
            <th class="td-center">Type</th>
            <th class="td-center">Number</th>
            <th class="td-center">Expiration</th>
            <th class="td-center">Default</th>
            <th class="td-center">Delete</th>
        </tr>
        {% for card in bt_customer[1]["credit_cards"] %}
        <tr id="card_line_{{ card["id"] }}">
            <td class="td-center">
               {% include "_set_payment_system_sign.tpl" card_type=card["card_type"] %}
            </td>
            <td class="td-center">
               **** **** **** {{ card["last_four"] }}
            </td>
            <td class="td-center">
               {{ card["expiration_month"] }}/{{ card["expiration_year"] }}
            </td>
            <td class="td-center">
               {% if card["default"] %}
                   <i class="fa fa-check-square-o" title="{_ Default _}"></i>
               {% else %}
                    {% wire id="default_card_"++card["id"]
                      action={confirm text=_"Do you really want to set this card as default payment method?
                                               <br /><br />"++card["card_type"]++"  **** **** **** "++card["last_four"]++"<br /><br />"
                              action={postback postback={bt_make_default_card card_id=card["id"]} delegate="mod_kazoo"}
                              action={mask target="card_line_"++card["id"] message=_"Processing ..."}
                             }
                    %}
                   <i id="default_card_{{ card["id"] }}" style="cursor: pointer;" class="fa fa-square-o" title="{_ Click to set as default _}"></i>
               {% endif %}
            </td>
            <td class="td-center">
                {% wire id="delete_card_"++card["id"]
                  action={confirm text=_"Do you really want to delete this card?
                                           <br /><br />"++card["card_type"]++"  **** **** **** "++card["last_four"]++"<br /><br />"
                          action={postback postback={bt_delete_card card_id=card["id"]} delegate="mod_kazoo"}
                          action={mask target="card_line_"++card["id"] message=_"Processing card removal..."}
                         }
                %}
                <i id="delete_card_{{ card["id"] }}" style="cursor: pointer;" class="fa fa-trash-o" title="{_ Delete _}"></i>
            </td>
        </tr>
        {% endfor %}
