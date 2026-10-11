# 対象行: 入力の反数の平方比較・u の定義
# 式ペア: (2 * (u * u)) == (2 * ((-bp) * (-bp)))
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
    assert (2 * (u * u)) == (2 * ((-bp) * (-bp))), (a, b, ap, u)
    checked += 1
assert checked == 17424
print(f"RESULT: PASS (check_input_square_substitute_negative_second.sage: {checked} cases)")
