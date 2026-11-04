# 対象ラベル: trace_V_plus_is_positive
# 共通の準備。V^(+) の因子の厳密な作り方・エルミート性と正定値性の厳密な判定・x^*Ax は
# V_plus_is_positive_definite の検算の準備をそのまま読み込む（複製しない）。
load("../V_plus_is_positive_definite/_prelude.sage")


def trace_by_definition(A):
    """def_trace の tr(A) := Σ_{k=1}^{n} A_kk（対角成分を左から足す。Sage の trace は比べる側だけに使う）。"""
    s = A.base_ring()(0)
    for k in range(A.nrows()):
        s = s + A[k, k]
    return s


def standard_vector(n, k, R):
    """trace_of_positive_definite_is_positive の b^{(k)}：b^{(k)}_i := δ_ik（def_kronecker_delta）。"""
    return vector(R, [R(1) if i == k else R(0) for i in range(n)])
