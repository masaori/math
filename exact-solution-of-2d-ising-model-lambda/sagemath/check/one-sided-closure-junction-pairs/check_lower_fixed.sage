# 対象ラベル: claim_one_sided_closure_junction_pairs
# 横断逆向き列の基点不変性
import os
import sys
check_directory = os.path.dirname(os.path.abspath(sys.argv[0]))
if 'junction_rows' not in globals():
    load(os.path.join(check_directory, 'construction.sage'))
count = 0
for m,n,b,c,u,v,r,x,A,V,R,X,points,independent in junction_rows:
    for i in range(b):
        assert X[i] == x[i]
        count += 1
print("PASS check_lower_fixed: {}".format(count))
