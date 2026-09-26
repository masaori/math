# ---------------------------------------------------------
# SageMath: epsilon の射影子 P^{(+)} と、epsilon・P^{(+)} と転送行列との可換性
#   epsilon_projector_properties:
#     (1) (P^{(+)})^2 = P^{(+)}
#     (2) im P^{(+)} = F^{(+)}   （⊆: eps P^{(+)} = P^{(+)}、⊇: eps f = f なら P^{(+)} f = f）
#   epsilon_commutes_with_transfer_matrices:
#     [eps, V_1] = [eps, V_2] = [eps, V_1^{(+)}] = [eps, (V_1^{(+)})^{1/2}] = 0
#   epsilon_projectors_commute_with_transfer_matrices:
#     [P^{(+)}, V_1] = [P^{(+)}, V_2] = [P^{(+)}, V_1^{(+)}] = [P^{(+)}, (V_1^{(+)})^{1/2}] = 0
#   あわせて前提の eps^2 = I（epsilon_square_and_eigenvalues）も確認する。
# ---------------------------------------------------------
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

print("=== epsilon の射影子 P^{(+)} と転送行列との可換性 ===")
all_ok = True
for (M, K1v, K2v) in BRIDGE_CASES:
    O = SpinOps(M)
    Id = identity_matrix(CDF, O.d)
    eps = epsilon_op(O)
    Pp = projector_plus(O)
    V1 = V1_pauli(O, K1v)
    V2 = V2_pauli(O, K2v)
    V1p = V1_plus(O, K1v)
    V1p_half = V1_plus_half(O, K1v)
    r = {}
    r['eps^2=I'] = opnorm(eps * eps - Id)
    r['P+^2=P+'] = opnorm(Pp * Pp - Pp)
    # im P^{(+)} ⊆ F^{(+)}: eps P^{(+)} x = P^{(+)} x（すべての x について、すなわち行列として）
    r['eps P+ = P+'] = opnorm(eps * Pp - Pp)
    # F^{(+)} ⊆ im P^{(+)}: F^{(+)} の基底ベクトル f（e_k + e_{flip(k)}）について P^{(+)} f = f
    for k in range(O.d):
        f = vector(CDF, O.d)
        f[k] += 1
        f[O.d - 1 - k] += 1
        r[f'eps f = f ({k})'] = (eps * f - f).norm()
        r[f'P+ f = f ({k})'] = (Pp * f - f).norm()
    r['[eps,V1]'] = opnorm(eps * V1 - V1 * eps)
    r['[eps,V2]'] = opnorm(eps * V2 - V2 * eps)
    r['[eps,V1+]'] = opnorm(eps * V1p - V1p * eps)
    r['[eps,(V1+)^1/2]'] = opnorm(eps * V1p_half - V1p_half * eps)
    r['[P+,V1]'] = opnorm(Pp * V1 - V1 * Pp)
    r['[P+,V2]'] = opnorm(Pp * V2 - V2 * Pp)
    r['[P+,V1+]'] = opnorm(Pp * V1p - V1p * Pp)
    r['[P+,(V1+)^1/2]'] = opnorm(Pp * V1p_half - V1p_half * Pp)
    # (V_1^{(+)})^{1/2} の二乗が V_1^{(+)}（V1_plus_square_root_property。可換性の前提として併記）
    r['((V1+)^1/2)^2=V1+'] = opnorm(V1p_half * V1p_half - V1p) / max(opnorm(V1p), 1)
    worst = max(r.values())
    ok = worst <= TOL
    print(f"  M={M}, K1={K1v}, K2={K2v}: max residual = {worst:.2e}  -> {'PASS' if ok else 'FAIL'}")
    if not ok:
        print("    detail:", {k: v for k, v in r.items() if v > TOL})
    all_ok = ok and all_ok

print("RESULT: PASS" if all_ok else "RESULT: FAIL")
