# 対象ラベル: claim_dual_broken_edges_winding_zero
import os
import sys
winding_entry = sys.argv[0] if sys.argv[0].endswith('.sage') else __file__
winding_directory = os.path.dirname(os.path.abspath(winding_entry))
if 'winding_rows' not in globals():
    load(os.path.join(winding_directory, 'construction.sage'))
count = 0
for codes,shifted,broken in winding_rows:
    assert sum(broken) % 2 == sum((a+b) % 2 for a,b in zip(codes,shifted)) % 2
    count += 1
print("PASS check_encoding_substitution: {}".format(count))
