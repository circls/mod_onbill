{% wire id="form_add_periodic_fee" type="submit" postback="add_periodic_fee" delegate="mod_kazoo" %}
{% with m.onbill[{periodic_fees account_id=account_id fee_id=fee_id}] as fee_data %}
<form id="form_add_periodic_fee" method="post" action="postback">
    <div class="form-group">
      <div class="row">
        <div class="col-sm-6">
            <select id="service_plan_select" name="service_plan_select" class="form-control margin-bottom-xs" style="text-align:center;">
               <option value="balance_correction">Service Plan</option>
            </select>
        </div>
        <div class="col-sm-6">
            <select id="service_select" name="service_select" class="form-control margin-bottom-xs" style="text-align:center;">
               <option value="balance_correction">Balance correction</option>
            </select>
        </div>
      </div>
    </div>
    <div class="form-group">
      <div class="row">
        <div class="col-sm-6">
          <input id="service_starts" type="text" class="form-control margin-bottom-xs bg_color_white"
                                              name="service_starts"
                                              value="{{ fee_data[1]["service_starts"]|inno_timestamp_to_date|date: 'd/m/Y' }}"
                                              data-date="{{ fee_data[1]["service_starts"]|inno_timestamp_to_date|date: 'd/m/Y' }}"
                                              data-date-format="dd/mm/yyyy"
                                              data-date-autoclose="true"
                                              data-date-language={{ z_language }}
                                              data-date-start-date="-6m"
                                              data-date-end-date="+6m"
                                              readonly/>
         {% javascript %}
             $('#service_starts').datepicker();
         {% endjavascript %}
        </div>
        <div class="col-sm-6">
          <input id="service_ends" type="text" class="form-control margin-bottom-xs bg_color_white"
                                              name="service_ends"
                                              value="{{ fee_data[1]["service_ends"]|inno_timestamp_to_date|date: 'd/m/Y' }}"
                                              data-date="{{ fee_data[1]["service_ends"]|inno_timestamp_to_date|date: 'd/m/Y' }}"
                                              data-date-format="dd/mm/yyyy"
                                              data-date-autoclose="true"
                                              data-date-language={{ z_language }}
                                              data-date-start-date="-6m"
                                              data-date-end-date="+6m"
                                              readonly/>
         {% javascript %}
             $('#service_ends').datepicker();
         {% endjavascript %}
        </div>
      </div>
    </div>
    <div class="form-group">
      <div class="row">
        <div class="col-sm-12">
          <input type="text" class="form-control margin-bottom-xs" id="service_comment" name="service_comment" placeholder="{_ Enter service comment here _}" value="{{ fee_data[1]['comment'] }}">
        </div>
      </div>
    </div>
    <div class="form-group">
      <div class="row">
        <div class="col-sm-12">
          {% button class="col-xs-12 btn btn-zprimary margin-bottom-xs" text=_"Save service"
                    action={submit target="form_add_periodic_fee"}
                    action={update target="billing_children_area" template="billing_children.tpl"}
          %}
        </div>
      </div>
    </div>
    <input type="hidden" name="account_id" value="{{ account_id }}">
</form>
{% endwith %}
