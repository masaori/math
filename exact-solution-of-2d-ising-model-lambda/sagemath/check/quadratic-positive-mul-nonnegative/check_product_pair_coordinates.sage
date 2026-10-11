# 対象ラベル: claim_quadratic_positive_mul_nonnegative
# 対象行: 出力の組の等号
# 式ペア: ((A, B) != (0, 0)) == (not (A == 0 and B == 0))
# 帰属: QQ の厳密計算。
from pathlib import Path
import sys
qpm_directory = Path(__file__).resolve().parent
if not (qpm_directory / '_prelude.sage').is_file():
    qpm_directory = Path(sys.argv[0]).resolve().parent
load(str(qpm_directory / '_prelude.sage'))

checked = 0
for a, b, ap, bp, A, B in qpm_cases(None):
    assert ((A, B) != (0, 0)) == (not (A == 0 and B == 0))
    checked += 1
assert checked > 0
print(f"RESULT: PASS (check_product_pair_coordinates.sage: {checked} cases)")
