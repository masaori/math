# 対象ラベル: claim_iterate_powers_form_finite_commutative_monoid
# 反復写像の集合 P_F（衝突指数 j 未満の反復写像の集合）が、単位元 F^0 = id を持ち、
# 合成で閉じ、結合律・交換律を満たし、|P_F| <= M^M であることを全数検査する。
# 帰属: 有限集合の写像の等号と非負整数の比較だけを使う。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

instances = 0
pair_checks = 0
triple_checks = 0
for stage_size, rule, table in exhaustive_instances():
    M = 2 ** stage_size
    powers = power_tables(table, scan_bound(stage_size))
    i, j = first_collision(powers)
    P = sorted(set(powers[:j]))
    Pset = set(P)
    assert identity_table(M) == powers[0]
    assert powers[0] in Pset
    for a in P:
        assert compose(powers[0], a) == a == compose(a, powers[0])
        for b in P:
            ab = compose(a, b)
            assert ab in Pset                      # 閉性
            assert ab == compose(b, a)             # 可換性
            pair_checks += 1
            for c in P:
                assert compose(ab, c) == compose(a, compose(b, c))   # 結合律
                triple_checks += 1
    assert len(P) <= M ** M
    instances += 1

print("global maps checked: {}".format(instances))
print("pair checks: {}".format(pair_checks))
print("triple checks: {}".format(triple_checks))
print("RESULT: PASS")
