# 対象行: 入力の反数の平方比較・負の第二係数条件
# 式ペア: (2 * bp * bp) < (ap * ap)
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
    assert (2 * bp * bp) < (ap * ap), (a, b, ap, u)
    checked += 1
assert checked == 6768
print(f"RESULT: PASS (check_input_square_strict_input_bound.sage: {checked} cases)")
