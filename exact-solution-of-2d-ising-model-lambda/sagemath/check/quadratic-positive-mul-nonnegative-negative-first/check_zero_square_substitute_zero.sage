# 対象行: 平方が等しく b=0 の場合・b=0 の代入
# 関係: (2 * (b * b)) == (2 * (0 * 0))
# 局所条件: b == 0
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
    if not (b == 0):
        continue
    assert (2 * (b * b)) == (2 * (0 * 0)), (a, b, c, bp)
    checked += 1
assert checked == 1452
print(f"RESULT: PASS (check_zero_square_substitute_zero.sage: {checked} cases)")
