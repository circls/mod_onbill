{% with m.session.rs_selected_account_id as account_id %}
<div class="row" style="padding: 1em; margin-bottom: 1em;">

  {% wire id="to_reseller_portal" action={redirect dispatch="reseller_portal"} %}
  <div class="col-xs-2 col-xs-offset-1">
    <button id="to_reseller_portal" class="col-xs-12 btn btn-zalarm margin-bottom-xs">{_ Reseller Portal _}</button>
  </div>

  <div class="col-xs-2">
    {% wire id="user_mask_selector" type="change" action={postback postback={rs_account_mask account_id=account_id} delegate="mod_kazoo"} %}
    <select id="user_mask_selector" name="selected" class="col-xs-12 form-control margin-bottom-xs selectpicker" title="{_ Mask _}"  data-live-search="true">
      <option value="userless_mask">{_ Without user _}</option>
      {% for option in m.kazoo[{kz_list_account_users account_id=account_id}] %}
          <option value="{{ option["id"] }}">{{ option["username"] }}</option>
      {% endfor %}
    </select>
  </div>
  {% javascript %}
    $('#user_mask_selector').selectpicker({
      style: 'btn-zprimary',
      size: 5
    });
  {% endjavascript %}

  {% wire id="cf_details_btn" action={ dialog_open title=_"Account details" template="_account_details.tpl" account_id=account_id class="iamclass" width="auto" } %}
  <div class="col-xs-2">
    <button id="cf_details_btn" class="col-xs-12 btn btn-zprimary margin-bottom-xs">{_ Details _}</button>
  </div>
  {% wire id="rs_account_delete_btn" action={confirm text="Do you really want to delete this account?"
                                     action={postback postback={rs_account_delete account_id=account_id} delegate="mod_kazoo"}
                             }
  %}
  <div class="col-xs-2">
    <button id="rs_account_delete_btn" class="col-xs-12 btn btn-zalarm margin-bottom-xs">{_ Delete _}</button>
  </div>
</div>

<div class="pl-10 pr-10 col-md-6">
    <span id="rs_widget_transactions_list_tpl">
        {% include "rs_widget_transactions_list.tpl" headline=_"Transactions list" account_id=account_id %}
    </span>

  {% include "onbill_customer.tpl" customer_id=account_id headline=_"Customer data" %}



</div>
<div class="pl-10 pr-10 col-md-6">
    {% wire action={connect signal={update_rs_widget_related_documents_tpl}
                    action={update target="rs_widget_related_documents_tpl" template="update_rs_widget_related_documents.tpl"}
                   }
    %}
    <span id="rs_widget_related_documents_tpl">
        {% include "rs_widget_related_documents.tpl" headline=_"Related documents" customer_id=account_id %}
    </span>
</div>
{% endwith %}
