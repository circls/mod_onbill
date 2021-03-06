-module(onbill_util).
-author("Kirill Sysoev <kirill.sysoev@gmail.com>").

-export([crossbar_listing/3
         ,crossbar_listing/4
         ,onbill_modb_attachment/6
         ,onbill_attachment_link/5
         ,onbill_attachment_link/6
         ,onbill_attachment_link/7
         ,generate_monthly_docs/5
         ,customer/2
         ,customer/4
         ,reseller/2
         ,reseller/4
         ,onbill_service_plan/2
         ,onbill_service_plan/5
         ,carrier/2
         ,carrier/5
         ,carrier_template/7
         ,doc/2
         ,doc/5
         ,doc_field/3
         ,periodic_fees/4
         ,periodic_fees/5
         ,onbill_transaction/3
         ,promised_payment/1
         ,promised_payment/4
]).

-include_lib("zotonic.hrl").
-include_lib("include/mod_onbill.hrl").


-define(V1, <<"/v1">>).
-define(V2, <<"/v2">>).
-define(ACCOUNTS, <<"/accounts/">>).
-define(ONBILLS, <<"/onbills">>).
-define(INVOICE, <<"/invoice">>).
-define(ATTACHMENT, <<"/attachment">>).
-define(GENERATE, <<"/generate">>).
-define(MODB, <<"/onbills_modb">>).
-define(CUSTOMERS, <<"/onbill_customers">>).
-define(RESELLERS, <<"/onbill_resellers">>).
-define(CARRIERS, <<"/onbill_carriers">>).
-define(SERVICE_PLANS, <<"/onbill_service_plans">>).
-define(PERIODIC_FEES, <<"/periodic_fees">>).
-define(ONBILL_TRANSACTIONS, <<"/onbill_transactions">>).
-define(PROMISED_PAYMENT, <<"/promised_payment">>).

crossbar_listing('undefined', 'undefined', Context) ->
    Timezone = z_convert:to_list(kazoo_util:may_be_get_timezone(Context)),
    {{Year0,Month0,_}, _} = localtime:local_to_local(calendar:gregorian_seconds_to_datetime(calendar:datetime_to_gregorian_seconds(calendar:universal_time())), "UTC", Timezone), 
    {{Year,Month,_}, _} = calendar:gregorian_seconds_to_datetime((calendar:datetime_to_gregorian_seconds({{Year0,Month0,1},{0,0,0}}) - 60)),
    crossbar_listing(Year, Month, Context);

crossbar_listing(Year, Month, Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    crossbar_listing(AccountId, Year, Month, Context).

crossbar_listing(AccountId, 'undefined', 'undefined', Context) ->
    Timezone = z_convert:to_list(kazoo_util:may_be_get_timezone(Context)),
    {{Year,Month,_}, _} = localtime:local_to_local(calendar:gregorian_seconds_to_datetime(calendar:datetime_to_gregorian_seconds(calendar:universal_time())), "UTC", Timezone), 
    crossbar_listing(AccountId, Year, Month, Context);

crossbar_listing(AccountId, Year, Month, Context) ->
    API_String = <<?V2/binary, ?ACCOUNTS/binary, (z_convert:to_binary(AccountId))/binary, ?ONBILLS/binary
                   ,"?year=",(z_convert:to_binary(Year))/binary,"&month=",(z_convert:to_binary(Month))/binary>>,
    kazoo_util:crossbar_account_request('get', API_String, [], Context).

doc(DocId, Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    doc('get', AccountId, DocId, [], Context).

doc(Verb, AccountId, DocId, DataBag, Context) ->
    API_String = <<?V2/binary, ?ACCOUNTS/binary, (z_convert:to_binary(AccountId))/binary
                   ,?ONBILLS/binary,"/",(z_convert:to_binary(DocId))/binary>>,
    kazoo_util:crossbar_account_request(Verb, API_String, DataBag, Context).

customer(CustomerId, Context) ->
    customer('get', CustomerId, [], Context).

customer(Verb, CustomerId, DataBag, Context) ->
    API_String = <<?V2/binary, ?ACCOUNTS/binary, (z_convert:to_binary(CustomerId))/binary, ?CUSTOMERS/binary>>,
    kazoo_util:crossbar_account_request(Verb, API_String, DataBag, Context).

reseller(ResellerId, Context) ->
    reseller('get', ResellerId, [], Context).

reseller(Verb, ResellerId, DataBag, Context) ->
    API_String = <<?V2/binary, ?ACCOUNTS/binary, (z_convert:to_binary(ResellerId))/binary, ?RESELLERS/binary>>,
    kazoo_util:crossbar_account_request(Verb, API_String, DataBag, Context).

onbill_service_plan(ServicePlanId, Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    onbill_service_plan('get', AccountId, ServicePlanId, [], Context).

onbill_service_plan(Verb, AccountId, ServicePlanId, DataBag, Context) ->
    API_String = <<?V2/binary, ?ACCOUNTS/binary, (z_convert:to_binary(AccountId))/binary
                   ,?SERVICE_PLANS/binary,"/",(z_convert:to_binary(ServicePlanId))/binary>>,
    kazoo_util:crossbar_account_request(Verb, API_String, DataBag, Context).

carrier(CarrierId, Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    carrier('get', AccountId, CarrierId, [], Context).

carrier(Verb, AccountId, CarrierId, DataBag, Context) ->
    API_String = <<?V2/binary, ?ACCOUNTS/binary, (z_convert:to_binary(AccountId))/binary
                  ,?CARRIERS/binary,"/",(z_convert:to_binary(CarrierId))/binary>>,
    kazoo_util:crossbar_account_request(Verb, API_String, DataBag, Context).

carrier_template(Verb, Headers, AccountId, CarrierId, TemplateId, MessageBody, Context) ->
    API_String = <<?V2/binary, ?ACCOUNTS/binary, (z_convert:to_binary(AccountId))/binary
                  ,?CARRIERS/binary,"/",(z_convert:to_binary(CarrierId))/binary,"/",(z_convert:to_binary(TemplateId))/binary>>,
    kazoo_util:crossbar_account_send_raw_request_body(Verb, API_String, Headers, MessageBody, Context).



%kz_save_notification_template(ContextType, NotificationId, AccountId, MessageBody, Context) ->
%    API_String = <<?V2/binary, ?ACCOUNTS/binary, AccountId/binary, ?NOTIFICATIONS/binary, <<"/">>/binary, (z_convert:to_binary(NotificationId))/binary>>,
%    crossbar_account_send_request('post', API_String, ContextType, MessageBody, Context).



onbill_modb_attachment(AccountId, DocId, AuthToken, Year, Month, Context) ->
    API_String = <<?V2/binary, ?ACCOUNTS/binary, (z_convert:to_binary(AccountId))/binary
                   ,?ONBILLS/binary,?MODB/binary,"/",(z_convert:to_binary(DocId))/binary, ?ATTACHMENT/binary
                   ,"?year=",(z_convert:to_binary(Year))/binary,"&month=",(z_convert:to_binary(Month))/binary>>,
    kazoo_util:crossbar_account_send_raw_request_body(AuthToken, 'get', API_String, [], [], Context).

onbill_attachment_link(DocId, DocType, 'undefined', 'undefined', Context) ->
    Timezone = z_convert:to_list(kazoo_util:may_be_get_timezone(Context)),
    {{Year0,Month0,_}, _} = localtime:local_to_local(calendar:gregorian_seconds_to_datetime(calendar:datetime_to_gregorian_seconds(calendar:universal_time())), "UTC", Timezone), 
    {{Year,Month,_}, _} = calendar:gregorian_seconds_to_datetime((calendar:datetime_to_gregorian_seconds({{Year0,Month0,1},{0,0,0}}) - 60)),
    onbill_attachment_link(DocId, DocType, Year, Month, Context);

onbill_attachment_link(DocId, DocType, Year, Month, Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    AuthToken = z_context:get_session(kazoo_auth_token, Context),
    onbill_attachment_link(AccountId, DocId, AuthToken, DocType, Year, Month, Context).

onbill_attachment_link(AccountId, DocId, DocType, 'undefined', 'undefined', Context) ->
    Timezone = z_convert:to_list(kazoo_util:may_be_get_timezone(Context)),
    {{Year,Month,_}, _} = localtime:local_to_local(calendar:gregorian_seconds_to_datetime(calendar:datetime_to_gregorian_seconds(calendar:universal_time())), "UTC", Timezone), 
    onbill_attachment_link(AccountId, DocId, DocType, Year, Month, Context);

onbill_attachment_link(AccountId, DocId, DocType, Year, Month, Context) ->
    AuthToken = z_context:get_session(kazoo_auth_token, Context),
    onbill_attachment_link(AccountId, DocId, AuthToken, DocType, Year, Month, Context).

onbill_attachment_link(AccountId, DocId, AuthToken, DocType, Year, Month, Context) ->
    API_String = <<"/kzattachment?"
                   ,"account_id=", (z_convert:to_binary(AccountId))/binary
                   ,"&doc_id=", (z_convert:to_binary(DocId))/binary
                   ,"&auth_token=", (z_convert:to_binary(AuthToken))/binary
                   ,"&doc_type=", (z_convert:to_binary(DocType))/binary
                   ,"&year=", (z_convert:to_binary(Year))/binary
                   ,"&month=", (z_convert:to_binary(Month))/binary
                 >>,
    <<"https://", (z_convert:to_binary(z_dispatcher:hostname(Context)))/binary, API_String/binary>>.

generate_monthly_docs(DocType, DocsAccountId, Year, Month, Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    API_String = <<?V2/binary, ?ACCOUNTS/binary, (z_convert:to_binary(AccountId))/binary, ?ONBILLS/binary, ?GENERATE/binary, "/", (z_convert:to_binary(DocsAccountId))/binary>>,
    DataBag = ?MK_DATABAG({[{<<"year">>, Year},{<<"month">>, Month},{<<"doc_type">>, DocType}]}),
    kazoo_util:crossbar_account_request('put', API_String, DataBag, Context).

doc_field(Field, DocId, Context) when is_binary(Field) ->
    modkazoo_util:get_value(Field, doc(DocId, Context));
doc_field(Field, DocId, Context) when is_list(hd(Field)) ->
    modkazoo_util:get_value([z_convert:to_binary(X) || X <- Field], doc(DocId, Context));
doc_field(Field, DocId, Context) when is_binary(hd(Field)) ->
    modkazoo_util:get_value(Field, doc(DocId, Context));
doc_field(Field, DocId, Context) when is_list(Field) ->
    modkazoo_util:get_value(z_convert:to_binary(Field), doc(DocId, Context)).

periodic_fees(Verb, AccountId, DataBag, Context) ->
    API_String = <<?V2/binary, ?ACCOUNTS/binary, (z_convert:to_binary(AccountId))/binary, ?PERIODIC_FEES/binary>>,
    kazoo_util:crossbar_account_request(Verb, API_String, DataBag, Context).

periodic_fees(Verb, AccountId, 'undefined', DataBag, Context) ->
    API_String = <<?V2/binary, ?ACCOUNTS/binary, (z_convert:to_binary(AccountId))/binary ,?PERIODIC_FEES/binary>>,
    kazoo_util:crossbar_account_request(Verb, API_String, DataBag, Context);
periodic_fees(Verb, AccountId, FeeId, DataBag, Context) ->
    API_String = <<?V2/binary, ?ACCOUNTS/binary, (z_convert:to_binary(AccountId))/binary
                   ,?PERIODIC_FEES/binary,"/",(z_convert:to_binary(FeeId))/binary>>,
    kazoo_util:crossbar_account_request(Verb, API_String, DataBag, Context).

onbill_transaction(TransactionId, AccountId, Context) ->
    API_String = <<?V1/binary, ?ACCOUNTS/binary, ?TO_BIN(AccountId)/binary, ?ONBILL_TRANSACTIONS/binary, "/", ?TO_BIN(TransactionId)/binary>>,
    kazoo_util:crossbar_account_request('get', API_String, [], Context).

promised_payment(Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    promised_payment('get', AccountId, [], Context).

promised_payment(Verb, AccountId, DataBag, Context) ->
    API_String = <<?V1/binary, ?ACCOUNTS/binary, ?TO_BIN(AccountId)/binary, ?PROMISED_PAYMENT/binary>>,
    kazoo_util:crossbar_account_request(Verb, API_String, DataBag, Context).

