# 対象ラベル: claim_quadratic_positive_add_nonnegative_negative_first
# 対象行: 第一係数の負数の左乗法
# 式ペア: ap * A <= ap * ap
# 帰属: QQ と二次体の厳密計算。
from pathlib import Path
import sys
qpf_directory = Path(__file__).resolve().parent
if not (qpf_directory / '_prelude.sage').is_file():
    qpf_directory = Path(sys.argv[0]).resolve().parent
load(str(qpf_directory / '_prelude.sage'))

checked = 0
for a, b, ap, bp, A, B in qpf_cases('negative'):
    assert ap * A <= ap * ap
    checked += 1
assert checked > 0
print(f"RESULT: PASS (第一係数の負数の左乗法: {checked} cases)")
