  {% if m.modules.info.mod_onbill.enabled %}
    <span id="rs_widget_transactions_list_tpl">
        {% include "rs_widget_transactions_list.tpl" headline=_"Transactions list" account_id=account_id %}
    </span>

    {% wire action={connect signal={update_rs_widget_related_documents_tpl}
                    action={update target="rs_widget_related_documents_tpl" template="update_rs_widget_related_documents.tpl"}
                   }
    %}
    <span id="rs_widget_related_documents_tpl">
        {% include "rs_widget_related_documents.tpl" headline=_"Related documents" account_id=account_id %}
    </span>
  {% endif %}
