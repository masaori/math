import os
import sys
load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), '_prelude.sage'))
assert (1 + x^2)^2 - x*(1 - x^2)*mode_sum - (x^2 + 2*x - 1)^2 == 4*x*(1 - x^2) - x*(1 - x^2)*mode_sum
print('RESULT: PASS square difference')
