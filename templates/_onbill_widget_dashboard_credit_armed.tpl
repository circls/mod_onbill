<table id="dashboard_credit_table" class="table table-hover table-centered table-condensed">
  <thead>
    <tr>
      <th width="35%">
        {_ Status _}
      </th>
      <th width="65%">
        {% if (pr_pt[1]["start"] + pr_pt[1]["duration"])|inno_timestamp_expiried == "active" %}
          <span class="zwarning"> {_ Active _} </span>
        {% elif (pr_pt[1]["start"] + pr_pt[1]["duration"])|inno_timestamp_expiried == "expiried" %}
          <span class="zalarm"> {_ Expired _} </span>
        {% else %}
          {_ Undefined _}
        {% endif %}
      </th>
    </tr>
  </thead>
  <tbody>
    <tr><td>{_ Credit amount _}</td><td>{{ m.config.mod_kazoo.local_currency_sign.value }}{{ pr_pt[1]["amount"]|onnet_format_price }}</td></tr>
    <tr><td>{_ Maturity date _}</td><td>{{ (pr_pt[1]["start"] + pr_pt[1]["duration"])|inno_timestamp_to_date }}</td></tr>
  </tbody>
</table>
