# 対象ラベル: def_invertible_elements_of_R
# (iv) c ≠ 0 に対する二つの鎖
#   (cI)(c^{-1}I) = c(I(c^{-1}I)) = c(c^{-1}(II)) = (cc^{-1})(II) = (cc^{-1})I = 1I = I
#   (c^{-1}I)(cI) = c^{-1}(I(cI)) = c^{-1}(c(II)) = (c^{-1}c)(II) = (c^{-1}c)I = 1I = I
# と、主張 (cI)^{-1} = c^{-1}I。
# 根拠の四つの式 (aA)B = a(AB)、A(aB) = a(AB)、a(bA) = (ab)A、1A = A は、a, b と A, B の成分を
# QQ 上の不定元に置いて確かめる。鎖は c を有理関数体 QQ(c) の不定元に置いて各行の値を組み、
# 隣り合う行が等しいことを確かめる（c^{-1} の分母は c の冪だけなので、c に 0 でない複素数を代入しても等号は保たれる）。
# 主張は、QQ(c) と具体の c ∈ QQ(i)\{0} で Sage の inverse（独立な経路）と比べる。
load("_prelude.sage")

for n in SIZES:
    names = ["s_a", "s_b"] + [f"{x}_{r}_{t}" for x in ["A", "B"] for r in range(n) for t in range(n)]
    P = PolynomialRing(QQ, names)
    sa, sb = P.gen(0), P.gen(1)
    A = matrix(P, n, n, P.gens()[2:2 + n*n])
    B = matrix(P, n, n, P.gens()[2 + n*n:])
    AB = body_product(A, B)
    assert body_product(body_scalar(sa, A), B) == body_scalar(sa, AB)
    assert body_product(A, body_scalar(sa, B)) == body_scalar(sa, AB)
    assert body_scalar(sa, body_scalar(sb, A)) == body_scalar(sa * sb, A)
    assert body_scalar(1, A) == A

    F = FractionField(PolynomialRing(QQ, "c"))
    c = F.gen()
    I = body_identity(F, n)
    for (u, v) in [(c, 1 / c), (1 / c, c)]:
        chain = [
            body_product(body_scalar(u, I), body_scalar(v, I)),
            body_scalar(u, body_product(I, body_scalar(v, I))),
            body_scalar(u, body_scalar(v, body_product(I, I))),
            body_scalar(u * v, body_product(I, I)),
            body_scalar(u * v, I),
            body_scalar(F(1), I),
            I,
        ]
        assert u * v == F(1)
        for t in range(len(chain) - 1):
            assert chain[t] == chain[t + 1], (n, t)
    assert body_scalar(c, I).inverse() == body_scalar(1 / c, I)

    IK = body_identity(K, n)
    for cK in [K(2), -3 * i_K, K(1) + 2 * i_K, K(-5) / 7 + i_K / 3]:
        assert body_scalar(cK, IK).inverse() == body_scalar(cK ** -1, IK)
    print(f"n = {n}: 根拠の四つの式を不定元で、二つの鎖を QQ(c) で、主張を QQ(c) と具体の 4 つの c で確かめた")

print("RESULT: PASS")
