# 対象ラベル: claim_qbar_determinant_fixed_points
from pathlib import Path
load(str(Path(__file__).resolve().parent / "_prelude.sage"))
count=0
for n,family,A in qdf_inputs(True):
    for sigma in qdf_permutations(n):
        if not qdf_free(sigma):
            value=qdf_product(A,sigma)
            assert value==0
            assert qdf_weight(sigma)*value==qdf_weight(sigma)*qdf_R.zero()
            count+=1
qdf_report("substitute_zero_product",count,2760)
