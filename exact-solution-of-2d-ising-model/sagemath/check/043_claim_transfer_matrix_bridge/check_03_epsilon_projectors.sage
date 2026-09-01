# ---------------------------------------------------------
# SageMath: epsilon の射影子と可換性、セクター上での V_1 の置き換え
#   eps^2 = I, (P^pm)^2 = P^pm, P^+ P^- = 0, P^+ + P^- = I,
#   [eps, V_1] = [eps, V_2] = [eps, V_1^{(pm)}] = 0,
#   V_1 P^{(pm)} = V_1^{(pm)} P^{(pm)},
#   (V_1V_2)^n P^{(pm)} = (V_1^{(pm)} V_2)^n P^{(pm)}
# 対象: structured-latex sector_replacement_of_V1 / sector_replacement_pow
#   （epsilon_projector_properties / epsilon_commutes_with_transfer_matrices も検証）
# ---------------------------------------------------------
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

print("=== epsilon の射影子・可換性・セクター置き換え ===")
all_ok = True
for (M, K1v, K2v) in BRIDGE_CASES:
    O = SpinOps(M)
    Id = identity_matrix(CDF, O.d)
    eps = epsilon_op(O)
    Pp, Pm = projectors(O)
    V1 = V1_pauli(O, K1v)
    V2 = V2_pauli(O, K2v)
    r = {}
    r['eps^2=I'] = opnorm(eps * eps - Id)
    r['P+^2=P+'] = opnorm(Pp * Pp - Pp)
    r['P-^2=P-'] = opnorm(Pm * Pm - Pm)
    r['P+P-=0'] = opnorm(Pp * Pm)
    r['P-P+=0'] = opnorm(Pm * Pp)
    r['P++P-=I'] = opnorm(Pp + Pm - Id)
    r['[eps,V1]'] = opnorm(eps * V1 - V1 * eps)
    r['[eps,V2]'] = opnorm(eps * V2 - V2 * eps)
    for sgn, P in [(1, Pp), (-1, Pm)]:
        V1s = V1_pm(O, K1v, sgn)
        half = matrix(CDF, (CDF(I) / 2 * RDF(K1v) * O.H1(sgn)).exp())
        r[f'[eps,V1^{sgn:+d}]'] = opnorm(eps * V1s - V1s * eps)
        r[f'[eps,sqrtV1^{sgn:+d}]'] = opnorm(eps * half - half * eps)
        r[f'V1P=V1pmP({sgn:+d})'] = opnorm(V1 * P - V1s * P)
        # im P^{(pm)} が eps の固有空間であること
        r[f'eps P = {sgn:+d} P'] = opnorm(eps * P - sgn * P)
        # (V1V2)^n P = (V1^pm V2)^n P
        L = Id; R = Id
        for n in range(1, 4):
            L = L * (V1 * V2)
            R = R * (V1s * V2)
            r[f'pow{n}({sgn:+d})'] = opnorm(L * P - R * P) / max(opnorm(L * P), 1)
    worst = max(r.values())
    ok = worst <= TOL
    print(f"  M={M}, K1={K1v}, K2={K2v}: max residual = {worst:.2e}  -> {'PASS' if ok else 'FAIL'}")
    if not ok:
        print("    detail:", {k: v for k, v in r.items() if v > TOL})
    all_ok = ok and all_ok

print("RESULT: PASS" if all_ok else "RESULT: FAIL")
