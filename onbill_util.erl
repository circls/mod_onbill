-module(onbill_util).
-author("Kirill Sysoev <kirill.sysoev@gmail.com>").

-export([crossbar_listing/1
         ,crossbar_listing/2
]).

-include_lib("zotonic.hrl").

-define(V2, <<"/v2">>).
-define(ACCOUNTS, <<"/accounts/">>).
-define(ONBILLS, <<"/onbills">>).

crossbar_listing(Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    crossbar_listing(AccountId, Context).

crossbar_listing(AccountId, Context) ->
    API_String = <<?V2/binary, ?ACCOUNTS/binary, (z_convert:to_binary(AccountId))/binary, ?ONBILLS/binary>>,
    kazoo_util:crossbar_account_request('get', API_String, [], Context).

