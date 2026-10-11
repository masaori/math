# 対象行: 第二の場合の線形比較の平方・非負の二数の平方の大小
# 関係: (((2 * bp) * V) * ((2 * bp) * V)) <= ((c * A) * (c * A))
# 局所条件: 0 <= (2*bp)*V and (2*bp)*V <= c*A
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
    if not (0 <= (2*bp)*V and (2*bp)*V <= c*A):
        continue
    assert (((2 * bp) * V) * ((2 * bp) * V)) <= ((c * A) * (c * A)), (a, b, c, bp)
    checked += 1
assert checked == 4401
print(f"RESULT: PASS (check_second_square_square_linear_bound.sage: {checked} cases)")
