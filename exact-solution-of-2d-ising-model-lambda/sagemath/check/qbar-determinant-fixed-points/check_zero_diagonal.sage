# 対象ラベル: claim_qbar_determinant_fixed_points
from pathlib import Path
load(str(Path(__file__).resolve().parent / "_prelude.sage"))
count=0
for A,sigma,j in qdf_fixed_cases(True):
    assert A[j,j]==0
    remainder=qdf_product(A,sigma,j)
    assert A[j,j]*remainder==qdf_R.zero()*remainder
    count+=1
qdf_report("zero_diagonal",count,4365)
