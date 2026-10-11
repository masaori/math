# 対象ラベル: claim_quadratic_positive_add_mixed_signs
# 対象行: 和の表示
# 式ペア: qpm_rep(xi + eta, sign) == (A, B)
# 帰属: QQ と二次体の厳密計算。浮動小数点を使わない。
from pathlib import Path
import sys
qpm_directory = Path(__file__).resolve().parent
if not (qpm_directory / '_prelude.sage').is_file():
    qpm_directory = Path(sys.argv[0]).resolve().parent
load(str(qpm_directory / '_prelude.sage'))

checked = 0
for sign, xi, eta, a, b, ap, bp, c, u, A, B, U, C in qpm_algebraic_cases("all"):
    assert qpm_rep(xi + eta, sign) == (A, B)
    checked += 1
assert checked == 134616
print(f"RESULT: PASS (和の表示: {checked} cases)")
