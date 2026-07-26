# ---------------------------------------------------------
# SageMath: N_row -> infinity の極限
#   | (1/(M N)) log Z - (1/M) log c(M) | <= log 2 / N
# 対象: structured-latex onsager_free_energy_expression
#   （limit_of_log_Z_in_N_row を検証）
#
# 注意: Z = tr(W^N) = sum_k w_k^N は N が大きいと倍精度で溢れる。
#       log Z = N log c + log( sum_k (w_k/c)^N ) と対数空間で計算する
#       （c = max_k w_k なので括弧内は 1 以上 2^M 以下）。
# ---------------------------------------------------------
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

print("=== (1/(M N)) log Z -> (1/M) log c(M) ===")
all_ok = True
for (M, K1v, K2v) in [(2, 0.4, 0.8), (3, 0.4, 0.8), (3, 0.7, 0.3), (4, 0.4, 0.8)]:
    O = SpinOps(M)
    Wr = to_real(W_matrix(O, K1v, K2v))
    evs = [RDF(CDF(z).real()) for z in Wr.eigenvalues()]
    c = max(evs)
    target = RDF(log(c) / M)
    ok = True
    row = []
    for N in [1, 2, 5, 10, 50, 200, 1000]:
        # log Z = N log c + log( sum (w/c)^N )
        tail = RDF(sum((w / c) ** N for w in evs))
        logZ = RDF(N * log(c) + log(tail))
        val = logZ / (M * N)
        err = abs(val - target)
        bound = RDF(log(2) / N)
        ok = ok and (err <= bound * (1 + 1e-9))
        row.append((N, float(err), float(bound)))
    print(f"  M={M}, K1={K1v}, K2={K2v}: (1/M)log c = {float(target):.10f}")
    for (N, e, b) in row:
        print(f"    N_row={N:5d}: |誤差|={e:.3e}  <= log2/N={b:.3e}")
    print(f"    -> {'PASS' if ok else 'FAIL'}")
    all_ok = ok and all_ok

print("RESULT: PASS" if all_ok else "RESULT: FAIL")
