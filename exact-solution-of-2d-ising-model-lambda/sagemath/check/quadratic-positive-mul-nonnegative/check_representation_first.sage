# 対象ラベル: claim_quadratic_positive_mul_nonnegative
# 対象行: 積の第一係数の表示
# 式ペア: qpm_rep(xi * eta, sign)[0] == a * ap + 2 * (b * bp)
# 帰属: QQ と二次体 の厳密計算。
from pathlib import Path
import sys
qpm_directory = Path(__file__).resolve().parent
if not (qpm_directory / '_prelude.sage').is_file():
    qpm_directory = Path(sys.argv[0]).resolve().parent
load(str(qpm_directory / '_prelude.sage'))

checked = 0
for sign, xi, eta, a, b, ap, bp, A, B in qpm_algebraic_cases():
    assert qpm_rep(xi * eta, sign)[0] == a * ap + 2 * (b * bp)
    checked += 1
assert checked > 0
print(f"RESULT: PASS (check_representation_first.sage: {checked} cases)")
