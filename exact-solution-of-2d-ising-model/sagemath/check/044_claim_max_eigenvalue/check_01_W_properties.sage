# ---------------------------------------------------------
# SageMath: W の基本性質
#   W は実対称・正定値、成分はすべて正、epsilon と可換、Z = tr(W^n)
# 対象: structured-latex partition_function_sandwich
#   （W_is_real_symmetric_positive_definite / W_has_positive_entries /
#     Z_equals_trace_of_W も併せて検証）
# ---------------------------------------------------------
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

print("=== W の実対称性・正定値性・正値成分・epsilon との可換性 ===")
all_ok = True
for (M, K1v, K2v) in MAXEIG_CASES:
    O = SpinOps(M)
    W = W_matrix(O, K1v, K2v)
    Wr = to_real(W)
    eps = epsilon_op(O)
    r_sym = opnorm(W - W.transpose())
    r_imag = opnorm(W - W.conjugate())
    r_comm = opnorm(W * eps - eps * W)
    min_entry = min([Wr[i, j] for i in range(O.d) for j in range(O.d)])
    min_eig = min([RDF(CDF(z).real()) for z in Wr.eigenvalues()])
    # Z = tr(W^n) = tr((V1 V2)^n)
    V1V2 = V1_pauli(O, K1v) * V2_pauli(O, K2v)
    r_tr = 0.0
    for n in [1, 2, 3]:
        a = CDF((W ** n).trace()); b = CDF((V1V2 ** n).trace())
        r_tr = max(r_tr, abs(a - b) / max(abs(b), 1))
    ok = (max(r_sym, r_imag, r_comm, r_tr) <= 1e-9) and (min_entry > 0) and (min_eig > 0)
    print(f"  M={M}, K1={K1v}, K2={K2v}: 対称 {r_sym:.1e}, 実 {r_imag:.1e}, "
          f"[W,eps] {r_comm:.1e}, 最小成分 {min_entry:.3e}, 最小固有値 {min_eig:.3e}, "
          f"tr(W^n)=tr((V1V2)^n) {r_tr:.1e}  -> {'PASS' if ok else 'FAIL'}")
    all_ok = ok and all_ok

print("RESULT: PASS" if all_ok else "RESULT: FAIL")
