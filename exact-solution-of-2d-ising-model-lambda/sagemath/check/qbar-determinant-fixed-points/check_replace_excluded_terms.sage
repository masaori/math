# 対象ラベル: claim_qbar_determinant_fixed_points
from pathlib import Path
load(str(Path(__file__).resolve().parent / "_prelude.sage"))
count=0
for n,family,A in qdf_inputs(True):
    excluded=tuple(s for s in qdf_permutations(n) if not qdf_free(s))
    assert all(qdf_term(A,s)==0 for s in excluded)
    lhs=qdf_total(A,qdf_free)+sum((qdf_term(A,s) for s in excluded),qdf_R.zero())
    rhs=qdf_total(A,qdf_free)+sum((qdf_R.zero() for s in excluded),qdf_R.zero())
    assert lhs==rhs
    count+=1
qdf_report("replace_excluded_terms",count,35)
