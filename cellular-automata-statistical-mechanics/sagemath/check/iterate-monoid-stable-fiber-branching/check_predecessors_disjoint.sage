# 対象ラベル: claim_iterate_monoid_stable_fiber_predecessors_disjoint
# z ≠ w なら Pre_F(z) ∩ Pre_F(w) = ∅ を確かめる。
# 人手証明の段: y が両方に属せば F(y)=z かつ F(y)=w、よって z=w で矛盾。
# 帰属: 有限集合の写像の値の等号と所属判定だけを使う。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_common.sage'))

instances = 0
pairs = 0
memberships = 0
for stage_size, rule, table in exhaustive_instances():
    F, E, Q, fibers, sigma, pre, d = branching_data(table)
    n = len(F)
    for z in range(n):
        for y in pre[z]:
            assert F[y] == z                      # 一段前像集合の定義
            memberships += 1
        for w in range(n):
            if z == w:
                continue
            for y in pre[z]:
                # 人手証明: y ∈ Pre_F(z) ∩ Pre_F(w) と仮定すると F(y)=z かつ F(y)=w、ゆえに z=w
                if y in pre[w]:
                    assert F[y] == z and F[y] == w
                    assert z == w                 # 到達しない
            assert len(pre[z] & pre[w]) == 0
            pairs += 1
    instances += 1

print("global maps checked: {}".format(instances))
print("ordered pairs z != w checked: {}".format(pairs))
print("predecessor memberships checked: {}".format(memberships))
print("RESULT: PASS")
