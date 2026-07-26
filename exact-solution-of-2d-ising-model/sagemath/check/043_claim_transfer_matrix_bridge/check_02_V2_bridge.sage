# ---------------------------------------------------------
# SageMath: V_2 の成分定義とパウリ表示の一致と、2x2 の恒等式
#   A = [[e^{K2}, e^{-K2}], [e^{-K2}, e^{K2}]] = (2 sinh 2K_2)^{1/2} exp(K_2^* sigma^x)
#   (V_2)_{mu,mu'} = ((2 s_2)^{M/2} exp(K_2^* sum_m sx_m))_{iota(mu),iota(mu')}
# 対象: structured-latex V2_component_equals_pauli
#   （two_by_two_transfer_identity も併せて検証）
# ---------------------------------------------------------
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

print("=== V_2: 成分定義 vs パウリ表示、および 2x2 の恒等式 ===")
all_ok = True
sx2 = matrix(CDF, [[0, 1], [1, 0]])
for (M, K1v, K2v) in BRIDGE_CASES:
    O = SpinOps(M)
    K2 = RDF(K2v); K2s = K_star(K2); s2 = RDF(sinh(2 * K2))
    # 2x2 恒等式
    A = matrix(CDF, [[CDF(exp(K2)), CDF(exp(-K2))], [CDF(exp(-K2)), CDF(exp(K2))]])
    A_rhs = CDF((2 * s2) ** RDF(0.5)) * matrix(CDF, (K2s * sx2).exp())
    r_2x2 = opnorm(A - A_rhs)
    # A のクロネッカー冪
    Akron = matrix(CDF, [[1]])
    for _ in range(M):
        Akron = Akron.tensor_product(A)
    r_kron = opnorm(matrix(CDF, Akron) - V2_component(M, K2v))
    # 成分定義 vs パウリ表示
    r_eq = opnorm(V2_component(M, K2v) - V2_pauli(O, K2v))
    ok = max(r_2x2, r_kron, r_eq) <= 1e-7
    print(f"  M={M}, K2={K2v}: 2x2 = {r_2x2:.2e}, A^(kron M) = {r_kron:.2e}, "
          f"|Vc - Vp| = {r_eq:.2e}  -> {'PASS' if ok else 'FAIL'}")
    all_ok = ok and all_ok

print("RESULT: PASS" if all_ok else "RESULT: FAIL")
