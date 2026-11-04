# 対象ラベル: eigenvalues_of_V_plus
# eigenvalues_of_V_plus (1) の対角化可能性・重複度・総個数の段落
#   前の鎖（8 行）: Q̌_εy = Q̌_ε(Q̌_εx) = (Q̌_εQ̌_ε)x = ((IQ̌_ε)Q̌_ε)x = ((Q̌_ε^0Q̌_ε)Q̌_ε)x = (Q̌_ε^1Q̌_ε)x = Q̌_ε^2x = Q̌_εx = y
#   後の鎖（5 行）: V^(+)y = V^(+)(Q̌_εy) = (V^(+)Q̌_ε)y = ((Λ̌_ε)_ℂQ̌_ε)y = (Λ̌_ε)_ℂ(Q̌_εy) = (Λ̌_ε)_ℂy
# を、括弧どおりに一行ずつ厳密に確かめる（y = Q̌_εx）。冪 Q̌^k は def_exp (1) の A^0 := I、A^{m+1} := A^mA を左から組んで作る。
# 続く段落（各 im Q̌_ε から 0 でない元を 1 本ずつ取ると固有ベクトルの基底になる）は、rank Q̌_ε = 1、各 ε の q_ε を並べた行列が正則、
# V^(+)q_ε = Λ̌_εq_ε、並べた本数が 2^{M_col} であることで確かめる。
# 続く「固有値はどれもある (Λ̌_ε)_ℂ に等しい」の鎖（左から Q̌_ε を掛ける 5 行、d_ε(Q̌_εx) = O の 4 行、Q̌_εx = O の 5 行、x = O の 5 行）は、
# 固有ベクトル x := q_{ε0}、λ := (Λ̌_{ε0})_ℂ で全ての ε について 5 行を、(Λ̌_ε)_ℂ ≠ λ の ε について 4 行と 5 行を確かめる。
# x = O の 5 行は背理法の中の鎖で、前提（全ての ε で Q̌_εx = O）を満たす x は O だけなので、前提を満たす x = O と、前提を満たさない x で
# 仮定を使う行だけが外れることで確かめる。主張そのものは charpoly(V^(+)) = Π_ε (X − (Λ̌_ε)_ℂ) でも確かめる。
# 鎖が使う仮定は、(1) の第一の鎖の V^(+)Q̌_ε = (Λ̌_ε)_ℂQ̌_ε と check_joint_eigenspace_decomposition (1) の Q̌_ε^2 = Q̌_ε だけである。
# ň_μ は ../eigenvalues_of_check_Vprime/_vprime_settings.sage が読み込む number_operator_settings() から取る
# （既定は Jordan–Wigner の模型 n_μ := c_μ^T c_μ）。exp(γ_μ/2) を不定元 t_μ、a := (2s_2)^{M_col/2} を不定元 a に置き、
# V̌' := Π_μ (t_μ^{-1}(I − ň_μ) + t_μ ň_μ)、V^(+) := aV̌'、(Λ̌_ε)_ℂ := a·Π_μ t_μ^{2ε_μ − 1} とする
# （指数関数の値と a の値そのものは ℝ への脱出なので、ローラン多項式環 F[a, t^{±1}] の中で鎖の形だけを確かめる。
# 基底の段落の正則性は、不定元に有理数を代入した値でも確かめる）。
# M = 2, 3、ε を全列挙、x は有理数の列ベクトル 2 本。
# 否定コントロール: 不定元の成分の 2×2 行列 V、Q と不定元 L、x では、仮定（Q^2 = Q、VQ = LQ、Qy = y）を使う行だけが等号を外れ、
# mat_mult_associative・identity_matrix_is_left_unit_of_mat_mult・def_exp (1)・scalar_multiple_factors_out_of_left_factor を引く行は
# 等号のまま残ることを確かめる。
# 帰属: 成分は F[a, t_1^{±1}, …, t_M^{±1}]（F = QQ）、代入値は QQ、否定コントロールは QQ 上の多項式環（厳密計算）。
load("../eigenvalues_of_check_Vprime/_vprime_settings.sage")


def mat_pow(A, k, Id):
    """def_exp (1): A^0 := I、A^{m+1} := A^m A。"""
    P = Id
    for _ in range(k):
        P = P * A
    return P


# 各行は (名前, 値, その行へ移る段が仮定を使うか)
def first_chain(Q, x, Id):
    y = Q * x
    return [
        ("Q y", Q * y, False),
        ("Q (Q x)", Q * (Q * x), True),                        # y = Q x と書いた
        ("(Q Q) x", (Q * Q) * x, False),                       # mat_mult_associative（q → 1）を右辺から左辺へ
        ("((I Q) Q) x", ((Id * Q) * Q) * x, False),            # identity_matrix_is_left_unit_of_mat_mult を右辺から左辺へ
        ("((Q^0 Q) Q) x", ((mat_pow(Q, 0, Id) * Q) * Q) * x, False),  # def_exp (1) の A^0 := I
        ("(Q^1 Q) x", (mat_pow(Q, 1, Id) * Q) * x, False),     # def_exp (1) の A^{m+1} := A^m A（m → 0）
        ("Q^2 x", mat_pow(Q, 2, Id) * x, False),               # def_exp (1) の A^{m+1} := A^m A（m → 1）
        ("Q x", Q * x, True),                                  # check_joint_eigenspace_decomposition (1) の Q^2 = Q
        ("y", y, True),                                        # y = Q x と書いた
    ]


def second_chain(Vp, Q, L, y):
    return [
        ("V+ y", Vp * y, False),
        ("V+ (Q y)", Vp * (Q * y), True),                      # 上の等式 Q y = y を右辺から左辺へ
        ("(V+ Q) y", (Vp * Q) * y, False),                     # mat_mult_associative（q → 1）を右辺から左辺へ
        ("(L Q) y", (L * Q) * y, True),                        # (1) の第一の鎖
        ("L (Q y)", L * (Q * y), False),                       # scalar_multiple_factors_out_of_left_factor（p → 1）
        ("L y", L * y, True),                                  # 上の等式 Q y = y
    ]


def left_mult_chain(Vp, Q, L, lam, x):
    return [
        ("L (Q x)", L * (Q * x), False),
        ("(L Q) x", (L * Q) * x, False),                       # scalar_multiple_factors_out_of_left_factor を右辺から左辺へ
        ("(Q V+) x", (Q * Vp) * x, True),                      # (1) の第二の鎖を右辺から左辺へ
        ("Q (V+ x)", Q * (Vp * x), False),                     # mat_mult_associative
        ("Q (lam x)", Q * (lam * x), True),                    # V^(+)x = λx
        ("lam (Q x)", lam * (Q * x), False),                   # scalar_multiple_factors_out_of_right_factor
    ]


def d_chain(Q, L, lam, x, d):
    w = Q * x
    return [
        ("d (Q x)", d * w, False),
        ("(L - lam)(Q x)", (L - lam) * w, False),              # d の置き方
        ("L(Qx) - lam(Qx)", L * w - lam * w, False),           # difference_of_scalar_multiples_of_one_matrix を右辺から左辺へ
        ("lam(Qx) - lam(Qx)", lam * w - lam * w, True),        # 上の鎖の両端の等式
        ("O", 0 * w, False),                                   # matrix_difference_zero_iff_equal の ⇐
    ]


def zero_chain(Q, x, d, dinv):
    w = Q * x
    return [
        ("Q x", w, False),
        ("1 (Q x)", 1 * w, False),                             # scalar_multiple_by_one を右辺から左辺へ
        ("(d^-1 d)(Q x)", (dinv * d) * w, False),              # d^{-1}d = 1 を右辺から左辺へ
        ("d^-1 (d (Q x))", dinv * (d * w), False),             # scalar_multiple_is_associative を右辺から左辺へ
        ("d^-1 O", dinv * (0 * w), True),                      # 上の鎖 d(Qx) = O
        ("O", 0 * w, False),                                   # scalar_multiple_of_zero_matrix
    ]


def sum_chain(Qs, x, Id, top):
    return [
        ("x", x, False),
        ("I x", Id * x, False),                                # identity_matrix_is_left_unit_of_mat_mult を右辺から左辺へ
        ("(sum Q) x", sum(Qs) * x, False),                     # check_joint_eigenspace_decomposition (2) を右辺から左辺へ
        ("sum (Q x)", sum(Q * x for Q in Qs), False),          # sum_over_binary_words_distributes_in_left_factor
        ("Q_top x", Qs[top] * x, True),                        # sum_over_binary_words_with_one_nonzero_term（前提 Q̌_εx = O）
        ("O", 0 * x, True),                                    # 上で示した Q̌_{(1,…,1)}x = O
    ]


def check_chain(lines, label, expect_all):
    global count
    for (u, A, _), (w, B, hyp) in zip(lines, lines[1:]):
        if expect_all or not hyp:
            assert A == B, (label, u, w)
            count += 1


count = 0
basis_checks = 0
charpoly_checks = 0
eigen_chain_count = [0]
for (tag, M, F, ns) in number_operator_settings():
    if M not in (2, 3):
        continue
    K = LaurentPolynomialRing(F, ["a"] + ["t%d" % j for j in range(M)])
    a = K.gens()[0]
    t = K.gens()[1:]
    n = [A.change_ring(K) for A in ns]
    Id = identity_matrix(K, 2 ** M)
    Vc = Id
    for mu in range(M):
        Vc = Vc * (t[mu] ** -1 * (Id - n[mu]) + t[mu] * n[mu])
    Vp = a * Vc
    xs = [vector(K, [QQ(j * j - 3 * j + 1) / (j + 2) for j in range(2 ** M)]).column(),
          vector(K, [QQ((-1) ** j * (2 * j + 5)) / 3 for j in range(2 ** M)]).column()]
    cols = []
    lams = []
    for eps in cartesian_product([[0, 1]] * M):
        Q = joint_projector(n, eps, Id)
        L = a * prod(t[mu] ** (2 * eps[mu] - 1) for mu in range(M))
        assert Q * Q == Q and Vp * Q == L * Q                  # 仮定が成り立つ
        for x in xs:
            check_chain(first_chain(Q, x, Id), ("first", tag, eps), True)
            check_chain(second_chain(Vp, Q, L, Q * x), ("second", tag, eps), True)
        # 基底の段落: rank Q̌_ε = 1（check_joint_eigenspace_decomposition (4)）、0 でない列 q_ε を 1 本取る
        assert Q.rank() == 1
        q = next(Q.column(j) for j in range(2 ** M) if Q.column(j) != 0)
        assert Vp * q == L * q
        cols.append(q)
        lams.append(L)
    P = matrix(K, cols).transpose()
    assert P.ncols() == 2 ** M                                 # 総個数 2^{M_col}
    assert P.determinant() != 0                                # 基底（ローラン多項式環で 0 でない）
    sub = {a: QQ(3) / 2}
    sub.update({t[mu]: QQ(mu + 2) for mu in range(M)})
    Pq = P.apply_map(lambda z: z.subs(sub)).change_ring(QQ)
    assert Pq.is_invertible()                                  # 有理数を代入しても正則
    D = diagonal_matrix(K, lams)
    assert Vp * P == P * D                                     # 固有ベクトルの基底で対角化される
    basis_checks += 1
    # 固有値の鎖（d_ε^{-1} を取るため、不定元に有理数を代入した QQ の値で確かめる）
    epss = [tuple(e) for e in cartesian_product([[0, 1]] * M)]
    ev = lambda A: A.apply_map(lambda z: z.subs(sub)).change_ring(QQ)
    Vq = ev(Vp)
    Iq = identity_matrix(QQ, 2 ** M)
    Qs = [ev(joint_projector(n, eps, Id)) for eps in epss]
    lamq = [QQ(L.subs(sub)) for L in lams]
    for i0 in range(len(epss)):
        x = ev(cols[i0].column())
        lam = lamq[i0]
        assert x != 0 and Vq * x == lam * x                    # x は λ に属する固有ベクトル
        for i, Q in enumerate(Qs):
            check_chain(left_mult_chain(Vq, Q, lamq[i], lam, x), ("leftmult", tag, i0, i), True)
            if lamq[i] != lam:
                d = lamq[i] - lam
                check_chain(d_chain(Q, lamq[i], lam, x, d), ("d", tag, i0, i), True)
                check_chain(zero_chain(Q, x, d, d ** -1), ("zero", tag, i0, i), True)
                eigen_chain_count[0] += 1
    top = epss.index(tuple([1] * M))
    check_chain(sum_chain(Qs, zero_matrix(QQ, 2 ** M, 1), Iq, top), ("sum", tag), True)   # 前提を満たす x は O だけ
    # 主張: charpoly(V^(+)) = Π_ε (X − (Λ̌_ε)_ℂ)（有理数を代入して QQ で）
    X = polygen(QQ, "X")
    assert Vq.charpoly(X) == prod(X - QQ(L.subs(sub)) for L in lams)
    charpoly_checks += 1

# 否定コントロール: 不定元の成分の 2×2 行列 V、Q と不定元 L、x
R = PolynomialRing(QQ, ["v%d" % j for j in range(4)] + ["q%d" % j for j in range(4)] + ["L", "x0", "x1"])
gens = R.gens()
Vg = matrix(R, 2, 2, gens[0:4])
Qg = matrix(R, 2, 2, gens[4:8])
Lg = gens[8]
xg = matrix(R, 2, 1, gens[9:11])
Ig = identity_matrix(R, 2)
chain_count = count
neg_control = 0
for (name, lines) in [("first", first_chain(Qg, xg, Ig)), ("second", second_chain(Vg, Qg, Lg, Qg * xg))]:
    check_chain(lines, "generic " + name, False)
    for (u, A, _), (w, B, hyp) in zip(lines, lines[1:]):
        if hyp and A != B:
            neg_control += 1
# 仮定を使う行のうち、y = Q x の書き換えの行は不定元でも構成上一致するので数えない（Q^2 = Q・VQ = LQ・Qy = y を使う行だけが外れる）
assert neg_control == 4, neg_control
# 固有値の鎖の否定コントロール: 不定元の V、Q、L、λ、x と d := L − λ（分数体）では仮定（QV = LQ、Vx = λx、LQx = λQx、dQx = O、Q̌_εx = O）を使う行だけが外れる
R2 = PolynomialRing(QQ, ["v%d" % j for j in range(4)] + ["q%d" % j for j in range(4)] + ["r%d" % j for j in range(4)] + ["L", "lam", "x0", "x1"]).fraction_field()
G = R2.gens()
V2 = matrix(R2, 2, 2, G[0:4]); Q2 = matrix(R2, 2, 2, G[4:8]); Q3 = matrix(R2, 2, 2, G[8:12])
L2, lam2 = G[12], G[13]
d2 = L2 - lam2
di2 = 1 / d2
x2 = matrix(R2, 2, 1, G[14:16]); I2 = identity_matrix(R2, 2)
neg2 = 0
for (name, lines) in [("leftmult", left_mult_chain(V2, Q2, L2, lam2, x2)), ("d", d_chain(Q2, L2, lam2, x2, d2)),
                      ("zero", zero_chain(Q2, x2, d2, di2)), ("sum", sum_chain([Q2, Q3, I2 - Q2 - Q3], x2, I2, 0))]:
    check_chain(lines, "generic2 " + name, False)
    for (u, A, _), (w, B, hyp) in zip(lines, lines[1:]):
        if hyp:
            assert A != B, ("generic2: 仮定を使う行が不定元でも成り立った", name, u, w)
            neg2 += 1
neg_control += neg2

print("PASS: eigenvalues_of_V_plus (1) の対角化可能性と固有値の段落。厳密等号 %d 段（否定コントロールの不定元で等号のまま残る段 %d を別に数えた）、基底の検査 %d 組、Q̌_εx = O の鎖 %d 本、特性多項式の検査 %d 組、否定コントロール %d 行" % (chain_count, count - chain_count, basis_checks, eigen_chain_count[0], charpoly_checks, neg_control))
print("RESULT: PASS")
