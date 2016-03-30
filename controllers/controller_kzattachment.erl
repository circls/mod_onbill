-module(controller_kzattachment).
-export([
    init/1,
    service_available/2,
    allowed_methods/2,
    resource_exists/2,
    forbidden/2,
    content_types_provided/2,
    charsets_provided/2,
    encodings_provided/2,
    provide_content/2,
    finish_request/2
]).

-include_lib("controller_webmachine_helper.hrl").
-include_lib("zotonic.hrl").

init(ConfigProps) ->
    {ok, ConfigProps}.

service_available(ReqData, DispatchArgs) ->
    Context  = z_context:new(ReqData, ?MODULE),
    Context1 = z_context:set(DispatchArgs, Context),
    Context2 = z_context:ensure_all(Context1),
    ?WM_REPLY(true, Context2).

allowed_methods(ReqData, Context) ->
    {['HEAD', 'GET'], ReqData, Context}.

forbidden(ReqData, Context) ->
    {false, ReqData, Context}.

content_types_provided(ReqData, Context) ->
 %   {[{z_context:get(mime, Context), provide_content}], ReqData, Context}.
    {[{"application/pdf", provide_content}], ReqData, Context}.

encodings_provided(ReqData, Context) ->
    Mime = z_context:get(mime, Context),
    Encodings = case z_media_identify:is_mime_compressed(Mime) of
                    true ->
                        [{"identity", fun(Data) -> Data end}];
                    _ ->
                        [{"identity", fun(Data) -> decode_data(identity, Data) end},
                        {"gzip",     fun(Data) -> decode_data(gzip, Data) end}]
                end,
    {Encodings, ReqData, z_context:set(encode_data, length(Encodings) > 1, Context)}.

resource_exists(ReqData, Context) ->
    {true , ReqData, Context}.

charsets_provided(ReqData, Context) ->
    case is_text(z_context:get(mime, Context)) of
        true -> {[{"utf-8", fun(X) -> X end}], ReqData, Context};
        _ -> {no_charset, ReqData, Context}
    end.

provide_content(ReqData, Context) ->
lager:info("IAM provide_content/2. Q ALL: ~p ",[z_context:get_q_all(Context)]),
    ReqData1 = case z_context:get(content_disposition, Context) of
              inline ->     wrq:set_resp_header("Content-Disposition", "inline", ReqData);
              attachment -> wrq:set_resp_header("Content-Disposition", "attachment", ReqData);
              undefined ->  ReqData
          end,
    case z_context:get_q("doc_type", Context) of
        "onbill_doc" ->
                    {'ok', Data} = onbill_doc(Context),
                    Body = case z_context:get(encode_data, Context, false) of
                               true -> encode_data(Data);
                               false -> Data
                           end,
                    {Body, ReqData1, z_context:set(body, Body, Context)};
        _ ->
            {<<>>, ReqData, Context}
    end.

onbill_doc(Context) ->
    {ok, <<"Hello from controller">>}.

finish_request(ReqData, Context) ->
    {ok, ReqData, Context}.

is_text("text/" ++ _) -> true;
is_text("application/x-javascript") -> true;
is_text("application/xhtml+xml") -> true;
is_text("application/xml") -> true;
is_text(_Mime) -> false.

encode_data(Data) when is_binary(Data) ->
    {Data, zlib:gzip(Data)}.

decode_data(gzip, Data) when is_binary(Data) ->
    zlib:gzip(Data);
decode_data(identity, Data) when is_binary(Data) ->
    Data;
decode_data(identity, {Data, _Gzip}) ->
    Data;
decode_data(gzip, {_Data, Gzip}) ->
    Gzip.

