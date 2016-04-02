-module(onbill_util).
-author("Kirill Sysoev <kirill.sysoev@gmail.com>").

-export([crossbar_listing/1
         ,crossbar_listing/2
         ,onbill_attachment/4
         ,onbill_attachment_link/3
         ,onbill_attachment_link/5
]).

-include_lib("zotonic.hrl").

-define(V1, <<"/v1">>).
-define(V2, <<"/v2">>).
-define(ACCOUNTS, <<"/accounts/">>).
-define(ONBILLS, <<"/onbills">>).
-define(INVOICE, <<"/invoice">>).
-define(ATTACHMENT, <<"/attachment">>).

crossbar_listing(Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    crossbar_listing(AccountId, Context).

crossbar_listing(AccountId, Context) ->
    API_String = <<?V2/binary, ?ACCOUNTS/binary, (z_convert:to_binary(AccountId))/binary, ?ONBILLS/binary>>,
    kazoo_util:crossbar_account_request('get', API_String, [], Context).

onbill_attachment(AccountId, DocId, AuthToken, Context) ->
    API_String = <<?V1/binary, ?ACCOUNTS/binary, (z_convert:to_binary(AccountId))/binary
                   ,?ONBILLS/binary,<<"/">>/binary,(z_convert:to_binary(DocId))/binary, ?ATTACHMENT/binary>>,
    kazoo_util:crossbar_account_send_raw_request_body(AuthToken, 'get', API_String, [], [], Context).

onbill_attachment_link(DocId, DocType, Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    AuthToken = z_context:get_session(kazoo_auth_token, Context),
    onbill_attachment_link(AccountId, DocId, AuthToken, DocType, Context).

onbill_attachment_link(AccountId, DocId, AuthToken, DocType, Context) ->
    API_String = <<"/kzattachment?"
                   ,"account_id=", (z_convert:to_binary(AccountId))/binary
                   ,"&doc_id=", (z_convert:to_binary(DocId))/binary
                   ,"&auth_token=", (z_convert:to_binary(AuthToken))/binary
                   ,"&doc_type=", (z_convert:to_binary(DocType))/binary
                 >>,
    <<"https://", (z_convert:to_binary(z_dispatcher:hostname(Context)))/binary, API_String/binary>>.

