# 対象ラベル: claim_quadratic_positive_add_negative_second_negative_second
# 対象行: 交差項の左辺の正値性
# 式ペア: 0 < 2 * (b * bp)
# 帰属: QQの厳密計算。
from pathlib import Path
import sys
qps_directory = Path(__file__).resolve().parent
if not (qps_directory / '_prelude.sage').is_file():
    qps_directory = Path(sys.argv[0]).resolve().parent
load(str(qps_directory / '_prelude.sage'))

checked = 0
for a, b, ap, bp, A, B in qps_cases():
    assert 0 < 2 * (b * bp)
    checked += 1
assert checked == 45369
print(f"RESULT: PASS (交差項の左辺の正値性: {checked} cases)")

