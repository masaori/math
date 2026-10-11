# 対象ラベル: claim_quadratic_positive_mul_nonnegative
# 対象行: 右入力の非零仮定
# 式ペア: ((ap, bp) != (0, 0)) == True
# 帰属: QQ の厳密計算。
from pathlib import Path
import sys
qpm_directory = Path(__file__).resolve().parent
if not (qpm_directory / '_prelude.sage').is_file():
    qpm_directory = Path(sys.argv[0]).resolve().parent
load(str(qpm_directory / '_prelude.sage'))

checked = 0
for a, b, ap, bp, A, B in qpm_cases(None):
    assert ((ap, bp) != (0, 0)) == True
    checked += 1
assert checked > 0
print(f"RESULT: PASS (check_right_truth.sage: {checked} cases)")
