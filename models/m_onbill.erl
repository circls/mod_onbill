-module(m_onbill).
-author("kirill.sysoev@gmail.com").

-behaviour(gen_model).

-export([
    m_find_value/3,
    m_to_list/2,
    m_value/2
]).

-include_lib("zotonic.hrl").

m_find_value({crossbar_listing, [{year, Year},{month, Month}]}, _M, Context) ->
    onbill_util:crossbar_listing(Year, Month, Context);

m_find_value({attachment_download_link, [{doc_id, DocId},{year, Year},{month, Month}]}, _M, Context) ->
    onbill_util:onbill_attachment_link(DocId, "onbill_doc", Year, Month, Context);

m_find_value(_V, _VV, _Context) ->
    lager:info("m_find_value _V: ~p", [_V]),
    lager:info("m_find_value _VV: ~p", [_VV]),
    [_V,_VV,"m_kazoo_find_value_mismatch"].

m_to_list(_V, _Context) ->
    lager:info("m_to_list _V: ~p", [_V]),
    [_V,"m_to_list"].

m_value(#m{value=V}, _Context) -> V.

