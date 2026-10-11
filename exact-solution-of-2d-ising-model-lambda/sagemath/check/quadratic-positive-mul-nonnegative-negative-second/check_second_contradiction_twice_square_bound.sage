# 対象行: 第二の場合の背理法の平方比較・先に得た平方比較を非負因子 2 で乗算
# 式ペア: (2 * ((b * ap) * (b * ap))) <= (2 * ((a * u) * (a * u)))
# 局所条件: (b * ap) * (b * ap) <= (a * u) * (a * u)
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
    if not ((b * ap) * (b * ap) <= (a * u) * (a * u)):
        continue
    assert (2 * ((b * ap) * (b * ap))) <= (2 * ((a * u) * (a * u))), (a, b, ap, u)
    checked += 1
assert checked == 9094
print(f"RESULT: PASS (check_second_contradiction_twice_square_bound.sage: {checked} cases)")
