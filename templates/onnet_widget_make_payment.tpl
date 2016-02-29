{% extends "onnet_widget_dashboard.tpl" %}

{% block widget_headline %}
    {{ headline }}
{% endblock %}

{% block widget_content %}

{% with m.kazoo.kz_bt_customer as bt_customer %}

<table class="table table-hover table-centered table-condensed">
    <thead>
        <tr style="background-color:#F8F8F8">
            <th>
                <a class="visible-lg" style="color: #FF9002; text-decoration: none; cursor: pointer;" href="https://www.braintreepayments.com/about" target="_blank">{_ Braintree - Electronic Payment System _}</a>
                <span class="hidden-lg" style="color: #FF9002">{_ Braintree _}</span>
            </th>
            <th colspan="2">
                <span style="display: block; text-align: right;">
                  <img src="/lib/paysysimg/Mastercard.png" height="18px" title="Mastercard" alt="Mastercard">
                  <img src="/lib/paysysimg/Discover.png" height="18px" title="Discover" alt="Discover">
                  <img src="/lib/paysysimg/Maestro.png" height="18px" title="Maestro" alt="Maestro">
                  <img src="/lib/paysysimg/Visa.png" height="18px" title="Visa" alt="Visa">
                  <img src="/lib/paysysimg/American-Express.png" height="18px" title="American Express" alt="American Express">
                </span>
            </th>
        </tr>
    </thead>
    <tbody>
        <tr id="make_payment_line_id">
            <td width="55%">{_ Enter an amount to pay _} (£10 - £200)</td>
            <td>{{ m.config.mod_kazoo.local_currency_sign.value }} <input class="input input-small-onnet" type="text" id="kazoo_transaction" name="kazoo_transaction" value="" />
            </td>
            <td>
                {% button class="btn btn-xs btn-onnet pull-right" text=_"proceed" 
                    action={confirm text=_"<br />Do you really want to proceed with payment?
                                           <br /><br />Your default card will be immediately charged!
                                           <br /><br /> Please refer to our <a href='https://onnet.info/termscons'>Terms & Conditions</a>
                                           regarding cancellation and refund policy.<br /><br />"
                        action={postback postback="kazoo_transaction" delegate="mod_kazoo" qarg="kazoo_transaction"}
                        action={mask target="make_payment_line_id" message=_"Processing ..."}
                    }
                 %}
            </td>
        </tr>
    </tbody>
</table>
<span id="make_payment_manage_cards_tpl">
    {% include "_make_payment_manage_cards.tpl" %}
</span>
<span id="make_payment_topup_settings_tpl">
{% include "_make_payment_topup_settings.tpl" %}
</span>

{% endwith %}

{% endblock %}

