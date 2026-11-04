# 対象ラベル: rayleigh_bounds_operator_norm
# 共通の準備。W の厳密な作り方（K_1 := 2 log y、K_2 := log x）は共有の準備 transfer_matrix_factor_inverses.sage
# （とその先の pauli_sites_exact.sage・row_configurations.sage）の関数を使う。
load("../../_shared/transfer_matrix_factor_inverses.sage")


def W_exact(M, x, y):
    """def_symmetrized_transfer_matrix の W = (BV_2)B を、B = Σ_λ y^λ P_λ(D)（QQ）と V_2 の成分の定義（成分 x^n）で作り、AA の行列で返す。"""
    n = 2**M
    D = bond_sum(M)
    DQ = matrix(QQ, n, n, [QQ(z) for z in D.list()])
    B = exp_by_spectral_projectors(DQ, lambda lam: QQ(y)**lam, QQ)
    V2 = V2_by_components(M, lambda m: QQ(x)**m, QQ)
    W = body_product(body_product(B, V2), B)
    return matrix(QQ, n, n, [QQ(z) for z in W.list()])


def norm_exact(v):
    """def_matrix_norm の ‖v‖ := √(Σ_i |v_i|^2)（実の成分。値は AA）。"""
    return AA(sum(abs(AA(a))**2 for a in v)).sqrt()


def bil(x, P, y):
    """def_real_bilinear_value の x^⊤Py := Σ_k Σ_l x_k P_kl y_l（左から順に足す）。"""
    n = P.nrows()
    s = 0
    for k in range(n):
        for l in range(n):
            s = s + (x[k] * P[k, l]) * y[l]
    return s


def matvec(P, x):
    """行列積の成分表示 (Px)_k := Σ_l P_kl x_l。"""
    n = P.nrows()
    return vector([sum(P[k, l] * x[l] for l in range(n)) for k in range(n)])


def power_by_def_exp(P, k):
    """def_exp (1) の冪: P^0 := I、P^{m+1} := P^m P（積は mat_mult の成分の式）。"""
    A = body_identity(P.base_ring(), P.nrows())
    for _ in range(k):
        A = body_product(A, P)
    return A


def is_real_symmetric(P):
    """def_real_symmetric_matrix: すべての k, l で P_kl = P_lk。"""
    n = P.nrows()
    return all(P[k, l] == P[l, k] for k in range(n) for l in range(n))


def real_rooted_with_signs(P, strict):
    """実対称な P の特性多項式 det(tI − P) が実根だけを持つことを確かめ、その根が全て ≥ 0（strict なら > 0）かを、
    係数の符号の交代で判定する（実根だけの多項式では、根が全て ≥ 0 ⟺ 係数が弱く交代）。"""
    assert is_real_symmetric(P)
    cp = P.charpoly()
    n = P.nrows()
    assert sum(m for _, m in cp.roots(AA)) == n
    coeffs = [cp[k] for k in range(n + 1)]
    if strict:
        return all(coeffs[k] != 0 and (coeffs[k] > 0) == ((n - k) % 2 == 0) for k in range(n + 1))
    return all(coeffs[k] == 0 or (coeffs[k] > 0) == ((n - k) % 2 == 0) for k in range(n + 1))


def rayleigh_sup_exact(P):
    """def_rayleigh_sup の c := sup{x^⊤Px | ‖x‖ = 1} を、P の特性多項式の最大の実根として AA で作り、それが上限であることを確かめる。
    (上界) cI − P の特性多項式の根が全て ≥ 0、すなわち cI − P は半正定値なので ∀x: x^⊤Px ≤ c‖x‖^2。
    (到達) c の固有ベクトル v（AA の核の元）で v^⊤Pv = c‖v‖^2 なので、c より小さい上界は無い。
    最大固有値と上限の一致そのものは本文に無い（本文は上限が達成されることを主張しない）。ここでは c の値を作る独立な経路として使う。"""
    n = P.nrows()
    PA = P.change_ring(AA)
    c = max(r for r, _ in P.charpoly().roots(AA))
    Q = c * identity_matrix(AA, n) - PA
    assert real_rooted_with_signs(Q, strict=False), "cI − P が半正定値でない"
    v = Q.right_kernel().basis()[0]
    assert v != 0 and bil(v, PA, v) == c * sum(a * a for a in v)
    return c
