# 対象ラベル: claim_quadratic_positive_add_nonnegative_negative_second
# 対象行: 和の表示
# 式ペア: rep_s(xi+eta) = (a+ap,B)
# 帰属: QQ と二次体の厳密計算。
from pathlib import Path
import sys
qps_directory = Path(__file__).resolve().parent
if not (qps_directory / '_prelude.sage').is_file():
    qps_directory = Path(sys.argv[0]).resolve().parent
load(str(qps_directory / '_prelude.sage'))

checked = 0
for sign, xi, eta, a, b, ap, bp, A, B in qps_algebraic_cases(None):
    assert qps_rep(xi + eta, sign) == (a + ap, B)
    checked += 1
assert checked > 0
print(f'RESULT: PASS (和の表示: {checked} cases)')
