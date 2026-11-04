# 対象ラベル: open_chain_endpoint_product_sum（Σ_{s∈𝔐} s(M_col)s(1) exp(KE(s)) = 2(2sinh K)^{M_col-1}）
# 証明の Step 1（open_chain_partition_sum の Φ）、Step 2 の M_col = 2 の鎖（3 行）と M_col ≥ 3 の鎖（4 行）、
# 被加数の鎖（4 行）、主張の鎖（6 行）の全ての行と主張を確かめる。
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
for M in range(3, 9):
    for s in configs(M):
        lines = [
            finite_prod([t(s, m) for m in range(1, M)]),
            finite_prod([spin(s, m) * spin(s, m + 1) for m in range(1, M)]),
            spin(s, 1) * finite_prod([spin(s, m) * spin(s, m) for m in range(2, M)]) * spin(s, M),
            spin(s, 1) * finite_prod([ZZ(1) for m in range(2, M)]) * spin(s, M),
            spin(s, 1) * spin(s, M),
        ]
        for a, b in zip(lines, lines[1:]):
            assert a == b, (M, s)
            count += 1
        assert all(spin(s, m) * spin(s, m) == 1 for m in range(2, M))   # 3 行目の根拠
        count += 1
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
# 「ς の値」「1·b = b」「a·1 = a」「a(-1) = -a」「a + (-1)b = a - b」の行は、この層では隣の行と同じ多項式になる
# （実数の層で別に確かめる）。
for M in range(2, 9):
    S = configs(M)
    L1 = finite_sum([finite_prod([t(s, m) * w_sym(t(s, m)) for m in range(1, M)]) for s in S], Rxy(0))
    L2 = finite_sum([finite_prod([tau * w_sym(tau) for tau in taus]) for (u, taus) in codomain(M)], Rxy(0))
    L3 = finite_sum([binword_sum(lambda e: finite_prod([varsigma(em) * w_sym(varsigma(em)) for em in e]), M - 1, Rxy(0))
                     for u in [-1, 1]], Rxy(0))
    L4 = finite_sum([finite_prod([varsigma(1) * w_sym(varsigma(1)) + varsigma(0) * w_sym(varsigma(0)) for m in range(1, M)])
                     for u in [-1, 1]], Rxy(0))
    L9 = finite_sum([finite_prod([X - Y for m in range(1, M)]) for u in [-1, 1]], Rxy(0))
    L10 = 2 * finite_prod([X - Y for m in range(1, M)])
    sinhK = (X - Y) / 2                         # def_cosh_sinh（exp(K) → x、exp(-K) → y）
    L11 = 2 * finite_prod([2 * sinhK for m in range(1, M)])
    L12 = 2 * (2 * sinhK) ^ (M - 1)
    chain = [L1, L2, L3, L4, L9, L10, L11, L12]
    for a, b in zip(chain, chain[1:]):
        assert a == b, M
        count += 1
    # 左辺（被加数を s(M_col)s(1)·Π w(t_m(s)) で直接組んだもの）とも一致する
    L0 = finite_sum([spin(s, M) * spin(s, 1) * finite_prod([w_sym(t(s, m)) for m in range(1, M)]) for s in S], Rxy(0))
    assert L0 == L1
    count += 1
    # 否定コントロール: 端点因子を落とすと cosh の側になる、二元集合の和で符号を落とすと外れる
    L0_no_endpoint = finite_sum([finite_prod([w_sym(t(s, m)) for m in range(1, M)]) for s in S], Rxy(0))
    if L0_no_endpoint != L12:
        neg_no_endpoint += 1
    if L12 != 2 * (X + Y) ^ (M - 1):
        neg_sign += 1

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
        L8 = outer(lambda: rexp(RK) + (-1) * rexp(-RK))
        L9 = outer(lambda: rexp(RK) - rexp(-RK))
        L10 = 2 * finite_prod([rexp(K) - rexp(-K) for m in range(1, M)])
        L11 = 2 * finite_prod([2 * rsinh_def(K) for m in range(1, M)])
        L12 = 2 * (2 * rsinh_def(K)) ^ (M - 1)
        chain = [L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12]
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
assert neg_unpaired == sum(2 ^ (M - 1) for M in range(3, 9)), neg_unpaired
assert neg_no_endpoint == 7 and neg_sign == 7
assert neg_cosh == 6 * len([K for K in K_SAMPLES if K != 0])
neg = neg_unpaired + neg_no_endpoint + neg_sign + neg_cosh
print(f"checked {count} equalities/claims")
print(f"negative controls detected: {neg}")
print("RESULT: PASS")
