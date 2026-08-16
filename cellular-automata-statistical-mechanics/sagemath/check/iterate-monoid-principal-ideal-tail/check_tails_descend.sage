# 対象ラベル: claim_iterate_monoid_tails_descend
# I_{n+1}(F) ⊆ I_n(F) を、人手証明の行 H = F^{(n+1)+k} = F^{n+(1+k)}（N の結合律）ごとに検査する。
# 帰属: 有限集合の写像の等号と非負整数の加法だけを使う。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

instances = 0
lines = 0
for stage_size, rule, table in exhaustive_instances():
    powers, i, j = monoid_and_collision(table)
    powers = power_tables(table, 3 * j + 4)
    for n in range(0, j + 2):
        tail_n = tail_by_definition(powers, n, n + j)
        tail_n1 = tail_by_definition(powers, n + 1, n + 1 + j)
        for k in range(0, j + 1):
            H = powers[(n + 1) + k]
            assert (n + 1) + k == n + (1 + k)                  # N の加法の結合律
            assert H == powers[n + (1 + k)]
            assert H in tail_n
            lines += 1
        assert tail_n1 <= tail_n                                # 包含
    instances += 1

print("global maps checked: {}".format(instances))
print("descend lines checked: {}".format(lines))
print("RESULT: PASS")
