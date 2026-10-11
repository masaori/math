# 対象ラベル: claim_qbar_determinant_fixed_points
from pathlib import Path
load(str(Path(__file__).resolve().parent / "_prelude.sage"))
count=0
for n,family,A in qdf_inputs(False):
    value=qdf_total(A,qdf_free)
    assert value+qdf_R.zero()==value
    count+=1
qdf_report("add_zero",count,35)
