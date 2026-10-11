# 対象ラベル: claim_qbar_determinant_fixed_points
from pathlib import Path
load(str(Path(__file__).resolve().parent / "_prelude.sage"))
count=0
# 符号と零の乗法だけを調べる。空集合の置換も含める。
for n,family,A in qdf_inputs(False):
    for sigma in qdf_permutations(n):
        assert qdf_weight(sigma)*qdf_R.zero()==qdf_R.zero()
        count+=1
qdf_report("weight_times_zero",count,4370)
