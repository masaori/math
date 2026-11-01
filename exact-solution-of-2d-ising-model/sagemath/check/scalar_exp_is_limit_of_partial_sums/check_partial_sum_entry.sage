# 対象ラベル: scalar_exp_is_limit_of_partial_sums
# Step 2（部分和の成分）の三行の等号の鎖を、N = 0,…,15 について確かめる。
#   (S_N([x]))_11 = Σ_{m=0}^{N} (1/m!) ([x]^m)_11 = Σ_{m=0}^{N} (1/m!) ([x^m])_11 = Σ_{m=0}^{N} x^m/m!
# 第一辺は行列の和とスカラー倍を Sage の行列演算で取った S_N([x]) の成分、第二辺以降は数の和として書いた。
# 最後の辺は、Sage の形式冪級数環の exp(t) を次数 N で打ち切ったもの（独立な経路）とも比べる。
# 帰属: 係数 QQ（K = R）と QQ(i)（K = C）の上の一変数多項式環・形式冪級数環。x は不定元。
load("../../_shared/one_by_one_matrix.sage")

N_MAX = 15
for name, F in COEFFICIENT_FIELDS:
    R = PolynomialRing(F, 'x')
    x = R.gen()
    X = one_by_one(R, x)
    PS = PowerSeriesRing(F, 't', default_prec=N_MAX + 2)
    t = PS.gen()
    exp_series = exp(t)
    for N in range(N_MAX + 1):
        line0 = entry11(matrix_partial_sum(X, N))
        line1 = sum((QQ(1) / factorial(m)) * entry11(X^m) for m in range(N + 1))       # 和とスカラー倍は成分ごと
        line2 = sum((QQ(1) / factorial(m)) * entry11(one_by_one(R, x^m)) for m in range(N + 1))  # Step 1
        line3 = sum(x^m / factorial(m) for m in range(N + 1))                           # def_one_by_one_matrix
        assert line0 == line1 == line2 == line3, (name, N)
        truncated = R([exp_series[k] for k in range(N + 1)])
        assert line3 == truncated, (name, N)
    print(f"{name}: N = 0,…,{N_MAX} で三行が多項式として一致し、exp(t) の次数 N までの切り捨てに等しい")
print("RESULT: PASS")
