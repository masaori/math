# 対象ラベル: claim_quadratic_positive_add_mixed_signs
# 対象行: 交差積の二つの平方因子を交換
# 式ペア: 2*((bp*bp)*(u*u)) == 2*((u*u)*(bp*bp))
# 帰属: QQ の厳密計算。浮動小数点を使わない。
from pathlib import Path
import sys
qpm_directory = Path(__file__).resolve().parent
if not (qpm_directory / '_prelude.sage').is_file():
    qpm_directory = Path(sys.argv[0]).resolve().parent
load(str(qpm_directory / '_prelude.sage'))

checked = 0
for a, b, ap, bp, c, u, A, B, U, C in qpm_cases("all"):
    assert 2*((bp*bp)*(u*u)) == 2*((u*u)*(bp*bp))
    checked += 1
assert checked == 67308
print(f"RESULT: PASS (交差積の二つの平方因子を交換: {checked} cases)")
