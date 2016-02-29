import sys
import braintree

if sys.argv[1] == "Sandbox":
    braintree.Configuration.configure(braintree.Environment.Sandbox, sys.argv[2], sys.argv[3], sys.argv[4])
elif sys.argv[1] == "Production":
    braintree.Configuration.configure(braintree.Environment.Production, sys.argv[2], sys.argv[3], sys.argv[4])
else:
    sys.exit('\nusage: client_token Environment(Production/Sandbox) MerchantId PublicKey PrivateKey\n')

try:
    result = braintree.ClientToken.generate({"customer_id": sys.argv[5]})
    sys.stdout.write(result)
except Exception, e:
    braintree.Customer.create({
        "id": sys.argv[5],
    })
    result = braintree.ClientToken.generate({"customer_id": sys.argv[5]})
    sys.stdout.write(result)
