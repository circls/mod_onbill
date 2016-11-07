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

m_find_value({onbill_get_doc, [{doc_id, DocId}]}, _M, Context) ->
    onbill_util:doc(DocId, Context);

m_find_value({onbill_get_doc_json, [{doc_id, DocId}]}, _M, Context) ->
    jiffy:encode(onbill_util:doc(DocId, Context));

m_find_value({onbill_get_customer, [{customer_id, CustomerId}]}, _M, Context) ->
    onbill_util:customer(CustomerId, Context);

m_find_value({onbill_get_customer_json, [{customer_id, CustomerId}]}, _M, Context) ->
    jiffy:encode(onbill_util:customer(CustomerId, Context));

m_find_value({onbill_get_reseller, [{reseller_id, ResellerId}]}, _M, Context) ->
    onbill_util:reseller(ResellerId, Context);

m_find_value({onbill_get_reseller_json, [{reseller_id, ResellerId}]}, _M, Context) ->
    jiffy:encode(onbill_util:reseller(ResellerId, Context));

m_find_value({onbill_get_carrier, [{carrier_id, CarrierId}]}, _M, Context) ->
    onbill_util:carrier(CarrierId, Context);

m_find_value({onbill_get_carrier_json, [{carrier_id, CarrierId}]}, _M, Context) ->
    jiffy:encode(onbill_util:carrier(CarrierId, Context));

m_find_value({onbill_get_service_plan,[{service_plan_id, ServicePlanId}]}, _M, Context) ->
    onbill_util:onbill_service_plan(ServicePlanId, Context);

m_find_value({onbill_get_service_plan_json,[{service_plan_id, ServicePlanId}]}, _M, Context) ->
    jiffy:encode(onbill_util:onbill_service_plan(ServicePlanId, Context));

m_find_value({doc_field,[{doc_id, DocId},{field, Field}]}, _M, Context) ->
    onbill_util:doc_field(Field, DocId, Context);

m_find_value({crossbar_listing, [{account_id, 'undefined'}, {year, Year},{month, Month}]}, _M, Context) ->
    onbill_util:crossbar_listing(Year, Month, Context);

m_find_value({crossbar_listing, [{account_id, AccountId}, {year, Year},{month, Month}]}, _M, Context) ->
    onbill_util:crossbar_listing(AccountId, Year, Month, Context);

m_find_value({attachment_download_link, [{doc_id, DocId},{year, Year},{month, Month}]}, _M, Context) ->
    onbill_util:onbill_attachment_link(DocId, "onbill_modb", Year, Month, Context);

m_find_value({attachment_download_link, [{account_id, 'undefined'}, {doc_id, DocId},{year, Year},{month, Month}]}, _M, Context) ->
    onbill_util:onbill_attachment_link(DocId, "onbill_modb", Year, Month, Context);

m_find_value({attachment_download_link, [{account_id, AccountId}, {doc_id, DocId},{year, Year},{month, Month}]}, _M, Context) ->
    onbill_util:onbill_attachment_link(AccountId, DocId, "onbill_modb", Year, Month, Context);

m_find_value({carrier_template,[{carrier_id,CarrierId},{template_id,TemplateId}]}, _M, Context) ->
    AccountId = z_context:get_session('kazoo_account_id', Context),
    onbill_util:carrier_template('get', [], AccountId, CarrierId, TemplateId, [], Context);

m_find_value({periodic_fees, [{account_id, AccountId}]}, _M, Context) ->
    onbill_util:periodic_fees('get', AccountId, [], Context);

m_find_value({periodic_fees, [{account_id, AccountId},{fee_id, FeeId}]}, _M, Context) ->
    onbill_util:periodic_fees('get', AccountId, FeeId, [], Context);

m_find_value({transaction, [{account_id, AccountId},{transaction_id, TransactionId}]}, _M, Context) ->
    onbill_util:onbill_transaction(TransactionId, AccountId, Context);

m_find_value(promised_payment, _M, Context) ->
    onbill_util:promised_payment(Context);

m_find_value(_V, _VV, _Context) ->
    lager:info("m_find_value _V: ~p", [_V]),
    lager:info("m_find_value _VV: ~p", [_VV]),
    [_V,_VV,"m_kazoo_find_value_mismatch"].

m_to_list(_V, _Context) ->
    lager:info("m_to_list _V: ~p", [_V]),
    [_V,"m_to_list"].

m_value(#m{value=V}, _Context) -> V.

