# 対象ラベル: claim_iterate_collision_gives_repeating_tail
# 衝突 F^i = F^j (i < j, p = j - i >= 1) から、n >= i のとき F^{n+p} = F^n が従うことを、
# 人手証明の式変形の各行（k = n - i と置き、指数の書き換え・加法則・衝突の代入・加法則・指数の書き換え）
# を一行ずつ真理値表の等号で検査する。
# 帰属: 有限集合の写像の等号と非負整数の加減だけを使う。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

instances = 0
step_equalities = 0
for stage_size, rule, table in exhaustive_instances():
    M = 2 ** stage_size
    K = M ** M
    scan = scan_bound(stage_size)
    found = first_collision(power_tables(table, scan))
    assert found is not None, "collision must appear within scan bound"
    i, j = found
    assert 0 <= i < j <= K
    p = j - i
    assert p >= 1
    powers = power_tables(table, j + 2 * p + 2 * j + 4)
    # n >= i の各 n（有限範囲）について、人手証明の各行を検査する
    for n in range(i, i + 2 * j + 3):
        k = n - i
        assert k >= 0 and n == i + k                       # k := n - i の置き方
        assert n + p == (i + k) + p                        # F^{n+p} = F^{(i+k)+p}
        assert (i + k) + p == (i + p) + k                  # N の加法の結合律と交換律
        assert (i + p) + k == j + k                        # j = i + p
        assert powers[j + k] == compose(powers[j], powers[k])   # 加法則 F^{j+k} = F^j ∘ F^k
        assert compose(powers[j], powers[k]) == compose(powers[i], powers[k])  # F^i = F^j の代入
        assert compose(powers[i], powers[k]) == powers[i + k]   # 加法則 F^{i+k} = F^i ∘ F^k
        assert powers[i + k] == powers[n]                  # n = i + k
        assert powers[n + p] == powers[n]                  # 結論
        step_equalities += 1
    instances += 1

print("global maps checked: {}".format(instances))
print("eventual-period step groups checked: {}".format(step_equalities))
print("RESULT: PASS")
