-define(JSON_WRAPPER(Proplist), {Proplist}).
-define(EMPTY_JSON_OBJECT, ?JSON_WRAPPER([])).
-define(MK_DATABAG(JObj), {[{<<"data">>, JObj}]}).
-define(TO_BIN(Var), <<(z_convert:to_binary(Var))/binary>>).
