-module(onbill_util).
-author("Kirill Sysoev <kirill.sysoev@gmail.com>").

-export([crossbar_listing/3
         ,crossbar_listing/4
         ,onbill_attachment/6
         ,onbill_attachment_link/5
         ,onbill_attachment_link/6
         ,onbill_attachment_link/7
]).

-include_lib("zotonic.hrl").

-define(V1, <<"/v1">>).
-define(V2, <<"/v2">>).
-define(ACCOUNTS, <<"/accounts/">>).
-define(ONBILLS, <<"/onbills">>).
-define(INVOICE, <<"/invoice">>).
-define(ATTACHMENT, <<"/attachment">>).

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

onbill_attachment(AccountId, DocId, AuthToken, Year, Month, Context) ->
    API_String = <<?V2/binary, ?ACCOUNTS/binary, (z_convert:to_binary(AccountId))/binary
                   ,?ONBILLS/binary,"/",(z_convert:to_binary(DocId))/binary, ?ATTACHMENT/binary
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

