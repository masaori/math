# 対象ラベル: claim_iterate_monoid_zero_depth_maps_to_zero_depth
# μ(y) = 0 の各配位で、人手証明の各段を分けて確かめる。
#   p := π(y) >= 1 かつ (0,p) ∈ P(y)                    (def_min_period)
#   各 n の窓で F^{n+p}(F(y)) = F^{n+p+1}(y)             (def_finite_self_map_iterate)
#             = F^{n+1}(y)                               ((0,p) ∈ P(y) を n+1 で適用)
#             = F^n(F(y))                                (def_finite_self_map_iterate)
#   よって (0,p) ∈ P(F(y))、最小性から μ(F(y)) = 0
# 帰属: 有限集合の写像の等号と非負整数の大小比較だけを使う。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_common.sage'))

instances = 0
zero_configs = 0
for stage_size, rule, table in exhaustive_instances():
    F, E, Q, fibers, sigma, mp, mu_of, layers = depth_data(table)
    M = len(F)
    for y in range(M):
        if mu_of[y] != 0:
            continue
        p = mp[y][1]
        assert p >= 1                                        # def_min_period の p >= 1
        assert is_periodicity_pair(F, y, 0, p, M)            # (0,p) ∈ P(y)
        fy = F[y]
        orb_y = orbit(F, y, M + p + 2)
        orb_fy = orbit(F, fy, M + p + 1)
        for n in range(M + 1):
            assert orb_fy[n + p] == orb_y[n + p + 1]         # F^{n+p}(F(y)) = F^{n+p+1}(y)
            assert orb_y[n + p + 1] == orb_y[n + 1]          # = F^{n+1}(y)  ((0,p) ∈ P(y))
            assert orb_y[n + 1] == orb_fy[n]                 # = F^n(F(y))
        assert is_periodicity_pair(F, fy, 0, p, M)           # (0,p) ∈ P(F(y))
        assert mu_of[fy] == 0                                # 最小性から μ(F(y)) = 0
        zero_configs += 1
    instances += 1

print("global maps checked: {}".format(instances))
print("configurations with zero min preperiod checked: {}".format(zero_configs))
print("RESULT: PASS")
