# 対象行: 負の第一係数条件の正因子消去・正因子 a'² の消去
# 式ペア: (C * C) < (2 * (B * B))
# 局所条件: (ap * ap) * (C * C) < (ap * ap) * (2 * (B * B))
# 対象ラベル: claim_quadratic_positive_mul_nonnegative_negative_second
# 帰属: QQ と二次体。浮動小数点を使わない。
from pathlib import Path
import sys
qpn_directory = Path(__file__).resolve().parent
if not (qpn_directory / '_prelude.sage').is_file():
    qpn_directory = Path(sys.argv[0]).resolve().parent
load(str(qpn_directory / '_prelude.sage'))

checked = 0
for a, b, ap, u, bp, A, B, V, C in qpn_cases():
    if not ((ap * ap) * (C * C) < (ap * ap) * (2 * (B * B))):
        continue
    assert (C * C) < (2 * (B * B)), (a, b, ap, u)
    checked += 1
assert checked == 8287
print(f"RESULT: PASS (check_second_final_cancel_positive_factor.sage: {checked} cases)")
