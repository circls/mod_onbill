-module(scomp_onbill_onbill_documents_menu_item).
-behaviour(gen_scomp).

-export([vary/2, render/3]).

-include("zotonic.hrl").

vary(_Params, _Context) -> default.

render(_Params, _Vars, Context) ->
    Documents = z_trans:trans("Documents", Context),
    {'ok', <<"<li><a href='/documents'>", Documents/binary, "</a></li>">>}.
