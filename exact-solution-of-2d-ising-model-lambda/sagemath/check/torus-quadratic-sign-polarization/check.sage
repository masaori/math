import os
import sys
directory = os.path.dirname(os.path.abspath(sys.argv[0]))
for name in ('check_exponent_substitution.sage', 'check_exponent_expansion.sage', 'check_sign_product.sage'):
    load(os.path.join(directory, name))
print('RESULT: PASS torus quadratic sign polarization (64 exact cases)')
