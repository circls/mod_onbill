{% extends "dashboard_base.tpl" %}

{% block service_description %}

{# include "cf_app_style.tpl" #}
{# lib "css/kazoo/cf_tables.css" #}
{# lib "css/kazoo/cf_mod_kazoo.css" #}

<span id="billing_children_area">
  {% include "billing_children.tpl" %}
</span>

{% endblock %}

