# 対象ラベル: eigenvalues_of_V_plus
# eigenvalues_of_V_plus (1) の二つの鎖（各 9 行）
#   V^(+)Q̌_ε = (a_ℂV̌')Q̌_ε = a_ℂ(V̌'Q̌_ε) = a_ℂ(e_ℂQ̌_ε) = (a_ℂe_ℂ)Q̌_ε = (ae)_ℂQ̌_ε = … = (Λ̌_ε)_ℂQ̌_ε
#   Q̌_εV^(+) = Q̌_ε(a_ℂV̌') = a_ℂ(Q̌_εV̌') = a_ℂ(e_ℂQ̌_ε) = (a_ℂe_ℂ)Q̌_ε = (ae)_ℂQ̌_ε = … = (Λ̌_ε)_ℂQ̌_ε
# を、括弧どおりに一行ずつ厳密に確かめる（a := (2s_2)^{M_col/2}、e := exp(ǧ(ε))）。
# 鎖が使う仮定は constant_c_value_even_sector の V^(+) = a_ℂV̌' と、eigenvalues_of_check_Vprime の V̌'Q̌_ε = Q̌_εV̌' = e_ℂQ̌_ε だけである。
# ň_μ は ../eigenvalues_of_check_Vprime/_vprime_settings.sage が読み込む number_operator_settings() から取る
# （既定は Jordan–Wigner の模型 n_μ := c_μ^T c_μ。鎖が ň_μ について使う性質は Q̌_ε の固有関係だけである）。
# exp(γ_μ/2) を不定元 t_μ、a を不定元 a に置き、V̌' := Π_μ (t_μ^{-1}(I − ň_μ) + t_μ ň_μ)、e := Π_μ t_μ^{2ε_μ − 1}、V^(+) := aV̌' とする
# （指数関数の値と a の値そのものは ℝ への脱出なので、ここではローラン多項式環 F[a, t^{±1}] の中で鎖の形だけを確かめる）。
# 6〜9 行目（a の置き方、ǧ(ε) の定義、s_2 = sinh 2K_2、Λ̌_ε の定義）は記号の読み替えなので、同じ多項式 a·e の行として数える。
# M = 2, 3、ε を全列挙。
# 否定コントロール: 不定元の成分の 2×2 行列 V'、Q と不定元 a、e では、仮定（V^(+) = aV̌'、V̌'Q̌ = eQ̌、Q̌V̌' = eQ̌）を使う行だけが
# 等号を外れ、scalar_multiple_factors_out_of_*_factor・scalar_multiple_is_associative を引く行は等号のまま残ることを確かめる。
# 帰属: 成分は F[a, t_1^{±1}, …, t_M^{±1}]（F = QQ）と QQ 上の多項式環（否定コントロール）（厳密計算）。
load("../eigenvalues_of_check_Vprime/_vprime_settings.sage")


# 各行は (名前, 値, その行へ移る段が仮定を使うか)
def left_chain(Vp, Vc, Q, a, e):
    return [
        ("V+ Q", Vp * Q, False),
        ("(a V') Q", (a * Vc) * Q, True),        # constant_c_value_even_sector
        ("a (V' Q)", a * (Vc * Q), False),       # scalar_multiple_factors_out_of_left_factor
        ("a (e Q)", a * (e * Q), True),          # eigenvalues_of_check_Vprime の V̌'Q̌_ε = e_ℂQ̌_ε
        ("(a e) Q", (a * e) * Q, False),         # scalar_multiple_is_associative
        ("(ae) Q", (a * e) * Q, False),          # real_inclusion_preserves_product（ℂ の積と ℝ の積の像が一致）
        ("Λ Q", (a * e) * Q, False),             # 6〜9 行目（a・ǧ・s_2・Λ̌_ε の定義）
    ]


def right_chain(Vp, Vc, Q, a, e):
    return [
        ("Q V+", Q * Vp, False),
        ("Q (a V')", Q * (a * Vc), True),        # constant_c_value_even_sector
        ("a (Q V')", a * (Q * Vc), False),       # scalar_multiple_factors_out_of_right_factor
        ("a (e Q)", a * (e * Q), True),          # eigenvalues_of_check_Vprime の Q̌_εV̌' = e_ℂQ̌_ε
        ("(a e) Q", (a * e) * Q, False),         # scalar_multiple_is_associative
        ("(ae) Q", (a * e) * Q, False),          # real_inclusion_preserves_product
        ("Λ Q", (a * e) * Q, False),             # 6〜9 行目
    ]


def check_chain(lines, label, expect_all):
    global count
    for (x, A, _), (y, B, hyp) in zip(lines, lines[1:]):
        if expect_all or not hyp:
            assert A == B, (label, x, y)
            count += 1


count = 0
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
    for eps in cartesian_product([[0, 1]] * M):
        Q = joint_projector(n, eps, Id)
        e = prod(t[mu] ** (2 * eps[mu] - 1) for mu in range(M))
        assert Vc * Q == e * Q and Q * Vc == e * Q           # 仮定 eigenvalues_of_check_Vprime が成り立つ
        check_chain(left_chain(Vp, Vc, Q, a, e), ("left", tag, eps), True)
        check_chain(right_chain(Vp, Vc, Q, a, e), ("right", tag, eps), True)
        assert Vp * Q == Q * Vp                               # 主張の「左右どちらから掛けても同じ」

# 否定コントロール: 不定元の成分の 2×2 行列 V+、V'、Q と不定元 a、e
R = PolynomialRing(QQ, ["p%d" % j for j in range(4)] + ["v%d" % j for j in range(4)] + ["q%d" % j for j in range(4)] + ["a", "e"])
gens = R.gens()
Vpg = matrix(R, 2, 2, gens[0:4])
Vcg = matrix(R, 2, 2, gens[4:8])
Qg = matrix(R, 2, 2, gens[8:12])
ag, eg = gens[12], gens[13]
chain_count = count
neg_control = 0
for (name, lines) in [("left", left_chain(Vpg, Vcg, Qg, ag, eg)), ("right", right_chain(Vpg, Vcg, Qg, ag, eg))]:
    check_chain(lines, "generic " + name, False)
    for (x, A, _), (y, B, hyp) in zip(lines, lines[1:]):
        if hyp:
            assert A != B, ("generic: 仮定を使う行が不定元でも成り立った", name, x, y)
            neg_control += 1

print("PASS: eigenvalues_of_V_plus (1) の二つの鎖。厳密等号 %d 段（否定コントロールの不定元で等号のまま残る段 %d を別に数えた）、否定コントロール %d 行" % (chain_count, count - chain_count, neg_control))
print("RESULT: PASS")
