# 対象ラベル: claim_iterate_monoid_conjugacy_numerical_profile_invariant
# 共役対の全数族で、数値プロファイル P(F)=P(G) を定義どおり再計算して一致を確かめる。
# 帰属: 有限集合の写像の真理値表、有限集合の等号・所属・個数、非負整数の除法・乗算・大小比較だけを使う。R/C 脱出なし。
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_common.sage'))

pairs = 0
for stage_size, rule, table, h, g_table in conjugate_instances():
    assert numerical_profile(table) == numerical_profile(g_table)
    pairs += 1

print("conjugate pairs checked: {}".format(pairs))
print("RESULT: PASS")
