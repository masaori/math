# 対象ラベル: claim_iterate_monoid_conjugacy_numerical_profile_not_complete
# def_iterate_monoid_conjugacy_numerical_profile_counterexample の写像表を検査する。
# 2 値 CA の大域写像としての実現（N(v)=V の局所規則から大域表を再構成して一致）、
# 証明が引く反復の各行、μ=λ の値、冪等反復写像の像、安定ファイバーの一致を確かめる。
# 帰属: 有限集合の写像の真理値表、有限集合の等号・所属・個数、非負整数の大小比較だけを使う。R/C 脱出なし。
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_common.sage'))

F_table, G_table = counterexample_tables()
cells = 3
realizations = 0
for table in (F_table, G_table):
    # N(v)=V、f_v(y) := F(y) の v ビット。局所規則の評価から大域表を再構成する。
    rebuilt = []
    for y in range(8):
        bits = [(table[y] >> v) & 1 for v in range(cells)]
        rebuilt.append(sum(bits[v] << v for v in range(cells)))
    assert tuple(rebuilt) == table
    realizations += 1

# 証明が引く反復の各行。
assert apply_table_power(F_table, 6, 1) == 4
assert apply_table_power(F_table, 6, 2) == 1
assert apply_table_power(G_table, 6, 1) == 5
assert apply_table_power(G_table, 6, 2) == 2
iterate_rows = 4
for n in range(3, 10):
    assert apply_table_power(F_table, 6, n) == 0
    assert apply_table_power(G_table, 6, n) == 0
    iterate_rows += 2
for y in range(8):
    assert apply_table_power(F_table, y, 3) == apply_table_power(F_table, y, 4)
    assert apply_table_power(G_table, y, 3) == apply_table_power(G_table, y, 4)
    iterate_rows += 2
assert apply_table_power(F_table, 6, 2) != apply_table_power(F_table, 6, 3)
assert apply_table_power(G_table, 6, 2) != apply_table_power(G_table, 6, 3)

# μ・λ・e・m と冪等反復写像・安定像・安定ファイバー。
structure_checks = 0
for table in (F_table, G_table):
    _, mu, lam, e, m, E, one_period, Q, fibers, powers = rooted_tree_data(table)
    assert mu == 3 and lam == 1 and e == 3 and m == 3
    assert E == powers[3]
    assert set(Q) == {0, 7}
    assert fibers[0] == frozenset(range(7))
    assert fibers[7] == frozenset({7})
    structure_checks += 1

print("global map realizations checked: {}".format(realizations))
print("iterate rows checked: {}".format(iterate_rows))
print("structure tables checked: {}".format(structure_checks))
print("RESULT: PASS")
