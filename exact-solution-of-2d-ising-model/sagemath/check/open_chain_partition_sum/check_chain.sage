# 対象ラベル: open_chain_partition_sum（Σ_{s∈𝔐} exp(KE(s)) = 2(2cosh K)^{M_col-1}）
# 証明の Step 1（全単射 Φ）、Step 2 の準備の鎖（3 行）、主張の鎖（6 行）の全ての行と主張を確かめる。
# 組合せの層（QQ[x, y]、exp(K) → x、exp(-K) → y）は M_col = 2..8 の全ての配置で厳密に、
# 実数の層（RealBallField(200)）は M_col = 2..7、K ∈ K_SAMPLES で確かめる。
load("../../_shared/open_chain_spin_sums.sage")

count = 0
neg = 0

# ---- Step 1: Φ は全単射、両側は 2^{M_col} 個 ----
for M in range(2, 9):
    S = configs(M)
    C = codomain(M)
    assert len(S) == 2 ^ M and len(C) == 2 ^ M
    images = [Phi(s) for s in S]
    assert len(set(images)) == len(S)          # 単射
    assert set(images) == set(C)              # 全射
    for s in S:
        assert Phi_inv(*Phi(s)) == s          # 復元は Φ の左逆
    for c in C:
        assert Phi(Phi_inv(*c)) == c          # 復元は Φ の右逆
    count += 6
# s(m+1) = s(m)τ ⟺ τ = s(m)s(m+1)（s(m)s(m) = 1 による）を全ての組で
for a in [-1, 1]:
    for b in [-1, 1]:
        for tau in [-1, 1]:
            assert (b == a * tau) == (tau == a * b)
            assert a * a == 1
            count += 2

# ---- Step 2 の準備の鎖（実数の層）----
for M in range(2, 8):
    for K in K_SAMPLES:
        for s in configs(M):
            lines = [
                rexp(RB(K) * energy(s)),
                rexp(RB(K) * finite_sum([RB(t(s, m)) for m in range(1, M)], RB(0))),
                rexp(finite_sum([RB(K) * t(s, m) for m in range(1, M)], RB(0))),
                finite_prod([rexp(RB(K) * t(s, m)) for m in range(1, M)]),
            ]
            # 1 行目の根拠: E(s) = Σ t_m(s)（整数で厳密に）
            assert energy(s) == sum(t(s, m) for m in range(1, M))
            count += 1
            for a, b in zip(lines, lines[1:]):
                assert same(a, b), (M, K, s)
                count += 1
            # 否定コントロール: 指数法則の行を「和の exp を exp の和」に壊すと外れる
            bad = finite_sum([rexp(RB(K) * t(s, m)) for m in range(1, M)], RB(0))
            if not same(bad, lines[3]):
                neg += 1
            elif M != 2:
                raise AssertionError(("prep negative control did not fire", M, K, s))

# ---- Step 1: ς と成分ごとの写像 {0,1}^{M_col-1} → {-1,1}^{M_col-1} は全単射 ----
assert varsigma(1) == 1 and varsigma(0) == -1 and {varsigma(0), varsigma(1)} == {-1, 1}
assert all(varsigma((tau + 1) / 2) == tau for tau in [-1, 1])
count += 3
for M in range(2, 9):
    words = [tuple(w) for w in itertools.product([0, 1], repeat=M - 1)]
    imgs = [tuple(varsigma(e) for e in w) for w in words]
    assert len(set(imgs)) == len(words) and set(imgs) == set(itertools.product([-1, 1], repeat=M - 1))
    count += 1

neg_power = neg_sinh = neg_sinh_real = neg_prep = 0

# ---- 主張の鎖（組合せの層。厳密）----
# w_sym(τ) が exp(Kτ)。exp(Kς(e)) は w_sym(ς(e))、exp(K·1)・exp(K·(-1)) も w_sym(1)・w_sym(-1) なので、
# 「ς の値」「a·1 = a」「a(-1) = -a」の三行はこの層では同じ多項式になる（実数の層で別に確かめる）。
for M in range(2, 9):
    S = configs(M)
    L1 = finite_sum([finite_prod([w_sym(t(s, m)) for m in range(1, M)]) for s in S], Rxy(0))
    L2 = finite_sum([finite_prod([w_sym(tau) for tau in taus]) for (u, taus) in codomain(M)], Rxy(0))
    L3 = finite_sum([binword_sum(lambda e: finite_prod([w_sym(varsigma(em)) for em in e]), M - 1, Rxy(0))
                     for u in [-1, 1]], Rxy(0))
    L4 = finite_sum([finite_prod([w_sym(varsigma(1)) + w_sym(varsigma(0)) for m in range(1, M)]) for u in [-1, 1]], Rxy(0))
    L7 = finite_sum([finite_prod([X + Y for m in range(1, M)]) for u in [-1, 1]], Rxy(0))
    L8 = 2 * finite_prod([X + Y for m in range(1, M)])
    coshK = (X + Y) / 2                         # def_cosh_sinh（exp(K) → x、exp(-K) → y）
    L9 = 2 * finite_prod([2 * coshK for m in range(1, M)])
    L10 = 2 * (2 * coshK) ^ (M - 1)            # Sage の冪（有限積とは別の経路）
    chain = [L1, L2, L3, L4, L7, L8, L9, L10]
    for a, b in zip(chain, chain[1:]):
        assert a == b, M
        count += 1
    if L10 != 2 * (2 * coshK) ^ M:
        neg_power += 1
    if L10 != 2 * (X - Y) ^ (M - 1):
        neg_sinh += 1

# ---- 主張の鎖（実数の層）と主張 ----
for M in range(2, 8):
    for K in K_SAMPLES:
        S = configs(M)
        RK = RB(K)
        L0 = finite_sum([rexp(RK * energy(s)) for s in S], RB(0))
        L1 = finite_sum([finite_prod([rexp(RK * t(s, m)) for m in range(1, M)]) for s in S], RB(0))
        L2 = finite_sum([finite_prod([rexp(RK * tau) for tau in taus]) for (u, taus) in codomain(M)], RB(0))
        L3 = finite_sum([binword_sum(lambda e: finite_prod([rexp(RK * varsigma(em)) for em in e]), M - 1, RB(0))
                         for u in [-1, 1]], RB(0))
        L4 = finite_sum([finite_prod([rexp(RK * varsigma(1)) + rexp(RK * varsigma(0)) for m in range(1, M)]) for u in [-1, 1]], RB(0))
        L5 = finite_sum([finite_prod([rexp(RK * 1) + rexp(RK * (-1)) for m in range(1, M)]) for u in [-1, 1]], RB(0))
        L6 = finite_sum([finite_prod([rexp(RK) + rexp(RK * (-1)) for m in range(1, M)]) for u in [-1, 1]], RB(0))
        L7 = finite_sum([finite_prod([rexp(RK) + rexp(-RK) for m in range(1, M)]) for u in [-1, 1]], RB(0))
        L8 = 2 * finite_prod([rexp(K) + rexp(-K) for m in range(1, M)])
        L9 = 2 * finite_prod([2 * rcosh_def(K) for m in range(1, M)])
        L10 = 2 * (2 * rcosh_def(K)) ^ (M - 1)
        chain = [L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10]
        for a, b in zip(chain, chain[1:]):
            assert same(a, b), (M, K)
            count += 1
        # 主張: 右辺を Sage の cosh（定義とは別の経路）で
        assert same(L0, 2 * (2 * RK.cosh()) ^ (M - 1)), (M, K)
        count += 1
        if K != 0 and not same(L0, 2 * (2 * RK.sinh()) ^ (M - 1)):
            neg_sinh_real += 1

# 否定コントロールの件数: 準備の鎖は M_col = 2（和も積も一項で一致する）以外の全て、
# 冪と sinh の取り違えは全ての M_col、Sage の sinh との取り違えは K ≠ 0 の全て
n_prep_expected = sum(2 ^ M for M in range(3, 8)) * len(K_SAMPLES)
assert neg == n_prep_expected, (neg, n_prep_expected)
assert neg_power == 7 and neg_sinh == 7
assert neg_sinh_real == 6 * len([K for K in K_SAMPLES if K != 0])
neg = neg + neg_power + neg_sinh + neg_sinh_real
print(f"checked {count} equalities/claims")
print(f"negative controls detected: {neg}")
print("RESULT: PASS")
