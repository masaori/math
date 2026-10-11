# 対象ラベル: claim_quadratic_positive_add_nonnegative_negative_second
# 対象行: 非負分岐の第一係数の非負性
# 式ペア: 0 <= a+ap
# 帰属: QQ と二次体の厳密計算。
from pathlib import Path
import sys
qps_directory = Path(__file__).resolve().parent
if not (qps_directory / '_prelude.sage').is_file():
    qps_directory = Path(sys.argv[0]).resolve().parent
load(str(qps_directory / '_prelude.sage'))

checked = 0
for a, b, ap, bp, A, B in qps_cases('nonnegative'):
    assert 0 <= A
    checked += 1
assert checked > 0
print(f'RESULT: PASS (非負分岐の第一係数の非負性: {checked} cases)')
