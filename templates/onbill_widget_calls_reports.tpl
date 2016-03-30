{% extends "modkazoo_widget_dashboard.tpl" %}

{% block widget_headline %}
    {{ headline }}
    {% button class="btn btn-xs btn-onnet pull-right" action={mask target="reports_body_to_mask" message=_"Preparing reports..."} action={postback postback="callsreportme" delegate="mod_onbill" qarg="docsmonthInput"} text=_"generate" %}
{% endblock %}

{% block widget_class %}{% if last %}last{% endif %}{% endblock %}

{% block widget_content %}
<table id="calls_reports_table" class="table table-condensed table-hover table-centered">
    <tbody id="reports_body_to_mask">
        <tr>
            <td><a href="/getlbdocs/id/{{order_id}}">{{ oper_name }}</a></td>
        </tr>
    </tbody>
</table>
{% endblock %}

