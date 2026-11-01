# 対象ラベル: trace_of_idempotent
# Step 1（直和分解）。冪等行列 Q は QQ(i) の具体の行列、x は成分を QQ(i) 上の不定元に置いたベクトルとする。
# (a) (Qx + (x - Qx))_k の 3 行の鎖、(b) Q(x - Qx) の 4 行の鎖、(c) y = Qx から Qy までの 4 個の等号を、
# 本文の組み方で確かめる。(c) の最後の行 Qy = 0（y ∈ ker Q の仮定）は x を不定元のままでは課せないので、
# Sage の column_space と right_kernel で im Q ∩ ker Q = {0} と dim im Q + dim ker Q = n を独立に確かめる。
load("_prelude.sage")

count = 0
for n in SIZES:
    Ring = PolynomialRing(K, [f"x_{j}" for j in range(n)])
    x = matrix(Ring, n, 1, Ring.gens())
    for (r, seed, Q0) in idempotents(n):
        Q = Q0.change_ring(Ring)
        QQm = body_product(Q, Q)
        assert QQm == Q                                                    # 準備の QQ = Q（仮定 Q^2 = Q から）
        Qx = body_product(Q, x)
        xmQx = body_difference(x, Qx)
        # (a) x = Qx + (x - Qx) を成分で
        s = body_sum(Qx, xmQx)
        for k in range(n):
            a = [s[k, 0], Qx[k, 0] + xmQx[k, 0], Qx[k, 0] + (x[k, 0] - Qx[k, 0]), x[k, 0]]
            assert a[0] == a[1] == a[2] == a[3], (n, r, seed, k)
        assert s == x and Qx + (x - Qx) == x
        # (b) Q(x - Qx) = Qx - Q(Qx) = Qx - (QQ)x = Qx - Qx = 0
        b = [
            body_product(Q, xmQx),
            body_difference(Qx, body_product(Q, Qx)),                      # mat_mult_vector_difference
            body_difference(Qx, body_product(QQm, x)),                     # mat_mult_associative
            body_difference(Qx, Qx),                                       # QQ = Q
            body_zero(Ring, n, 1),                                         # matrix_difference_zero_iff_equal
        ]
        for t in range(len(b) - 1):
            assert b[t] == b[t + 1], (n, r, seed, t)
        assert Q * (x - Q * x) == 0
        # (c) y = Qx = (QQ)x = Q(Qx) = Qy
        y = Qx
        c = [y, Qx, body_product(QQm, x), body_product(Q, Qx), body_product(Q, y)]
        for t in range(len(c) - 1):
            assert c[t] == c[t + 1], (n, r, seed, t)
        # 主張の直和分解: im Q ∩ ker Q = {0}、dim im Q + dim ker Q = n、im Q の次元は r
        V = (K ** n)
        im, ker = Q0.column_space(), Q0.right_kernel()
        assert im.intersection(ker).dimension() == 0
        assert im.dimension() + ker.dimension() == n and im.dimension() == r
        assert (im + ker) == V
        count += 1
    print(f"n = {n}: 冪等行列 {len(idempotents(n))} 個で (a)(b)(c) の鎖と直和分解を確かめた")

# 否定コントロール: 冪等でない Q（2I）では Q(x - Qx) は 0 にならない
n = 2
Ring = PolynomialRing(K, ["x_0", "x_1"])
x = matrix(Ring, 2, 1, Ring.gens())
Q = 2 * body_identity(Ring, 2)
assert body_product(Q, body_difference(x, body_product(Q, x))) != body_zero(Ring, 2, 1)
print("否定コントロール: 冪等でない 2I では Q(x - Qx) ≠ 0")
print("RESULT: PASS")
