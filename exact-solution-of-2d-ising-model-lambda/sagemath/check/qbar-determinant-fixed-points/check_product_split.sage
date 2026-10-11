# 対象ラベル: claim_qbar_determinant_fixed_points
from pathlib import Path
load(str(Path(__file__).resolve().parent / "_prelude.sage"))
count=0
# 零対角性も不動点条件も使わない行なので、非零対角を許す全行列・全添字で調べる。
for n,family,A in qdf_inputs(False):
    for sigma in qdf_permutations(n):
        for j in range(n):
            lhs=qdf_product(A,sigma)
            rhs=A[j,sigma[j]]*qdf_product(A,sigma,j)
            assert lhs==rhs,(n,family,sigma,j)
            count+=1
qdf_report("product_split",count,25195)
