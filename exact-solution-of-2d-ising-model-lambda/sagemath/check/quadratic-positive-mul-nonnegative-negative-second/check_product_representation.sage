# 対象行: 積の二次体での表示
# 関係: qpn_rep(xi * eta, sign) == (a * ap + 2 * (b * bp), a * bp + b * ap)
# 局所条件: qpn_domain(a, b, ap, u) and (True)
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
    assert qpn_rep(xi * eta, sign) == (a * ap + 2 * (b * bp), a * bp + b * ap), (sign, a, b, ap, u)
    checked += 1
assert checked == 13442
print(f"RESULT: PASS (check_product_representation.sage: {checked} cases)")
