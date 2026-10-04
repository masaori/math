# 対象ラベル: claim_one_sided_closure_junction_pairs
# 独立に構成した閉点列の四接合
import os
import sys
check_directory = os.path.dirname(os.path.abspath(sys.argv[0]))
if 'junction_rows' not in globals():
    load(os.path.join(check_directory, 'construction.sage'))
count = 0
for m,n,b,c,u,v,r,x,A,V,R,X,points,independent in junction_rows:
    assert points == independent
    assert independent[0] == independent[-1]
    steps = adjacent_steps(independent)
    cuts = (c*m,c*m+b,c*m+b+c*n,len(steps))
    pairs = tuple((steps[k-1],steps[k % len(steps)]) for k in cuts)
    assert pairs == junction_pairs(u,v,r,x)
    count += 1
print("PASS check_whole_closure: {}".format(count))
