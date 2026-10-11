# 対象ラベル: claim_quadratic_positive_add_negative_second_negative_second
# 対象行: 第二係数の符号・加法の狭義単調性
# 式ペア: b + bp < QQ(0) + QQ(0)
# 帰属: QQの厳密計算。
from pathlib import Path
import sys
qps_directory = Path(__file__).resolve().parent
if not (qps_directory / '_prelude.sage').is_file():
    qps_directory = Path(sys.argv[0]).resolve().parent
load(str(qps_directory / '_prelude.sage'))

checked = 0
for a, b, ap, bp, A, B in qps_cases():
    assert b + bp < QQ(0) + QQ(0)
    checked += 1
assert checked == 45369
print(f"RESULT: PASS (第二係数の符号・加法の狭義単調性: {checked} cases)")

