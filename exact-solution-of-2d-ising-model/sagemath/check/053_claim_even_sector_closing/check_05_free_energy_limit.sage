# =========================================================================
# check_05: onsager_exact_solution
#   (1) c(M)（W の最大 Rayleigh 商）= max(c_+(M), c_−(M))
#   (2) c_+(M) = Λ^{(1/2)}_M（check_04 の再確認）、c_−(M) = Λ^{(0)}_M（対照）
#   (3) 挟み撃ち Λ^{(1/2)}_M ≤ c(M) ≤ 2 Λ^{(1/2)}_M（本文 Step 2, 3）
#       実際には c(M) = c_+(M) が成り立つことも記録する（本文はこれを使わない）
#   (4) (1/M) log Λ^{(1/2)}_M → (1/2)log(2 sinh 2K_2) + (1/4π)∫_0^{2π} γ(θ)dθ
#       （M を大きくして Onsager 積分への収束を見る。δ = 0 でも同じ値へ収束）
#   (5) (1/(M N_row)) log Z = (1/M) log c(M) + O(1/N_row)（有限 M で直接確認）
# =========================================================================
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

print("=== check_05: c(M) の挟み撃ちと Onsager の自由エネルギーへの収束 ===")

ok_all = True


def flip_index(M, k):
    return (2 ** M - 1) - k


def sector_basis(M, sgn):
    """F^{(±)} ∩ R^{2^M} の正規直交基底（実）。"""
    d = 2 ** M
    cols = []
    for k in range(d):
        kb = flip_index(M, k)
        if k < kb:
            v = vector(RDF, d)
            v[k] = 1 / sqrt(RDF(2)); v[kb] = sgn / sqrt(RDF(2))
            cols.append(v)
    return matrix(RDF, cols).transpose()


def top_eig(A):
    return max([RDF(CDF(z).real()) for z in A.eigenvalues()])


w_c = w_sand = w_ceq = 0
cminus_rows = []
print("  --- 有限 M での c(M) の分解 ---")
for M in EIG_M:
    O = SpinOps(M)
    for p in EIG_PARAMS:
        K1 = RDF(p['K1']); K2 = RDF(p['K2'])
        P = coeffs(K1, K2)
        W = W_op(O, K1, K2)
        Wr = matrix(RDF, [[W[i, j].real() for j in range(O.d)] for i in range(O.d)])
        cM = top_eig(Wr)
        Bp = sector_basis(M, +1); Bm = sector_basis(M, -1)
        cp = top_eig(Bp.transpose() * Wr * Bp)
        cm = top_eig(Bm.transpose() * Wr * Bm)
        Lhalf = Lambda_delta_M(O, P, RDF(1) / 2)
        Lzero = Lambda_delta_M(O, P, RDF(0))
        w_c = max(w_c, abs(cM - max(cp, cm)) / cM)
        cminus_rows.append((M, param_label(p), RDF(cm), RDF(Lzero)))
        # (3) 挟み撃ち
        if not (Lhalf <= cM * (1 + 1e-9) and cM <= 2 * Lhalf * (1 + 1e-9)):
            w_sand += 1
        w_ceq = max(w_ceq, abs(cM - cp) / cM)

ok_all &= report("(1) c(M) = max(c_+(M), c_−(M))", w_c, TOL)
print("  (2) 対照: c_−(M) と Λ^{(0)}_M の比較（本文はこの関係に依存しない）")
for (M, lab, cm, Lz) in cminus_rows:
    print(f"      M={M} {lab}: c_−(M)={float(cm):.10g}, Λ^{{(0)}}_M={float(Lz):.10g}, "
          f"c_−/Λ^{{(0)}}={float(cm/Lz):.10g}")
print(f"  (3) Λ^{{(1/2)}}_M ≤ c(M) ≤ 2Λ^{{(1/2)}}_M の違反件数: {w_sand}  ->  "
      f"{'PASS' if w_sand == 0 else 'FAIL'}")
ok_all &= (w_sand == 0)
ok_all &= report("(3') 実際には c(M) = c_+(M)（本文の評価より強い）", w_ceq, TOL)

# (5) 分配関数の側から
print("  --- (1/(M N_row)) log tr(W^{N_row}) の N_row 依存 ---")
w_N = 0
for M in [3, 4]:
    O = SpinOps(M)
    p = EIG_PARAMS[3]
    K1 = RDF(p['K1']); K2 = RDF(p['K2'])
    W = W_op(O, K1, K2)
    Wr = matrix(RDF, [[W[i, j].real() for j in range(O.d)] for i in range(O.d)])
    cM = top_eig(Wr)
    for N in [1, 2, 4, 8, 16, 32]:
        Z = RDF((Wr ** N).trace())
        lhs = RDF(log(Z) / (M * N))
        rhs = RDF(log(cM) / M)
        bound = RDF(log(2) / N)   # limit_of_log_Z_in_N_row の評価
        if abs(lhs - rhs) > bound * (1 + 1e-9):
            w_N += 1
    print(f"    M={M}: N=32 で |(1/(MN))log tr(W^N) − (1/M)log c(M)| = "
          f"{float(abs(RDF(log(RDF((Wr**32).trace()))/(M*32)) - RDF(log(cM)/M))):.3e} "
          f"(評価 log2/32 = {float(RDF(log(2)/32)):.3e})")
print(f"  (5) |(1/(MN))log Z − (1/M)log c(M)| ≤ log2/N の違反件数: {w_N}  ->  "
      f"{'PASS' if w_N == 0 else 'FAIL'}")
ok_all &= (w_N == 0)

# (4) 熱力学極限
print("  --- (1/M) log Λ^{(δ)}_M の M → ∞ 収束（Onsager 積分と比較） ---")


def onsager_limit(P):
    """(1/2)log(2 sinh 2K_2) + (1/4π)∫_0^{2π} arccosh(γ_1(θ)) dθ"""
    f = lambda t: RDF(arccosh(g1(RDF(t), P)))
    val = numerical_integral(f, 0, float(2 * pi), max_points=20000)[0]
    return RDF(log(2 * P['s2']) / 2 + RDF(val) / (4 * pi))


w_lim = 0
for p in [EIG_PARAMS[1], EIG_PARAMS[3], EIG_PARAMS[4]]:
    P = coeffs(p['K1'], p['K2'])
    target = onsager_limit(P)
    row = []
    for M in [4, 16, 64, 256, 1024, 4096]:
        lh = log_Lambda_delta_over_M(M, P, RDF(1) / 2)
        lz = log_Lambda_delta_over_M(M, P, RDF(0))
        row.append((M, lh - target, lz - target))
    print(f"    {param_label(p)}  極限値 = {float(target):.10f}")
    for (M, dh, dz) in row:
        print(f"      M={M:5d}: δ=1/2 との差 {float(dh):+.3e}   δ=0 との差 {float(dz):+.3e}")
    # M = 4096 で十分近いこと（臨界点は収束が遅いので緩め）
    if abs(row[-1][1]) > 1e-3 or abs(row[-1][2]) > 1e-3:
        w_lim += 1
print(f"  (4) M=4096 で |(1/M)log Λ^{{(δ)}}_M − Onsager| ≤ 1e-3 の違反件数: {w_lim}  ->  "
      f"{'PASS' if w_lim == 0 else 'FAIL'}")
ok_all &= (w_lim == 0)

print("=== check_05: " + ("ALL PASS" if ok_all else "FAIL") + " ===")
