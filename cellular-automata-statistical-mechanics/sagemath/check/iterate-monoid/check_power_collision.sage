# 対象ラベル: claim_iterate_map_collision_finite_representatives
# 反復写像 F^0, F^1, ... の衝突 F^i = F^j (0 <= i < j <= K = M^M) の存在、衝突の反復不変性
# F^{i+p+k} = F^{i+k}、および P_F = {F^n | 0 <= n < j} を有限範囲で検査する。
# 帰属: 有限集合の写像の等号と非負整数の四則・除法だけを使う。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

instances = 0
shift_equalities = 0
reduction_equalities = 0
for stage_size, rule, table in exhaustive_instances():
    M = 2 ** stage_size
    K = M ** M
    scan = scan_bound(stage_size)
    found = first_collision(power_tables(table, scan))
    assert found is not None, "collision must appear within scan bound"
    i, j = found
    assert 0 <= i < j <= scan
    assert j <= K
    bound = j + 2
    powers = power_tables(table, 3 * bound)
    assert powers[i] == powers[j]
    p = j - i
    assert p >= 1
    # 衝突の反復不変性: F^{i+p+k} = F^{j+k} = F^j ∘ F^k = F^i ∘ F^k = F^{i+k}
    for k in range(2 * bound + 1):
        assert powers[i + p + k] == powers[j + k]
        assert powers[j + k] == compose(powers[j], powers[k])
        assert compose(powers[j], powers[k]) == compose(powers[i], powers[k])
        assert compose(powers[i], powers[k]) == powers[i + k]
        shift_equalities += 1
    # 有限代表: 各 n <= 3*bound について F^n = F^{i+r}（n >= i, n - i = q p + r）または n < j
    representatives = set(powers[:j])
    for n in range(3 * bound + 1):
        if n >= i:
            q, r = divmod(n - i, p)
            assert 0 <= r < p and n - i == q * p + r
            assert powers[n] == powers[i + r]
            assert i + r < j
        else:
            assert n < j
        assert powers[n] in representatives
        reduction_equalities += 1
    assert len(representatives) <= j <= K
    instances += 1

print("global maps checked: {}".format(instances))
print("shift equalities checked: {}".format(shift_equalities))
print("reduction equalities checked: {}".format(reduction_equalities))
print("RESULT: PASS")
