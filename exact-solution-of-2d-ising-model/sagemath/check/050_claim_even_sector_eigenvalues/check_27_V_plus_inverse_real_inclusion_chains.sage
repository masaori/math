# 対象ラベル: V_plus_is_invertible
# Step 2 の a := (2s_2)^{M_col/2} ∈ ℝ_{>0} と a^{-1} = (2s_2)^{-M_col/2} ∈ ℝ、スカラー倍の係数を包含 a_C・(a^{-1})_C で掛ける
# Step 2・Step 3 の鎖のうち、係数を扱う行（1 行目の表示の後の 2〜8 行目）を一行ずつ厳密に確かめる:
#   (a_C X)((a^{-1})_C Y) = a_C(X((a^{-1})_C Y)) = a_C((a^{-1})_C(XY)) = (a_C(a^{-1})_C)(XY)
#     = (aa^{-1})_C(XY) = (1)_C(XY) = 1_C(XY) = XY                       （Step 3 は a と a^{-1} を入れ替えた鎖）
# 行列の因子の積の段（9 行目以降）は check_10 が覆う。
# 帰属: ℝ の元は実代数的数 AA、ℂ の元は代数的数 QQbar（厳密計算）。包含 ι(r) := QQbar(r) で、
#       ι(r) が (r, 0) であること（inclusion_rr_to_cc）を実部・虚部で確かめる。
# s_2 は正の有理数（M_col が奇数なら a は無理数の実代数的数）。a = (2s_2)^{M/2} と a^{-1} = (2s_2)^{-M/2} は
# 別の経路で計算して比べる（a は √((2s_2)^M) と (√(2s_2))^M、a^{-1} は √((2s_2)^{-M})）。
# X, Y は QQbar 上の 2^{min(M,3)} 次の行列（虚部を持つ成分を含む。係数の段は行列の大きさに依らない）。
# 否定コントロール: 鎖を c = d = a（逆数でない）で回すと、ℝ で cd = 1 を引く段だけが外れることを確かめる。
set_random_seed(20261102)


def iota(r):
    z = QQbar(r)
    assert z.real() == r and z.imag() == 0
    return z


count = 0
neg = 0
for M in [2, 3, 4, 5]:
    for s2 in [QQ(1) / 3, QQ(2), QQ(5) / 7]:
        base = AA(2 * s2)
        a = AA((2 * s2) ** M).nth_root(2)             # (2s_2)^{M/2} ∈ ℝ
        assert a == base.nth_root(2) ** M              # 同じ値を別の経路で
        assert a > 0                                   # a ∈ ℝ_{>0}
        ainv = AA((2 * s2) ** (-M)).nth_root(2)        # (2s_2)^{-M/2} ∈ ℝ（a を使わずに計算）
        assert ainv == a ** -1                         # 正の実数の冪の指数法則 a^{-1} = (2s_2)^{-M/2}
        n = 2 ** min(M, 3)
        X = matrix(QQbar, n, n, [QQbar(randint(-3, 3)) + QQbar(I) * randint(-3, 3) for _ in range(n * n)])
        Y = matrix(QQbar, n, n, [QQbar(randint(-3, 3)) + QQbar(I) * randint(-3, 3) for _ in range(n * n)])
        def chain_of(c, d):
            return [
                (iota(c) * X) * (iota(d) * Y),
                iota(c) * (X * (iota(d) * Y)),            # scalar_multiple_factors_out_of_left_factor
                iota(c) * (iota(d) * (X * Y)),            # scalar_multiple_factors_out_of_right_factor
                (iota(c) * iota(d)) * (X * Y),            # scalar_multiple_is_associative
                iota(c * d) * (X * Y),                    # real_inclusion_preserves_product
                iota(AA(1)) * (X * Y),                    # ℝ で cd = 1
                QQbar(1) * (X * Y),                       # 1_C は ι(1) の略記
                X * Y,                                    # scalar_multiple_by_one
            ]
        for (c, d) in [(a, ainv), (ainv, a)]:
            assert iota(c) * iota(d) == iota(c * d)       # real_inclusion_preserves_product の主張そのもの
            assert iota(AA(1)) == QQbar(1)
            chain = chain_of(c, d)
            for r in range(len(chain) - 1):
                assert chain[r] == chain[r + 1], (M, s2, r)
                count += 1
        # 否定コントロール: c = d = a では ℝ で cd = 1 の段（index 4 → 5）だけが外れる
        if a != 1 and X * Y != 0:
            bad = chain_of(a, a)
            fails = [r for r in range(len(bad) - 1) if bad[r] != bad[r + 1]]
            assert fails == [4], fails
            neg += 1
print("PASS V_plus_is_invertible Step 2・Step 3 の実数の係数の包含の行: %d 段、否定コントロール %d 行" % (count, neg))
