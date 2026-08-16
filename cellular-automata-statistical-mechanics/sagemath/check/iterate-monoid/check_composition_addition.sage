# 対象ラベル: claim_iterate_composition_addition
# F^m ∘ F^n = F^{m+n} を、真理値表の合成と再帰で得た F^{m+n} の等号として全数検査する。
# 帰属: 有限集合（配位番号）の写像の等号だけを使う。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

instances = 0
equalities = 0
for stage_size, rule, table in exhaustive_instances():
    # 衝突指数 j を求め、m, n <= j + 2 の範囲で検査する（j 以降は衝突により j 未満へ戻る）
    i, j = first_collision(power_tables(table, scan_bound(stage_size)))
    bound = j + 2
    powers = power_tables(table, 2 * bound)
    # 基底段: F^0 ∘ F^n = F^n = F^{0+n}
    for n in range(bound + 1):
        assert compose(powers[0], powers[n]) == powers[n] == powers[0 + n]
        equalities += 1
    # 帰納段の各行: F^{m+1} ∘ F^n = (F ∘ F^m) ∘ F^n = F ∘ (F^m ∘ F^n) = F ∘ F^{m+n} = F^{(m+n)+1}
    for m in range(bound):
        for n in range(bound + 1):
            left = compose(powers[m + 1], powers[n])
            assert powers[m + 1] == compose(table, powers[m])
            assert left == compose(compose(table, powers[m]), powers[n])
            assert left == compose(table, compose(powers[m], powers[n]))
            assert compose(powers[m], powers[n]) == powers[m + n]
            assert left == compose(table, powers[m + n])
            assert left == powers[(m + n) + 1] == powers[(m + 1) + n]
            equalities += 1
    instances += 1

print("global maps checked: {}".format(instances))
print("composition equalities checked: {}".format(equalities))
print("RESULT: PASS")
