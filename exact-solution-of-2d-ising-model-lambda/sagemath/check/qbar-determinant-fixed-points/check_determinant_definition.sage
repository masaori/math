# 対象ラベル: claim_qbar_determinant_fixed_points
from pathlib import Path
load(str(Path(__file__).resolve().parent / "_prelude.sage"))
count=0
# SageMath の行列式と、転倒数を自分で数えた行指定の置換和を比較する。
for zero_diagonal in (False,True):
    for n,family,A in qdf_inputs(zero_diagonal):
        assert A.det()==qdf_total(A),(zero_diagonal,n,family)
        count+=1
qdf_report("determinant_definition",count,70)
