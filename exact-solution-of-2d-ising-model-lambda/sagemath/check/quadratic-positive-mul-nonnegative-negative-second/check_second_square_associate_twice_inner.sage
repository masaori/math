# 対象行: 負の第一係数の場合の平方比較・結合則
# 式ペア: (2 * ((u * B) * (2 * (u * B)))) == (2 * (((u * B) * 2) * (u * B)))
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
    assert (2 * ((u * B) * (2 * (u * B)))) == (2 * (((u * B) * 2) * (u * B))), (a, b, ap, u)
    checked += 1
assert checked == 17424
print(f"RESULT: PASS (check_second_square_associate_twice_inner.sage: {checked} cases)")
