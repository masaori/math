import os
_dir = os.path.dirname(os.path.abspath(__file__))

for filename in [
    "check_constant_configuration.sage",
    "check_odd_orbit_product.sage",
    "check_orbit_product_square.sage",
    "check_endpoint_multiplicities.sage",
]:
    load(os.path.join(_dir, filename))

print("ALL PASS")
