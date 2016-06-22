<div class="pl-10 pr-10 col-md-6">
    <span id="rs_widget_transactions_list_tpl">
        {% include "rs_widget_transactions_list.tpl" headline=_"Transactions list" account_id=account_id %}
    </span>
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
