# 対象行: 第一の場合の背理法の平方比較・可換則
# 式ペア: (2 * (2 * (b * ((u * b) * u)))) == (2 * (2 * (b * ((b * u) * u))))
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
    assert (2 * (2 * (b * ((u * b) * u)))) == (2 * (2 * (b * ((b * u) * u)))), (a, b, ap, u)
    checked += 1
assert checked == 17424
print(f"RESULT: PASS (check_first_contradiction_commute_b_middle.sage: {checked} cases)")
