<div class="pl-10 pr-10 col-md-6">
  <span id="onnet_widget_account_details_tpl">
     <div class="text-center p-3">
        {% ilazy class="fa fa-spinner fa-spin fa-3x" action={update target="onnet_widget_account_details_tpl" 
                                                                    template="onbill_widget_account_details.tpl"
                                                                    dashboard
                                                                    headline=_"Account details"}
        %}
      </div>
  </span>
  <span id="onnet_widget_account_balance_tpl">
     <div class="text-center p-3">
        {% ilazy class="fa fa-spinner fa-spin fa-3x" action={update target="onnet_widget_account_balance_tpl" 
                                                                    template="onnet_widget_account_balance.tpl"
                                                                    dashboard
                                                                    headline=_"Account balance"}
        %}
      </div>
  </span>

</div>
<div class="pl-10 pr-10 col-md-6">
  <span id="onnet_widget_monthly_fees_tpl">
     <div class="text-center p-3">
        {% ilazy class="fa fa-spinner fa-spin fa-3x" action={update target="onnet_widget_monthly_fees_tpl" 
                                                                    template="onbill_widget_monthly_fees.tpl"
                                                                    headline=_"Current services"}
        %}
      </div>
  </span>
  <span id="onnet_widget_order_additional_number_tpl">
      {% include "onnet_widget_order_additional_number.tpl" %}
  </span>
  {% if m.kazoo.kz_current_context_superadmin or m.kazoo.kz_current_context_reseller_status %}
  {% wire action={connect signal={reseller_registrations_widget_tpl}
                          action={update target="reseller_registrations_widget_tpl"
                          template="reseller_registrations_widget.tpl"
                          headline=_"System-wide registrations"}
                 }
  %}
  <span id="reseller_registrations_widget_tpl">
        {% include "reseller_registrations_widget.tpl" headline=_"System-wide registrations" %}
  </span>
  {% endif %}
</div>
