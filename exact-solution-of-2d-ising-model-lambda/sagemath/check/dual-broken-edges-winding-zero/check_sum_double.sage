# 対象ラベル: claim_dual_broken_edges_winding_zero
import os
import sys
winding_directory = os.path.dirname(os.path.abspath(__file__)) if '__file__' in globals() else os.path.dirname(os.path.abspath(sys.argv[0]))
if 'winding_rows' not in globals():
    load(os.path.join(winding_directory, 'construction.sage'))
count = 0
for codes,shifted,broken in winding_rows:
    assert (sum(codes)+sum(codes)) % 2 == (2*sum(codes)) % 2
    count += 1
print("PASS check_sum_double: {}".format(count))
