# 対象ラベル: real_exp_of_finite_sum（exp(Σ_{j=1}^m x_j) = Π_{j=1}^m exp(x_j)）
# 証明の 2 本の鎖:
#   m = 1:     exp(Σ_{j=1}^1 x_j) = exp(x_1)                           (def_finite_sum_of_real_numbers)
#                                 = Π_{j=1}^1 exp(x_j)                   (def_finite_product_of_real_numbers を右辺から左辺へ)
#   m → m+1:   exp(Σ_{j=1}^{m+1} x_j) = exp((Σ_{j=1}^m x_j) + x_{m+1})   (def_finite_sum_of_real_numbers)
#                                     = exp(Σ_{j=1}^m x_j) exp(x_{m+1})  (scalar_exp_product, K → ℝ, を右辺から左辺へ)
#                                     = (Π_{j=1}^m exp(x_j)) exp(x_{m+1}) (帰納法の仮定)
#                                     = Π_{j=1}^{m+1} exp(x_j)            (def_finite_product_of_real_numbers を右辺から左辺へ)
# 帰属: x_j は有理数で与え、exp の値は ℝ への脱出なので区間演算 RealBallField(200) の球で扱う
# （丸めの誤差を球の半径に含め、真の値を必ず囲む）。等号の行は球が共通部分を持つこと（overlaps）で確かめ、
# overlaps は半径が広いと誤った行も通すので、比べる球の半径が 1e-40 未満であることも確かめる。
# 有限和・有限積は定義どおり左から畳み込む。m = 1..7、有理数の組 6 通り。
# 否定コントロール: 2 行目の exp(a + b) を exp(a) + exp(b) に壊すと隣の行と交わらないことを確かめる。

RB = RealBallField(200)


def finite_sum(xs):
    # def_finite_sum_of_real_numbers: Σ_{j=1}^1 r_j := r_1、Σ_{j=1}^{m+1} r_j := (Σ_{j=1}^m r_j) + r_{m+1}
    s = xs[0]
    for x in xs[1:]:
        s = s + x
    return s


def finite_prod(ys):
    # def_finite_product_of_real_numbers: Π_{j=1}^1 r_j := r_1、Π_{j=1}^{m+1} r_j := (Π_{j=1}^m r_j) r_{m+1}
    p = ys[0]
    for y in ys[1:]:
        p = p * y
    return p


def same(a, b):
    assert a.rad() < 1e-40 and b.rad() < 1e-40
    return a.overlaps(b)


SAMPLES = [
    [QQ(1) / 3, QQ(-2) / 7, QQ(5) / 4, QQ(-1), QQ(3) / 11, QQ(2), QQ(-7) / 5],
    [QQ(0)] * 7,
    [QQ(9) / 2, QQ(-9) / 2, QQ(1) / 100, QQ(-13) / 6, QQ(4) / 9, QQ(-3) / 8, QQ(17) / 10],
    [QQ(-1) / 2] * 7,
    [QQ(7), QQ(-5), QQ(1) / 7, QQ(2) / 3, QQ(-11) / 12, QQ(1) / 2, QQ(-1) / 9],
    [QQ(1) / 64, QQ(-1) / 32, QQ(1) / 16, QQ(-1) / 8, QQ(1) / 4, QQ(-1) / 2, QQ(1)],
]

count = 0
broken = 0
for xs_q in SAMPLES:
    xs_all = [RB(x) for x in xs_q]
    # m = 1 の鎖
    x1 = xs_all[:1]
    lines = [finite_sum(x1).exp(), x1[0].exp(), finite_prod([x.exp() for x in x1])]
    for a, b in zip(lines, lines[1:]):
        assert same(a, b)
        count += 1
    # m → m+1 の鎖（m = 1..6）。帰納法の仮定の行は、m 個の場合の主張を先に確かめてから使う
    for m in range(1, 7):
        xs = xs_all[:m]
        xn = xs_all[m]
        assert same(finite_sum(xs).exp(), finite_prod([x.exp() for x in xs]))   # m 個の場合（帰納法の仮定）
        count += 1
        lines = [
            finite_sum(xs + [xn]).exp(),
            (finite_sum(xs) + xn).exp(),
            finite_sum(xs).exp() * xn.exp(),
            finite_prod([x.exp() for x in xs]) * xn.exp(),
            finite_prod([x.exp() for x in xs + [xn]]),
        ]
        for a, b in zip(lines, lines[1:]):
            assert same(a, b), (m, xs_q)
            count += 1
        bad = finite_sum(xs).exp() + xn.exp()
        if not same(bad, lines[1]):
            broken += 1
assert broken > 0
print(f"checked {count} lines")
print(f"negative controls (broken lines detected): {broken}")
print("RESULT: PASS")
