# 対象ラベル: claim_quadratic_positive_add_mixed_signs
# 対象行: 負の第二係数の大きさの正値
# 式ペア: 0 < U
# 帰属: QQ と二次体の厳密計算。浮動小数点を使わない。
from pathlib import Path
import sys
qpm_directory = Path(__file__).resolve().parent
if not (qpm_directory / '_prelude.sage').is_file():
    qpm_directory = Path(sys.argv[0]).resolve().parent
load(str(qpm_directory / '_prelude.sage'))

checked = 0
for a, b, ap, bp, c, u, A, B, U, C in qpm_cases("second"):
    assert 0 < U
    checked += 1
assert checked == 10182
print(f"RESULT: PASS (負の第二係数の大きさの正値: {checked} cases)")
