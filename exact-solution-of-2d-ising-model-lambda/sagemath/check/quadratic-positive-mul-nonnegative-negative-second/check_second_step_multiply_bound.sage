# 対象行: 第一係数を掛けた平方比較・非負因子 a による比較の保存
# 式ペア: (a * (2 * (u * u))) <= (a * (ap * ap))
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
    assert (a * (2 * (u * u))) <= (a * (ap * ap)), (a, b, ap, u)
    checked += 1
assert checked == 6768
print(f"RESULT: PASS (check_second_step_multiply_bound.sage: {checked} cases)")
