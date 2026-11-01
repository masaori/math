# 対象ラベル: scalar_exp_is_limit_of_partial_sums
# Step 3（極限）と主張そのもの: Σ_{m=0}^{N} x^m/m! → exp(x) を、具体の点 x で確かめる。
# R への脱出: 極限と exp(x) の値は可算な係数の中に収まらない（exp(1) は有理数でも代数的数でもない）。
# この段だけを ComplexBallField(1024)（値と誤差の上界の組。丸めの誤差も包含に入る）で扱う。
# 部分和 S_N は各点で QQ(i) の中で厳密に計算し、最後にボールへ移す。比べる exp(x) は Arb の exp（Sage の
# CBF の exp）で、本文の定義（1 行 1 列の行列の exp の成分）とは独立な経路である。
# 確かめること:
#   (a) |S_N - exp(x)| の上界が、尾の評価 2|x|^{N+1}/(N+1)!（N + 2 ≥ 2|x| のとき成り立つ）以下である。
#   (b) |S_N - exp(x)| の上界は N = 120 で 10^{-40} を下回る。
#   (c) 1 行 1 列の行列の部分和 S_N([x]) の成分が、数の部分和 S_N と同じ値である（Step 2 を点で）。
load("../../_shared/one_by_one_matrix.sage")

CBF = ComplexBallField(1024)
RBF = RealBallField(1024)
ii = GAUSSIAN.gen()
points = [("K = R", QQ, QQ(0)), ("K = R", QQ, QQ(1)), ("K = R", QQ, QQ(-3)),
          ("K = R", QQ, QQ(7) / 2), ("K = R", QQ, QQ(-10)),
          ("K = C", GAUSSIAN, ii), ("K = C", GAUSSIAN, 2 - 3 * ii), ("K = C", GAUSSIAN, -5 + ii / 2)]
N_LIST = [0, 1, 5, 10, 20, 40, 80, 120]

for name, F, x0 in points:
    exp_ball = CBF(x0).exp()
    abs_x = CBF(x0).abs()
    for N in N_LIST:
        S_N = sum(x0^m / factorial(m) for m in range(N + 1))
        assert entry11(matrix_partial_sum(one_by_one(F, x0), N)) == S_N
        err_upper = (CBF(S_N) - exp_ball).abs().upper()
        if RBF(N + 2) >= 2 * abs_x:
            tail = 2 * abs_x^(N + 1) / factorial(N + 1)
            assert err_upper <= tail.upper(), (name, x0, N)
        if N == 120:
            assert err_upper < (RBF(10)^(-40)).lower(), (name, x0, N, err_upper)
    print(f"{name}, x = {x0}: |S_120 - exp(x)| ≤ {abs(float(err_upper)):.3e}")
print("RESULT: PASS")
