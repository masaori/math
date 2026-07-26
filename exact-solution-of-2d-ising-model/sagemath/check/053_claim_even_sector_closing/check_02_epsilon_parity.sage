# =========================================================================
# check_02: epsilon_eigenvalue_on_check_Q / max_eigenvector_in_even_sector
#   (1) ε Q̌_ε = η_ε Q̌_ε,  η_ε ∈ {+1,−1}
#   (2) ε_μ = 0 ⟹ η_{ε[μ→1]} = −η_ε（ψ̌_μ^† による橋渡し。ψ̌_μ^† q ≠ 0 も確認）
#   (3) η_ε = η_{(1,…,1)} (−1)^{M−|ε|}
#   (4) ε = η_{(1,…,1)} (−1)^M Π_μ (I − 2ň_μ)
#   (5) η_{(1,…,1)} = +1、したがって η_ε = (−1)^{M+|ε|}、ε = (−1)^M Π(I − 2ň_μ)
#   (6) im Q̌_{(1,…,1)} ⊆ F^{(+)}（ε Q̌_max = +Q̌_max）
# =========================================================================
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

print("=== check_02: ε の Q̌_ε 上の固有値 η_ε とパリティ表示 ===")

ok_all = True
w_eig = 0        # ε Q̌_ε = η_ε Q̌_ε の残差
w_flip = 0       # 反転則の違反件数（0 であるべき）
w_pred = 0       # η_ε = (−1)^{M+|ε|} の違反件数
w_parity = 0     # ε = (−1)^M Π(I − 2ň_μ) の残差
w_max = 0        # ε Q̌_{(1,…,1)} = +Q̌_{(1,…,1)} の残差
w_psi_nonzero = None  # ψ̌_μ^† q の最小ノルム（0 でないこと）

def eta_of(E, Q):
    """ε Q̌ = η Q̌ を満たす η を、Q̌ の最大成分の比から読み取る。"""
    n = Q.nrows()
    best = None; bi = bj = 0
    for i in range(n):
        for j in range(n):
            a = abs(Q[i, j])
            if best is None or a > best:
                best = a; bi = i; bj = j
    return CDF((E * Q)[bi, bj] / Q[bi, bj])

for M in EIG_M:
    O = SpinOps(M)
    E = eps_op(O)
    Id = identity_matrix(CDF, O.d)
    for p in EIG_PARAMS:
        P = coeffs(p['K1'], p['K2'])
        ns = n_check_all(O, P)
        eta = {}
        for e in eps_list(M):
            Q = Q_check(O, e, ns)
            h = eta_of(E, Q)
            w_eig = max(w_eig, opnorm(E * Q - h * Q))
            # η が ±1 の実数であること
            w_eig = max(w_eig, abs(h.imag()), min(abs(h - 1), abs(h + 1)))
            eta[e] = RDF(h.real())
        # (2) 反転則
        for e in eps_list(M):
            for mu in range(1, M + 1):
                if e[mu - 1] != 0:
                    continue
                e2 = list(e); e2[mu - 1] = 1; e2 = tuple(e2)
                if abs(eta[e2] + eta[e]) > 1e-6:
                    w_flip += 1
                # ψ̌_μ^† q ≠ 0
                Q = Q_check(O, e, ns)
                pdag, _ = psi_pair(O, mu, P)
                nrm = opnorm(pdag * Q)
                w_psi_nonzero = nrm if w_psi_nonzero is None else min(w_psi_nonzero, nrm)
        # (3)(5) η_ε = (−1)^{M+|ε|}
        for e in eps_list(M):
            if abs(eta[e] - RDF((-1) ** (M + sum(e)))) > 1e-6:
                w_pred += 1
        # (4)(5) ε = (−1)^M Π(I − 2ň_μ)
        pr = Id
        for mu in range(1, M + 1):
            pr = pr * (Id - 2 * ns[mu])
        w_parity = max(w_parity, opnorm(E - CDF((-1) ** M) * pr))
        # (6)
        Qmax = Q_check(O, tuple([1] * M), ns)
        w_max = max(w_max, opnorm(E * Qmax - Qmax))

ok_all &= report("(1) ε Q̌_ε = η_ε Q̌_ε,  η_ε ∈ {±1}", w_eig, TOL)
print(f"  (2) 反転則 η_{{ε[μ→1]}} = −η_ε の違反件数: {w_flip}  ->  {'PASS' if w_flip == 0 else 'FAIL'}")
print(f"      ψ̌_μ^† Q̌_ε のノルムの最小値（0 でないこと）: {float(w_psi_nonzero):.3e}")
ok_all &= (w_flip == 0)
print(f"  (3)(5) η_ε = (−1)^{{M+|ε|}} の違反件数: {w_pred}  ->  {'PASS' if w_pred == 0 else 'FAIL'}")
ok_all &= (w_pred == 0)
ok_all &= report("(4)(5) ε = (−1)^M Π_μ (I − 2ň_μ)", w_parity, TOL)
ok_all &= report("(6) ε Q̌_{(1,…,1)} = +Q̌_{(1,…,1)}", w_max, TOL)

print("=== check_02: " + ("ALL PASS" if ok_all else "FAIL") + " ===")
