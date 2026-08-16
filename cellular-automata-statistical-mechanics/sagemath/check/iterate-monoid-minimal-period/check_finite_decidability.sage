# 対象ラベル: claim_iterate_monoid_minimal_period_finite_decidability
# 最初の安定位置から μ_F を求め、p = 1, 2, 3, ... の順に大域真理値表の等号 F^{μ_F} = F^{μ_F+p} を
# 全配位・全セルの 2 値等号の連言として判定し、最初に成り立つ p が有限回で見つかって λ_F に等しいことを検査する。
# 帰属: 有限集合の写像の等号と非負整数だけを使う。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

instances = 0
binary_comparisons = [0]
for stage_size, rule, table in exhaustive_instances():
    powers, i, j = monoid_and_collision(table)
    monoid = powers[:j]
    confs = configurations(stage_size)
    # μ_F を最初の安定位置として走査で求める（前章の claim）
    def tail_by_scan(n):
        return frozenset(compose(powers[n], G) for G in monoid)
    mu = next(n for n in range(0, j + 1) if tail_by_scan(n) == tail_by_scan(n + 1))
    # p = 1, 2, ... の順に走査。停止は Π_F の非空性による（上限は付けない: 停止しなければこの検算は終わらない）
    def tables_equal_by_cells(G, H):
        for c in range(len(G)):
            for cell in range(stage_size):
                binary_comparisons[0] += 1
                if confs[G[c]][cell] != confs[H[c]][cell]:
                    return False
        return True
    p = 1
    current = compose(table, powers[mu])                   # F^{μ+1}
    while not tables_equal_by_cells(powers[mu], current):
        p += 1
        current = compose(table, current)                  # F^{μ+p}
    # 独立に定義から求めた λ_F と一致
    lam = min(q for q in range(1, j + 1) if powers[mu] == powers[mu + q])
    assert p == lam
    instances += 1

print("global maps checked: {}".format(instances))
print("binary state comparisons: {}".format(binary_comparisons[0]))
print("RESULT: PASS")
