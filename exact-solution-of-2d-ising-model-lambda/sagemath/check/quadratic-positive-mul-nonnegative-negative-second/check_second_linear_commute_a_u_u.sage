# 対象行: 負の第一係数の場合の線形比較・可換則
# 式ペア: ((2 * u) * (b * ap) - 2 * ((a * u) * u)) == ((2 * u) * (b * ap) - 2 * (u * (a * u)))
# 局所条件: True
# 対象ラベル: claim_quadratic_positive_mul_nonnegative_negative_second
# 帰属: QQ と二次体。浮動小数点を使わない。
from pathlib import Path
import sys
qpn_directory = Path(__file__).resolve().parent
if not (qpn_directory / '_prelude.sage').is_file():
    qpn_directory = Path(sys.argv[0]).resolve().parent
load(str(qpn_directory / '_prelude.sage'))

checked = 0
for a, b, ap, u, bp, A, B, V, C in qpn_cases():
    assert ((2 * u) * (b * ap) - 2 * ((a * u) * u)) == ((2 * u) * (b * ap) - 2 * (u * (a * u))), (a, b, ap, u)
    checked += 1
assert checked == 17424
print(f"RESULT: PASS (check_second_linear_commute_a_u_u.sage: {checked} cases)")
