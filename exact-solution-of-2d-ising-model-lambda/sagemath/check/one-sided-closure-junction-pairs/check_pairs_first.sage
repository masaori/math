# 対象ラベル: claim_one_sided_closure_junction_pairs
# 先頭の余りの評価
import os
import sys
check_directory = os.path.dirname(os.path.abspath(sys.argv[0]))
if 'junction_rows' not in globals():
    load(os.path.join(check_directory, 'construction.sage'))
count = 0
for m,n,b,c,u,v,r,x,A,V,R,X,points,independent in junction_rows:
    assert ((u[m-1],v[0]),(v[b-1],r[0 % n]),
            (r[n-1],x[0]),(x[b-1],u[0 % m])) == junction_pairs(u,v,r,x)
    count += 1
print("PASS check_pairs_first: {}".format(count))
