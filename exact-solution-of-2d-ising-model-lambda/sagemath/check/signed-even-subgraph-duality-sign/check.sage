import os
import sys

directory = os.path.dirname(os.path.abspath(sys.argv[0]))
load(os.path.join(directory, 'check_critical_mode_nonzero.sage'))
load(os.path.join(directory, 'check_nontrivial_sign.sage'))
load(os.path.join(directory, 'check_untwisted_sign.sage'))
print('RESULT: PASS signed even subgraph duality sign')
