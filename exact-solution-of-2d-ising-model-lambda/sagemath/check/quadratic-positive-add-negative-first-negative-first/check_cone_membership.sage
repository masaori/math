# 対象ラベル: claim_quadratic_positive_add_negative_first_negative_first
# 対象行: 正錐の第三条件から所属
# 式ペア: qpf_positive_coefficient(qpf_rep(xi + eta, sign))
# 帰属: QQ と二次体の厳密計算。
from pathlib import Path
import sys
qpf_directory = Path(__file__).resolve().parent
if not (qpf_directory / '_prelude.sage').is_file():
    qpf_directory = Path(sys.argv[0]).resolve().parent
load(str(qpf_directory / '_prelude.sage'))

checked = 0
for sign, xi, eta, a, b, ap, bp, A, B in qpf_algebraic_cases():
    assert qpf_positive_coefficient(qpf_rep(xi + eta, sign))
    checked += 1
assert checked == 199712
print(f"RESULT: PASS (正錐の第三条件から所属: {checked} cases)")
