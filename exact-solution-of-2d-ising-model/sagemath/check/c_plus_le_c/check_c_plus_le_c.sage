# 対象ラベル: c_plus_le_c
#   c_+(M_col) <= c(M_col)
#
#   c(M)   は W（実対称）の最大固有値として求める（R^{2^M} の単位ベクトル上の Rayleigh 商の上限）。
#   c_+(M) は二通りに独立に求めて一致を確かめる:
#     (a) F^{(+)} ∩ R^{2^M} の正規直交基底 B へ W を制限した実対称行列 B^T W B の最大固有値
#     (b) F^{(+)} ∩ R^{2^M} の乱数単位ベクトルから出発した冪乗法（W は epsilon と可換なので
#         反復は F^{(+)} を出ない。W は正定値なので最大固有値へ収束する）の Rayleigh 商
#   そのうえで
#     (1) R_+ ⊆ R: F^{(+)} ∩ R^{2^M} の乱数単位ベクトル x について x^T W x <= c_+ <= c
#     (2) x^{(+)} = a_+ ⊠ … ⊠ a_+ の Rayleigh 商は R_+ の元で c_+ 以下
#     (3) c_+ <= c
#   を判定する。c_+ = c（本文より強い観測。本文は使わない）も比として記録する。
#
#   許容誤差: (a)(b) の一致は相対 1e-9。不等号は相対余裕 1e-12（倍精度の丸め分）で判定する。
#   W の成分は exp(±K_1 M/2 ± K_2 M) 程度の大きさで、LAPACK の対称固有値計算の誤差は
#   ||W|| × 1e-16 程度なので、相対 1e-12 はその 1e4 倍の余裕である。
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

set_random_seed(20260926)
REL_EQ = 1e-9
REL_INEQ = 1e-12

print("=== c_plus_le_c: c_+(M_col) <= c(M_col) ===")
all_ok = True
worst_ab = RDF(0)
n_viol = 0
for M in C_PLUS_M:
    E = epsilon_matrix(M)
    B = even_real_basis(M)
    d = 2 ** M
    x_plus = vector(RDF, [RDF(2) ** (-RDF(M) / 2)] * d)
    for (K1, K2) in C_PLUS_PARAMS:
        W = W_matrix(M, K1, K2)
        # 前提: W は実対称で epsilon と可換、B の列は F^{(+)} ∩ R^{2^M} の正規直交基底
        pre = max((W - W.transpose()).norm(1) / W.norm(1),
                  (E * W - W * E).norm(1) / W.norm(1),
                  (E * B - B).norm(1),
                  (B.transpose() * B - identity_matrix(RDF, B.ncols())).norm(1))
        c = top_eigenvalue(W)
        c_plus_a = top_eigenvalue(B.transpose() * W * B)
        # (b) 冪乗法
        y = B * vector(RDF, [RDF.random_element(-1, 1) for _ in range(B.ncols())])
        y = y / y.norm()
        q_prev = RDF(0)
        for it in range(20000):
            y = W * y
            y = y / y.norm()
            q = y * W * y
            if abs(q - q_prev) <= 1e-15 * q:
                break
            q_prev = q
        c_plus_b = q
        in_even = (E * y - y).norm()
        rel_ab = abs(c_plus_a - c_plus_b) / c_plus_a
        worst_ab = max(worst_ab, rel_ab, pre, in_even)
        # (1) R_+ ⊆ R の標本
        viol = 0
        for _ in range(20):
            x = B * vector(RDF, [RDF.random_element(-1, 1) for _ in range(B.ncols())])
            x = x / x.norm()
            qx = x * W * x
            if not (qx <= c_plus_a * (1 + REL_INEQ) and qx <= c * (1 + REL_INEQ)):
                viol += 1
        # (2) x^{(+)} の Rayleigh 商
        q_plus = x_plus * W * x_plus
        if not (abs(x_plus.norm() - 1) <= 1e-15 and (E * x_plus - x_plus).norm() == 0
                and q_plus <= c_plus_a * (1 + REL_INEQ)):
            viol += 1
        # (3) c_+ <= c
        if not (c_plus_a <= c * (1 + REL_INEQ)):
            viol += 1
        n_viol += viol
        ok = viol == 0 and rel_ab <= REL_EQ and pre <= REL_EQ and in_even <= REL_EQ
        print(f"  M={M}, K1={float(K1):.8g}, K2={float(K2):.8g}: c={float(c):.12g}, "
              f"c_+(固有値)={float(c_plus_a):.12g}, c_+(冪乗法, {it + 1} 回)={float(c_plus_b):.12g}, "
              f"一致 {float(rel_ab):.1e}, x^(+) の商={float(q_plus):.6g}, c_+/c={float(c_plus_a / c):.15f}, "
              f"違反 {viol}  -> {'PASS' if ok else 'FAIL'}")
        all_ok = ok and all_ok

print(f"  c_+ の二通りの計算・前提の最大相対残差: {float(worst_ab):.3e}（許容 {REL_EQ}）")
print(f"  不等号の違反件数: {n_viol}")
print("RESULT: PASS" if all_ok else "RESULT: FAIL")
if not all_ok:
    raise AssertionError("c_plus_le_c numerical check failed")
