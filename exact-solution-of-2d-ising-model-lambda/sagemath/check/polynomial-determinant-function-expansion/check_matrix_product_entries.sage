# 行列積の成分
# 式ペア（Sum/Prod は本文の有限和/有限積）:
# Sum(c[s]*Prod((A*B)[i,s[i]] for i in J) for s in S)
# = Sum(c[s]*Prod(Sum(A[i,j]*B[j,s[i]] for j in J) for i in J) for s in S)
# 対象ラベル: claim_polynomial_determinant_function_expansion
# 帰属: Q(zeta_8)[x]。多項式の完全一致を厳密に比較する。
import os
import sys

if "_dfe_cases" not in globals():
    _dfe_dir = os.path.dirname(os.path.abspath(__file__))
    if not os.path.isfile(os.path.join(_dfe_dir, "_prelude.sage")):
        _dfe_dir = os.path.dirname(os.path.abspath(sys.argv[0]))
    load(os.path.join(_dfe_dir, "_prelude.sage"))

def _dfe_rows():
    Sum, Prod = _dfe_sum, _dfe_prod
    for n, A, B in _dfe_cases:
        J = tuple(range(n))
        S = tuple(permutations(J))
        F = tuple(product(J, repeat=n))
        c = {s: _dfe_sign(s) for s in S}
        lhs = Sum(c[s]*Prod((A*B)[i,s[i]] for i in J) for s in S)
        rhs = Sum(c[s]*Prod(Sum(A[i,j]*B[j,s[i]] for j in J) for i in J) for s in S)
        yield lhs, rhs
        for i in J:
            for k in J:
                yield (A*B)[i,k], Sum(A[i,j]*B[j,k] for j in J)

_dfe_verify(_dfe_rows(), "matrix_product_entries")
