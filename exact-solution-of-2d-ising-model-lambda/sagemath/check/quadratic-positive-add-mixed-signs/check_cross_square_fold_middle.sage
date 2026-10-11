# 対象ラベル: claim_quadratic_positive_add_mixed_signs
# 対象行: 右交差積の内側の因子を交換
# 式ペア: (a*(a*bp))*bp == (a*(bp*a))*bp
# 帰属: QQ の厳密計算。浮動小数点を使わない。
from pathlib import Path
import sys
qpm_directory = Path(__file__).resolve().parent
if not (qpm_directory / '_prelude.sage').is_file():
    qpm_directory = Path(sys.argv[0]).resolve().parent
load(str(qpm_directory / '_prelude.sage'))

checked = 0
for a, b, ap, bp, c, u, A, B, U, C in qpm_cases("all"):
    assert (a*(a*bp))*bp == (a*(bp*a))*bp
    checked += 1
assert checked == 67308
print(f"RESULT: PASS (右交差積の内側の因子を交換: {checked} cases)")
