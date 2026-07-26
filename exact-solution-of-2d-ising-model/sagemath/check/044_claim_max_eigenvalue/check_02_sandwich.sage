# ---------------------------------------------------------
# SageMath: 挟み撃ち  c^n <= tr(W^n) <= 2^M c^n,  および Z との一致
#   c = sup_{||x||=1} x^T W x
# 対象: structured-latex partition_function_sandwich
#   （trace_power_sandwich / rayleigh_bounds_operator_norm も併せて検証）
# ---------------------------------------------------------
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

print("=== c^n <= tr(W^n) <= 2^M c^n と Z の挟み撃ち ===")
all_ok = True
for (M, K1v, K2v) in MAXEIG_CASES:
    O = SpinOps(M)
    Wr = to_real(W_matrix(O, K1v, K2v))
    c = rayleigh_sup(Wr)
    ok = True
    detail = []
    for n in [1, 2, 3, 4, 5]:
        tr = RDF(sum([RDF(CDF(z).real()) ** n for z in Wr.eigenvalues()]))
        lo = c ** n
        hi = RDF(2) ** M * c ** n
        good = (lo <= tr * (1 + 1e-10)) and (tr <= hi * (1 + 1e-10))
        ok = ok and good
        detail.append((n, float(lo / tr), float(tr / hi)))
    # ||W x|| <= c ||x||（ランダムでなく標準基底と和ベクトルで確認）
    r_op = 0.0
    for k in range(O.d):
        e = vector(RDF, [1 if i == k else 0 for i in range(O.d)])
        r_op = max(r_op, (Wr * e).norm() / c)
    ones = vector(RDF, [1] * O.d)
    r_op = max(r_op, (Wr * ones).norm() / (c * ones.norm()))
    ok = ok and (r_op <= 1 + 1e-10)
    # Z（直接和）との一致（小さい格子のみ）
    zmsg = ""
    if M <= 3:
        Nrow = 3
        Zd = Z_direct(Nrow, M, K1v, K2v)
        tr = RDF(sum([RDF(CDF(z).real()) ** Nrow for z in Wr.eigenvalues()]))
        rz = abs(tr - Zd) / abs(Zd)
        zok = (c ** Nrow <= Zd * (1 + 1e-10)) and (Zd <= RDF(2) ** M * c ** Nrow * (1 + 1e-10))
        ok = ok and (rz <= 1e-9) and zok
        zmsg = f", Z 一致 rel={rz:.1e}, Z 挟み撃ち={zok}"
    print(f"  M={M}, K1={K1v}, K2={K2v}: c={c:.6f}, "
          f"下限比(最小)={min(d[1] for d in detail):.4f}, 上限比(最大)={max(d[2] for d in detail):.4f}, "
          f"||Wx||/(c||x||) 最大={r_op:.6f}{zmsg}  -> {'PASS' if ok else 'FAIL'}")
    all_ok = ok and all_ok

print("RESULT: PASS" if all_ok else "RESULT: FAIL")
