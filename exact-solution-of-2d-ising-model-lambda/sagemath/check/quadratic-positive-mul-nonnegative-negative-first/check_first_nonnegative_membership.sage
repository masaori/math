# 対象行: 第一の場合で第一係数が非負の積の所属
# 関係: qpf_cone_nonnegative(qpf_rep(xi * eta, sign))
# 局所条件: 2*(b*b) < a*a and 0 <= A
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
    if not (2*(b*b) < a*a and 0 <= A):
        continue
    assert qpf_cone_nonnegative(qpf_rep(xi * eta, sign)), (sign, a, b, c, bp)
    checked += 1
assert checked == 4398
print(f"RESULT: PASS (check_first_nonnegative_membership.sage: {checked} cases)")
