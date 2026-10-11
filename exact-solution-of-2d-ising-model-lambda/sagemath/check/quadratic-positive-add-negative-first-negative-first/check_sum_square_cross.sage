# 対象ラベル: claim_quadratic_positive_add_negative_first_negative_first
# 対象行: 和の平方比較・交差項を置換
# 式ペア: 2 * (b * b) + 2 * (a * ap) + ap * ap < 2 * (b * b) + 2 * (2 * (b * bp)) + ap * ap
# 帰属: QQ の厳密計算。
from pathlib import Path
import sys
qpf_directory = Path(__file__).resolve().parent
if not (qpf_directory / '_prelude.sage').is_file():
    qpf_directory = Path(sys.argv[0]).resolve().parent
load(str(qpf_directory / '_prelude.sage'))

checked = 0
for a, b, ap, bp, A, B in qpf_cases():
    assert 2 * (b * b) + 2 * (a * ap) + ap * ap < 2 * (b * b) + 2 * (2 * (b * bp)) + ap * ap
    checked += 1
assert checked == 99856
print(f"RESULT: PASS (和の平方比較・交差項を置換: {checked} cases)")
