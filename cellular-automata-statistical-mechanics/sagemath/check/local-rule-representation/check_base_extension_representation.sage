# 対象ラベル: claim_support_subset_implies_representable
# supp(g) ⊆ S のとき、証明で構成した h := g ∘ ι^V_S が実際に g = h ∘ ρ^V_S を満たすこと、
# および帰納段で使う事実「w ∈ V∖S、y(w) = 1 なら g(y) = g(φ_w y) かつ ρ^V_S y = ρ^V_S(φ_w y)」を、
# |V| = 1, 2, 3 の全 g・全 S・全 y・全 w で検査する。帰属: 有限集合の等号だけ。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

checked_pairs = 0
checked_steps = 0
for n in (1, 2, 3):
    cells = tuple(range(n))
    confs = configurations(cells)
    for g in all_rules(cells):
        supp = support(cells, g)
        for S in subsets(cells):
            if not (supp <= frozenset(S)):
                continue
            checked_pairs += 1
            for y in confs:
                # 主張: g(y) = (g ∘ ι^V_S)(ρ^V_S y)
                assert g[y] == g[base_extend(cells, S, restrict(cells, S, y))], (n, S, y)
                # 底: V∖S 上で 0 なら ι(ρ y) = y
                if all(y[i] == 0 for i, c in enumerate(cells) if c not in S):
                    assert base_extend(cells, S, restrict(cells, S, y)) == y
                # 帰納段: w ∈ V∖S, y(w) = 1 のとき、g の値と S への制限が反転で不変
                for i, w in enumerate(cells):
                    if w in S or y[i] != 1:
                        continue
                    yp = flip(cells, w, y)
                    assert g[y] == g[yp], (n, S, y, w)
                    assert restrict(cells, S, y) == restrict(cells, S, yp)
                    checked_steps += 1
print("(g, S) with supp(g) ⊆ S: {}; induction steps checked: {}".format(checked_pairs, checked_steps))
print("RESULT: PASS")
