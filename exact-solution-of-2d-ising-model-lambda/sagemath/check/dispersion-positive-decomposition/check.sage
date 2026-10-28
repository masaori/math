import os
import sys
directory = os.path.dirname(os.path.abspath(sys.argv[0]))
for name in ('check_definition.sage', 'check_square_difference.sage', 'check_factor.sage', 'check_mode_pair.sage'):
    load(os.path.join(directory, name))
print('RESULT: PASS dispersion positive decomposition')
