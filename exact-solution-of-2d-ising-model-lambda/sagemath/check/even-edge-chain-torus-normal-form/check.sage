import os
import sys
directory = os.path.dirname(os.path.abspath(sys.argv[0]))
for name in ('check_vertical_reduction.sage', 'check_horizontal_reduction.sage', 'check_chain_reconstruction.sage'):
    load(os.path.join(directory, name))
print('RESULT: PASS even edge chain torus normal form')
