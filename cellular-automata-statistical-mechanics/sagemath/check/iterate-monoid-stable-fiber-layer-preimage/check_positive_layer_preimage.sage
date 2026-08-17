# 対象ラベル: claim_iterate_monoid_positive_depth_layer_exact_preimage
# 各 q ∈ Q_F, k >= 1 で F^{-1}(L_F(σ_F(q), k)) = L_F(q, k+1) を、人手証明の両包含の各段で確かめる。
#   包含 ⊆: F(y) ∈ L_F(σ_F(q),k) ⇒ y ∈ B_F(q)           (claim_iterate_monoid_stable_fiber_exact_preimage)
#           ⇒ μ(y) > 0                                    (μ(y)=0 なら零層保存で k=0 に矛盾)
#           ⇒ k = μ(F(y)) = μ(y) - 1 ⇒ μ(y) = k+1        (claim_iterate_monoid_min_preperiod_decrements)
#   包含 ⊇: y ∈ L_F(q,k+1) ⇒ F(y) ∈ B_F(σ_F(q)) かつ μ(F(y)) = (k+1)-1 = k
# 完全逆像は _common.sage の一括走査で得る（分割性はそこで検査する）。
# 帰属: 有限集合の所属・等号と非負整数の加減・大小比較だけを使う。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_common.sage'))

instances = 0
preimage_sets = 0
forward_elements = 0
backward_elements = 0
for stage_size, rule, table in exhaustive_instances():
    F, E, Q, fibers, sigma, mp, mu_of, layers = depth_data(table)
    M = len(F)
    fiber_of, sigma_inv, pre = layer_preimage_scan(F, Q, fibers, sigma, mu_of, layers)
    # 検査対象の (q,k): どちらかの辺が空でない組を尽くす（残りは両辺とも空）
    keys = set()
    for (qp, k) in pre:
        if k >= 1:
            keys.add((sigma_inv[qp], k))
    for q in Q:
        for k2 in range(2, M + 1):
            if layers[q][k2]:
                keys.add((q, k2 - 1))
    for q, k in keys:
        pre_set = pre.get((sigma[q], k), frozenset())
        upper = layers[q][k + 1] if k + 1 <= M else frozenset()
        for y in pre_set:                                # 包含 ⊆ の各段
            assert F[y] in layers[sigma[q]][k]
            assert y in fibers[q]                        # 完全逆像の主張
            assert mu_of[y] > 0                          # 零層なら零層へ写り k>0 に矛盾
            assert mu_of[F[y]] == mu_of[y] - 1           # 一段で最小前周期が一つ減る
            assert mu_of[y] == k + 1
            forward_elements += 1
        for y in upper:                                  # 包含 ⊇ の各段
            assert F[y] in fibers[sigma[q]]              # 完全逆像の主張
            assert mu_of[F[y]] == (k + 1) - 1            # 一段減少と N の加減
            assert F[y] in layers[sigma[q]][k]
            backward_elements += 1
        assert pre_set == upper                          # 両包含による集合の等号
        preimage_sets += 1
    instances += 1

print("global maps checked: {}".format(instances))
print("preimage set equalities checked: {}".format(preimage_sets))
print("forward inclusion elements checked: {}".format(forward_elements))
print("backward inclusion elements checked: {}".format(backward_elements))
print("RESULT: PASS")
