# 対象ラベル: open_chain_endpoint_product_sum（Σ_{s∈𝔐} s(M_col)s(1) exp(KE(s)) = 2(2sinh K)^{M_col-1}）
# 証明の Step 1（open_chain_partition_sum の Φ）、Step 2 の M_col = 2 の鎖（3 行）と M_col ≥ 3 の鎖（11 行）、
# 被加数の鎖（4 行）、主張の鎖（15 行）の全ての行と主張を確かめる。
# 端点因子の鎖は ZZ で厳密に、組合せの層（QQ[x, y]、exp(K) → x、exp(-K) → y）は M_col = 2..8 の全ての配置で厳密に、
# 実数の層（RealBallField(200)）は M_col = 2..7、K ∈ K_SAMPLES で確かめる。
load("../../_shared/open_chain_spin_sums.sage")

count = 0
neg_unpaired = neg_no_endpoint = neg_sign = neg_cosh = 0

# ---- Step 1: Φ の逆写像（復元）----
for M in range(2, 9):
    for s in configs(M):
        assert Phi_inv(*Phi(s)) == s
        count += 1
    for c in codomain(M):
        assert Phi(Phi_inv(*c)) == c
        count += 1

# ---- Step 2: 端点因子の書き替え（ZZ で厳密）----
for s in configs(2):
    M = 2
    lines = [finite_prod([t(s, m) for m in range(1, 2)]), t(s, 1), spin(s, 1) * spin(s, 2), spin(s, 1) * spin(s, M)]
    for a, b in zip(lines, lines[1:]):
        assert a == b
        count += 1
def step2_lines(M, sp, one):
    # Step 2 の M_col ≥ 3 の鎖の 11 行（左辺と 11 行）。sp(m) がサイト m の値、one が乗法の単位元。
    # 積は def_finite_product_of_real_numbers の左からの畳み込み finite_prod で組み、括弧は鎖の行の括弧どおりに掛ける。
    P = finite_prod([sp(m + 1) for m in range(1, M - 1)])                  # Π_{m=1}^{M_col-2} s(m+1)
    return [
        finite_prod([sp(m) * sp(m + 1) for m in range(1, M)]),             # 左辺（t_m(s) を展開した後の形も同じ値。1 行目は別に見る）
        finite_prod([sp(m) * sp(m + 1) for m in range(1, M)]),             # 1 行目: t_m(s) := s(m)s(m+1)
        finite_prod([sp(m) for m in range(1, M)]) * finite_prod([sp(m + 1) for m in range(1, M)]),   # 2 行目
        (sp(1) * P) * finite_prod([sp(m + 1) for m in range(1, M)]),       # 3 行目
        (sp(1) * P) * (P * sp(M)),                                         # 4 行目
        sp(1) * (P * (P * sp(M))),                                         # 5 行目
        sp(1) * ((P * P) * sp(M)),                                         # 6 行目
        (sp(1) * (P * P)) * sp(M),                                         # 7 行目
        (sp(1) * finite_prod([sp(m + 1) * sp(m + 1) for m in range(1, M - 1)])) * sp(M),   # 8 行目
        (sp(1) * finite_prod([one for m in range(1, M - 1)])) * sp(M),     # 9 行目
        (sp(1) * one) * sp(M),                                             # 10 行目: finite_product_of_real_ones（m → M_col-2）
        sp(1) * sp(M),                                                     # 11 行目: ℝ の乗法の単位元 p·1 = p（p → s(1)）
    ]

# 行ごとの根拠の確かめ: サイトの値を非可換な自由代数 QQ<a_1,…,a_M> の生成元に取ると、乗法の結合律だけで移れる行
# （3 行目 finite_product_of_real_numbers_splits_off_first_factor、4 行目 def_finite_product_of_real_numbers の帰納の式、
# 5〜7 行目 ℝ の乗法の結合律、10 行目 finite_product_of_real_ones、11 行目 ℝ の乗法の単位元 p·1 = p）は自由代数でも隣の行と一致し、可換律を使う 2 行目・8 行目（finite_product_of_real_products）は
# 自由代数では一致せず（否定コントロール）、可換な多項式環 QQ[a_1,…,a_M] では一致する。
neg_free = 0
for M in range(3, 9):
    F = FreeAlgebra(QQ, M, "a")
    fl = step2_lines(M, lambda m: F.gen(m - 1), F(1))
    C = PolynomialRing(QQ, M, "a")
    cl = step2_lines(M, lambda m: C.gen(m - 1), C(1))
    for i in [3, 4, 5, 6, 7, 10, 11]:
        assert fl[i - 1] == fl[i], (M, i)
        count += 1
    for i in [2, 8]:
        if fl[i - 1] != fl[i]:
            neg_free += 1
        assert cl[i - 1] == cl[i], (M, i)
        count += 1
# 5〜7 行目の結合律を、積を評価しない二分木で 1 回ずつ確かめる。木は step2_lines の行の式から作る
# （Tree の積は二つの木を対にするだけで、括弧は行の式の括弧そのもの）。assoc は ((x, y), t) → (x, (y, t))。
class Tree:
    def __init__(self, v):
        self.v = v
    def __mul__(self, other):
        return Tree((self.v, other.v))
def assoc(tr):
    (x, y), t = tr
    return (x, (y, t))
def assoc_inv(tr):
    x, (y, t) = tr
    return ((x, y), t)
for M in range(3, 9):
    T = [l.v for l in step2_lines(M, lambda m: Tree("s%d" % m), Tree("1"))]
    assert assoc(T[4]) == T[5]                   # 5 行目: x → s(1), y → P, t → P s(M_col)
    assert (T[5][0], assoc_inv(T[5][1])) == T[6] # 6 行目: x → P, y → P, t → s(M_col) を右辺から左辺へ（右の因子の中で）
    assert assoc_inv(T[6]) == T[7]               # 7 行目: x → s(1), y → PP, t → s(M_col) を右辺から左辺へ
    assert T[4] != T[5] and T[5] != T[6] and T[6] != T[7]
    count += 3
for M in range(3, 9):
    for s in configs(M):
        lines = step2_lines(M, lambda m: spin(s, m), ZZ(1))
        lines[0] = finite_prod([t(s, m) for m in range(1, M)])
        for a, b in zip(lines, lines[1:]):
            assert a == b, (M, s)
            count += 1
        assert all(spin(s, m + 1) in (ZZ(-1), ZZ(1)) for m in range(1, M - 1))     # 9 行目の根拠の仮定 s(m+1) ∈ {-1,1}
        assert all(spin(s, m + 1) * spin(s, m + 1) == 1 for m in range(1, M - 1))   # 9 行目の根拠（real_plus_or_minus_one_times_itself_is_one、σ → s(m+1)）
        count += 1
        count += 1
        assert finite_prod([ZZ(1) for m in range(1, M - 1)]) == 1                     # 10 行目の根拠（finite_product_of_real_ones、m → M_col-2）
        assert spin(s, 1) * 1 == spin(s, 1)                                            # 11 行目の根拠（p·1 = p、p → s(1)）
        count += 2
        # 否定コントロール: 対にならない因子 s(2) を一つ残すと、s(2) = -1 の配置（全体の半分）で外れる
        if finite_prod([t(s, m) for m in range(1, M)]) != spin(s, 1) * spin(s, 2) * spin(s, M):
            neg_unpaired += 1

# ---- 被加数の鎖（実数の層）----
for M in range(2, 8):
    for K in K_SAMPLES:
        for s in configs(M):
            RK = RB(K)
            # exp(KE(s)) の鎖（3 行）
            pre = [rexp(RK * energy(s)),
                   rexp(RK * finite_sum([RB(t(s, m)) for m in range(1, M)], RB(0))),
                   rexp(finite_sum([RK * t(s, m) for m in range(1, M)], RB(0))),
                   finite_prod([rexp(RK * t(s, m)) for m in range(1, M)])]
            for a, b in zip(pre, pre[1:]):
                assert same(a, b), (M, K, s)
                count += 1
            # 2 行目の根拠: finite_sum_of_real_scalar_multiples（m → M_col−1、c → K、j → m、x_j → t_m(s)）の等式 Σ K t_m(s) = K Σ t_m(s) を QQ で厳密に
            assert finite_sum([QQ(K) * t(s, m) for m in range(1, M)], QQ(0)) == QQ(K) * finite_sum([QQ(t(s, m)) for m in range(1, M)], QQ(0))
            count += 1
            e = rexp(RB(K) * energy(s))
            lines = [
                spin(s, M) * spin(s, 1) * e,
                spin(s, 1) * spin(s, M) * e,
                finite_prod([RB(t(s, m)) for m in range(1, M)]) * e,
                finite_prod([RB(t(s, m)) for m in range(1, M)]) * finite_prod([rexp(RB(K) * t(s, m)) for m in range(1, M)]),
                finite_prod([t(s, m) * rexp(RB(K) * t(s, m)) for m in range(1, M)]),
            ]
            for a, b in zip(lines, lines[1:]):
                assert same(a, b), (M, K, s)
                count += 1

# ---- 主張の鎖（組合せの層。厳密）----
# 「ς の値」「乗法の単位元 1·exp(K·1) = exp(K·1)」「乗法の単位元 K·1 = K」「乗法の可換律 K(-1) = (-1)K」「(-1)K = -K」「(-1)exp(-K) = -exp(-K)」「def_real_difference」の行は、この層では隣の行と同じ多項式になる
# （実数の層で別に確かめる）。
for M in range(2, 9):
    S = configs(M)
    L1 = finite_sum([finite_prod([t(s, m) * w_sym(t(s, m)) for m in range(1, M)]) for s in S], Rxy(0))
    L2 = finite_sum([finite_prod([tau * w_sym(tau) for tau in taus]) for (u, taus) in codomain(M)], Rxy(0))
    L3 = finite_sum([binword_sum(lambda e: finite_prod([varsigma(em) * w_sym(varsigma(em)) for em in e]), M - 1, Rxy(0))
                     for u in [-1, 1]], Rxy(0))
    L4 = finite_sum([finite_prod([varsigma(1) * w_sym(varsigma(1)) + varsigma(0) * w_sym(varsigma(0)) for m in range(1, M)])
                     for u in [-1, 1]], Rxy(0))
    L11 = finite_sum([finite_prod([X - Y for m in range(1, M)]) for u in [-1, 1]], Rxy(0))
    L12 = finite_prod([X - Y for m in range(1, M)]) + finite_prod([X - Y for m in range(1, M)])
                                                # u に依らない c の二元集合 {-1,1} 上の和は c + c
    L13 = 2 * finite_prod([X - Y for m in range(1, M)])
                                                # real_sum_of_two_equal_terms_is_twice（a → Π_m(x − y)）
    L14 = 2 * finite_prod([2 * ((X - Y) / 2) for m in range(1, M)])
                                                # real_twice_quotient_by_two_is_original（b → x − y）を右辺から左辺へ
    sinhK = (X - Y) / 2                         # def_cosh_sinh の sinh（exp(K) → x、exp(-K) → y）
    L15 = 2 * finite_prod([2 * sinhK for m in range(1, M)])
                                                # def_cosh_sinh の sinh（exp(K) → x、exp(-K) → y として）を右辺から左辺へ
    L16 = 2 * (2 * sinhK) ^ (M - 1)
    chain = [L1, L2, L3, L4, L11, L12, L13, L14, L15, L16]
    for a, b in zip(chain, chain[1:]):
        assert a == b, M
        count += 1
    # 左辺（被加数を s(M_col)s(1)·Π w(t_m(s)) で直接組んだもの）とも一致する
    L0 = finite_sum([spin(s, M) * spin(s, 1) * finite_prod([w_sym(t(s, m)) for m in range(1, M)]) for s in S], Rxy(0))
    assert L0 == L1
    count += 1
    # 否定コントロール: 端点因子を落とすと cosh の側になる、二元集合の和で符号を落とすと外れる
    L0_no_endpoint = finite_sum([finite_prod([w_sym(t(s, m)) for m in range(1, M)]) for s in S], Rxy(0))
    if L0_no_endpoint != L16:
        neg_no_endpoint += 1
    if L16 != 2 * (X + Y) ^ (M - 1):
        neg_sign += 1

# 主張の鎖の 8 行目・9 行目の根拠（K ∈ K_SAMPLES ⊂ ℚ で厳密に）: 乗法の可換律 K·(-1) = (-1)·K と
# real_minus_one_times_is_negation の (-1)·K = -K（a → K）
for K in K_SAMPLES:
    assert QQ(K) * QQ(-1) == QQ(-1) * QQ(K)
    assert QQ(-1) * QQ(K) == -QQ(K)
    count += 2
# 主張の鎖の 10 行目・11 行目の根拠（QQ[x,y] で厳密に。exp(K) → x、exp(-K) → y）:
# real_minus_one_times_is_negation の (-1)·y = -y（a → exp(-K)）と def_real_difference の x + (-y) = x - y
assert (-1) * Y == -Y and X + (-1) * Y == X + (-Y) and X + (-Y) == X - Y
count += 3

# ---- 主張の鎖（実数の層）と主張 ----
for M in range(2, 8):
    for K in K_SAMPLES:
        S = configs(M)
        RK = RB(K)
        L0 = finite_sum([spin(s, M) * spin(s, 1) * rexp(RK * energy(s)) for s in S], RB(0))
        L1 = finite_sum([finite_prod([t(s, m) * rexp(RK * t(s, m)) for m in range(1, M)]) for s in S], RB(0))
        L2 = finite_sum([finite_prod([tau * rexp(RK * tau) for tau in taus]) for (u, taus) in codomain(M)], RB(0))
        L3 = finite_sum([binword_sum(lambda e: finite_prod([varsigma(em) * rexp(RK * varsigma(em)) for em in e]), M - 1, RB(0))
                         for u in [-1, 1]], RB(0))
        def outer(f):
            return finite_sum([finite_prod([f() for m in range(1, M)]) for u in [-1, 1]], RB(0))
        L4 = outer(lambda: varsigma(1) * rexp(RK * varsigma(1)) + varsigma(0) * rexp(RK * varsigma(0)))
        L5 = outer(lambda: 1 * rexp(RK * 1) + (-1) * rexp(RK * (-1)))
        L6 = outer(lambda: rexp(RK * 1) + (-1) * rexp(RK * (-1)))
        L7 = outer(lambda: rexp(RK) + (-1) * rexp(RK * (-1)))
        L8 = outer(lambda: rexp(RK) + (-1) * rexp((-1) * RK))
        L9 = outer(lambda: rexp(RK) + (-1) * rexp(-RK))
        L10 = outer(lambda: rexp(RK) + (-rexp(-RK)))
        L11 = outer(lambda: rexp(RK) - rexp(-RK))
        L12 = (finite_prod([rexp(RK) - rexp(-RK) for m in range(1, M)])
               + finite_prod([rexp(RK) - rexp(-RK) for m in range(1, M)]))  # 二元集合 {-1,1} 上の和は c + c
        L13 = 2 * finite_prod([rexp(RK) - rexp(-RK) for m in range(1, M)])   # real_sum_of_two_equal_terms_is_twice
        L14 = 2 * finite_prod([2 * ((rexp(RK) - rexp(-RK)) / 2) for m in range(1, M)])
                                                # real_twice_quotient_by_two_is_original（b → exp(K) − exp(−K)）を右辺から左辺へ
        L15 = 2 * finite_prod([2 * rsinh_def(K) for m in range(1, M)])   # def_cosh_sinh の sinh（x → K）を右辺から左辺へ
        L16 = 2 * (2 * rsinh_def(K)) ^ (M - 1)
        chain = [L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16]
        if K == 0:
            # 値が 0 になるので相対の半径の判定が効かない。0 を含むことと半径の絶対値で見る
            for v in chain:
                assert v.contains_zero() and v.rad() < 1e-40
                count += 1
            continue
        for a, b in zip(chain, chain[1:]):
            assert same(a, b), (M, K)
            count += 1
        assert same(L0, 2 * (2 * RK.sinh()) ^ (M - 1)), (M, K)   # 主張（Sage の sinh の経路）
        count += 1
        if not same(L0, 2 * (2 * RK.cosh()) ^ (M - 1)):
            neg_cosh += 1

# 否定コントロールの件数: 対にならない因子は M_col = 3..8 の各配置の半分、端点因子の脱落と符号の脱落は全ての M_col、
# cosh との取り違えは K ≠ 0 の全て
# 自由代数で可換律の行が外れるのは M_col = 4..8 の 2 行ずつ（M_col = 3 では因子の並びが変わらない）
assert neg_free == 2 * 5, neg_free
assert neg_unpaired == sum(2 ^ (M - 1) for M in range(3, 9)), neg_unpaired
assert neg_no_endpoint == 7 and neg_sign == 7
assert neg_cosh == 6 * len([K for K in K_SAMPLES if K != 0])
neg = neg_unpaired + neg_no_endpoint + neg_sign + neg_cosh + neg_free
print(f"checked {count} equalities/claims")
print(f"negative controls detected: {neg}")
print("RESULT: PASS")
