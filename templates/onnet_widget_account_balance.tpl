{% extends "onnet_widget_dashboard.tpl" %}

{% block widget_headline %}
    {{ headline }}
{% endblock %}

{% block widget_class %}{% if last %}last{% endif %}{% endblock %}

{% block widget_content %}
<table class="table table-condensed table-centered">
    <thead>
        <tr>
            <th>{_ Account status _}</th>
            <th>{% if m.kazoo[{kz_account_doc_field field1="enabled"}] %}<span class="zprimary">{_ Active _}</span> 
                            {% else %}<span class="zalarm">{_ Blocked _}{% endif %}</span>
            </th>
        </tr>
    </thead>
    <tbody>
        <tr><td>{_ Current balance _}</td><td>{{ m.kazoo.current_account_credit|currency_sign }}</td></tr>
    </tbody>
</table>

    <span id="set_notify_level_tpl">
        {% include "_set_notify_level.tpl" %}
    </span>

{% endblock %}

