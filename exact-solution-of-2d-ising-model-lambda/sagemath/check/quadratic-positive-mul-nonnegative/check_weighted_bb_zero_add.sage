# 対象ラベル: claim_quadratic_positive_mul_nonnegative
# 対象行: 第二係数積の二倍の左への零の加算
# 式ペア: 2 * (b * bp) == 0 + 2 * (b * bp)
# 帰属: QQ の厳密計算。
from pathlib import Path
import sys
qpm_directory = Path(__file__).resolve().parent
if not (qpm_directory / '_prelude.sage').is_file():
    qpm_directory = Path(sys.argv[0]).resolve().parent
load(str(qpm_directory / '_prelude.sage'))

checked = 0
for a, b, ap, bp, A, B in qpm_cases('bb'):
    assert 2 * (b * bp) == 0 + 2 * (b * bp)
    checked += 1
assert checked > 0
print(f"RESULT: PASS (check_weighted_bb_zero_add.sage: {checked} cases)")
