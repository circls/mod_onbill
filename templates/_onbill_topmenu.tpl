     {% if (m.kazoo.kz_current_context_superadmin or m.kazoo.kz_current_context_reseller_status) and m.kazoo.is_kazoo_account_admin %}
       <ul class="nav navbar-nav">
         <li class="dropdown">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown">{_ Billing _} <b class="caret"></b></a>
            <ul class="dropdown-menu">
              <li><a href="/billing_operations">{_ Billing Operations _}</a>
              <li><a href="/billing_settings">{_ Billing Settings _}</a>
            </ul>
         </li>
       </ul>
     {% endif %}
