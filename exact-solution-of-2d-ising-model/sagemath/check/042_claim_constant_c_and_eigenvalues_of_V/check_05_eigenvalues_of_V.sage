# ---------------------------------------------------------
# SageMath: V の固有値
#   V Q_eps = Lambda_eps Q_eps,
#   Lambda_eps = (2 s2)^{M/2} exp( sum gamma(theta_mu)(eps_mu - 1/2) )
#   固有値の重複度込みの多重集合が V の実際の固有値と一致すること、
#   Lambda_max / Lambda_min の表式、Lambda_max * Lambda_min = c^2
# 対象: structured-latex eigenvalues_of_V
#   （eigenvalues_of_Vprime も併せて検証）
# ---------------------------------------------------------
import os
import itertools
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

print("=== V の固有値 ===")
all_ok = True
for (M, K1v, K2v) in TEST_CASES:
    T = TransferSetup(M, K1v, K2v)
    Id = identity_matrix(CDF, T.d)
    V = T.V()
    Vp = T.Vprime()
    nops = T.number_operators()
    Iset = sorted(nops.keys())
    m = len(Iset)

    predicted = []
    r_eig = 0.0
    r_eigp = 0.0
    for eps in itertools.product([0, 1], repeat=m):
        Q = Id
        for (mu, e) in zip(Iset, eps):
            Q = Q * (nops[mu] if e == 1 else (Id - nops[mu]))
        g = RDF(0)
        for (mu, e) in zip(Iset, eps):
            g = g + T.gamma(mu) * (RDF(e) - RDF(1) / 2)
        lam = T.prefactor * CDF(exp(g))
        r_eig = max(r_eig, opnorm(V * Q - lam * Q) / abs(lam))
        r_eigp = max(r_eigp, opnorm(Vp * Q - CDF(exp(g)) * Q))
        predicted += [lam.real()] * (2 ** (M - m))

    actual = sorted([CDF(z).real() for z in V.eigenvalues()])
    predicted_sorted = sorted(predicted)
    r_spec = max(abs(a - b) / max(abs(b), 1e-30)
                 for a, b in zip(actual, predicted_sorted))

    gsum = RDF(0)
    for mu in Iset:
        gsum = gsum + T.gamma(mu)
    lam_max = T.prefactor * CDF(exp(gsum / 2))
    lam_min = T.prefactor * CDF(exp(-gsum / 2))
    r_max = abs(lam_max.real() - actual[-1]) / abs(actual[-1])
    r_min = abs(lam_min.real() - actual[0]) / abs(actual[0])
    r_prod = abs(lam_max * lam_min - T.prefactor ** 2) / abs(T.prefactor ** 2)

    worst = max(r_eig, r_eigp, r_spec, r_max, r_min, r_prod)
    ok = worst <= 1e-7
    print(f"  M={M}, K1={K1v}, K2={K2v} (|I|={m}): "
          f"VQ=LQ {r_eig:.2e}, V'Q {r_eigp:.2e}, spectrum {r_spec:.2e}, "
          f"Lmax {r_max:.2e}, Lmin {r_min:.2e}, Lmax*Lmin=c^2 {r_prod:.2e}"
          f"  -> {'PASS' if ok else 'FAIL'}")
    all_ok = ok and all_ok

print("RESULT: PASS" if all_ok else "RESULT: FAIL")
