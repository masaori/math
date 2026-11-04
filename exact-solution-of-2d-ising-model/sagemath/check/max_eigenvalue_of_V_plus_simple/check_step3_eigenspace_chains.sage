# 対象ラベル: max_eigenvalue_of_V_plus_simple
# max_eigenvalue_of_V_plus_simple (3) の後半の 5 本の鎖を、括弧どおりに一行ずつ厳密に確かめる。
#   (A) d(Q̌_{ε'}x) = (Λ̌_{ε'} − Λ̌_max)(Q̌_{ε'}x) = Λ̌_{ε'}(Q̌_{ε'}x) − Λ̌_max(Q̌_{ε'}x) = Λ̌_max(Q̌_{ε'}x) − Λ̌_max(Q̌_{ε'}x) = O
#   (B) Q̌_{ε'}x = 1(Q̌_{ε'}x) = (d^{-1}d)(Q̌_{ε'}x) = d^{-1}(d(Q̌_{ε'}x)) = d^{-1}O = O
#   (C) x = Ix = (Σ_ε Q̌_ε)x = Σ_ε Q̌_εx = Q̌_{(1,…,1)}x
#   (D) Q̌y = Q̌(Q̌z) = (Q̌Q̌)z = ((IQ̌)Q̌)z = ((Q̌^0Q̌)Q̌)z = (Q̌^1Q̌)z = Q̌^2z = Q̌z = y（Q̌ := Q̌_{(1,…,1)}、y := Q̌z）
#   (E) V^{(+)}y = V^{(+)}(Q̌y) = (V^{(+)}Q̌)y = (Λ̌_{(1,…,1)}Q̌)y = (Λ̌_maxQ̌)y = Λ̌_max(Q̌y) = Λ̌_max y
# 数ベクトルは 2^M 行 1 列の行列として置く（mat_mult の約束）。鎖が使う仮定は check_joint_eigenspace_decomposition (1)(2)、
# eigenvalues_of_V_plus (1) の V^{(+)}Q̌_ε = Q̌_εV^{(+)} = Λ̌_εQ̌_ε と (2) の Λ̌_max = Λ̌_{(1,…,1)}、(2) の狭義の最大性、
# 固有方程式 V^{(+)}x = Λ̌_max x だけなので、それを満たす模型として check_step3_left_projection_chain.sage と同じく Jordan–Wigner のフェルミ演算子
# c_μ から n_μ := c_μ^T c_μ、Q̌_ε := Π_μ R_μ^{(ε_μ)} を作り、有理数 Λ_ε（(1,…,1) で狭義に最大）で V := Σ_ε Λ_ε Q̌_ε、
# x := Q̌_{(1,…,1)}w（w は有理数の列）、y := Q̌_{(1,…,1)}z とする（M = 2, 3, 4、ε' ≠ (1,…,1) を全列挙）。
# 否定コントロール: 固有ベクトルでない x では (A) の 3 行目と (B) の 4 行目と (C) の 4 行目が、im Q̌ に入らない y では (D) の最後の行が外れる。
# 帰属: 成分は QQ（厳密計算）。

def kron(factors):
    out = matrix(factors[0].base_ring(), 1, 1, [1])
    for A in factors:
        out = out.tensor_product(A)
    return out


def check_chain(lines, tag):
    n = 0
    for (a, A), (b, B) in zip(lines, lines[1:]):
        assert A == B, (tag, a, b)
        n += 1
    return n


def failing_steps(lines):
    return [(a, b) for (a, A), (b, B) in zip(lines, lines[1:]) if A != B]


count = 0
neg_control = 0
sz = matrix(QQ, [[1, 0], [0, -1]])
lower = matrix(QQ, [[0, 1], [0, 0]])
id2 = identity_matrix(QQ, 2)
for M in range(2, 5):
    N = 2 ** M
    Id = kron([id2] * M)
    O = zero_matrix(QQ, N, 1)
    c = [kron([sz] * (k - 1) + [lower] + [id2] * (M - k)) for k in range(1, M + 1)]
    n = [c[mu].transpose() * c[mu] for mu in range(M)]
    Qs = {}
    for eps in cartesian_product([[0, 1]] * M):
        Q = Id
        for mu in range(M):
            Q = Q * (n[mu] if eps[mu] == 1 else Id - n[mu])
        Qs[tuple(eps)] = Q
    top = tuple([1] * M)
    lams = {e: QQ(3 + sum((mu + 2) * e[mu] for mu in range(M))) / 7 for e in Qs}
    lam_max = lams[top]
    V = sum(lams[e] * Qs[e] for e in Qs)
    # 仮定が模型で成り立つ
    assert sum(Qs.values()) == Id                                     # (2)
    for e in Qs:
        assert Qs[e] * Qs[e] == Qs[e]                                 # (1) の冪等
        assert V * Qs[e] == lams[e] * Qs[e] == Qs[e] * V              # eigenvalues_of_V_plus (1)
        if e != top:
            assert lams[e] < lam_max                                  # (2) の狭義の最大性
    w = vector(QQ, [QQ(j * j - 2 * j + 5) / (j + 3) for j in range(N)]).column()
    x = Qs[top] * w
    assert V * x == lam_max * x                                       # 固有方程式

    def chain_A(e, x):
        Qx = Qs[e] * x
        d = lams[e] - lam_max
        return [
            ("d(Qx)", d * Qx),
            ("(λ'−λmax)(Qx)", (lams[e] - lam_max) * Qx),               # d の置き方
            ("λ'(Qx) − λmax(Qx)", lams[e] * Qx - lam_max * Qx),       # difference_of_scalar_multiples_of_one_matrix を右辺から左辺へ
            ("λmax(Qx) − λmax(Qx)", lam_max * Qx - lam_max * Qx),     # 上の鎖の両端の等式
            ("O", O),                                                 # matrix_difference_zero_iff_equal の ⟸
        ]

    def chain_B(e, x):
        Qx = Qs[e] * x
        d = lams[e] - lam_max
        return [
            ("Qx", Qx),
            ("1(Qx)", QQ(1) * Qx),                                    # scalar_multiple_by_one を右辺から左辺へ
            ("(d^{-1}d)(Qx)", (d ** -1 * d) * Qx),                    # d^{-1}d = 1
            ("d^{-1}(d(Qx))", d ** -1 * (d * Qx)),                    # scalar_multiple_is_associative を右辺から左辺へ
            ("d^{-1}O", d ** -1 * O),                                 # 上の鎖 d(Qx) = O
            ("O", O),                                                 # scalar_multiple_of_zero_matrix
        ]

    def chain_C(x):
        return [
            ("x", x),
            ("Ix", Id * x),                                           # identity_matrix_is_left_unit_of_mat_mult を右辺から左辺へ
            ("(ΣQ)x", sum(Qs.values()) * x),                          # check_joint_eigenspace_decomposition (2) を右辺から左辺へ
            ("ΣQx", sum(Qs[e] * x for e in Qs)),                      # sum_over_binary_words_distributes_in_left_factor
            ("Q_top x", Qs[top] * x),                                 # sum_over_binary_words_with_one_nonzero_term
        ]

    def chain_D(y, z):
        Q = Qs[top]
        return [
            ("Qy", Q * y),
            ("Q(Qz)", Q * (Q * z)),                                   # y = Qz
            ("(QQ)z", (Q * Q) * z),                                   # mat_mult_associative を右辺から左辺へ
            ("((IQ)Q)z", ((Id * Q) * Q) * z),                         # identity_matrix_is_left_unit_of_mat_mult を右辺から左辺へ
            ("((Q^0Q)Q)z", ((Q ** 0 * Q) * Q) * z),                   # def_exp (1) の A^0 := I
            ("(Q^1Q)z", (Q ** 1 * Q) * z),                            # def_exp (1) の A^{m+1} := A^m A（m → 0）
            ("Q^2z", Q ** 2 * z),                                     # def_exp (1) の A^{m+1} := A^m A（m → 1）
            ("Qz", Q * z),                                            # check_joint_eigenspace_decomposition (1)
            ("y", y),                                                 # y = Qz
        ]

    def chain_E(y):
        Q = Qs[top]
        return [
            ("Vy", V * y),
            ("V(Qy)", V * (Q * y)),                                   # Qy = y を右辺から左辺へ
            ("(VQ)y", (V * Q) * y),                                   # mat_mult_associative を右辺から左辺へ
            ("(Λ_top Q)y", (lams[top] * Q) * y),                      # eigenvalues_of_V_plus (1)
            ("(Λmax Q)y", (lam_max * Q) * y),                         # eigenvalues_of_V_plus (2)（模型では lam_max = lams[top] なので構成上成り立ち、写し間違いの検出だけに効く）
            ("Λmax(Qy)", lam_max * (Q * y)),                          # scalar_multiple_factors_out_of_left_factor
            ("Λmax y", lam_max * y),                                  # Qy = y
        ]

    for e in Qs:
        if e == top:
            continue
        count += check_chain(chain_A(e, x), ("A", M, e))
        count += check_chain(chain_B(e, x), ("B", M, e))
    count += check_chain(chain_C(x), ("C", M))
    z = vector(QQ, [QQ(2 * j + 1) / (j * j + 1) for j in range(N)]).column()
    y = Qs[top] * z
    count += check_chain(chain_D(y, z), ("D", M))
    count += check_chain(chain_E(y), ("E", M))

    # 否定コントロール: 固有ベクトルでない x（w そのもの）、im Q̌ に入らない y（z そのもの）
    assert V * w != lam_max * w
    bad = failing_steps(chain_C(w))
    assert bad == [("ΣQx", "Q_top x")], bad
    neg_control += 1
    some_fail = False
    for e in Qs:
        if e == top:
            continue
        badA = failing_steps(chain_A(e, w))
        assert all(step == ("λ'(Qx) − λmax(Qx)", "λmax(Qx) − λmax(Qx)") for step in badA), badA
        some_fail = some_fail or len(badA) == 1
    assert some_fail
    neg_control += 1
    some_fail = False
    for e in Qs:
        if e == top:
            continue
        badB = failing_steps(chain_B(e, w))
        assert all(step == ("d^{-1}(d(Qx))", "d^{-1}O") for step in badB), badB
        some_fail = some_fail or len(badB) == 1
    assert some_fail
    neg_control += 1
    badD = failing_steps(chain_D(z, z))
    assert badD == [("Qz", "y")], badD
    neg_control += 1

print("PASS max_eigenvalue_of_V_plus_simple (3) の後半の鎖（差・割り算・項を消す・逆向きの 2 本）: %d 段、否定コントロール %d 件" % (count, neg_control))
