# 対象行: 第一の場合の線形比較・同じ数から引くと不等号が逆向きになる
# 関係: (a * (c * bp) - b * (2 * (bp * bp))) <= (a * (c * bp) - b * (c * c))
# 局所条件: c*c < 2*(bp*bp)
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
    if not (c*c < 2*(bp*bp)):
        continue
    assert (a * (c * bp) - b * (2 * (bp * bp))) <= (a * (c * bp) - b * (c * c)), (a, b, c, bp)
    checked += 1
assert checked == 10656
print(f"RESULT: PASS (check_first_linear_subtract_product_bound.sage: {checked} cases)")
