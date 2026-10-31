# ---------------------------------------------------------
# SageMath: 主張 c_between_Lambda_half_and_twice_Lambda_half の証明を一行ずつ確かめる。
#   Step 1（下からの評価）: c(M) >= c_+(M)（c_plus_le_c）と c_+(M) = Λ^{(1/2)}_M（c_plus_equals_Lambda_half_integer）
#   Step 2（上からの評価）: 単位ベクトル x から u := |x|、v := u + εu を作り、本文の式変形の各行を確かめて
#                          c(M) <= 2Λ^{(1/2)}_M を得る
#   結論: Λ^{(1/2)}_M <= c(M) <= 2Λ^{(1/2)}_M
#   下界の鋭さの確認: 下界を 1.01Λ にしたもの（1.01Λ <= c）と上界を 0.99Λ にしたもの（c <= 0.99Λ）が
#                     すべての組で破れること（数値では c = c_+ = Λ なので、上からの評価の検査にはならない）。
#   否定コントロール: Step 2 の ‖v‖^2 <= 4 を ‖v‖^2 <= 2 にすると破れる x があること、
#                     F^{(+)} を F^{(-)} に替えた c(M) <= 2c_-(M) が破れる組があること（上からの評価が
#                     εv = v、すなわち F^{(+)} への制限に依ることの対照）。
#   以下の検算の本体（行ごとの判定）は 053_claim_even_sector_closing/check_05 の (1)〜(3) と同じものを、
#   この主張だけについて走らせる（Step の番号はこの主張の証明の番号に直した）。
# 対象ラベル: c_between_Lambda_half_and_twice_Lambda_half
# 対象: structured-latex/content/thermodynamic_limit_column_limit_and_closed_form.ts
#       ブロック column_limit_claim_c_between_Lambda_half_and_twice_Lambda_half
# 帰属: W は行列の指数関数から作るので成分が超越数になり、c(M), c_+(M) は上限（実数の完備性）で定まり、
#       Λ^{(1/2)}_M は実数の指数関数と arccosh の値なので、厳密計算できない（ℝ 脱出: 指数評価・完備性）。
#       倍精度（CDF・RDF）で計算し、不等式は相対 1e-12 の余裕で判定する。
#       c(M)・c_+(M) を W（とその F^{(+)} への制限）の最大固有値として作るのは検算の手段である。
# ---------------------------------------------------------
import os
_dir = os.getcwd()   # このディレクトリで実行する（overview.md の「実行方法」）
__file__ = os.path.join(_dir, "../053_claim_even_sector_closing/_prelude.sage")
load(__file__)

print("=== c_between_Lambda_half_and_twice_Lambda_half ===")
ok_all = True
set_random_seed(20261031)


def flip_index(M, k):
    return (2 ** M - 1) - k


def even_sector_basis(M):
    """F^{(+)} ∩ R^{2^M} の正規直交基底（実）。"""
    d = 2 ** M
    cols = []
    for k in range(d):
        kb = flip_index(M, k)
        if k < kb:
            v = vector(RDF, d)
            v[k] = 1 / sqrt(RDF(2)); v[kb] = 1 / sqrt(RDF(2))
            cols.append(v)
    return matrix(RDF, cols).transpose()


def odd_sector_basis(M):
    """F^{(-)} ∩ R^{2^M} の正規直交基底（実）。否定コントロール用。"""
    d = 2 ** M
    cols = []
    for k in range(d):
        kb = flip_index(M, k)
        if k < kb:
            v = vector(RDF, d)
            v[k] = 1 / sqrt(RDF(2)); v[kb] = -1 / sqrt(RDF(2))
            cols.append(v)
    return matrix(RDF, cols).transpose()


def top_eig(A):
    return max([RDF(CDF(z).real()) for z in A.eigenvalues()])


def to_real(A):
    return matrix(RDF, [[A[i, j].real() for j in range(A.ncols())] for i in range(A.nrows())])


def test_vectors(M, Wr):
    """Step 2 の x の例: 乱数（符号の混じった成分）、W の最大固有ベクトル、F^{(-)} 側の実ベクトル。"""
    d = 2 ** M
    xs = []
    for _ in range(6):
        x = vector(RDF, [RDF.random_element(-1, 1) for _ in range(d)])
        xs.append(x / x.norm())
    import numpy as np
    w, V = np.linalg.eigh(np.array([[float(Wr[i, j]) for j in range(d)] for i in range(d)]))
    x = vector(RDF, [RDF(t) for t in V[:, int(np.argmax(w))]])
    xs.append(x / x.norm())
    y = vector(RDF, d)
    y[0] = 1; y[flip_index(M, 0)] = -1   # ε y = −y（奇セクター側の実ベクトル。u = |y| は偶セクターへ移る）
    xs.append(y / y.norm())
    return xs


REL = 1e-12   # 不等式の判定の相対余裕（倍精度の丸め分）。等式は TOL で判定する。
w_step2 = w_lower = 0
w_sand = 0
w_ceq = RDF(0)
w3_eq = RDF(0)
w3_ineq = 0
n3 = 0
neg_low_ok = True
neg_up_ok = True
neg_norm_hits = 0
neg_minus_hits = 0
print("  --- 有限 M での Step 1 / Step 2 ---")
for M in EIG_M:
    O = SpinOps(M)
    E = to_real(eps_op(O))
    Id = identity_matrix(RDF, O.d)
    for p in EIG_PARAMS:
        K1 = RDF(p['K1']); K2 = RDF(p['K2'])
        P = coeffs(K1, K2)
        Wr = to_real(W_op(O, K1, K2))
        cM = top_eig(Wr)
        Bp = even_sector_basis(M)
        cp = top_eig(Bp.transpose() * Wr * Bp)
        Lhalf = Lambda_delta_M(O, P, RDF(1) / 2)
        # (1) Step 1
        if not (cp <= cM * (1 + REL)):
            w_step2 += 1                       # c_plus_le_c
        w3_eq = max(w3_eq, abs(cp - Lhalf) / Lhalf)   # c_plus_equals_Lambda_half_integer
        if not (Lhalf <= cM * (1 + REL)):
            w_lower += 1
        # (2) Step 2 の前提: ε^T = ε、ε^2 = I、ε は置換行列、εW = Wε、W^T = W、W の成分が正
        w3_eq = max(w3_eq, (E.transpose() - E).norm(1), (E * E - Id).norm(1),
                    (E * Wr - Wr * E).norm(1) / Wr.norm(1), (Wr.transpose() - Wr).norm(1) / Wr.norm(1))
        if not (all(E[i, j] in (0, 1) for i in range(O.d) for j in range(O.d))
                and all(sum(E.row(i)) == 1 and sum(E.column(i)) == 1 for i in range(O.d))):
            w3_ineq += 1
        if not all(Wr[i, j] > 0 for i in range(O.d) for j in range(O.d)):
            w3_ineq += 1
        for x in test_vectors(M, Wr):
            n3 += 1
            u = vector(RDF, [abs(t) for t in x])
            Eu = E * u
            v = u + Eu
            qx = x * Wr * x
            qu = u * Wr * u
            # u^T W u = Σ|x_k||x_l|W_kl ≥ |Σ x_k x_l W_kl| ≥ x^T W x
            ssum = sum(abs(x[k]) * abs(x[l]) * Wr[k, l] for k in range(O.d) for l in range(O.d))
            w3_eq = max(w3_eq, abs(qu - ssum) / qu)
            if not (qu >= abs(qx) * (1 - REL) and abs(qx) >= qx):
                w3_ineq += 1
            # εu ≥ 0、‖εu‖ = ‖u‖ = ‖x‖ = 1
            if not all(t >= 0 for t in Eu):
                w3_ineq += 1
            w3_eq = max(w3_eq, abs(Eu.norm() - u.norm()), abs(u.norm() - x.norm()), abs(x.norm() - 1))
            # εv = ε(u + εu) = εu + ε^2 u = εu + u = v
            chain = [E * v, E * (u + Eu), Eu + E * E * u, Eu + u, v]
            for a, b in zip(chain, chain[1:]):
                w3_eq = max(w3_eq, (a - b).norm())
            # v ≥ u ≥ 0、v ≠ 0
            if not (all(v[k] >= u[k] >= 0 for k in range(O.d)) and v.norm() > 0):
                w3_ineq += 1
            # ‖v‖^2 = ‖u‖^2 + 2u^Tεu + ‖εu‖^2 = 2 + 2u^Tεu ≤ 4
            nv2 = v * v
            if nv2 > 2 * (1 + 1e-9):
                neg_norm_hits += 1   # ‖v‖^2 <= 4 を ‖v‖^2 <= 2 にすると破れる x がある
            w3_eq = max(w3_eq, abs(nv2 - (u * u + 2 * (u * Eu) + Eu * Eu)),
                        abs(u * u + 2 * (u * Eu) + Eu * Eu - (2 + 2 * (u * Eu))))
            if not (u * Eu <= u.norm() * Eu.norm() * (1 + REL) and 2 + 2 * (u * Eu) <= 4 * (1 + REL)):
                w3_ineq += 1
            # v^T W v = u^TWu + 2u^TWεu + (εu)^TW(εu) = … + u^TεWεu = … + u^TWε^2u = 2u^TWu + 2u^TWεu ≥ 2u^TWu
            vWv = [v * Wr * v,
                   qu + 2 * (u * Wr * Eu) + Eu * Wr * Eu,
                   qu + 2 * (u * Wr * Eu) + u * (E.transpose() * Wr * E) * u,
                   qu + 2 * (u * Wr * Eu) + u * (Wr * E * E) * u,
                   2 * qu + 2 * (u * Wr * Eu)]
            for a, b in zip(vWv, vWv[1:]):
                w3_eq = max(w3_eq, abs(a - b) / abs(vWv[0]))
            if not (u * Wr * Eu >= 0 and vWv[-1] >= 2 * qu * (1 - REL)):
                w3_ineq += 1
            # Λ^{(1/2)} = c_+ ≥ v̂^TWv̂ = v^TWv/‖v‖^2 ≥ 2u^TWu/‖v‖^2 ≥ 2u^TWu/4 = u^TWu/2 ≥ x^TWx/2
            vh = v / v.norm()
            q_vh = vh * Wr * vh
            w3_eq = max(w3_eq, abs(q_vh - vWv[0] / nv2) / q_vh)
            ineq = [Lhalf, cp, q_vh, 2 * qu / nv2, 2 * qu / 4, qu / 2, qx / 2]
            # Λ = c_+（等号）、以降は ≥ の鎖（2u^TWu/4 = u^TWu/2 も等号）
            if not (ineq[1] >= ineq[2] * (1 - REL) and ineq[3] >= ineq[4] * (1 - REL)
                    and ineq[5] >= ineq[6] * (1 - REL) and ineq[2] >= ineq[3] * (1 - REL)):
                w3_ineq += 1
            w3_eq = max(w3_eq, abs(ineq[4] - ineq[5]) / ineq[5])
        # 結論 c(M) ≤ 2Λ^{(1/2)}_M
        if not (Lhalf <= cM * (1 + REL) and cM <= 2 * Lhalf * (1 + REL)):
            w_sand += 1
        w_ceq = max(w_ceq, abs(cM - cp) / cM)
        # 下界の鋭さの確認: 下界を 1.01Λ にしたもの、上界を 0.99Λ にしたものは破れる（数値では c = c_+ = Λ）
        if 1.01 * Lhalf <= cM:
            neg_low_ok = False
        if cM <= 0.99 * Lhalf:
            neg_up_ok = False
        # 否定コントロール（上からの評価）: Step 2 の v = u + εu を F^{(+)} へ送る議論を F^{(-)} に置き換えた
        # c(M) <= 2c_-(M)（c_- は F^{(-)} ∩ R^{2^M} 上の上限）は成り立つとは限らない
        Bm = odd_sector_basis(M)
        cm = top_eig(Bm.transpose() * Wr * Bm)
        if not (cM <= 2 * cm * (1 + REL)):
            neg_minus_hits += 1

print(f"  (1) Step 1: c_+(M) ≤ c(M) の違反件数: {w_step2}、Λ^{{(1/2)}}_M ≤ c(M) の違反件数: {w_lower}  ->  "
      f"{'PASS' if w_step2 == 0 and w_lower == 0 else 'FAIL'}")
ok_all &= (w_step2 == 0 and w_lower == 0)
ok_all &= report("(2) Step 2 の等式の各行（と Step 1 の c_+(M) = Λ^{(1/2)}_M）", w3_eq, TOL)
print(f"  (2) Step 2 の不等式の各行の違反件数: {w3_ineq}（x の本数 {n3}）  ->  "
      f"{'PASS' if w3_ineq == 0 else 'FAIL'}")
ok_all &= (w3_ineq == 0)
print(f"  (3) Λ^{{(1/2)}}_M ≤ c(M) ≤ 2Λ^{{(1/2)}}_M の違反件数: {w_sand}  ->  "
      f"{'PASS' if w_sand == 0 else 'FAIL'}")
ok_all &= (w_sand == 0)
ok_all &= report("(3') 実際には c(M) = c_+(M)（本文の評価より強い。本文はこれを使わない）", w_ceq, TOL)


print(f"  下界の鋭さ: 1.01Λ <= c が全て破れる {neg_low_ok}、c <= 0.99Λ が全て破れる {neg_up_ok}")
print(f"  否定コントロール: ‖v‖^2 <= 2 が破れる x の本数 {neg_norm_hits}（x の本数 {n3}）、"
      f"F^(+) を F^(-) に替えた c <= 2c_- が破れる組の数 {neg_minus_hits}")
neg_ok = neg_low_ok and neg_up_ok and neg_norm_hits > 0 and neg_minus_hits > 0
print("RESULT: PASS" if (ok_all and neg_ok) else "RESULT: FAIL")
