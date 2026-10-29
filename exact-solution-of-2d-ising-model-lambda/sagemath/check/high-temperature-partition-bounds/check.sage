import os
import sys

directory = os.path.dirname(os.path.abspath(sys.argv[0]))
load(os.path.join(directory, 'check_dual_point.sage'))
load(os.path.join(directory, 'check_lower_bound.sage'))
load(os.path.join(directory, 'check_upper_bound.sage'))
print('RESULT: PASS high-temperature partition bounds')
