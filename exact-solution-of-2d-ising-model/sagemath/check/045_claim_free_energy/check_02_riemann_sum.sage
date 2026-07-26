# ---------------------------------------------------------
# SageMath: リーマン和 -> 積分（実数解析への移行点）と Onsager の表式
#   (1/M) sum_{mu} gamma(2 pi (mu - delta)/M) -> (1/2pi) int_0^{2pi} gamma
#   (1/M) log Lambda^{(delta)}_M -> (1/2) log(2 sinh 2K2) + (1/4pi) int gamma
#   delta = 0（整数運動量）と delta = 1/2（半整数運動量）の両方で同じ極限。
# 対象: structured-latex onsager_free_energy_expression
#   （riemann_sum_to_integral / gamma_is_continuous / gamma1_lower_bound_all_theta も検証）
#
# 注意: Lambda^{(delta)}_M 自体は M が大きいと倍精度で溢れるので、
#       (1/M) log Lambda = (1/2) log(2 sinh 2K2) + (1/(2M)) sum gamma
#       と対数空間で直接計算する（本文 onsager_free_energy_expression の proof の式）。
# ---------------------------------------------------------
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))


def log_Lambda_over_M(M, K1, K2, delta):
    g = gamma_fn(K1, K2)
    s2 = RDF(sinh(2 * RDF(K2)))
    tot = sum(g(th) for th in theta_family(M, delta))
    return RDF(log(2 * s2) / 2 + tot / (2 * M))


print("=== リーマン和 -> 積分、および Onsager の表式 ===")
all_ok = True
HALF = RDF(1) / 2
for (K1v, K2v) in FE_CASES:
    g = gamma_fn(K1v, K2v)
    lower = gamma1_lower(K1v, K2v)
    K1 = RDF(K1v); K2 = RDF(K2v); K2s = K_star(K2)
    c1 = RDF(cosh(2*K1)); s1 = RDF(sinh(2*K1))
    c2s = RDF(cosh(2*K2s)); s2s = RDF(sinh(2*K2s))
    worst = min(RDF(c1*c2s - s1*s2s*RDF(cos(RDF(2*pi*k/2000)))) for k in range(2000))
    bound_ok = bool((worst >= lower * (1 - 1e-12)) and (lower >= 1 - 1e-12))
    target = onsager_rhs(K1v, K2v)
    Ival = integral_of_gamma(K1v, K2v) / (2 * RDF(pi))
    print(f"  K1={K1v}, K2={K2v}: gamma_1 の最小={float(worst):.8f} >= "
          f"cosh(2K1-2K2*)={float(lower):.8f} >= 1 -> {bound_ok}")
    print(f"    (1/2pi)∫gamma = {float(Ival):.10f},  Onsager 右辺 = {float(target):.10f}")
    ok = bound_ok
    prev = None
    for M in [10, 100, 1000, 10000]:
        e0 = abs(sum(g(th) for th in theta_family(M, 0)) / M - Ival)
        eh = abs(sum(g(th) for th in theta_family(M, HALF)) / M - Ival)
        l0 = abs(log_Lambda_over_M(M, K1v, K2v, 0) - target)
        lh = abs(log_Lambda_over_M(M, K1v, K2v, HALF) - target)
        print(f"    M={M:6d}: |和-積分| 整数点 {float(e0):.3e} / 半整数点 {float(eh):.3e}"
              f"  |(1/M)logΛ-Onsager| 整数点 {float(l0):.3e} / 半整数点 {float(lh):.3e}")
        if prev is not None:
            ok = ok and (e0 <= prev[0] * 1.05 + 1e-12) and (eh <= prev[1] * 1.05 + 1e-12)
        prev = (e0, eh)
        if M == 10000:
            ok = ok and (e0 <= 1e-6) and (eh <= 1e-6) and (l0 <= 1e-6) and (lh <= 1e-6)
    print(f"    -> {'PASS' if ok else 'FAIL'}")
    all_ok = ok and all_ok

print("RESULT: PASS" if all_ok else "RESULT: FAIL")
