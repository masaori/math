# 対象ラベル: claim_quadratic_positive_add_negative_first_negative_first
# 対象行: 正の第二係数の積の正値性
# 式ペア: 0 < b * bp
# 帰属: QQ の厳密計算。
from pathlib import Path
import sys
qpf_directory = Path(__file__).resolve().parent
if not (qpf_directory / '_prelude.sage').is_file():
    qpf_directory = Path(sys.argv[0]).resolve().parent
load(str(qpf_directory / '_prelude.sage'))

checked = 0
for a, b, ap, bp, A, B in qpf_cases():
    assert 0 < b * bp
    checked += 1
assert checked == 99856
print(f"RESULT: PASS (正の第二係数の積の正値性: {checked} cases)")
