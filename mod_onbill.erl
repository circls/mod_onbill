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

event(A, Context) ->
    lager:info("Unknown event A: ~p", [A]),
    lager:info("Unknown event variables: ~p", [z_context:get_q_all(Context)]),
    lager:info("Unknown event Context: ~p", [Context]),
    Context.
