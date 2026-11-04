# 対象ラベル: W_is_real_symmetric_positive_definite
# 共通の準備。σ_k^a・Z_m・Y_m・H_2・D := Σ_m σ_m^z σ_{m+1}^z・V_1, V_2 の成分の定義・整数固有値の行列の exp の厳密な作り方は
# 共有の準備（transfer_matrix_factor_inverses.sage とその先の pauli_sites_exact.sage・row_configurations.sage）から読み込む。
load("../../_shared/transfer_matrix_factor_inverses.sage")


def is_real_embedded_field(R):
    """実の埋め込み（AA への埋め込み）を持つ数体か。"""
    return R in NumberFields() and R.coerce_embedding() is not None and R.coerce_embedding().codomain() is AA


def conj_transpose_exact(A):
    """def_hermitian_positive_definite の (A^*)_{kl} := conj(A_{lk})。成分は KG・QQ・AA・QQbar・実の埋め込みを持つ数体か、
    KG 係数で実の不定元の多項式。実の埋め込みを持つ数体の元は実数なので、複素共役は恒等写像である。"""
    R = A.base_ring()

    def cj(z):
        if is_real_embedded_field(R):
            return z
        if hasattr(z, "map_coefficients"):
            return z.map_coefficients(lambda c: c.conjugate())
        return z.conjugate()
    return matrix(R, A.ncols(), A.nrows(), lambda k, l: cj(A[l, k]))


def entries_are_real(A):
    """def_matrix_with_real_entries。KG・QQbar の成分は虚部 0、KG 係数の多項式は全ての係数の虚部 0。"""
    def real(z):
        if hasattr(z, "coefficients") and not z.parent() in (QQ, AA):
            return all(c.imag() == 0 for c in z.coefficients())
        if z.parent() in (QQ, AA) or is_real_embedded_field(z.parent()):
            return True
        return z.imag() == 0
    return all(real(z) for z in A.list())


def is_positive_definite_exact(A):
    """エルミートな A（成分は AA などの実の順序体）の正定値性を二つの独立な経路で判定する。
    (1) 首座小行列式が全て正（Sylvester の判定法）。(2) 特性多項式 det(tI − A) の係数の符号が厳密に交代する
    （エルミート行列の固有値は実なので、根が全て正であることと同値）。二つが一致することも確かめる。"""
    n = A.nrows()
    assert conj_transpose_exact(A) == A
    if is_real_embedded_field(A.base_ring()):
        B = A   # 埋め込みで順序の入った数体のまま判定する（AA の式の木が深くなるのを避ける）
    else:
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


def bilinear_transpose_value(x, A):
    """x^⊤Ax（共役を取らない。旧い可逆性の段が使っていた量）。"""
    n = A.nrows()
    return sum(x[k] * A[k, l] * x[l] for k in range(n) for l in range(n))


def real_field_for(x):
    """K_2 := log x のとき、√t（t = tanh K_2）と √(2s_2) を含む、AA への埋め込みを持つ数体 F と、その中の √t・√(2s_2) を返す。"""
    s2, t = second_coupling_exact(x)
    F, (rt, rs), _ = number_field_elements_from_algebraics([AA(t).sqrt(), AA(2 * s2).sqrt()], embedded=True)
    assert rt > 0 and rs > 0 and rt**2 == t and rs**2 == 2 * s2
    return F, rt, rs


def quadratic_form_value_split(u, v, A):
    """x := u + iv（u, v は実の数ベクトル）について x^*Ax を (実部, 虚部) で返す（def_conjugate_bilinear_value の和を展開したもの）。
    conj(u_k + iv_k)A_{kl}(u_l + iv_l) = (u_kA_{kl}u_l + v_kA_{kl}v_l) + i(u_kA_{kl}v_l − v_kA_{kl}u_l)。"""
    n = A.nrows()
    re = sum(u[k] * A[k, l] * u[l] + v[k] * A[k, l] * v[l] for k in range(n) for l in range(n))
    im = sum(u[k] * A[k, l] * v[l] - v[k] * A[k, l] * u[l] for k in range(n) for l in range(n))
    return re, im


n_steps = 0
n_neg = 0


def eq(a, b, what):
    global n_steps
    assert a == b, what
    n_steps += 1


def neq(a, b, what):
    global n_neg
    assert a != b, what
    n_neg += 1
