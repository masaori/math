# 対象行: 負の第二係数の場合の線形比較・分配則
# 式ペア: (ap * (a * u - b * ap)) == (ap * (a * u) - ap * (b * ap))
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
    assert (ap * (a * u - b * ap)) == (ap * (a * u) - ap * (b * ap)), (a, b, ap, u)
    checked += 1
assert checked == 17424
print(f"RESULT: PASS (check_first_linear_distribute_left_factor.sage: {checked} cases)")
