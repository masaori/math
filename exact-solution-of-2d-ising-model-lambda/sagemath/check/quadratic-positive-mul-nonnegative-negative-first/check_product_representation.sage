# 対象行: 積の表示式
# 関係: qpf_rep(xi * eta, sign) == (a * ap + 2 * (b * bp), a * bp + b * ap)
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
for sign, xi, eta, a, b, c, bp, ap, A, B, C, V in qpf_algebraic_cases():
    if not (True):
        continue
    assert qpf_rep(xi * eta, sign) == (a * ap + 2 * (b * bp), a * bp + b * ap), (sign, a, b, c, bp)
    checked += 1
assert checked == 21164
print(f"RESULT: PASS (check_product_representation.sage: {checked} cases)")
