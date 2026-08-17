# 対象ラベル: claim_iterate_monoid_stable_fiber_dynamics_finite_decidability
# 前章の走査で得た Q_F と B_F(q) から、σ_F の表、各 F(B_F(q))、各 F^{-1}(B_F(σ_F(q))) を
# 有限走査で得て、定義どおりの集合と一致することを確かめる。
# 帰属: 有限集合の走査と配位番号の等号だけを使う。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_common.sage'))

instances = 0
comparisons = 0
for stage_size, rule, table in exhaustive_instances():
    F, mu, lam, e, E, FE1, Q, fibers, sigma = stable_fiber_dynamics_data(table)
    # σ_F の表: Q_F の各元へ F を適用する
    sigma_scan = {}
    for q in Q:
        sigma_scan[q] = F[q]
    assert sigma_scan == sigma
    for q in Q:
        # 像: B_F(q) の全元へ F を適用し重複を除く
        image_scan = []
        for y in fibers[q]:
            z = F[y]
            found = False
            for w in image_scan:
                comparisons += 1
                if w == z:
                    found = True
                    break
            if not found:
                image_scan.append(z)
        assert frozenset(image_scan) == frozenset(F[y] for y in fibers[q])
        # 完全逆像: A^V の各元の像が B_F(σ_F(q)) に属するかを検査する
        target = fibers[sigma_scan[q]]
        preimage_scan = []
        for y in range(len(F)):
            comparisons += 1
            if F[y] in target:
                preimage_scan.append(y)
        assert frozenset(preimage_scan) == fibers[q]      # claim_iterate_monoid_stable_fiber_exact_preimage
    instances += 1

print("global maps checked: {}".format(instances))
print("configuration comparisons: {}".format(comparisons))
print("RESULT: PASS")
