# 対象行: 第二の場合の線形比較の平方・正数を掛けると狭義不等号を保つ
# 関係: ((c * c) * (A * A)) < ((2 * (bp * bp)) * (A * A))
# 局所条件: c*c < 2*(bp*bp) and 0 < A
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
    if not (c*c < 2*(bp*bp) and 0 < A):
        continue
    assert ((c * c) * (A * A)) < ((2 * (bp * bp)) * (A * A)), (a, b, c, bp)
    checked += 1
assert checked == 8197
print(f"RESULT: PASS (check_second_square_strict_square_bound.sage: {checked} cases)")
