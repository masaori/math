# 対象ラベル: claim_single_cell_flip_positive_count_domain
# 式ペア・判定: Z_{2k+1}=0、Z_{2k+2}=2、Pos_G は正の偶数回（有限範囲）
# プログラミングによる検証: 有限集合・ZZ・QQ の厳密計算。R/C 脱出なし。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), "_prelude.sage"))

configs = tuple(configuration(a) for a in STATES)
assert len(configs) == 2
for k in range(17):
    odd_fixed = [x for x in configs if flip_iterate(x, 2*k+1) == x]
    even_fixed = [x for x in configs if flip_iterate(x, 2*k+2) == x]
    assert odd_fixed == [], k
    assert even_fixed == list(configs), k
positive_window = {n for n in range(1, 35)
                   if any(flip_iterate(x,n) == x for x in configs)}
assert positive_window == {2*m for m in range(1,18)}
assert 1 not in positive_window
print("flip exponents checked: 1..34; odd count 0, even count 2")
print("RESULT: PASS")
