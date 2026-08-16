# 対象ラベル: claim_iterate_monoid_generated_ideals_comparable
# G = F^m, H = F^n の全組について、m <= n なら J_F(H) subseteq J_F(G)、n <= m なら逆包含となることを検査する。
# 各主イデアルが既証明の後尾集合 I_m(F) と一致することも別に検査する。
# 帰属: 有限集合、有限集合の包含、非負整数の全順序だけを使う。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

instances = 0
pair_checks = 0
for stage_size, rule, table in exhaustive_instances():
    powers, i, j, monoid, ideals = finite_monoid_data(table)
    powers = power_tables(table, 2 * j + 2)
    for m in range(j):
        tail_m = tail_by_definition(powers, m, m + j)
        assert ideals[m] == tail_m
        for n in range(j):
            if m <= n:
                d = n - m
                assert n == m + d
                assert ideals[n] <= ideals[m]
            if n <= m:
                d = m - n
                assert m == n + d
                assert ideals[m] <= ideals[n]
            assert ideals[m] <= ideals[n] or ideals[n] <= ideals[m]
            pair_checks += 1
    instances += 1

print("global maps checked: {}".format(instances))
print("ordered generator pairs checked: {}".format(pair_checks))
print("RESULT: PASS")
