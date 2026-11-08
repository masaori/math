# ---------------------------------------------------------
# SageMath: 主張 c_between_Lambda_half_and_twice_Lambda_half の証明を一行ずつ確かめる。
#   Step 1（下からの評価）: c(M) >= c_+(M)（c_plus_le_c）と c_+(M) = Λ^{(1/2)}_M（c_plus_equals_Lambda_half_integer）
#   Step 2（上からの評価）: 単位ベクトル x から u_k := |x_k|、v_k := u_k + (ε_ℝu)_k、v̂_k := v_k/‖v‖ を作り、
#                          準備の各行（引く主張ごとの結論）と、Λ ≥ … ≥ x^⊤W_ℝx/2、x^⊤W_ℝx ≤ 2Λ の鎖の各行を確かめて
#                          c(M) <= 2Λ^{(1/2)}_M を得る（W_ℝ・ε_ℝ は実数の行列）
#   結論: Λ^{(1/2)}_M <= c(M) <= 2Λ^{(1/2)}_M
#   下界の鋭さの確認: 下界を 1.01Λ にしたもの（1.01Λ <= c）と上界を 0.99Λ にしたもの（c <= 0.99Λ）が
#                     すべての組で破れること（数値では c = c_+ = Λ なので、上からの評価の検査にはならない）。
#   否定コントロール: Step 2 の ‖v‖^2 <= 4 を ‖v‖^2 <= 2 にすると破れる x があること、
#                     F^{(+)} を F^{(-)} に替えた c(M) <= 2c_-(M) が破れる組があること（上からの評価が
#                     εv = v、すなわち F^{(+)} への制限に依ることの対照）。
#   否定コントロール（準備）: u 自身は ε_ℝu = u を満たすとは限らないこと（v を作る理由）。
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
neg_fix_hits = 0
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
        # (2) Step 2 の準備: (W_ℝ)_kl > 0（W_real_has_positive_entries）
        if not all(Wr[i, j] > 0 for i in range(O.d) for j in range(O.d)):
            w3_ineq += 1
        for x in test_vectors(M, Wr):
            n3 += 1
            u = vector(RDF, [abs(t) for t in x])          # u_k := |x_k|
            Eu = E * u                                     # ε_ℝu（def_real_matrix_vector_product）
            v = u + Eu                                     # v_k := u_k + (ε_ℝu)_k
            nv = v.norm()
            vh = v / nv                                    # v̂_k := v_k/‖v‖
            nv2 = nv ** 2                                  # ‖v‖^2（def_power_of_real_number の冪 m = 2）
            # 準備: ‖v‖^2 = ‖v‖‖v‖（square_of_real_number_is_product、r → ‖v‖）
            w3_eq = max(w3_eq, abs(nv2 - nv * nv))
            qx = x * Wr * x
            qu = u * Wr * u
            qv = v * Wr * v
            q_vh = vh * Wr * vh
            # 準備: u_k ≥ 0（def_real_absolute_value）
            if not all(t >= 0 for t in u):
                w3_ineq += 1
            # 準備: x^⊤W_ℝx ≤ u^⊤W_ℝu（real_bilinear_value_at_most_value_at_absolute_vector）
            if not (qx <= qu * (1 + REL) + 1e-300):
                w3_ineq += 1
            # 準備: ‖u‖ = ‖x‖ = 1（norm_of_vector_of_absolute_values_equals_norm、x の取り方）と u ≠ 0
            w3_eq = max(w3_eq, abs(u.norm() - x.norm()), abs(x.norm() - 1))
            if not any(t != 0 for t in u):
                w3_ineq += 1
            # 準備: v ≠ 0、‖v‖ > 0、‖v̂‖ = 1、‖v‖^2 > 0
            if not (any(t != 0 for t in v) and nv > 0 and nv2 > 0):
                w3_ineq += 1
            w3_eq = max(w3_eq, abs(vh.norm() - 1))
            # 準備: ε_ℝv = v（epsilon_real_fixes_sum_of_vector_and_its_image）、ε_ℝv̂ = v̂（real_matrix_fixed_vector_stays_fixed_after_normalization）
            w3_eq = max(w3_eq, (E * v - v).norm(), (E * vh - vh).norm())
            if (E * u - u).norm() > 1e-9:
                neg_fix_hits += 1   # 否定コントロール: u 自身は ε_ℝu = u を満たすとは限らない（v を作る意味）
            # 準備: ‖v‖^2 ≤ 4（norm_squared_of_sum_of_unit_vector_and_its_epsilon_real_image_is_at_most_four）
            if not (nv2 <= 4 * (1 + REL)):
                w3_ineq += 1
            # 準備: 0 < ‖v‖^2 ≤ 4 から 1/‖v‖^2 ≥ 1/4（正の数の逆数は大小を逆にする）
            if not (1 / nv2 >= (RDF(1) / 4) * (1 - REL)):
                w3_ineq += 1
            if nv2 > 2 * (1 + 1e-9):
                neg_norm_hits += 1   # ‖v‖^2 <= 4 を ‖v‖^2 <= 2 にすると破れる x がある
            # 準備: v^⊤W_ℝv ≥ 2(u^⊤W_ℝu)（W_real_bilinear_value_at_sum_..._is_at_least_twice）
            if not (qv >= 2 * qu * (1 - REL)):
                w3_ineq += 1
            # 準備: u^⊤W_ℝu ≥ 0（real_bilinear_value_with_nonnegative_entries_is_nonnegative）と 2(u^⊤W_ℝu) ≥ 0
            if not (qu >= 0 and 2 * qu >= 0):
                w3_ineq += 1
            # 主の鎖: Λ = c_+ ≥ v̂^⊤W_ℝv̂ = v^⊤W_ℝv/‖v‖^2 ≥ 2u^⊤W_ℝu/‖v‖^2 ≥ 2u^⊤W_ℝu/4 = u^⊤W_ℝu/2 ≥ x^⊤W_ℝx/2
            chain = [Lhalf, cp, q_vh, qv / nv2, 2 * qu / nv2, 2 * qu / 4, qu / 2, qx / 2]
            rel = ['=', '>=', '=', '>=', '>=', '=', '>=']
            for (a_, b_), r in zip(zip(chain, chain[1:]), rel):
                if r == '=':
                    w3_eq = max(w3_eq, abs(a_ - b_) / abs(chain[0]))
                elif not (a_ >= b_ - REL * abs(chain[0])):
                    w3_ineq += 1
            # 二つ目の鎖: x^⊤W_ℝx = 2·(x^⊤W_ℝx/2) ≤ 2Λ
            w3_eq = max(w3_eq, abs(qx - 2 * (qx / 2)) / abs(chain[0]))
            if not (2 * (qx / 2) <= 2 * Lhalf * (1 + REL)):
                w3_ineq += 1
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
print(f"  否定コントロール: ε_ℝu = u が破れる x の本数 {neg_fix_hits}（x の本数 {n3}）")
neg_ok = neg_low_ok and neg_up_ok and neg_norm_hits > 0 and neg_minus_hits > 0 and neg_fix_hits > 0
print("RESULT: PASS" if (ok_all and neg_ok) else "RESULT: FAIL")
