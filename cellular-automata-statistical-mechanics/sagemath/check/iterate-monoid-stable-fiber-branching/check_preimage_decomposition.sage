# 対象ラベル: claim_iterate_monoid_stable_fiber_preimage_decomposition
# 各 q ∈ Q_F について F^{-1}(B_F(σ_F(q))) = ⋃_{z ∈ B_F(σ_F(q))} Pre_F(z) を確かめる。
# 人手証明の段: y ∈ F^{-1}(B) ⟺ F(y) ∈ B ⟺ ∃z∈B, F(y)=z ⟺ ∃z∈B, y∈Pre_F(z) ⟺ y ∈ ⋃ Pre_F(z)。
# 帰属: 有限集合の所属・等号だけを使う。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_common.sage'))

instances = 0
memberships = 0
for stage_size, rule, table in exhaustive_instances():
    F, E, Q, fibers, sigma, pre, d = branching_data(table)
    n = len(F)
    for q in Q:
        target = fibers[sigma[q]]                              # B_F(σ_F(q))
        preimage = frozenset(y for y in range(n) if F[y] in target)   # 完全逆像の定義
        union = frozenset().union(*[pre[z] for z in target]) if target else frozenset()
        for y in range(n):
            lhs = y in preimage
            s1 = F[y] in target                                # 完全逆像の定義
            assert lhs == s1
            s2 = any(F[y] == z for z in target)                # z := F(y)
            assert s1 == s2
            s3 = any(y in pre[z] for z in target)              # 一段前像集合の定義
            assert s2 == s3
            s4 = y in union                                    # 有限合併への所属
            assert s3 == s4
            memberships += 1
        assert preimage == union                               # 任意の y で所属が同値
    instances += 1

print("global maps checked: {}".format(instances))
print("memberships checked: {}".format(memberships))
print("RESULT: PASS")
