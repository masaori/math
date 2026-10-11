# 対象ラベル: claim_qbar_determinant_fixed_points
from pathlib import Path
load(str(Path(__file__).resolve().parent / "_prelude.sage"))
count=0
# 非零の除外項もある行列を含め、和を分ける等式自体を検算する。
for zero_diagonal in (False,True):
    for n,family,A in qdf_inputs(zero_diagonal):
        assert qdf_total(A)==qdf_total(A,qdf_free)+qdf_total(A,lambda s:not qdf_free(s))
        count+=1
qdf_report("split_permutation_sum",count,70)
