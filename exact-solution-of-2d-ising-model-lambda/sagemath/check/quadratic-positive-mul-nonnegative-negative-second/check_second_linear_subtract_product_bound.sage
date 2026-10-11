# 対象行: 負の第一係数の場合の線形比較・先に得た積の比較を差の右項に適用
# 式ペア: (2 * (b * (u * ap)) - a * (ap * ap)) <= (2 * (b * (u * ap)) - a * (2 * (u * u)))
# 局所条件: 2 * (u * u) < ap * ap
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
    if not (2 * (u * u) < ap * ap):
        continue
    assert (2 * (b * (u * ap)) - a * (ap * ap)) <= (2 * (b * (u * ap)) - a * (2 * (u * u))), (a, b, ap, u)
    checked += 1
assert checked == 6768
print(f"RESULT: PASS (check_second_linear_subtract_product_bound.sage: {checked} cases)")
