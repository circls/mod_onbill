-module(mod_onbill).
-author("kirill.sysoev@gmail.com").

-mod_title("OnNet billing").
-mod_description("Zotonic based frontend for onnet_billing Kazoo whapp").
-mod_prio(13).

-export([
    event/2
]).


-include_lib("zotonic.hrl").
-include_lib("include/mod_onbill.hrl").

event({postback,refresh_onbill_docs,_,_}, Context) ->
    DocsMonthInput = z_context:get_q("docsmonthInput",Context),
    [Month,Year] = z_string:split(DocsMonthInput,"/"),
    mod_signal:emit({update_onbill_widget_invoices_tpl, [{'year',Year},{'month',Month}]}, Context),
    mod_signal:emit({update_onbill_widget_vatinvoices_tpl, [{'year',Year},{'month',Month}]}, Context),
    mod_signal:emit({update_onbill_widget_acts_tpl, [{'year',Year},{'month',Month}]}, Context),
    mod_signal:emit({update_onbill_widget_calls_reports_tpl, [{'year',Year},{'month',Month}]}, Context),
    Context;

event({postback,{refresh_rs_payments_list,[{account_id, AccountId}]},_,_}, Context) ->
    PaymentsMonthChosen  = z_context:get_q("payments_month_chosen", Context),
    z_render:update("rs_widget_transactions_list_tpl"
                   ,z_template:render("rs_widget_transactions_list.tpl"
                                     ,[{headline, ?__("Transactions list", Context)}
                                      ,{account_id, AccountId}
                                      ,{payments_month_chosen, PaymentsMonthChosen}]
                                     ,Context)
                   ,Context);

event({postback,{generate_rs_related_documents,[{account_id,'undefined'}, {doc_type, DocType}]},_,_}, Context) ->
    AccountId = z_context:get_session(kazoo_account_id, Context),
    event({postback,{generate_rs_related_documents,[{account_id,AccountId}, {doc_type, DocType}]},<<>>,<<>>}, Context);
event({postback,{generate_rs_related_documents,[{account_id,AccountId}, {doc_type, DocType}]},_,_}, Context) ->
    MonthChosen = z_context:get_q("related_documents_month_chosen",Context),
    [Month,Year] = z_string:split(MonthChosen,"/"),
    _ = onbill_util:generate_monthly_docs(DocType, AccountId, Year, Month, Context),
    mod_signal:emit({update_rs_widget_related_documents_tpl
                     ,[{'account_id',AccountId},{'related_documents_month_chosen',MonthChosen},{'year',Year},{'month',Month}]}
                     ,Context
                   ),
    Context;

event({postback,{refresh_rs_related_documents,[{account_id,AccountId}]},_,_}, Context) ->
    MonthChosen = z_context:get_q("related_documents_month_chosen",Context),
    [Month,Year] = z_string:split(MonthChosen,"/"),
    mod_signal:emit({update_rs_widget_related_documents_tpl
                     ,[{'account_id',AccountId},{'related_documents_month_chosen',MonthChosen},{'year',Year},{'month',Month}]}
                     ,Context
                   ),
    Context;

event({postback,{onbill_set_doc_json,[{doc_id, "onbill_reseller_variables" = DocId}]},_,_}, Context) ->
    JsString = z_context:get_q("json_storage_"++z_convert:to_list("onbill_reseller_variables"), Context),
    AccountId = z_context:get_session('kazoo_account_id', Context),
    DataBag = {[{<<"data">>, jiffy:decode(JsString)}]},
    growl_bad_result(onbill_util:doc(post, AccountId, DocId, DataBag, Context), Context);
event({postback,{onbill_set_doc_json,[{doc_id,DocId}]},_,_}, Context) ->
    JsString = z_context:get_q("json_storage_"++z_convert:to_list(DocId), Context),
    AccountId = z_context:get_session('kazoo_account_id', Context),
    DataBag = {[{<<"data">>, jiffy:decode(JsString)}]},
    growl_bad_result(onbill_util:carrier(post, AccountId, DocId, DataBag, Context), Context);

event({submit,edit_carrier_template,_,_}, Context) ->
    AccountId = z_context:get_session(kazoo_account_id, Context),
    CarrierId = z_context:get_q("carrier_id", Context),
    TemplateId = z_context:get_q("template_id", Context),
    MessageBody = z_context:get_q("html_body", Context),
    _ = onbill_util:carrier_template('post', AccountId, CarrierId, TemplateId, MessageBody, Context),
    z_render:dialog_close(Context);

event(A, Context) ->
    lager:info("Unknown event A: ~p", [A]),
    lager:info("Unknown event variables: ~p", [z_context:get_q_all(Context)]),
    lager:info("Unknown event Context: ~p", [Context]),
    Context.

growl_bad_result(<<>>, Context) -> 
    z_render:growl_error(?__("Something went wrong.", Context), Context);
growl_bad_result(_, Context) -> 
    z_render:growl(?__("Operation succeeded.",Context), Context).

