# 対象ラベル: T_actions_on_check_Z_Y
# (1) 準備の二つの鎖 X = ((i/2)(K_1)_C)H_1^(+) = (i/2)((K_1)_C H_1^(+)) = G_1、Y = (i(K_2^*)_C)H_2 = i((K_2^*)_C H_2) = G_2 を、
#     (K_1)_C・(K_2^*)_C を QQ(i) 上の不定元 k1・k2 に置いて厳密に（H は本文の H_1^(+)・H_2 と、成分が不定元の行列の両方で）。
#     部分和の検算が使う書き換え G_1 = ℓ(iH_1^(+))（K_1 = 2ℓ）、G_2 = k2(iH_2) と、ad の冪の斉次性
#     ad^n_{ℓ·iH}(W) = ℓ^n ad^n_{iH}(W)（ℓ は不定元、W は Ž_μ・Y̌_μ、n = 0..4）もここで確かめる。
# (2) T_{V_2} の鎖の、係数を左・右の因子から出す行、係数をまとめる行、1_C を外す行を、exp(Y)・W・exp(-Y) を成分が独立な不定元の行列、
#     a_C・(a^{-1})_C を独立な不定元 p・q に置いて、隣り合う行が多項式として等しいことで確かめる（全ての値を一度に表す）。
#     p q = 1 を使う行は、q = p^{-1} を代入した有理関数体で確かめ、対照として p q = 1 を課さないと崩れることを見る。
# (3) 包含の三行 a_C (a^{-1})_C = (aa^{-1})_C = (1)_C = 1_C を、ℂ を実数の対で持つ complex_as_real_pairs.sage で a を QQ(a) の元に置いて。
# (4) def_pair_of_matrices_times_column_of_numbers の (A, B)(a; b) := aA + bB を、成分の式と Sage の演算の二経路で。
import sys
load("_prelude.sage")
load("../../_shared/complex_as_real_pairs.sage")

Ms = [int(a) for a in sys.argv[1:]] or [2, 3, 4]
Pk = PolynomialRing(KG, ['k1', 'k2', 'l'])
k1, k2, l = Pk.gens()
half_i = i_K / 2

# (1) 準備の鎖
for M in Ms:
    H1 = H1_plus(M).change_ring(Pk)
    H2m = H2(M).change_ring(Pk)
    X = body_scalar(half_i * k1, H1)
    G1 = body_scalar(half_i, body_scalar(k1, H1))
    report(X == G1, f"M={M}: X = ((i/2)(K_1)_C)H_1^(+) = (i/2)((K_1)_C H_1^(+)) = G_1")
    Y = body_scalar(i_K * k2, H2m)
    G2 = body_scalar(i_K, body_scalar(k2, H2m))
    report(Y == G2, f"M={M}: Y = (i(K_2^*)_C)H_2 = i((K_2^*)_C H_2) = G_2")
    report(G1.subs(k1=2 * l) == body_scalar(l, body_scalar(i_K, H1)), f"M={M}: K_1 = 2ℓ のとき G_1 = ℓ(iH_1^(+))")
    report(G2 == body_scalar(k2, body_scalar(i_K, H2m)), f"M={M}: G_2 = (K_2^*)_C (iH_2)")
    report(body_scalar(half_i, H1) != G1, f"M={M}: 対照 (K_1)_C を落とすと G_1 にならない")
    # 部分和の検算が使う ad^n_{ℓ·iH}(W) = ℓ^n ad^n_{iH}(W)（ad の冪の斉次性）を、W = Ž_μ・Y̌_μ、ℓ を円分体上の不定元にして n = 0..4 で
    S0 = Setting(M)
    Pl = PolynomialRing(S0.L, 'l')
    lL = Pl.gen()
    toPl = lambda A: matrix(Pl, A.nrows(), A.ncols(), lambda r, c: Pl(A[r, c].constant_coefficient()))
    for (hname, iH) in [("iH_1^(+)", toPl(body_scalar(S0.iL, S0.H1))), ("iH_2", toPl(body_scalar(S0.iL, S0.H2)))]:
        lH = body_scalar(lL, iH)
        for mu in range(1, M + 1):
            for (wname, Wm) in [("Ž", toPl(S0.checkZ(mu))), ("Y̌", toPl(S0.checkY(mu)))]:
                A, B = Wm, Wm
                for nn in range(5):
                    report(A == body_scalar(lL**nn, B), f"M={M} {hname} W={wname}_{mu} n={nn}: ad^n_{{ℓ·iH}}(W) = ℓ^n ad^n_{{iH}}(W)")
                    A, B = comm_body(lH, A), comm_body(iH, B)
for d in [2, 4]:
    P, (sa, sb), (H,) = generic_ring([("h", d, d)], scalars=("sa", "sb"))
    PK = P.change_ring(KG)
    H = H.change_ring(PK)
    sa, sb = PK(sa), PK(sb)
    report(body_scalar(sa * sb, H) == body_scalar(sa, body_scalar(sb, H)), f"d={d}: 一般の H で (ab)H = a(bH)（scalar_multiple_is_associative の当てはめ）")

# (2) T_{V_2} の鎖の係数の行
for d in [2, 4]:
    P, (p, q), (E, W, Em) = generic_ring([("e", d, d), ("w", d, d), ("f", d, d)], scalars=("p", "q"))
    EW = body_product(E, W)
    core = body_product(EW, Em)
    lines = [
        ("((pE)W)(qF)", body_product(body_product(body_scalar(p, E), W), body_scalar(q, Em))),
        ("(p(EW))(qF)", body_product(body_scalar(p, EW), body_scalar(q, Em))),
        ("p((EW)(qF))", body_scalar(p, body_product(EW, body_scalar(q, Em)))),
        ("p(q((EW)F))", body_scalar(p, body_scalar(q, core))),
        ("(pq)((EW)F)", body_scalar(p * q, core)),
    ]
    for (n0, v0), (n1, v1) in zip(lines, lines[1:]):
        report(v0 == v1, f"d={d}: 「{n0}」=「{n1}」（不定元の多項式として）")
    report(lines[0][1] == ((p * E) * W) * (q * Em), f"d={d}: 第 1 行は Sage の積・スカラー倍で作った値と一致")
    report(body_scalar(p * q, core) != core, f"d={d}: 対照 pq = 1 を課さないと (pq)((EW)F) ≠ (EW)F")
    Fr = P.fraction_field()
    sub = lambda A: matrix(Fr, A.nrows(), A.ncols(), lambda r, c: Fr(A[r, c]).subs({q: 1 / p}))
    one_line = body_scalar(Fr(1), sub(core))
    report(sub(body_scalar(p * q, core)) == one_line == sub(core), f"d={d}: q = p^{{-1}} のとき (pq)((EW)F) = 1((EW)F) = (EW)F（scalar_multiple_by_one）")

# (3) 包含の三行（ℂ を実数の対で）
Ra = PolynomialRing(QQ, 'a').fraction_field()
a = Ra.gen()
lhs = cc_mul(iota(a, Ra), iota(a**(-1), Ra))
report(lhs == iota(a * a**(-1), Ra), "a_C (a^{-1})_C = (aa^{-1})_C（real_inclusion_preserves_product、対の積）")
report(iota(a * a**(-1), Ra) == iota(1, Ra), "(aa^{-1})_C = (1)_C（ℝ で aa^{-1} = 1）")
report(iota(1, Ra) == (Ra(1), Ra(0)), "(1)_C = 1_C = (1, 0)（inclusion_rr_to_cc の略記）")
report(cc_mul(iota(a, Ra), iota(a, Ra)) != iota(1, Ra), "対照 a_C a_C は 1_C ではない")

# (4) 行列の組と数の列の積の定義
for d in [2, 4]:
    P, (sa, sb), (A, B) = generic_ring([("A", d, d), ("B", d, d)], scalars=("sa", "sb"))
    report(pair_times_column(A, B, sa, sb) == sa * A + sb * B, f"d={d}: (A, B)(a; b) の成分の式が Sage の aA + bB と一致")
    report(pair_times_column(A, B, sa, sb) != sb * A + sa * B, f"d={d}: 対照 係数を入れ替えた bA + aB とは異なる")
print("RESULT: PASS")
