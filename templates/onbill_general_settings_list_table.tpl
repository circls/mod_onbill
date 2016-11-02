
{% include "_onbill_json_editor.tpl"
   json_string=m.onbill[{onbill_get_reseller_json reseller_id=m.session.kazoo_reseller_account_id }]
   doc_id="onbill_reseller_variables"
%} 

<div id="json_field_onbill_reseller_variables" class='medium-12 columns'></div>
<input id="json_storage_onbill_reseller_variables" type="hidden" name="json_storage_onbill_reseller_variables" value="">
