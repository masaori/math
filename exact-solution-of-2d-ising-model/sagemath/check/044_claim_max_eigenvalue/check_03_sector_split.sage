# ---------------------------------------------------------
# SageMath: W P^{(+)} = V^{(+)} P^{(+)}（symmetrized_transfer_matrix_on_sectors の結論）
#   あわせて観測として、c(M) と c_+(M) の値を並べて記録する（本文はこの一致を使わない。
#   本文が使うのは c_+(M) <= c(M) だけで、それは check/c_plus_le_c/ が検証する）。
# 対象: structured-latex symmetrized_transfer_matrix_on_sectors
# ---------------------------------------------------------
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

print("=== W P^{(+)} = V^{(+)} P^{(+)} ===")
all_ok = True
for (M, K1v, K2v) in MAXEIG_CASES:
    O = SpinOps(M)
    W = W_matrix(O, K1v, K2v)
    Wr = to_real(W)
    Pp = projector_plus(O)
    c = rayleigh_sup(Wr)
    cp = rayleigh_sup(to_real(Pp * W * Pp))
    Vp = V_plus(O, K1v, K2v)
    r_rep = opnorm(W * Pp - Vp * Pp) / max(opnorm(W * Pp), 1)
    ok = r_rep <= 1e-9
    print(f"  M={M}, K1={K1v}, K2={K2v}: W P = V^(+) P {r_rep:.1e}"
          f"  （観測: c={c:.6f}, c+={cp:.6f}）  -> {'PASS' if ok else 'FAIL'}")
    all_ok = ok and all_ok

print("RESULT: PASS" if all_ok else "RESULT: FAIL")

if not all_ok:
    raise AssertionError("sector representation numerical checks failed")
