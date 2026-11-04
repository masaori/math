# 対象ラベル: V_plus_is_positive_definite
# 共通の準備。Z_m・Y_m・H_1^(+)・H_2・V_2 の成分の定義・exp の厳密な作り方は共有の準備から読み込む（複製しない）。
load("../../_shared/transfer_matrix_factor_inverses.sage")


def conj_transpose_exact(A):
    """def_hermitian_positive_definite の (A^*)_{kl} := conj(A_{lk})。成分は KG・QQ・AA か、KG 係数で実の不定元の多項式。"""
    R = A.base_ring()

    def cj(z):
        if hasattr(z, "map_coefficients"):
            return z.map_coefficients(lambda c: c.conjugate())
        return z.conjugate()
    return matrix(R, A.ncols(), A.nrows(), lambda k, l: cj(A[l, k]))


def is_positive_definite_exact(A):
    """エルミートな A（成分は AA などの実の順序体か、虚部 0 の KG）の正定値性を二つの独立な経路で判定する。
    (1) 首座小行列式が全て正（Sylvester の判定法）。(2) 特性多項式 det(tI − A) の係数の符号が厳密に交代する
    （エルミート行列の固有値は実なので、根が全て正であることと同値）。二つが一致することも確かめる。"""
    n = A.nrows()
    assert conj_transpose_exact(A) == A
    B = matrix(AA, n, n, [AA(z) for z in A.list()])
    minors_ok = all(B.submatrix(0, 0, k, k).det() > 0 for k in range(1, n + 1))
    cp = B.charpoly()
    coeffs = [cp[k] for k in range(n + 1)]   # t^0 .. t^n
    alt_ok = all(coeffs[k] != 0 and (coeffs[k] > 0) == ((n - k) % 2 == 0) for k in range(n + 1))
    assert minors_ok == alt_ok, "Sylvester の判定と特性多項式の判定が食い違う"
    return minors_ok


def quadratic_form_value(x, A):
    """def_conjugate_bilinear_value の x^*Ax（積は成分の和で組む）。"""
    n = A.nrows()
    return sum(x[k].conjugate() * A[k, l] * x[l] for k in range(n) for l in range(n))
