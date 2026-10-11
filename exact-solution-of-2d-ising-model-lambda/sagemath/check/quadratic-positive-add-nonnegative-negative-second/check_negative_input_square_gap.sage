# 対象ラベル: claim_quadratic_positive_add_nonnegative_negative_second
# 対象行: 入力の負の第二係数条件
# 式ペア: 2*(bp*bp) < ap*ap
# 帰属: QQ と二次体の厳密計算。
from pathlib import Path
import sys
qps_directory = Path(__file__).resolve().parent
if not (qps_directory / '_prelude.sage').is_file():
    qps_directory = Path(sys.argv[0]).resolve().parent
load(str(qps_directory / '_prelude.sage'))

checked = 0
for a, b, ap, bp, A, B in qps_cases('negative'):
    assert 2 * (bp * bp) < ap * ap
    checked += 1
assert checked > 0
print(f'RESULT: PASS (入力の負の第二係数条件: {checked} cases)')
