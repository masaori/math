# 対象ラベル: claim_qbar_determinant_fixed_points
from pathlib import Path
load(str(Path(__file__).resolve().parent / "_prelude.sage"))
count=0
for n,family,A in qdf_inputs(False):
    excluded=tuple(s for s in qdf_permutations(n) if not qdf_free(s))
    lhs=qdf_total(A,qdf_free)+sum((qdf_R.zero() for s in excluded),qdf_R.zero())
    assert lhs==qdf_total(A,qdf_free)+qdf_R.zero()
    count+=1
qdf_report("sum_of_zeros",count,35)
