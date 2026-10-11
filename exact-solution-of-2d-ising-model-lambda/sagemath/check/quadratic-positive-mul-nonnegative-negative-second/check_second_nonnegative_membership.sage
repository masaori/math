# 対象行: 第二の場合で第一係数が非負の積の所属
# 関係: qpn_cone_nonnegative(qpn_rep(xi * eta, sign))
# 局所条件: qpn_domain(a, b, ap, u) and (a * a < 2 * (b * b) and 0 <= A)
# 対象ラベル: claim_quadratic_positive_mul_nonnegative_negative_second
# 帰属: QQ と二次体。浮動小数点を使わない。
from pathlib import Path
import sys
qpn_directory = Path(__file__).resolve().parent
if not (qpn_directory / '_prelude.sage').is_file():
    qpn_directory = Path(sys.argv[0]).resolve().parent
load(str(qpn_directory / '_prelude.sage'))

checked = 0
for sign, xi, eta, a, b, ap, u, bp, A, B, V, C in qpn_algebraic_cases():
    if not (a * a < 2 * (b * b) and 0 <= A):
        continue
    assert qpn_cone_nonnegative(qpn_rep(xi * eta, sign)), (sign, a, b, ap, u)
    checked += 1
assert checked == 3142
print(f"RESULT: PASS (check_second_nonnegative_membership.sage: {checked} cases)")
