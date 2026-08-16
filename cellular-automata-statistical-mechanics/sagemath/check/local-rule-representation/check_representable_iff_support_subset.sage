# 対象ラベル: claim_support_is_minimum_representing_set
# 併せて claim_representable_implies_support_subset（⇒）と claim_support_subset_implies_representable（⇐）を検査する。
# |V| = 1, 2, 3 の全ての g: A^V → A と全ての S ⊆ V について、
#   定義どおりの表現可能性（全 h の走査）と supp(g) ⊆ S が一致すること
# を検査し、両方向を別々に数える。帰属: 有限集合の等号だけ。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

total = 0
forward = 0
backward = 0
for n in (1, 2, 3):
    cells = tuple(range(n))
    for g in all_rules(cells):
        supp = support(cells, g)
        for S in subsets(cells):
            rep = representable(cells, S, g)
            incl = supp <= frozenset(S)
            total += 1
            if rep:
                assert incl, (n, S, g)   # ⇒: 表せるなら supp(g) ⊆ S
                forward += 1
            if incl:
                assert rep, (n, S, g)    # ⇐: supp(g) ⊆ S なら表せる
                backward += 1
assert total == 4 * 2 + 16 * 4 + 256 * 8
print("pairs (g, S) checked: {}; representable: {}; supp-subset: {}".format(total, forward, backward))
print("RESULT: PASS")
