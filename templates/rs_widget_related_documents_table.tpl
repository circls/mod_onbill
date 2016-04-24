{% include  "rs_widget_proforma_invoice_lazy.tpl" year=year month=month %}

<table class="table table-condensed table-centered">
    <thead>
        <tr style="height: 10px; color: white!important; background-color: white!important;"><td colspan="3"></td></tr>
    </thead>
</table>

{% include  "rs_widget_invoices_lazy.tpl" year=year month=month %}

<table class="table table-condensed table-centered">
    <thead>
        <tr style="height: 10px; color: white!important; background-color: white!important;"><td colspan="3"></td></tr>
    </thead>
</table>

{% include  "rs_widget_acts_lazy.tpl" year=year month=month %}

{% print related_documents_month_chosen %}
{% print account_id %}
{% print year %}
{% print month %}
