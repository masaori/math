# 対象ラベル: claim_one_sided_closure_junction_pairs
# 平行帰路の反復同定
import os
import sys
check_directory = os.path.dirname(os.path.abspath(sys.argv[0]))
if 'junction_rows' not in globals():
    load(os.path.join(check_directory, 'construction.sage'))
count = 0
for m,n,b,c,u,v,r,x,A,V,R,X,points,independent in junction_rows:
    for s in range(c*n):
        assert R[s] == r[s % n]
        count += 1
print("PASS check_return_repetition: {}".format(count))
