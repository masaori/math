# 対象ラベル: claim_iterate_monoid_stable_fiber_predecessor_count_conservation
# 各 q ∈ Q_F について |B_F(q)| = Σ_{z ∈ B_F(σ_F(q))} b_F(z) を、人手証明の 4 等号を分けて確かめる。
#   |B_F(q)| = |F^{-1}(B_F(σ_F(q)))|            (完全逆像の等号)
#            = |⋃_{z} Pre_F(z)|                    (前像集合への分解)
#            = Σ_{z} |Pre_F(z)|                    (非交差)
#            = Σ_{z} b_F(z)                        (一段前像数の定義)
# 帰属: 有限集合の個数と非負整数の加算だけを使う。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_common.sage'))

instances = 0
fibers_checked = 0
for stage_size, rule, table in exhaustive_instances():
    F, E, Q, fibers, sigma, pre, d = branching_data(table)
    n = len(F)
    for q in Q:
        target = fibers[sigma[q]]
        preimage = frozenset(y for y in range(n) if F[y] in target)
        assert preimage == fibers[q]                          # claim_..._exact_preimage
        c1 = len(fibers[q])
        c2 = len(preimage)
        assert c1 == c2
        parts = [pre[z] for z in target]
        union = frozenset().union(*parts) if parts else frozenset()
        assert union == preimage                              # claim_..._preimage_decomposition
        c3 = len(union)
        assert c2 == c3
        for i in range(len(parts)):                           # 非交差の再確認
            for j in range(i + 1, len(parts)):
                assert len(parts[i] & parts[j]) == 0
        c4 = sum(len(p) for p in parts)
        assert c3 == c4                                       # 非交和の個数は和
        c5 = sum(d[z] for z in target)
        assert c4 == c5                                       # b_F の定義
        assert c1 == c5
        fibers_checked += 1
    instances += 1

print("global maps checked: {}".format(instances))
print("stable fibers checked: {}".format(fibers_checked))
print("RESULT: PASS")
