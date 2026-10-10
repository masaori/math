# 全置換和の重み表示
# 対象ラベル: claim_polynomial_determinant_noninjective_cancellation
# 対象: tools_claim_polynomial_determinant_noninjective_cancellation の証明
# 式ペア: Sum(c[phi]*Prod(B[f(i),phi(i)] for i in J) for phi in Perm(J)) = Sum(w[phi] for phi in Perm(J))
# 型: polynomial（多項式は Q(zeta_8)[x]、整数は ZZ、添字と置換は有限集合）。
import os
import sys

if "_nic_rows" not in globals():
    _nic_dir = os.path.dirname(os.path.abspath(__file__))
    if not os.path.isfile(os.path.join(_nic_dir, "_prelude.sage")):
        _nic_dir = os.path.dirname(os.path.abspath(sys.argv[0]))
    load(os.path.join(_nic_dir, "_prelude.sage"))

_nic_verify("whole_sum_definition", "polynomial")
