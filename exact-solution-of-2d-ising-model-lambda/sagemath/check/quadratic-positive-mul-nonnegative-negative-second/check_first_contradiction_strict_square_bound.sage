# 対象行: 第一の場合の背理法の平方比較・2u²<a'² の正因子 2b² による保存
# 式ペア: ((2 * (b * b)) * (2 * (u * u))) < ((2 * (b * b)) * (ap * ap))
# 局所条件: b > 0 and 2 * (u * u) < ap * ap
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
    if not (b > 0 and 2 * (u * u) < ap * ap):
        continue
    assert ((2 * (b * b)) * (2 * (u * u))) < ((2 * (b * b)) * (ap * ap)), (a, b, ap, u)
    checked += 1
assert checked == 6204
print(f"RESULT: PASS (check_first_contradiction_strict_square_bound.sage: {checked} cases)")
