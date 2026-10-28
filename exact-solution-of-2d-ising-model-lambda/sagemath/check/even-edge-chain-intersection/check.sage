import os
import sys
directory = os.path.dirname(os.path.abspath(sys.argv[0]))
for name in ('check_square_boundary.sage', 'check_basic_cycles.sage', 'check_normal_form.sage'):
    load(os.path.join(directory, name))
print('RESULT: PASS even edge chain intersection')
