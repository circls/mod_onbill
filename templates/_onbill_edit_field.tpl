<input id="{{ field_name }}_input" name="input_value" style="width:70%; height:20px; text-align:center;" type="text"
                                   value="{{ m.onbill[{doc_field doc_id=doc_id field=field_name}] }}"/>
<i id="{{ field_name }}_undo" class="fa fa-remove pointer" title="Cancel"></i>
{% wire id=field_name++"_undo" type="click" action={ update target=field_name template="_onbill_show_field.tpl" doc_id=doc_id field_name=field_name} %}
<i id="{{ field_name }}_save" class="fa fa-save pointer" title="{_ Save _}"></i>
{% wire id=field_name++"_save" type="click" action={postback postback={save_field doc_id field_name} 
                                                             delegate="mod_onbill" 
                                                             qarg=field_name++"_input" inject_args doc_id=doc_id field_name=field_name}
%}
