     {% if m.kazoo.is_kazoo_account_admin %}
       <ul class="nav navbar-nav">
         <li><a href="/dashboard">{_ Dashboard _}</a></li>
         {% if not m.kazoo.kz_current_context_superadmin %}
           <li><a href="/finance_details">{_ Payments _}</a></li>
         {% endif %}
       </ul>
     {% endif %}
     {% if (m.kazoo.kz_current_context_superadmin or m.kazoo.kz_current_context_reseller_status) and m.kazoo.is_kazoo_account_admin %}
       <ul class="nav navbar-nav">
         <li class="dropdown">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown">{_ Billing portal _} <b class="caret"></b></a>
            <ul class="dropdown-menu">
              <li><a href="/billing_accounts">{_ Accounts _}</a>
              <li><a href="/billing_operations">{_ Operations _}</a>
              <li><a href="/billing_general_settings">{_ General settings _}</a>
            </ul>
         </li>
       </ul>
     {% endif %}
