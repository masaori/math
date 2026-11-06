# 対象ラベル: finite_double_sum_of_real_numbers_interchange
# Σ_{k=1}^{n_1} Σ_{l=1}^{n_2} c_{k,l} = Σ_{l=1}^{n_2} Σ_{k=1}^{n_1} c_{k,l} の帰納法の各行（n_1 = 1 の 2 行、n_1 → n_1+1 の 4 行）を
# n_1 = 1,…,6、n_2 = 1,…,6 で確かめる（本文の n_1, n_2, c_{k,l} をここでは p, q, a(k, l) と書く）。有限和は def_finite_sum_of_real_numbers のとおり左から順に足して組む。
# 帰属: QQ 上の多項式環（a_{k,l} は不定元）。不定元で成り立つ等号は、任意の実数を代入しても成り立つ。
P_MAX = 7
Q_MAX = 6
R = PolynomialRing(QQ, [f"a{k}_{l}" for k in range(1, P_MAX + 1) for l in range(1, Q_MAX + 1)])
g = R.gens()


def a(k, l):
    """a_{k,l}（本文の 1 始まりの添字）。"""
    return g[(k - 1) * Q_MAX + (l - 1)]


def fsum(rs):
    """def_finite_sum_of_real_numbers: Σ_{j=1}^{1} r_j := r_1、Σ_{j=1}^{m+1} r_j := (Σ_{j=1}^{m} r_j) + r_{m+1}。"""
    rs = list(rs)
    s = rs[0]
    for r in rs[1:]:
        s = s + r
    return s


def outer_k_inner_l(p, q):
    return fsum(fsum(a(k, l) for l in range(1, q + 1)) for k in range(1, p + 1))


def outer_l_inner_k(p, q):
    return fsum(fsum(a(k, l) for k in range(1, p + 1)) for l in range(1, q + 1))


count = 0
for q in range(1, Q_MAX + 1):
    # p = 1
    lines1 = [
        outer_k_inner_l(1, q),                                              # Σ_{k=1}^{1} Σ_l a_{k,l}
        fsum(a(1, l) for l in range(1, q + 1)),                             # def_finite_sum_of_real_numbers（m → 1）
        outer_l_inner_k(1, q),                                              # 同上を右辺から左辺へ、各 l へ
    ]
    for t in range(len(lines1) - 1):
        assert lines1[t] == lines1[t + 1], (q, 1, t)
        count += 1
    for p in range(1, P_MAX):
        assert outer_k_inner_l(p, q) == outer_l_inner_k(p, q)               # 帰納法の仮定（p で成り立つ）
        last = fsum(a(p + 1, l) for l in range(1, q + 1))                   # Σ_l a_{p+1,l}
        lines = [
            outer_k_inner_l(p + 1, q),                                      # Σ_{k=1}^{p+1} Σ_l a_{k,l}
            outer_k_inner_l(p, q) + last,                                   # def_finite_sum_of_real_numbers（m → p）
            outer_l_inner_k(p, q) + last,                                   # 帰納法の仮定
            fsum(fsum(a(k, l) for k in range(1, p + 1)) + a(p + 1, l)
                 for l in range(1, q + 1)),                                 # finite_sum_of_real_sums を右辺から左辺へ
            outer_l_inner_k(p + 1, q),                                      # def_finite_sum_of_real_numbers を右辺から左辺へ、各 l へ
        ]
        for t in range(len(lines) - 1):
            assert lines[t] == lines[t + 1], (q, p, t)
            count += 1
        # 比べる側: Sage の sum（独立な経路）
        assert outer_k_inner_l(p + 1, q) == sum(sum(a(k, l) for k in range(1, p + 2)) for l in range(1, q + 1))
        # 対照: 外側の和の最後の項 a_{p+1,q} を落とした右辺とは一致しない
        assert outer_k_inner_l(p + 1, q) != outer_l_inner_k(p + 1, q) - a(p + 1, q)
print(f"p = 1 の 2 行と、帰納法の段 p → p+1（p = 1,…,{P_MAX - 1}）の各行を q = 1,…,{Q_MAX} で確かめた（{count} 段）")
print("RESULT: PASS")
