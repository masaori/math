# 対象ラベル: extract_taylor_coefficient_of_check_Z_Y
# 証明の準備 2(K_2^*)_C = (2K_2^*)_C（2 行）、四つの式それぞれの偶数・奇数の場合の鎖（係数変換の結果を
# exponential_series_of_even_odd_power_terms の仮定の形 (x_C)^n A・(c (x_C)^n) B へ並べ替える行）、その主張を当てた行と、
# 行列の和の可換律で主張の右辺へ着く行を、M_col = 2..5、全 μ、n = 0..N_MAX で厳密に確かめる。
# 左辺の項 ad^n_G(W) は Sage の演算の再帰（ad_power_sage）で生成子 (i/2)((K_1)_C H_1^(+))・i((K_2^*)_C H_2) から直接作る。
# (K_1)_C・(K_2^*)_C は円分体 L 上の多項式環の不定元 k1・k2、cosh・sinh の値は別の独立な不定元（補題を当てる行は補題の主張の形を
# そのまま使い、cosh・sinh の定義に依らない）。位相 e_∓ は 1 の冪根で、本文の exp との照合は nesting_of_commutator_of_H_and_check_Z の検算が行う。
import sys
load("_prelude.sage")

N_MAX = 7
Ms = [int(a) for a in sys.argv[1:]] or [2, 3, 4, 5]

# 準備: 2(K_2^*)_C = (2_R)_C (K_2^*)_C = (2K_2^*)_C を、ℂ を実数の対で持って確かめる（K は ℝ の不定元）。
RK = PolynomialRing(QQ, "Kstar")
Kstar = RK.gen()
run_chain([
    ("2 (K_2^*)_C", cc_mul(iota(2, RK), iota(Kstar, RK))),
    ("(2_R)_C (K_2^*)_C", cc_mul(iota(RK(2), RK), iota(Kstar, RK))),
    ("(2K_2^*)_C", iota(2 * Kstar, RK)),
], "準備 2(K_2^*)_C")
report(cc_mul(iota(2, RK), iota(Kstar, RK)) != iota(Kstar, RK), "対照: 2(K_2^*)_C ≠ (K_2^*)_C")

for M in Ms:
    S = Setting(M)
    P0 = S.P
    # cosh・sinh の値の不定元を足した環
    P = PolynomialRing(S.L, ['k1', 'k2', 'ch1', 'sh1', 'ch2', 'sh2'])
    k1, k2, ch1, sh1, ch2, sh2 = P.gens()
    phi = P0.hom([k1, k2], P)
    cv = lambda A: A.apply_map(phi, P)
    iP = P(S.iL)
    m_i = P(-1) * iP
    ihalf = iP * P(QQ(1) / 2)
    H1m, H2m = cv(S.H1), cv(S.H2)
    G1 = (ihalf * k1) * H1m
    G2 = (iP * k2) * H2m
    two_k2 = P(2) * k2           # 2(K_2^*)_C
    x2C = P(2) * k2              # (2K_2^*)_C（不定元の環では同じ元。等しさは上の準備で対の ℂ で確かめた）
    for mu in range(1, M + 1):
        Zc, Yc = cv(S.checkZ(mu)), cv(S.checkY(mu))
        em, ep = phi(S.ph(mu, -1)), phi(S.ph(mu, 1))
        tag0 = f"M={M} mu={mu}"
        cases = [
            # (名前, 生成子, W, x_C, A, B, 変換の奇数側の係数（変換の主張の形）, c, cosh, sinh, 主張の右辺)
            ("h1.z", G1, Zc, k1, Zc, Yc, lambda n: iP * pw(k1, n) * em, iP * em, ch1, sh1,
             body_sum(body_scalar(ch1, Zc), body_scalar((iP * em) * sh1, Yc))),
            ("h1.y", G1, Yc, k1, Yc, Zc, lambda n: m_i * pw(k1, n) * ep, m_i * ep, ch1, sh1,
             body_sum(body_scalar((m_i * ep) * sh1, Zc), body_scalar(ch1, Yc))),
            ("h2.z", G2, Zc, x2C, Zc, Yc, lambda n: m_i * pw(two_k2, n), m_i, ch2, sh2,
             body_sum(body_scalar(ch2, Zc), body_scalar(m_i * sh2, Yc))),
            ("h2.y", G2, Yc, x2C, Yc, Zc, lambda n: iP * pw(two_k2, n), iP, ch2, sh2,
             body_sum(body_scalar(iP * sh2, Zc), body_scalar(ch2, Yc))),
        ]
        for (name, G, W, xC, A, B, conv_odd, c, ch, sh, rhs) in cases:
            Tn = W
            for n in range(N_MAX + 1):
                if n > 0:
                    Tn = comm_sage(G, Tn)
                tag = f"{tag0} ({name}) n={n}"
                if n % 2 == 0:
                    conv_even = pw(k1, n) if name.startswith("h1") else pw(two_k2, n)
                    lines = [("ad^n_G(W)", Tn), ("変換の偶数の場合", body_scalar(conv_even, A))]
                    if name.startswith("h2"):
                        lines.append(("((2K_2^*)_C)^n A", body_scalar(pw(x2C, n), A)))
                    run_chain(lines, tag)
                    report(Tn == body_scalar(pw(xC, n), A), f"{tag}: 補題の仮定の偶数の形 (x_C)^n A")
                else:
                    lines = [("ad^n_G(W)", Tn), ("変換の奇数の場合", body_scalar(conv_odd(n), B))]
                    if name.startswith("h1"):
                        s0, e0 = (iP, em) if name == "h1.z" else (m_i, ep)
                        lines.append(("(s (k^n e)) B（結合律）", body_scalar(s0 * (pw(k1, n) * e0), B)))
                        lines.append(("(s (e k^n)) B（可換律）", body_scalar(s0 * (e0 * pw(k1, n)), B)))
                        lines.append(("((s e) k^n) B（結合律）", body_scalar(c * pw(k1, n), B)))
                    else:
                        lines.append(("(c ((2K_2^*)_C)^n) B", body_scalar(c * pw(x2C, n), B)))
                    run_chain(lines, tag)
                    report(Tn == body_scalar(c * pw(xC, n), B), f"{tag}: 補題の仮定の奇数の形 (c (x_C)^n) B")
            # 補題を当てた行と、和の可換律の行
            lemma_val = body_sum(body_scalar(ch, A), body_scalar(c * sh, B))
            if name.endswith(".y"):
                swapped = body_sum(body_scalar(c * sh, B), body_scalar(ch, A))
                run_chain([("補題の右辺", lemma_val), ("和の可換律で並べ替えた式", swapped)], f"{tag0} ({name})")
                report(swapped == rhs, f"{tag0} ({name}): 最後の行が主張の右辺")
            else:
                report(lemma_val == rhs, f"{tag0} ({name}): 補題の右辺が主張の右辺")
        # 対照: (h1.z) の c の位相を逆にした形は奇数の項と一致しない（e_- ≠ e_+ の μ）、(h2.z) の c の符号を逆にした形も一致しない
        T1 = comm_sage(G1, Zc)
        if em != ep:
            report(T1 != body_scalar((iP * ep) * k1, Yc), f"{tag0}: 対照 (h1.z) n=1 で位相を逆にすると仮定の形にならない")
        report(comm_sage(G2, Zc) != body_scalar(iP * x2C, Yc), f"{tag0}: 対照 (h2.z) n=1 で c の符号を逆にすると仮定の形にならない")
    print(f"M={M}: done")
print("RESULT: PASS")
