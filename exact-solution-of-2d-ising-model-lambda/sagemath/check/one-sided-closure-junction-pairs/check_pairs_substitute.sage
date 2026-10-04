# 対象ラベル: claim_one_sided_closure_junction_pairs
# 四部分の等式の端点への代入
import os
import sys
check_directory = os.path.dirname(os.path.abspath(sys.argv[0]))
if 'junction_rows' not in globals():
    load(os.path.join(check_directory, 'construction.sage'))
count = 0
for m,n,b,c,u,v,r,x,A,V,R,X,points,independent in junction_rows:
    assert junction_pairs(A,V,R,X) == (
        (u[(c*m-1) % m],v[0]),(v[b-1],r[0 % n]),
        (r[(c*n-1) % n],x[0]),(x[b-1],u[0 % m]))
    count += 1
print("PASS check_pairs_substitute: {}".format(count))
