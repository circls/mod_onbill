-module(mod_onbill).
-author("kirill.sysoev@gmail.com").

-mod_title("OnNet billing").
-mod_description("Zotonic based frontend for onnet_billing Kazoo whapp").
-mod_prio(7).

-export([
    observe_topmenu_element/2
    ,event/2
]).


-include_lib("zotonic.hrl").
-include_lib("include/mod_onbill.hrl").

observe_topmenu_element(_, Context) ->
    case modkazoo_auth:is_auth(Context) of
        'false' -> 'undefined';
        'true' -> <<"_onbill_topmenu.tpl">>
    end.

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

event({postback,generate_children_docs,_,_}, Context) ->
    MonthChosen = z_context:get_q("docs_month_chosen",Context),
    [Month,Year] = z_string:split(MonthChosen,"/"),
    _ = onbill_util:generate_monthly_docs('who_cares', <<"all_children">>, Year, Month, Context),
    z_render:growl(?__("Process started and could take a while.",Context), Context);

event({postback,{refresh_rs_related_documents,[{account_id,AccountId}]},_,_}, Context) ->
    MonthChosen = z_context:get_q("related_documents_month_chosen",Context),
    [Month,Year] = z_string:split(MonthChosen,"/"),
    mod_signal:emit({update_rs_widget_related_documents_tpl
                     ,[{'account_id',AccountId},{'related_documents_month_chosen',MonthChosen},{'year',Year},{'month',Month}]}
                     ,Context
                   ),
    Context;

event({postback,{onbill_set_doc_json,[{doc_id, _},{doc_type, "reseller"}]},_,_}, Context) ->
    JsString = z_context:get_q("json_storage_"++z_convert:to_list("onbill_reseller_variables"), Context),
    AccountId = z_context:get_session('kazoo_account_id', Context),
    DataBag = {[{<<"data">>, jiffy:decode(JsString)}]},
    growl_bad_result(onbill_util:reseller(post, AccountId, DataBag, Context), Context);
event({postback,{onbill_set_doc_json,[{doc_id,DocId},{doc_type, "customer"}]},_,_}, Context) ->
    JsString = z_context:get_q("json_storage_"++z_convert:to_list(DocId), Context),
    DataBag = {[{<<"data">>, jiffy:decode(JsString)}]},
    growl_bad_result(onbill_util:customer(post, DocId, DataBag, Context), Context);
event({postback,{onbill_set_doc_json,[{doc_id,DocId},{doc_type, DocType}]},AAA,_}, Context) ->
    JsString = z_context:get_q("json_storage_"++z_convert:to_list(DocId), Context),
    AccountId = z_context:get_session('kazoo_account_id', Context),
    DataBag = {[{<<"data">>, jiffy:decode(JsString)}]},
lager:info("IAM AAA: ~p",[AAA]),
    growl_bad_result(onbill_util:(z_convert:to_atom(DocType))(post, AccountId, DocId, DataBag, Context), Context);

event({submit,edit_carrier_template,_,_}, Context) ->
    AccountId = z_context:get_session(kazoo_account_id, Context),
    CarrierId = z_context:get_q("carrier_id", Context),
    TemplateId = z_context:get_q("template_id", Context),
    MessageBody = z_context:get_q("html_body", Context),
    _ = onbill_util:carrier_template('post', [{"Content-Type", "text/html;charset=utf-8"}], AccountId, CarrierId, TemplateId, MessageBody, Context),
    z_render:dialog_close(Context);

event({submit,periodic_fee,_,_}, Context) ->
    AccountId = ?TO_BIN(z_context:get_q("account_id", Context)),
    FeeId = case ?TO_BIN(z_context:get_q("fee_id", Context)) of
                      <<>> -> 'undefined';
                      FeeBin -> FeeBin
                  end,
    ServiceEnds = case ?TO_BIN(z_context:get_q("enddate_defined", Context)) of
                      <<>> -> 'undefined';
                      _ -> modkazoo_util:datepick_to_tstamp(z_context:get_q("service_ends", Context))
                  end,
    Props = [{<<"fee_id">>, FeeId}
            ,{<<"account_id">>, ?TO_BIN(z_context:get_q("account_id", Context))}
            ,{<<"service_id">>, ?TO_BIN(z_context:get_q("service_id", Context))}
            ,{<<"comment">>, ?TO_BIN(z_context:get_q("comment", Context))}
            ,{<<"service_starts">>, modkazoo_util:datepick_to_tstamp(z_context:get_q("service_starts", Context))}
            ,{<<"service_ends">>, ServiceEnds}
            ],
    DataBag = ?MK_DATABAG(modkazoo_util:set_values(modkazoo_util:filter_empty(Props), modkazoo_util:new())),
    case FeeId of
        'undefined' ->
            onbill_util:periodic_fees('put', AccountId, FeeId, DataBag, Context);
        _ ->
            onbill_util:periodic_fees('post', AccountId, FeeId, DataBag, Context)
    end,
    z_render:dialog_close(Context);

event({postback,disarm_credit,_,_}, Context) ->
    AccountId = z_context:get_session(kazoo_account_id, Context),
    DataBag = ?MK_DATABAG({[{<<"armed">>,false}]}),
    PrPt = onbill_util:promised_payment('patch', AccountId, DataBag, Context),
    z_render:update("update_widget_dashboard_credit"
                   ,z_template:render("onbill_widget_dashboard_credit.tpl"
                                     ,[{headline,"Credit"},{pr_pt, PrPt}]
                                     ,Context)
                   ,Context);

event({submit,arm_credit,_,_}, Context) ->
    AccountId = z_context:get_session(kazoo_account_id, Context),
    Credit_amount = z_context:get_q("creditme",Context),
    try z_convert:to_integer(Credit_amount) of
        Amount ->
            DataBag = ?MK_DATABAG({[{<<"armed">>, true}
                                   ,{<<"amount">>, Amount}
                                   ]}
                                 ),
            PrPt = onbill_util:promised_payment('patch', AccountId, DataBag, Context),
            z_render:update("update_widget_dashboard_credit"
                           ,z_template:render("onbill_widget_dashboard_credit.tpl"
                                             ,[{headline,"Credit"},{pr_pt, PrPt}]
                                             ,Context)
                           ,Context)
    catch
        error:_ ->
            z_render:growl_error(?__("Something went wrong.", Context), Context)
    end;

event(A, Context) ->
    lager:info("Unknown event A: ~p", [A]),
    lager:info("Unknown event variables: ~p", [z_context:get_q_all(Context)]),
    lager:info("Unknown event Context: ~p", [Context]),
    Context.

growl_bad_result(<<>>, Context) -> 
    z_render:growl_error(?__("Something went wrong.", Context), Context);
growl_bad_result(_, Context) -> 
    z_render:growl(?__("Operation succeeded.",Context), Context).

