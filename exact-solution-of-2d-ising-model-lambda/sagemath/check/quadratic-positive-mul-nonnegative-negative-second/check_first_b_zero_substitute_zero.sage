# 対象行: 第一の場合の第二係数零の除外・b=0
# 式ペア: (2 * (b * u)) == (2 * (0 * u))
# 局所条件: b == 0
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
    if not (b == 0):
        continue
    assert (2 * (b * u)) == (2 * (0 * u)), (a, b, ap, u)
    checked += 1
assert checked == 1452
print(f"RESULT: PASS (check_first_b_zero_substitute_zero.sage: {checked} cases)")
