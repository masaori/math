# 対象ラベル: claim_one_sided_closure_junction_pairs
# 周期持ち上げ部分の反復同定
import os
import sys
check_directory = os.path.dirname(os.path.abspath(sys.argv[0]))
if 'junction_rows' not in globals():
    load(os.path.join(check_directory, 'construction.sage'))
count = 0
for m,n,b,c,u,v,r,x,A,V,R,X,points,independent in junction_rows:
    for j in range(c*m):
        assert A[j] == u[j % m]
        count += 1
print("PASS check_lift_repetition: {}".format(count))
