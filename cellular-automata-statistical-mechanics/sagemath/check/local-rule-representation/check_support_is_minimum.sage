# 対象ラベル: claim_support_is_minimum_representing_set
# |V| = 1, 2, 3 の全 g について、g を表せる S ⊆ V の全体を定義どおりの走査で集め、
# supp(g) がその集合に属し、かつ全ての元に包含される（包含に関する最小元である）ことを検査する。
# 帰属: 有限集合の等号と包含だけ。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

rules = 0
for n in (1, 2, 3):
    cells = tuple(range(n))
    for g in all_rules(cells):
        supp = support(cells, g)
        family = [frozenset(S) for S in subsets(cells) if representable(cells, S, g)]
        assert supp in family, (n, g)
        assert all(supp <= S for S in family), (n, g)
        # 最小元は一意: family の共通部分と一致する
        common = frozenset(cells)
        for S in family:
            common = common & S
        assert common == supp
        rules += 1
assert rules == 4 + 16 + 256
print("rules checked: {}".format(rules))
print("RESULT: PASS")
