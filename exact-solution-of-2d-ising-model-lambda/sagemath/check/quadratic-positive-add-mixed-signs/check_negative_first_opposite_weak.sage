# 対象ラベル: claim_quadratic_positive_add_mixed_signs
# 対象行: 第一係数が負の場合の反対向きの広義比較
# 式ペア: c*bp <= c*u
# 帰属: QQ と二次体の厳密計算。浮動小数点を使わない。
from pathlib import Path
import sys
qpm_directory = Path(__file__).resolve().parent
if not (qpm_directory / '_prelude.sage').is_file():
    qpm_directory = Path(sys.argv[0]).resolve().parent
load(str(qpm_directory / '_prelude.sage'))

checked = 0
for a, b, ap, bp, c, u, A, B, U, C in qpm_cases("aux_nonpositive_second"):
    assert c*bp <= c*u
    checked += 1
assert checked == 60
print(f"RESULT: PASS (第一係数が負の場合の反対向きの広義比較: {checked} cases)")
