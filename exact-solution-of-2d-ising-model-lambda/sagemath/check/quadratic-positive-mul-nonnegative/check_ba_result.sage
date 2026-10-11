# 対象ラベル: claim_quadratic_positive_mul_nonnegative
# 対象行: 第二の交差積が正の場合の表示への置換
# 式ペア: a * bp + b * ap == B
# 帰属: QQ の厳密計算。
from pathlib import Path
import sys
qpm_directory = Path(__file__).resolve().parent
if not (qpm_directory / '_prelude.sage').is_file():
    qpm_directory = Path(sys.argv[0]).resolve().parent
load(str(qpm_directory / '_prelude.sage'))

checked = 0
for a, b, ap, bp, A, B in qpm_cases('ba'):
    assert a * bp + b * ap == B
    checked += 1
assert checked > 0
print(f"RESULT: PASS (check_ba_result.sage: {checked} cases)")
