{% extends "modkazoo_widget_dashboard.tpl" %}

{% block widget_headline %}
    {{ headline }}
{% endblock %}

{% block widget_class %}{% if last %}last{% endif %}{% endblock %}

{% block widget_content %}
<table class="table table-condensed table-hover table-centered">
   <thead>
        <tr>
            <th>{_ Counterparty _}</th>
            <th>{_ Date _}</th>
            <th>{_ Sum _}</th>
            <th>{_ VAT _}</th>
            <th>{_ Total _}</th>
        </tr>
    </thead>
    <tbody>
      {% for doc in m.onbill.crossbar_listing %}
        <tr>
            <td><a href="/kzattachment/id/{{ doc["id"] }}">{{ doc["name"] }}</a></td>
            <td><a href="/kzattachment/id/{{ doc["id"] }}">{{ doc["name"] }}</a></td>
            <td><a href="/kzattachment/id/{{ doc["id"] }}">{{ doc["name"] }}</a></td>
            <td><a href="/kzattachment/id/{{ doc["id"] }}">{{ doc["name"] }}</a></td>
            <td><a href="/kzattachment/id/{{ doc["id"] }}">{{ doc["name"] }}</a></td>
        </tr>
      {% endfor %}
    </tbody>
</table>
{% endblock %}

