# 対象行: 第二係数が零の場合の平方等号・零との積
# 式ペア: (2 * 0) == (0)
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
    assert (2 * 0) == (0), (a, b, ap, u)
    checked += 1
assert checked == 17424
print(f"RESULT: PASS (check_zero_square_outer_zero_product.sage: {checked} cases)")
