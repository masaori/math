# 対象行: 第一の場合の負の第一係数条件・正因子 b′b′ の消去
# 関係: (C * C) < (2 * (B * B))
# 局所条件: (bp*bp)*(C*C) < (bp*bp)*(2*(B*B))
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
    if not ((bp*bp)*(C*C) < (bp*bp)*(2*(B*B))):
        continue
    assert (C * C) < (2 * (B * B)), (a, b, c, bp)
    checked += 1
assert checked == 8287
print(f"RESULT: PASS (check_first_final_cancel_positive_factor.sage: {checked} cases)")
