# <theorem_exp_product>: Step 5 の鎖の最後の不等号
#   ‖I‖^2 ( (Σ_{j=P_N}^{N} a^j/j!)(Σ_{l=0}^{N} b^l/l!) + (Σ_{j=0}^{N} a^j/j!)(Σ_{l=P_N}^{N} b^l/l!) )
#     ≤ ‖I‖^2 ( R_{P_N-1}(a) E(b) + E(a) R_{P_N-1}(b) )        (∵ real_exp_series_converges (2)(3))
# を確かめる。P_N は 2j > N を満たす最小の整数 j。部分和は QQ で厳密に、E・R は ℝ の極限なので
# RealIntervalField の区間で囲む（ℝ への脱出: E(a) は部分和の極限として ℝ にしか住まない）。
# (3) の p = P_N, q = N（P_N ≤ N のとき）と (2) を各因子に当て、因子がすべて非負であることで積と和へ運ぶ。
load("../../_shared/operators.sage")
rep = CheckReport("theorem_exp_product: Step 5 の剰余の評価の行")
RIF = RealIntervalField(256)

def partial(a, p, q):
    # Σ_{m=p}^{q} a^m/m!（p > q なら空の和 0）
    return sum(QQ(a) ** m / factorial(m) for m in range(p, q + 1))

def E(a):
    return RIF(a).exp()

def R(a, n):
    # R_n(a) = E(a) − E_n(a)
    return E(a) - RIF(partial(a, 0, n))

def le(x, y):
    # 区間 x の全点が区間 y の全点以下（x の上端 ≤ y の下端）
    return x.upper() <= y.lower()

rows = 0
for a in [QQ(0), QQ(1)/2, QQ(2), QQ(9)/2]:
    for b in [QQ(0), QQ(1), QQ(3)]:
        for N in range(0, 15):
            P = N // 2 + 1  # 2j > N を満たす最小の j
            assert 2 * P > N and 2 * (P - 1) <= N
            if P <= N:
                # (3) p = P, q = N
                rep.truth(le(RIF(partial(a, P, N)), R(a, P - 1)), f"(3) a={a}, N={N}")
                rep.truth(le(RIF(partial(b, P, N)), R(b, P - 1)), f"(3) b={b}, N={N}")
            else:
                # P_N > N（N = 0）: 左の和は空の和 0 で、(3) の前半「R_{P_N−1} ≥ 0」で抑える
                rep.truth(partial(a, P, N) == 0 and le(RIF(0), R(a, P - 1)), f"(3) 前半 a={a}, N={N}")
                rep.truth(partial(b, P, N) == 0 and le(RIF(0), R(b, P - 1)), f"(3) 前半 b={b}, N={N}")
            # 積へ運ぶのに使う各因子の非負性
            rep.truth(partial(a, 0, N) >= 0 and partial(b, 0, N) >= 0 and partial(a, P, N) >= 0 and partial(b, P, N) >= 0,
                      f"各因子 ≥ 0 a={a}, b={b}, N={N}")
            # (2)
            rep.truth(le(RIF(partial(b, 0, N)), E(b)), f"(2) b={b}, N={N}")
            rep.truth(le(RIF(partial(a, 0, N)), E(a)), f"(2) a={a}, N={N}")
            for normI2 in [AA(1), AA(4), AA(7)]:
                lhs = RIF(normI2) * (RIF(partial(a, P, N)) * RIF(partial(b, 0, N))
                                     + RIF(partial(a, 0, N)) * RIF(partial(b, P, N)))
                rhs = RIF(normI2) * (R(a, P - 1) * E(b) + E(a) * R(b, P - 1))
                rep.truth(le(lhs, rhs), f"行 a={a}, b={b}, N={N}, ‖I‖^2={normI2}")
                rows += 1
# 否定の対照: 剰余の添字を P_N − 1 でなく N にすると、(3) の上界は成り立たない
a, N = QQ(2), 6
P = N // 2 + 1
rep.truth(RIF(partial(a, P, N)).lower() > R(a, N).upper(), "否定の対照: R_N(a) では Σ_{j=P_N}^{N} を抑えられない")
print("  確かめた行: %d" % rows)
rep.finish()
