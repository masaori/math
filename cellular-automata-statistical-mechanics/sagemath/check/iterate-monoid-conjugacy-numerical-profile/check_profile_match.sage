# 対象ラベル: claim_iterate_monoid_conjugacy_numerical_profile_not_complete
# 反例の二写像の数値プロファイルを定義どおり計算し、証明が引く値
# （大ファイバーの (1,2,3,1) と {{0,0,0,1,1,2,2}}、単元ファイバーの (1,0,0,0) と {{0}}）
# との一致と、P(F)=P(G) を確かめる。
# 帰属: 有限集合の写像の真理値表、有限集合の等号・所属・個数、非負整数の除法・乗算・大小比較だけを使う。R/C 脱出なし。
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_common.sage'))

F_table, G_table = counterexample_tables()
fiber_checks = 0
for table in (F_table, G_table):
    F, mu, lam, e, m, E, one_period, Q, fibers, _ = rooted_tree_data(table)
    assert depth_layer_sequence(F, lam, m, fibers[0], 0) == (1, 2, 3, 1)
    assert branching_multiset(one_period, fibers[0], 0) == (0, 0, 0, 1, 1, 2, 2)
    assert depth_layer_sequence(F, lam, m, fibers[7], 7) == (1, 0, 0, 0)
    assert branching_multiset(one_period, fibers[7], 7) == (0,)
    fiber_checks += 4

profile_f = numerical_profile(F_table)
profile_g = numerical_profile(G_table)
assert profile_f == profile_g
assert profile_f[0] == 3 and profile_f[1] == 1 and profile_f[2] == 2

print("fiber statistics checked: {}".format(fiber_checks))
print("numerical profiles equal: {}".format(profile_f == profile_g))
print("RESULT: PASS")
