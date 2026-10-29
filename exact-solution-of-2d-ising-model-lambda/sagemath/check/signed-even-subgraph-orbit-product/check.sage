import os
import sys

directory = os.path.dirname(os.path.abspath(sys.argv[0]))
for name in ('_prelude.sage', 'check_product_square_distribution.sage',
             'check_fixed_mode_substitution.sage', 'check_orbit_multiplicity.sage',
             'check_partition_reindex.sage'):
    load(os.path.join(directory, name))
print('RESULT: PASS signed even subgraph orbit product')
