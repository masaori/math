# 対象ラベル: claim_iterate_monoid_zero_depth_layer_exact_preimage
# 各 q ∈ Q_F で F^{-1}(L_F(σ_F(q), 0)) = L_F(q,0) ∪ L_F(q,1) を、人手証明の場合分けの各段で確かめる。
#   包含 ⊆: F(y) ∈ L_F(σ_F(q),0) ⇒ y ∈ B_F(q)           (claim_iterate_monoid_stable_fiber_exact_preimage)
#           μ(y) = 0 なら y ∈ L_F(q,0)
#           μ(y) > 0 なら 0 = μ(F(y)) = μ(y)-1 ⇒ μ(y)=1  (claim_iterate_monoid_min_preperiod_decrements)
#   包含 ⊇: y ∈ L_F(q,0) なら μ(F(y)) = 0                 (claim_iterate_monoid_zero_depth_maps_to_zero_depth)
#           y ∈ L_F(q,1) なら μ(F(y)) = 0                 (一段減少)
#           どちらも F(y) ∈ B_F(σ_F(q))                    (claim_iterate_monoid_stable_fiber_exact_preimage)
# 完全逆像は _common.sage の一括走査で得る（分割性はそこで検査する）。
# 帰属: 有限集合の所属・合併・等号と非負整数の等号だけを使う。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_common.sage'))

instances = 0
preimage_sets = 0
case_zero = 0
case_one = 0
for stage_size, rule, table in exhaustive_instances():
    F, E, Q, fibers, sigma, mp, mu_of, layers = depth_data(table)
    M = len(F)
    fiber_of, sigma_inv, pre = layer_preimage_scan(F, Q, fibers, sigma, mu_of, layers)
    for q in Q:
        pre_set = pre.get((sigma[q], 0), frozenset())
        union = layers[q][0] | layers[q][1]
        for y in pre_set:                                # 包含 ⊆ の場合分け
            assert F[y] in layers[sigma[q]][0]
            assert y in fibers[q]                        # 完全逆像の主張
            if mu_of[y] == 0:
                assert y in layers[q][0]
                case_zero += 1
            else:
                assert mu_of[F[y]] == mu_of[y] - 1       # 一段減少
                assert mu_of[y] == 1
                assert y in layers[q][1]
                case_one += 1
        for y in union:                                  # 包含 ⊇ の場合分け
            assert mu_of[F[y]] == 0                      # 零層保存または一段減少
            assert F[y] in fibers[sigma[q]]              # 完全逆像の主張
            assert F[y] in layers[sigma[q]][0]
        assert pre_set == union                          # 両包含による集合の等号
        preimage_sets += 1
    instances += 1

print("global maps checked: {}".format(instances))
print("preimage set equalities checked: {}".format(preimage_sets))
print("zero-layer case elements checked: {}".format(case_zero))
print("one-layer case elements checked: {}".format(case_one))
print("RESULT: PASS")
