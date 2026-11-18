# <theorem_exp_product>: Step 5 の鎖の最後の 3 段
#   ‖I‖^2 ( (Σ_{j=P_N}^{N} a^j/j!)(Σ_{l=0}^{N} b^l/l!) + (Σ_{j=0}^{N} a^j/j!)(Σ_{l=P_N}^{N} b^l/l!) )
#     = ‖I‖^2 ( (Σ_{j=P_N}^{N} a^j/j!) E_N(b) + E_N(a) (Σ_{l=P_N}^{N} b^l/l!) )  (∵ E_N の定義)
#     ≤ ‖I‖^2 ( R_{P_N-1}(a) E_N(b) + E_N(a) R_{P_N-1}(b) )    (∵ real_exp_series_converges (3)。N = 0 は空の和 0 と R_{P_N-1} ≥ 0)
#     ≤ ‖I‖^2 ( R_{P_N-1}(a) E(b) + E(a) R_{P_N-1}(b) )        (∵ real_exp_series_converges (2)。R_{P_N-1} ≥ 0)
# を確かめる。P_N は 2j > N を満たす最小の整数 j。部分和は QQ で厳密に、E・R は ℝ の極限なので
# RealIntervalField の区間で囲む（ℝ への脱出: E(a) は部分和の極限として ℝ にしか住まない）。
# 等号の段は E_N の定義（QQ で厳密に一致）。(3) の段は p = P_N, q = N（P_N ≤ N のとき）を Σ_{j=P_N}^{N}・Σ_{l=P_N}^{N} に当て、
# 掛かる因子 E_N(·) ≥ 0 で積と和へ運ぶ。(2) の段は (2) を E_N(·) に当て、掛かる因子 R_{P_N-1}(·) ≥ 0（(3) の前半）で積と和へ運ぶ。
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
            # (3) の段で掛かる因子 E_N(·) ≥ 0
            rep.truth(partial(a, 0, N) >= 0 and partial(b, 0, N) >= 0, f"E_N ≥ 0 a={a}, b={b}, N={N}")
            # (2)
            rep.truth(le(RIF(partial(b, 0, N)), E(b)), f"(2) b={b}, N={N}")
            rep.truth(le(RIF(partial(a, 0, N)), E(a)), f"(2) a={a}, N={N}")
            # (2) の段で掛かる因子 R_{P_N-1}(·) ≥ 0（(3) の前半）
            rep.truth(le(RIF(0), R(a, P - 1)) and le(RIF(0), R(b, P - 1)), f"R_(P_N-1) ≥ 0 a={a}, b={b}, N={N}")
            for normI2 in [AA(1), AA(4), AA(7)]:
                # 等号の段: Σ_{j=0}^{N} a^j/j!・Σ_{l=0}^{N} b^l/l! を E_N(a)・E_N(b) と読む（QQ で厳密に）
                EN_a = sum(QQ(a) ** m / factorial(m) for m in range(0, N + 1))
                EN_b = sum(QQ(b) ** m / factorial(m) for m in range(0, N + 1))
                rep.truth(normI2 * (partial(a, P, N) * partial(b, 0, N) + partial(a, 0, N) * partial(b, P, N))
                          == normI2 * (partial(a, P, N) * EN_b + EN_a * partial(b, P, N)), f"等号の段 a={a}, b={b}, N={N}, ‖I‖^2={normI2}")
                lhs = RIF(normI2) * (RIF(partial(a, P, N)) * RIF(EN_b)
                                     + RIF(EN_a) * RIF(partial(b, P, N)))
                mid = RIF(normI2) * (R(a, P - 1) * RIF(EN_b) + RIF(EN_a) * R(b, P - 1))
                rhs = RIF(normI2) * (R(a, P - 1) * E(b) + E(a) * R(b, P - 1))
                rep.truth(le(lhs, mid), f"(3) の段 a={a}, b={b}, N={N}, ‖I‖^2={normI2}")
                # (2) の段: a = 0 などで両辺が等しくなり、区間の幅で le が落ちるので、差
                # rhs − mid = ‖I‖^2 (R_{P_N-1}(a)(E(b) − E_N(b)) + (E(a) − E_N(a)) R_{P_N-1}(b))
                # の各因子を区間で作り、下端が 0 以上であることで比べる（E − E_N = R_N）。
                diff = RIF(normI2) * (R(a, P - 1) * R(b, N) + R(a, N) * R(b, P - 1))
                rep.truth(diff.lower() >= 0, f"(2) の段 a={a}, b={b}, N={N}, ‖I‖^2={normI2}")
                rows += 1
# 否定の対照: 剰余の添字を P_N − 1 でなく N にすると、(3) の上界は成り立たない
a, N = QQ(2), 6
P = N // 2 + 1
rep.truth(RIF(partial(a, P, N)).lower() > R(a, N).upper(), "否定の対照: R_N(a) では Σ_{j=P_N}^{N} を抑えられない")
print("  確かめた行: %d" % rows)
rep.finish()
