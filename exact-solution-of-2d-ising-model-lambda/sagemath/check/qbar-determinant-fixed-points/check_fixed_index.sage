# 対象ラベル: claim_qbar_determinant_fixed_points
from pathlib import Path
load(str(Path(__file__).resolve().parent / "_prelude.sage"))
count=0
# 不動点条件だけを使い、対角成分は零に制限しない。
for A,sigma,j in qdf_fixed_cases(False):
    assert sigma[j]==j
    remainder=qdf_product(A,sigma,j)
    assert A[j,sigma[j]]*remainder==A[j,j]*remainder
    count+=1
qdf_report("fixed_index",count,4365)
