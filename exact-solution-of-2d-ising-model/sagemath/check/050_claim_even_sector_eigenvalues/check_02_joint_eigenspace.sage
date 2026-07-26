# =========================================================================
# check_02: check_joint_eigenspace_decomposition
#
#   Q^_eps := prod_{mu=1}^{M} ( eps_mu n^_mu + (1-eps_mu)(I - n^_mu) )   (eps in {0,1}^M)
#
#   (1) Q^_eps Q^_eps' = 0 (eps != eps'),  (Q^_eps)^2 = Q^_eps
#   (2) sum_eps Q^_eps = I
#   (3) n^_nu Q^_eps = eps_nu Q^_eps
#   (4) tr(Q^_eps) = 2^{M-M} = 1、rank Q^_eps = 1（＝各同時固有空間は 1 次元）
#   (5) 個数は 2^M であり、次元の合計 2^M * 1 = 2^M が全空間に一致する
#
#   半整数運動量では gamma_2(theta~_mu) != 0 が常に成り立つので m = M であり、
#   009 章の 2^{M-m} 重の縮退が起こらない（各固有空間がちょうど 1 次元）。
# =========================================================================
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

print("=== check_02: 同時固有空間分解 Q^_eps ===")

ok_all = True
w_orth = 0
w_idem = 0
w_sum = 0
w_eig = 0
w_trace = 0
rank_bad = 0
count_bad = 0

for M in EIG_M:
    O = SpinOps(M)
    Id = identity_matrix(CDF, O.d)
    for p in EIG_PARAMS:
        P = coeffs(p['K1'], p['K2'])
        ns = n_check_all(O, P)
        E = eps_list(M)
        Qs = {eps: Q_check(O, eps, ns) for eps in E}
        if len(E) != 2 ** M:
            count_bad += 1
        S = matrix(CDF, O.d, O.d, 0)
        for eps in E:
            Q = Qs[eps]
            S = S + Q
            w_idem = max(w_idem, opnorm(Q * Q - Q))
            w_trace = max(w_trace, abs(Q.trace() - CDF(1)))
            # rank は数値的に特異値で判定する（丸め誤差に強い）
            sv = sorted([RDF(x) for x in Q.singular_values()], reverse=True)
            if not (sv[0] > 1e-3 and (len(sv) < 2 or sv[1] < 1e-6)):
                rank_bad += 1
            for nu in range(1, M + 1):
                w_eig = max(w_eig, opnorm(ns[nu] * Q - CDF(eps[nu - 1]) * Q))
            for eps2 in E:
                if eps2 == eps:
                    continue
                w_orth = max(w_orth, opnorm(Q * Qs[eps2]))
        w_sum = max(w_sum, opnorm(S - Id))

ok_all &= report("Q^_eps Q^_eps' = 0 (eps != eps')", w_orth, TOL)
ok_all &= report("(Q^_eps)^2 = Q^_eps", w_idem, TOL)
ok_all &= report("sum_eps Q^_eps = I", w_sum, TOL)
ok_all &= report("n^_nu Q^_eps = eps_nu Q^_eps", w_eig, TOL)
ok_all &= report("tr(Q^_eps) = 1", w_trace, TOL)

print(f"  rank Q^_eps = 1 に反した例の個数 = {rank_bad}  ->  {'PASS' if rank_bad == 0 else 'FAIL'}")
print(f"  |{{0,1}}^M| = 2^M に反した例の個数 = {count_bad}  ->  {'PASS' if count_bad == 0 else 'FAIL'}")
ok_all &= (rank_bad == 0 and count_bad == 0)

print("check_02:", "PASS" if ok_all else "FAIL")
