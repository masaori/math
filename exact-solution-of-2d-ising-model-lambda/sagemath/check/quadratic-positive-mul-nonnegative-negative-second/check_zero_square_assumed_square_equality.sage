# 対象行: 第二係数が零の場合の平方等号・仮定した平方の等号
# 式ペア: (a * a) == (2 * (b * b))
# 局所条件: a * a == 2 * (b * b)
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
    if not (a * a == 2 * (b * b)):
        continue
    assert (a * a) == (2 * (b * b)), (a, b, ap, u)
    checked += 1
assert checked == 121
print(f"RESULT: PASS (check_zero_square_assumed_square_equality.sage: {checked} cases)")
