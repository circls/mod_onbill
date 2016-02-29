import sys
import braintree

if len(sys.argv) != 7:
    sys.exit('\nusage1: python bt_card_add.py Environment(Production/Sandbox) MerchantId PublicKey PrivateKey CustimerId Payment_method_nonce\n')

if sys.argv[1] == "Sandbox":
    braintree.Configuration.configure(braintree.Environment.Sandbox, sys.argv[2], sys.argv[3], sys.argv[4])
elif sys.argv[1] == "Production":
    braintree.Configuration.configure(braintree.Environment.Production, sys.argv[2], sys.argv[3], sys.argv[4])
else:
    sys.exit('\nusage1: python bt_card_add.py Environment(Production/Sandbox) MerchantId PublicKey PrivateKey CustimerId Payment_method_nonce\n')

result = braintree.PaymentMethod.create({"customer_id": sys.argv[5], "payment_method_nonce": sys.argv[6], "options": {"make_default": True}})

if result.is_success:
    sys.stdout.write("success")
else:
    for error in result.errors.deep_errors:
        sys.stdout.write(error.message+" ")

## sys.stdout.write(result.is_success)
