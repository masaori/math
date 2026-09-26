# ---------------------------------------------------------
# SageMath: c(M) = max(c_+(M), c_-(M)) と、最大が (+) セクターにあること
#   W P^{(pm)} = V^{(pm)} P^{(pm)} も確認する。
# 対象: structured-latex sector_decomposition_of_rayleigh_sup / symmetrized_transfer_matrix_on_sectors
# ---------------------------------------------------------
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

print("=== c(M) = max(c_+, c_-) とセクターの特定 ===")
all_ok = True
for (M, K1v, K2v) in MAXEIG_CASES:
    O = SpinOps(M)
    W = W_matrix(O, K1v, K2v)
    Wr = to_real(W)
    Pp, Pm = projectors(O)
    c = rayleigh_sup(Wr)
    cp = rayleigh_sup(to_real(Pp * W * Pp))
    cm = rayleigh_sup(to_real(Pm * W * Pm))
    r_max = abs(c - max(cp, cm)) / abs(c)
    # W P^{(pm)} = V^{(pm)} P^{(pm)}
    r_rep = 0.0
    for sgn, P in [(1, Pp), (-1, Pm)]:
        Vs = V_sym(O, K1v, K2v, sgn)
        r_rep = max(r_rep, opnorm(W * P - Vs * P) / max(opnorm(W * P), 1))
    which = '(+)' if cp > cm else '(-)'
    ok = (r_max <= 1e-9) and (r_rep <= 1e-9) and (which == '(+)')
    print(f"  M={M}, K1={K1v}, K2={K2v}: c={c:.6f}, c+={cp:.6f}, c-={cm:.6f}, "
          f"|c-max|/c={r_max:.1e}, W P = V^pm P {r_rep:.1e}, 最大は{which}"
          f"  -> {'PASS' if ok else 'FAIL'}")
    all_ok = ok and all_ok

print("RESULT: PASS" if all_ok else "RESULT: FAIL")

if not all_ok:
    raise AssertionError("sector split numerical checks failed")
