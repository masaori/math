# 対象ラベル: claim_fisher_zero_finset_card_bound
#
# 主張: L >= 1 と有限部分集合 S ⊂ F_L について |S| <= 2 L^2 である。
# 人手証明の三つの仮定（Ẑ_L^F != 0、2L^2 < k で ac_k = 0、S の元は Ẑ_L^F の根）と
# 準備（ac_k(Ẑ_L^F) = Ω_L(k)）を ZZ[x]・QQbar[t] の厳密計算で確かめる。浮動小数点は使わない。

import os
from itertools import combinations

_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/defs.sage'))

Rt.<t> = PolynomialRing(QQbar)


def qbar_pow_rec(a, k):
    acc = QQbar(1)
    for _ in range(k):
        acc = acc * a
    return acc


def lift_F(f):
    # def_integer_polynomial_qbar_lift
    n = f.degree() if f.degree() >= 0 else 0
    g = Rt.zero()
    for k in range(n + 1):
        g = g + Rt(QQbar(f[k])) * t ** k
    return g


def aev(w, g):
    # def_qbar_poly_evaluation
    total = QQbar(0)
    for k in g.dict():
        total = total + g[k] * qbar_pow_rec(w, k)
    return total


def ev_F(xi, f):
    # def_qbar_polynomial_evaluation
    n = f.degree() if f.degree() >= 0 else 0
    total = QQbar(0)
    for m in range(n + 1):
        total = total + QQbar(f[m]) * qbar_pow_rec(xi, m)
    return total


def multiplicity(L, m):
    # def_multiplicity: b(σ) = m となる配位の個数
    return multiplicity_vector(L)[m]


def check_claim():
    count = 0
    for L in range(1, 4):
        Z = partition_polynomial(L)
        n = 2 * L ** 2
        g = lift_F(Z)
        # 準備: ac_k(Ẑ_L^F) = Ω_L(k) (k <= 2L^2), 0 (2L^2 < k)
        for k in range(n + 1):
            assert g[k] == QQbar(multiplicity(L, k))
        for k in range(n + 1, n + 4):
            assert g[k] == QQbar(0)
        # 第 1: Ẑ_L^F != 0（多重度の総和が 2^{L^2} != 0 なので、零な係数ばかりではない）
        assert sum(multiplicity(L, m) for m in range(n + 1)) == 2 ** (L ** 2)
        assert 2 ** (L ** 2) != 0
        assert any(g[k] != 0 for k in range(n + 1))
        assert g != Rt.zero()
        # 第 2: 2L^2 < k で ac_k = 0（上で確認済み）
        # 第 3: S ⊂ F_L の各元は Ẑ_L^F の根
        F = Z.roots(QQbar, multiplicities=False)
        for xi in F:
            assert ev_F(xi, Z) == 0
            assert aev(xi, g) == ev_F(xi, Z)
            assert aev(xi, g) == 0
        # 主張そのもの: 有限部分集合 S の個数は 2L^2 以下（F_L 全体と、大きさ 1・2 の部分集合）
        subsets = [tuple(F)] + [c for r in (1, 2) for c in combinations(F, r)]
        for S in subsets:
            assert len(set(S)) <= n
            count += 1
        print("  L=%d: |F_L|=%d <= 2L^2=%d、部分集合 %d 組" % (L, len(F), n, len(subsets)))
    print("claim_fisher_zero_finset_card_bound: 部分集合 %d 組、すべて通過" % count)


check_claim()
