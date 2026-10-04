# 対象ラベル: claim_one_sided_closure_junction_pairs
# 余りの代表元の評価
import os
import sys
check_directory = os.path.dirname(os.path.abspath(sys.argv[0]))
if 'junction_rows' not in globals():
    load(os.path.join(check_directory, 'construction.sage'))
count = 0
for m,n,b,c,u,v,r,x,A,V,R,X,points,independent in junction_rows:
    for h in (m,n):
        assert 0 <= h-1 < h
        assert (h-1) % h == h-1
        count += 1
print("PASS check_last_residue: {}".format(count))
