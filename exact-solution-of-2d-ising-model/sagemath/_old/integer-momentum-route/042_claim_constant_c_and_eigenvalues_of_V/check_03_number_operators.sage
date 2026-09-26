# ---------------------------------------------------------
# SageMath: フェルミオン数演算子 n_mu の性質と同時固有空間分解
#   n_mu^2 = n_mu, psi_{-mu} psi_mu^dagger = I - n_mu,
#   n_mu n_nu = n_nu n_mu, tr(n_{mu_1}...n_{mu_k}) = 2^{M-k},
#   sum_eps Q_eps = I, Q_eps Q_eps' = delta Q_eps, n_nu Q_eps = eps_nu Q_eps,
#   tr(Q_eps) = 2^{M-m}
# 対象: structured-latex joint_eigenspace_decomposition
#   （number_operator_idempotent / number_operators_commute /
#     trace_of_number_operator_product も併せて検証）
# ---------------------------------------------------------
import os
import itertools
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

print("=== 数演算子の性質と同時固有空間分解 ===")
all_ok = True
for (M, K1v, K2v) in TEST_CASES:
    T = TransferSetup(M, K1v, K2v)
    Id = identity_matrix(CDF, T.d)
    nops = T.number_operators()
    Iset = sorted(nops.keys())
    m = len(Iset)
    w = {'idem': 0.0, 'inv': 0.0, 'comm': 0.0, 'tr1': 0.0, 'tr2': 0.0,
         'sum': 0.0, 'orth': 0.0, 'eig': 0.0, 'trQ': 0.0}
    for mu in Iset:
        n = nops[mu]
        w['idem'] = max(w['idem'], opnorm(n * n - n))
        dag, _ = T.psi_pair(mu)
        _, ann = T.psi_pair(-mu)
        w['inv'] = max(w['inv'], opnorm(ann * dag - (Id - n)))
        w['tr1'] = max(w['tr1'], abs(CDF(n.trace()) - 2 ** (M - 1)))
        for nu in Iset:
            if nu <= mu:
                continue
            n2 = nops[nu]
            w['comm'] = max(w['comm'], opnorm(n * n2 - n2 * n))
            w['tr2'] = max(w['tr2'], abs(CDF((n * n2).trace()) - 2 ** (M - 2)))
    # Q_eps
    Qs = {}
    for eps in itertools.product([0, 1], repeat=m):
        Q = Id
        for (mu, e) in zip(Iset, eps):
            Q = Q * (nops[mu] if e == 1 else (Id - nops[mu]))
        Qs[eps] = Q
    tot = matrix(CDF, T.d, T.d, 0)
    for eps, Q in Qs.items():
        tot = tot + Q
        w['trQ'] = max(w['trQ'], abs(CDF(Q.trace()) - 2 ** (M - m)))
        for eps2, Q2 in Qs.items():
            target = Q if eps == eps2 else matrix(CDF, T.d, T.d, 0)
            w['orth'] = max(w['orth'], opnorm(Q * Q2 - target))
        for (mu, e) in zip(Iset, eps):
            w['eig'] = max(w['eig'], opnorm(nops[mu] * Q - e * Q))
    w['sum'] = opnorm(tot - Id)
    worst = max(w.values())
    ok = worst <= TOL
    print(f"  M={M}, K1={K1v}, K2={K2v} (|I|={m}): max residual = {worst:.2e}"
          f"  -> {'PASS' if ok else 'FAIL'}")
    if not ok:
        print(f"    detail: {w}")
    all_ok = ok and all_ok

print("RESULT: PASS" if all_ok else "RESULT: FAIL")
