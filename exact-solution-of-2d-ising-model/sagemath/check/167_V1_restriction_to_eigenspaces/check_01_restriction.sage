# <V1_restriction_to_eigenspaces>: (end(V_1))|_{F^{(±)}} = (end(V_1^{(±)}))|_{F^{(±)}}
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../../_shared/operators.sage"))
import numpy as np
rep = CheckReport("V1_restriction_to_eigenspaces")

def eig_basis(M, s):
    """F^{(s)} = {f | eps f = s f} の正規直交基底（列ベクトルを並べた行列）。"""
    E = eps_op(M)
    w, V = np.linalg.eigh(E)                 # eps はエルミート（実対称）
    cols = [V[:,k] for k in range(len(w)) if abs(w[k] - s) < 1e-8]
    return np.array(cols).T

for M in [2,3,4,5]:
    E = eps_op(M)
    rep.close(E @ E, eye_M(M), f"M={M}: eps^2 = I")
    for sgn, s in [('+', +1.0), ('-', -1.0)]:
        B = eig_basis(M, s)
        rep.truth(B.shape[1] == 2**(M-1), f"M={M} F^({sgn}) の次元 = 2^(M-1)")
        rep.close(E @ B, s*B, f"M={M}: eps B = {int(s)} B")
        for p in OP_TEST_PARAMS[:3]:
            K1 = p['K1']
            V1 = V1_op(K1, M)
            V1pm = V1pm_op(K1, M, sgn)         # exp(i K_1 H_1^{(sgn)}), H_1 の境界符号は ∓
            # F^{(±)} 上での作用の一致
            rep.close(V1 @ B, V1pm @ B, f"M={M} K1={K1} sgn={sgn}: V_1|F = V_1^({sgn})|F")
            # F^{(±)} が両者で不変であること（像を基底へ射影して戻して一致するか）
            P = B @ B.conj().T
            rep.close(P @ (V1 @ B), V1 @ B, f"M={M} K1={K1} sgn={sgn}: F^({sgn}) は V_1 で不変")
            rep.close(P @ (V1pm @ B), V1pm @ B, f"M={M} K1={K1} sgn={sgn}: F^({sgn}) は V_1^({sgn}) で不変")
            # 反対符号の V_1^{(∓)} では一致しない（複号同順であることの確認）
            other = '-' if sgn == '+' else '+'
            V1other = V1pm_op(K1, M, other)
            rep.truth(np.max(np.abs(V1 @ B - V1other @ B)) > 1e-6,
                      f"M={M} K1={K1} sgn={sgn}: V_1^({other}) では一致しない（複号同順）")
        # eps は H_1 の各項と可換（制限が意味をもつ根拠）
        rep.close(comm(E, H1_op(M, sgn)), np.zeros((2**M,2**M)), f"M={M}: [eps, H_1^({sgn})] = 0")
rep.finish()
