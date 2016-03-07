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

event(A, Context) ->
    lager:info("Unknown event A: ~p", [A]),
    lager:info("Unknown event variables: ~p", [z_context:get_q_all(Context)]),
    lager:info("Unknown event Context: ~p", [Context]),
    Context.

