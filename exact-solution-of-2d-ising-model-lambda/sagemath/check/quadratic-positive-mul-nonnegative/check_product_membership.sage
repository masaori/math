# 対象ラベル: claim_quadratic_positive_mul_nonnegative
# 対象行: 積の正錐への所属
# 式ペア: qpm_positive(qpm_rep(xi * eta, sign))
# 帰属: QQ と二次体 の厳密計算。
from pathlib import Path
import sys
qpm_directory = Path(__file__).resolve().parent
if not (qpm_directory / '_prelude.sage').is_file():
    qpm_directory = Path(sys.argv[0]).resolve().parent
load(str(qpm_directory / '_prelude.sage'))

checked = 0
for sign, xi, eta, a, b, ap, bp, A, B in qpm_algebraic_cases():
    assert qpm_positive(qpm_rep(xi * eta, sign))
    checked += 1
assert checked > 0
print(f"RESULT: PASS (check_product_membership.sage: {checked} cases)")
