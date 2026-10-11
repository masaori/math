# 対象ラベル: claim_qbar_determinant_fixed_points
from pathlib import Path
load(str(Path(__file__).resolve().parent / "_prelude.sage"))
count=0
# 零の乗法そのものには零対角性が不要なので、残余積が非零の場合も含める。
for A,sigma,j in qdf_fixed_cases(False):
    remainder=qdf_product(A,sigma,j)
    assert qdf_R.zero()*remainder==qdf_R.zero()
    count+=1
qdf_report("zero_times_remainder",count,4365)
