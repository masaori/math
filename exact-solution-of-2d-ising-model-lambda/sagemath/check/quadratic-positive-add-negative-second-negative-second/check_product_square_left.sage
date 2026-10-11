# 対象ラベル: claim_quadratic_positive_add_negative_second_negative_second
# 対象行: 積の平方比較・第一条件を右乗法で拡大
# 式ペア: (2 * (b * b)) * (2 * (bp * bp)) < (a * a) * (2 * (bp * bp))
# 帰属: QQの厳密計算。
from pathlib import Path
import sys
qps_directory = Path(__file__).resolve().parent
if not (qps_directory / '_prelude.sage').is_file():
    qps_directory = Path(sys.argv[0]).resolve().parent
load(str(qps_directory / '_prelude.sage'))

checked = 0
for a, b, ap, bp, A, B in qps_cases():
    assert (2 * (b * b)) * (2 * (bp * bp)) < (a * a) * (2 * (bp * bp))
    checked += 1
assert checked == 45369
print(f"RESULT: PASS (積の平方比較・第一条件を右乗法で拡大: {checked} cases)")

