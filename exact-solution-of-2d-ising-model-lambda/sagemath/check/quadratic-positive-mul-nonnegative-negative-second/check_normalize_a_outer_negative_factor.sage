# 対象行: 第一係数の表示の整理・右因子の負号
# 式ペア: (a * ap + 2 * (-(b * u))) == (a * ap + (-(2 * (b * u))))
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
    assert (a * ap + 2 * (-(b * u))) == (a * ap + (-(2 * (b * u)))), (a, b, ap, u)
    checked += 1
assert checked == 17424
print(f"RESULT: PASS (check_normalize_a_outer_negative_factor.sage: {checked} cases)")
