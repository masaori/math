# 対象ラベル: Z_equals_trace_of_W
# 証明の準備 2: (X(YX)^k)Y = (XY)^{k+1} の k = 0 の鎖（5 等号）と、k → k+1 の鎖（6 等号）の各行。
# 各行を本文の括弧どおりに組み、隣の行と厳密に比べる。冪は def_exp (1) の再帰（power_by_definition）。
# 帰納法の仮定の行は、k での主張を同じ行列で確かめてから使う。
load("_prelude.sage")

ok = True
n_eq = 0
K_MAX = 5
for desc, mk in generic_families():
    mats = mk(['X', 'Y'])
    X, Y = mats['X'], mats['Y']
    I = identity_matrix(X.base_ring(), X.nrows())
    P = power_by_definition
    for m in range(0, K_MAX + 2):
        assert P(X * Y, m) == (X * Y) ** m and P(Y * X, m) == (Y * X) ** m
    # k = 0
    base = [(X * P(Y * X, 0)) * Y, (X * I) * Y, X * Y, I * (X * Y), P(X * Y, 0) * (X * Y), P(X * Y, 1)]
    for a, b in zip(base, base[1:]):
        ok &= (a == b); n_eq += 1
    # k -> k+1
    for k in range(0, K_MAX):
        hyp = (X * P(Y * X, k)) * Y == P(X * Y, k + 1)
        ok &= hyp
        step = [
            (X * P(Y * X, k + 1)) * Y,
            (X * (P(Y * X, k) * (Y * X))) * Y,
            ((X * P(Y * X, k)) * (Y * X)) * Y,
            (((X * P(Y * X, k)) * Y) * X) * Y,
            (P(X * Y, k + 1) * X) * Y,
            P(X * Y, k + 1) * (X * Y),
            P(X * Y, k + 2),
        ]
        for a, b in zip(step, step[1:]):
            ok &= (a == b); n_eq += 1
    print(f"{desc}: ok={ok}")

# 対照: 不定元 s = 2 では (X(YX)^k)Y と (YX)^{k+1} は一致しない（積の順序が効く比較であること）。
mats = generic_ring(['X', 'Y'], 2)[1]
X, Y = mats['X'], mats['Y']
ctrl = all(((X * power_by_definition(Y * X, k)) * Y) != power_by_definition(Y * X, k + 1) for k in range(0, 4))
print(f"対照 (X(YX)^k)Y ≠ (YX)^(k+1): {ctrl}")
ok &= ctrl
print(f"checked {n_eq} equalities")
exact_result(ok)
