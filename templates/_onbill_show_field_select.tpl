<span>
    {{ m.onbill[{doc_field doc_id=doc_id field=field_name}] }} 
    <i id="edit_{{ prefix }}{{ field_name }}" class="fa fa-edit pointer" title="Edit field"></i>
</span>
{% wire id="edit_"++prefix++field_name type="click"
        action={ update target=prefix++field_name
                        template="_onbill_edit_field_"++select++postfix++".tpl"
                        doc_id=doc_id
                        field_name=field_name
                        options=options
                        prefix=prefix
                        postfix=postfix}
%}
