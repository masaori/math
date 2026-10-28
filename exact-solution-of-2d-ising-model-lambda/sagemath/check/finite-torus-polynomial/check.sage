import os
import sys

directory = os.path.dirname(os.path.abspath(sys.argv[0]))
for name in ('check_character_sum.sage', 'check_sum_interchange.sage', 'check_trivial_sector.sage'):
    load(os.path.join(directory, name))
print('RESULT: PASS finite torus polynomial')
