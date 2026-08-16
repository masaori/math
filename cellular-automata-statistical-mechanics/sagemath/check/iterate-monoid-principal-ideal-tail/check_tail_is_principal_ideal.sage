# 対象ラベル: claim_iterate_monoid_tail_is_principal_ideal（併せて claim_iterate_monoid_tail_absorbs_composition）
# I_n(F) = {F^{n+k} | k in N} が {F^n ∘ G | G in P_F} に等しいことを両包含で検査する。
# 各包含は人手証明の行 H = F^{n+k} = F^n ∘ F^k（加法則）と F^n ∘ G = F^n ∘ F^k = F^{n+k}（加法則）を
# 一行ずつ真理値表の等号で確認する。吸収 G ∘ H = F^a ∘ F^{n+b} = F^{a+(n+b)} = F^{n+(a+b)} も同様に検査する。
# 帰属: 有限集合の写像の等号と非負整数の加法だけを使う。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

instances = 0
containments = 0
absorptions = 0
for stage_size, rule, table in exhaustive_instances():
    powers, i, j = monoid_and_collision(table)
    monoid = powers[:j]                        # P_F の有限代表 F^0..F^{j-1}（相異なる）
    assert len(set(monoid)) == j
    last = 2 * j + 2
    powers = power_tables(table, last + j + 1)
    for n in range(0, j + 2):
        tail = tail_by_definition(powers, n, n + j)
        # 包含 I_n ⊆ {F^n ∘ G}: H = F^{n+k} = F^n ∘ F^k
        for k in range(0, j + 1):
            H = powers[n + k]
            assert H == compose(powers[n], powers[k])          # 加法則
            assert powers[k] in monoid                          # F^k ∈ P_F（有限代表のどれか）
            containments += 1
        # 包含 {F^n ∘ G} ⊆ I_n: F^n ∘ G = F^n ∘ F^k = F^{n+k}
        right = set()
        for k, G in enumerate(monoid):
            assert compose(powers[n], G) == compose(powers[n], powers[k])   # G = F^k
            assert compose(powers[n], powers[k]) == powers[n + k]           # 加法則
            assert powers[n + k] in tail
            right.add(compose(powers[n], G))
            containments += 1
        assert right == tail                                    # 集合の等号
        # 吸収: G ∘ H ∈ I_n
        for a, G in enumerate(monoid):
            for b in range(0, j + 1):
                H = powers[n + b]
                assert compose(G, H) == compose(powers[a], powers[n + b])   # G = F^a, H = F^{n+b}
                assert compose(powers[a], powers[n + b]) == powers[a + (n + b)]  # 加法則
                assert a + (n + b) == n + (a + b)                # N の結合律・交換律
                assert powers[n + (a + b)] in tail
                absorptions += 1
    instances += 1

print("global maps checked: {}".format(instances))
print("containment lines checked: {}".format(containments))
print("absorption lines checked: {}".format(absorptions))
print("RESULT: PASS")
