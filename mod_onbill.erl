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

event(A, Context) ->
    lager:info("Unknown event A: ~p", [A]),
    lager:info("Unknown event variables: ~p", [z_context:get_q_all(Context)]),
    lager:info("Unknown event Context: ~p", [Context]),
    Context.

