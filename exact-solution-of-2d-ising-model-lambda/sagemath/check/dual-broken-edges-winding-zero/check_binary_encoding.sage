# 対象ラベル: claim_dual_broken_edges_winding_zero
import os
import sys
winding_directory = os.path.dirname(os.path.abspath(__file__)) if '__file__' in globals() else os.path.dirname(os.path.abspath(sys.argv[0]))
if 'winding_rows' not in globals():
    load(os.path.join(winding_directory, 'construction.sage'))
count = 0
for left,right in product((1,-1), repeat=2):
    assert ZZ(left != right) == (ZZ(left == -1)+ZZ(right == -1)) % 2
    count += 1
print("PASS check_binary_encoding: {}".format(count))
