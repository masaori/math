import os
import sys
directory = os.path.dirname(os.path.abspath(sys.argv[0]))
for name in ('check_mode_membership.sage', 'check_mode_sum.sage',
             'check_square_factor.sage', 'check_zero_equivalence.sage'):
    load(os.path.join(directory, name))
print('RESULT: PASS untwisted mode zero condition')
