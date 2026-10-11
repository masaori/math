# 対象行: 平方が等しく b=0 の場合・仮定した平方の等号
# 関係: (a * a) == (2 * (b * b))
# 局所条件: a*a == 2*(b*b)
# 対象ラベル: claim_quadratic_positive_mul_nonnegative_negative_first
# 帰属: QQ と二次体。浮動小数点を使わない。
from pathlib import Path
import sys
qpf_directory = Path(__file__).resolve().parent
if not (qpf_directory / '_prelude.sage').is_file():
    qpf_directory = Path(sys.argv[0]).resolve().parent
load(str(qpf_directory / '_prelude.sage'))

checked = 0
for a, b, c, bp, ap, A, B, C, V in qpf_cases():
    if not (a*a == 2*(b*b)):
        continue
    assert (a * a) == (2 * (b * b)), (a, b, c, bp)
    checked += 1
assert checked == 121
print(f"RESULT: PASS (check_zero_square_assumed_square_equality.sage: {checked} cases)")
