# 対象ラベル: claim_one_sided_closure_junction_pairs
# 整数倍の除去
import os
import sys
check_directory = os.path.dirname(os.path.abspath(sys.argv[0]))
if 'junction_rows' not in globals():
    load(os.path.join(check_directory, 'construction.sage'))
count = 0
for m,n,b,c,u,v,r,x,A,V,R,X,points,independent in junction_rows:
    for h in (m,n):
        assert ((c-1)*h+(h-1)) % h == (h-1) % h
        count += 1
print("PASS check_last_period_remove: {}".format(count))
