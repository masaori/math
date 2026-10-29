import os
import sys

directory = os.path.dirname(os.path.abspath(sys.argv[0]))
for name in ('_prelude.sage', 'check_orbit_partition.sage'):
    load(os.path.join(directory, name))
print('RESULT: PASS mode inversion orbit cardinality')
