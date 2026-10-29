import os
import sys

directory = os.path.dirname(os.path.abspath(sys.argv[0]))
load(os.path.join(directory, 'check_fixed_factors.sage'))
load(os.path.join(directory, 'check_orbit_product_sign.sage'))
print('RESULT: PASS signed even subgraph rational sign')
