# ---------------------------------------------------------
# SageMath: 定数 c の決定
#   V'^{-1} V = c I  かつ  c = (2 sinh 2K_2)^{M/2}
#   併せて tr(V') = tr(V'^{-1}) = 2^{M-m} prod 2cosh(gamma/2) > 0、
#         tr(V) > 0、 tr(V)/tr(V^{-1}) = c^2 を確認する。
# 対象: structured-latex constant_c_value
# ---------------------------------------------------------
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

print("=== 定数 c = (2 sinh 2K_2)^{M/2} ===")
all_ok = True
for (M, K1v, K2v) in TEST_CASES:
    T = TransferSetup(M, K1v, K2v)
    Id = identity_matrix(CDF, T.d)
    V = T.V()
    Vp = T.Vprime()
    Vpi = Vp.inverse()
    Vi = V.inverse()
    Iset = sorted(T.number_operators().keys())
    m = len(Iset)

    # (a) V'^{-1} V = c I
    W = Vpi * V
    cval = CDF(W[0, 0])
    r_scalar = opnorm(W - cval * Id)
    # (b) c = (2 s2)^{M/2}
    r_c = abs(cval - T.prefactor) / abs(T.prefactor)
    # (c) tr(V') の閉じた表式と tr(V'^{-1}) との一致
    prod = RDF(1)
    for mu in Iset:
        prod = prod * (2 * RDF(cosh(T.gamma(mu) / 2)))
    trVp_expected = RDF(2) ** (M - m) * prod
    r_trVp = abs(CDF(Vp.trace()) - trVp_expected) / abs(trVp_expected)
    r_trVpi = abs(CDF(Vpi.trace()) - trVp_expected) / abs(trVp_expected)
    # (d) tr(V) > 0, tr(V^{-1}) > 0
    trV = CDF(V.trace())
    trVi = CDF(Vi.trace())
    pos_ok = (trV.real() > 0 and abs(trV.imag()) < 1e-8
              and trVi.real() > 0 and abs(trVi.imag()) < 1e-8)
    # (e) tr(V)/tr(V^{-1}) = c^2
    r_ratio = abs(trV / trVi - cval ** 2) / abs(cval ** 2)

    worst = max(r_scalar, r_c, r_trVp, r_trVpi, r_ratio)
    ok = (worst <= 1e-7) and pos_ok
    print(f"  M={M}, K1={K1v}, K2={K2v} (|I|={m}): "
          f"V'^-1 V - cI = {r_scalar:.2e}, c/(2s2)^(M/2)-1 = {r_c:.2e}, "
          f"tr(V') = {r_trVp:.2e}, tr(V'^-1) = {r_trVpi:.2e}, "
          f"tr(V)/tr(V^-1)/c^2-1 = {r_ratio:.2e}, trace positive: {pos_ok}"
          f"  -> {'PASS' if ok else 'FAIL'}")
    all_ok = ok and all_ok

print("RESULT: PASS" if all_ok else "RESULT: FAIL")
