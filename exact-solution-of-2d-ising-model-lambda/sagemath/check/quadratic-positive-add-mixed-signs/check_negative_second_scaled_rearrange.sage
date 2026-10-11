# 対象ラベル: claim_quadratic_positive_add_mixed_signs
# 対象行: 第二条件の重み付き平方の括弧を移す
# 式ペア: (u*u)*(2*(U*U)) == ((u*u)*2)*(U*U)
# 帰属: QQ の厳密計算。浮動小数点を使わない。
from pathlib import Path
import sys
qpm_directory = Path(__file__).resolve().parent
if not (qpm_directory / '_prelude.sage').is_file():
    qpm_directory = Path(sys.argv[0]).resolve().parent
load(str(qpm_directory / '_prelude.sage'))

checked = 0
for a, b, ap, bp, c, u, A, B, U, C in qpm_cases("second"):
    assert (u*u)*(2*(U*U)) == ((u*u)*2)*(U*U)
    checked += 1
assert checked == 10182
print(f"RESULT: PASS (第二条件の重み付き平方の括弧を移す: {checked} cases)")
