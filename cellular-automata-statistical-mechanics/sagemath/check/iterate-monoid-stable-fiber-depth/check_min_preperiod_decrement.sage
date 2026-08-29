# 対象ラベル: claim_iterate_monoid_min_preperiod_decrements
# 各 y ∈ A^V で μ(y) > 0 なら μ(F(y)) = μ(y) - 1 を、人手証明の二段に分けて確かめる。
#   (1) m := μ(y), p := π(y) に対し (m-1, p) ∈ P(F(y))  ⇒ μ(F(y)) <= m-1
#   (2) j := μ(F(y)), r := π(F(y)) に対し (j+1, r) ∈ P(y)  ⇒ m <= j+1
#   両不等式と N の反対称性から μ(F(y)) = m-1。
# (1)(2) の各所属は def_periodicity_pairs の全称文（窓 M）で判定し、その根拠となる
# F^{n+p}(F(y)) = F^{n+p+1}(y) 等の反復の等式も orbit の一致で確かめる。
# 帰属: 有限集合の写像の反復と非負整数の加減・大小比較だけを使う。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_common.sage'))

instances = 0
positive_cases = 0
zero_cases = 0
for stage_size, rule, table in exhaustive_instances():
    F, E, Q, fibers, sigma, mp, mu_of, layers = depth_data(table)
    M = len(F)
    for y in range(M):
        m, p = mp[y]
        fy = F[y]
        j, r = mp[fy]
        if m == 0:
            zero_cases += 1
            continue
        # def_finite_self_map_iterate: F^k(F(y)) = F^{k+1}(y) を窓の範囲で確認
        orb_y = orbit(F, y, 2 * M + p + r + 2)
        orb_fy = orbit(F, fy, 2 * M + p + r + 1)
        for k in range(2 * M + p + r + 1):
            assert orb_fy[k] == orb_y[k + 1]
        # (1) 全ての n >= m-1 で F^{n+p}(F(y)) = F^{n+1}(y) = F^n(F(y))
        for n in range(m - 1, m - 1 + M + 1):
            assert orb_fy[n + p] == orb_y[n + p + 1]     # 反復の定義
            assert orb_y[n + p + 1] == orb_y[n + 1]      # (m,p) ∈ P(y) かつ n+1 >= m
            assert orb_y[n + 1] == orb_fy[n]             # 反復の定義
        assert is_periodicity_pair(F, fy, m - 1, p, M)   # (m-1,p) ∈ P(F(y))
        assert j <= m - 1                                # 最小性
        # (2) 全ての n >= j+1 で F^{n+r}(y) = F^{h+r}(F(y)) = F^h(F(y)) = F^n(y)、h = n-1
        for n in range(j + 1, j + 1 + M + 1):
            h = n - 1
            assert orb_y[n + r] == orb_fy[h + r]         # n = h+1 と反復の定義
            assert orb_fy[h + r] == orb_fy[h]            # (j,r) ∈ P(F(y)) かつ h >= j
            assert orb_fy[h] == orb_y[n]                 # n = h+1 と反復の定義
        assert is_periodicity_pair(F, y, j + 1, r, M)    # (j+1,r) ∈ P(y)
        assert m <= j + 1                                # 最小性
        # 反対称性
        assert j == m - 1
        positive_cases += 1
    instances += 1

print("global maps checked: {}".format(instances))
print("configurations with positive min preperiod: {}".format(positive_cases))
print("configurations with zero min preperiod (claim vacuous): {}".format(zero_cases))
print("RESULT: PASS")
