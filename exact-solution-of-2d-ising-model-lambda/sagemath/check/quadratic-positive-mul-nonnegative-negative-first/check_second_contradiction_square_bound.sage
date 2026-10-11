# 対象行: 第二の場合の背理法の平方比較・非負の二数の平方の大小
# 関係: ((2 * (b * bp)) * (2 * (b * bp))) <= ((a * c) * (a * c))
# 局所条件: 2*(b*bp) <= a*c
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
    if not (2*(b*bp) <= a*c):
        continue
    assert ((2 * (b * bp)) * (2 * (b * bp))) <= ((a * c) * (a * c)), (a, b, c, bp)
    checked += 1
assert checked == 6803
print(f"RESULT: PASS (check_second_contradiction_square_bound.sage: {checked} cases)")
