# 対象ラベル: claim_quadratic_positive_add_nonnegative_negative_second
# 対象行: 第二係数の和の別名
# 式ペア: b+bp = B
# 帰属: QQ と二次体の厳密計算。
from pathlib import Path
import sys
qps_directory = Path(__file__).resolve().parent
if not (qps_directory / '_prelude.sage').is_file():
    qps_directory = Path(sys.argv[0]).resolve().parent
load(str(qps_directory / '_prelude.sage'))

checked = 0
for a, b, ap, bp, A, B in qps_cases('negative'):
    assert b + bp == B
    checked += 1
assert checked > 0
print(f'RESULT: PASS (第二係数の和の別名: {checked} cases)')
