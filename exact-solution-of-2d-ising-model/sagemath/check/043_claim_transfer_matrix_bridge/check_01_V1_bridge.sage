# ---------------------------------------------------------
# SageMath: V_1 の成分定義とパウリ表示の一致
#   (exp(K_1 sum_m sz_m sz_{m+1}))_{iota(mu),iota(mu')}
#     = delta_{mu=mu'} exp( sum_m J' mu(m) mu(m+1) )     (K_1 = J')
# 対象: structured-latex V1_component_equals_pauli
#   （sigma_z_diagonal_action / exp_of_diagonal_matrix も併せて検証）
# ---------------------------------------------------------
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

print("=== V_1: 成分定義 vs パウリ表示 ===")
all_ok = True
for (M, K1v, K2v) in BRIDGE_CASES:
    O = SpinOps(M)
    Vc = V1_component(M, K1v)
    Vp = V1_pauli(O, K1v)
    r_eq = opnorm(Vc - Vp)
    # sigma^z_m f_{iota(mu)} = mu(m) f_{iota(mu)}
    r_diag = 0.0
    # V_1 の証明で周期端へ実際に用いる
    # sigma^z_M sigma^z_1 f_{iota(mu)} = mu(M) mu(1) f_{iota(mu)}
    r_boundary = 0.0
    for mu in all_configs(M):
        v = vector(CDF, [0] * O.d)
        v[config_index(mu)] = 1
        for m in range(1, M + 1):
            w = O.SZ[m] * v
            r_diag = max(r_diag, (w - mu[m - 1] * v).norm())
        w_boundary = O.SZ[M] * O.SZ[1] * v
        r_boundary = max(r_boundary, (w_boundary - mu[M - 1] * mu[0] * v).norm())
    # V_1 が対角行列であること
    r_offdiag = max([abs(Vp[k, l]) for k in range(O.d) for l in range(O.d) if k != l])
    ok = max(r_eq, r_diag, r_boundary, r_offdiag) <= TOL
    print(f"  M={M}, K1={K1v}: |Vc - Vp| = {r_eq:.2e}, sigma^z 作用 = {r_diag:.2e}, "
          f"周期端 = {r_boundary:.2e}, 非対角成分 = {r_offdiag:.2e}  -> {'PASS' if ok else 'FAIL'}")
    all_ok = ok and all_ok

print("RESULT: PASS" if all_ok else "RESULT: FAIL")
