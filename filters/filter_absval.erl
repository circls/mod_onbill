-module(filter_absval).
-export([
          absval/2,
          absval/3
]).

absval('undefined', _Context) ->
    'undefined';
absval(Units, _Context) when is_integer(Units) ->
    abs(Units);
absval(Units, _Context) when is_float(Units) ->
    abs(Units);
absval(Units, _Context) ->
    abs(z_convert:to_float(Units)).

absval('undefined', _Args, _Context) ->
    'undefined';
absval(Units, _Args, _Context) ->
    abs(Units).
