-module(onbill_util).
-author("Kirill Sysoev <kirill.sysoev@gmail.com>").

-export([bt_client_token/1
        ,bt_card_add/1
        ,bt_make_default_card/2
]).


bt_client_token(Context) ->
    OsCmd = io_lib:format("python user/modules/mod_bt/priv/braintree/bt_client_token.py ~s ~s ~s ~s ~s", [
                                                             m_config:get_value('mod_bt', 'bt_environment', Context)
                                                            ,m_config:get_value('mod_bt', 'bt_merchant_id', Context)
                                                            ,m_config:get_value('mod_bt', 'bt_public_key', Context)
                                                            ,m_config:get_value('mod_bt', 'bt_private_key', Context)
                                                            ,z_context:get_session('kazoo_account_id', Context)
                                                           ]),
    os:cmd(OsCmd).

bt_card_add(Context) ->
    OsCmd = io_lib:format("python user/modules/mod_bt/priv/braintree/bt_card_add.py ~s ~s ~s ~s ~s ~s", [
                                                             m_config:get_value('mod_bt', 'bt_environment', Context)
                                                            ,m_config:get_value('mod_bt', 'bt_merchant_id', Context)
                                                            ,m_config:get_value('mod_bt', 'bt_public_key', Context)
                                                            ,m_config:get_value('mod_bt', 'bt_private_key', Context)
                                                            ,z_context:get_session('kazoo_account_id', Context)
                                                            ,z_context:get_q("payment_method_nonce", Context)
                                                           ]),
    os:cmd(OsCmd).

bt_make_default_card(CardId, Context) ->
    OsCmd = io_lib:format("python user/modules/mod_bt/priv/braintree/bt_card_set_default.py ~s ~s ~s ~s ~s", [
                                                             m_config:get_value('mod_bt', 'bt_environment', Context)
                                                            ,m_config:get_value('mod_bt', 'bt_merchant_id', Context)
                                                            ,m_config:get_value('mod_bt', 'bt_public_key', Context)
                                                            ,m_config:get_value('mod_bt', 'bt_private_key', Context)
                                                            ,CardId
                                                           ]),
    lager:info("OsCmd: ~p", [lists:flatten(OsCmd)]),
    os:cmd(OsCmd).
