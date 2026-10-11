# 対象行: 第一の場合の負の第一係数条件・C の定義
# 関係: ((-A) * (-A)) == (C * C)
# 局所条件: True
# 対象ラベル: claim_quadratic_positive_mul_nonnegative_negative_first
# 帰属: QQ と二次体。浮動小数点を使わない。
from pathlib import Path
import sys
qpf_directory = Path(__file__).resolve().parent
if not (qpf_directory / '_prelude.sage').is_file():
    qpf_directory = Path(sys.argv[0]).resolve().parent
load(str(qpf_directory / '_prelude.sage'))

checked = 0
for a, b, c, bp, ap, A, B, C, V in qpf_cases():
    if not (True):
        continue
    assert ((-A) * (-A)) == (C * C), (a, b, c, bp)
    checked += 1
assert checked == 17424
print(f"RESULT: PASS (check_first_final_substitute_negative_first.sage: {checked} cases)")
