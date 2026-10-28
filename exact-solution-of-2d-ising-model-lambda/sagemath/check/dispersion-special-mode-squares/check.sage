import os
import sys
directory = os.path.dirname(os.path.abspath(sys.argv[0]))
for name in ('check_one_one.sage', 'check_one_minus_one.sage', 'check_minus_one_one.sage', 'check_minus_one_minus_one.sage'):
    load(os.path.join(directory, name))
print('RESULT: PASS dispersion special mode squares')
