# 対象ラベル: claim_iterate_monoid_finite_decidability
# 局所真理値表から大域真理値表を作り、反復写像の等号を全配位・全セルの状態等号へ分解して決定し、
# 衝突指数 j 未満の反復写像を等しいものごとにまとめた元と、指数の加法で得る合成表が、
# 真理値表の合成と一致することを検査する。等号検査の回数が有限であることも数える。
# 帰属: 有限集合と非負整数だけを使う。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))


def tables_equal_by_state_scan(confs, left, right, counter):
    """F^a = F^b <=> forall y, F^a y = F^b y。配位の等号は各セルの 2 値状態の等号へ分解する。"""
    for k in range(len(confs)):
        for cell in range(len(confs[k])):
            counter[0] += 1
            if confs[left[k]][cell] != confs[right[k]][cell]:
                return False
    return True


instances = 0
composition_entries = 0
state_equalities = [0]
for stage_size, rule, table in exhaustive_instances():
    confs = configurations(stage_size)
    # 大域真理値表は局所真理値表の値の並びから得られる（def_global_map）
    for k, c in enumerate(confs):
        assert confs[table[k]] == elementary_global_map(rule, c)
    powers = power_tables(table, scan_bound(stage_size))
    # 衝突を状態走査だけで見つける（人手証明の候補組 0 <= a < b を指数の小さい順に走査する）
    found = None
    for b in range(len(powers)):
        for a in range(b):
            if tables_equal_by_state_scan(confs, powers[a], powers[b], state_equalities):
                found = (a, b)
                break
        if found is not None:
            break
    assert found is not None
    i, j = found
    assert (i, j) == first_collision(powers)
    # 指数 j 未満の反復写像を、状態走査による等号でまとめる
    classes = []  # 各元: 代表指数
    rep_of = {}
    for n in range(j):
        for r in classes:
            if tables_equal_by_state_scan(confs, powers[n], powers[r], state_equalities):
                rep_of[n] = r
                break
        else:
            classes.append(n)
            rep_of[n] = n
    assert len(classes) == len(set(powers[:j]))
    p = j - i

    def reduce_exponent(n):
        if n < j:
            return rep_of[n]
        return rep_of[i + (n - i) % p]

    # 合成表: 指数を加えて代表へ戻したものが、真理値表の合成と一致する
    for a in classes:
        for b in classes:
            assert powers[reduce_exponent(a + b)] == compose(powers[a], powers[b])
            composition_entries += 1
    instances += 1

print("global maps checked: {}".format(instances))
print("composition table entries checked: {}".format(composition_entries))
print("state equality checks performed (finite): {}".format(state_equalities[0]))
print("RESULT: PASS")
