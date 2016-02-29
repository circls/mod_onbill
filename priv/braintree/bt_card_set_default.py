import sys
import braintree

if sys.argv[1] == "Sandbox":
    braintree.Configuration.configure(braintree.Environment.Sandbox, sys.argv[2], sys.argv[3], sys.argv[4])
elif sys.argv[1] == "Production":
    braintree.Configuration.configure(braintree.Environment.Production, sys.argv[2], sys.argv[3], sys.argv[4])
else:
    sys.exit('\nusage: python bt_card_set_default Environment(Production/Sandbox) MerchantId PublicKey PrivateKey CardId\n')

result = braintree.PaymentMethod.update(sys.argv[5], { "options": { "make_default": True } })

if result.is_success:
    sys.stdout.write("success")
else:
    for error in result.errors.deep_errors:
        sys.stdout.write(error.message+" ")
