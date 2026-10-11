# 対象ラベル: claim_quadratic_positive_add_nonnegative_negative_first
# 対象行: 第二係数の平方を二倍する
# 式ペア: 2 * (bp * bp) <= 2 * ((b + bp) * (b + bp))
# 帰属: QQ と二次体の厳密計算。
from pathlib import Path
import sys
qpf_directory = Path(__file__).resolve().parent
if not (qpf_directory / '_prelude.sage').is_file():
    qpf_directory = Path(sys.argv[0]).resolve().parent
load(str(qpf_directory / '_prelude.sage'))

checked = 0
for a, b, ap, bp, A, B in qpf_cases('negative'):
    assert 2 * (bp * bp) <= 2 * ((b + bp) * (b + bp))
    checked += 1
assert checked > 0
print(f"RESULT: PASS (第二係数の平方を二倍する: {checked} cases)")
