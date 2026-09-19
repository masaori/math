# 対象ラベル: claim_finite_yang_baxter_condition_decidable
# 判定: 有限二体写像の braid 条件を全 n^3 入力で決定し、成分交換例と二元反例を照合する。
# 帰属: 有限集合、有限写像表、NN。実数体・複素数体・浮動小数点は使わない。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

swap_input_count = ZZ(0)
for size in range(1, 7):
    table = swap_table(size)
    triples = all_triples(size)
    assert len(triples) == size ** 3
    for triple in triples:
        assert braid_left(table, size, triple) == (ZZ(triple[2]), ZZ(triple[1]), ZZ(triple[0]))
        assert braid_right(table, size, triple) == (ZZ(triple[2]), ZZ(triple[1]), ZZ(triple[0]))
        swap_input_count += 1

binary_map_count = ZZ(0)
binary_solution_count = ZZ(0)
for table in product(range(4), repeat=4):
    decision_by_scan = all(
        braid_left(table, 2, triple) == braid_right(table, 2, triple)
        for triple in all_triples(2)
    )
    assert decision_by_scan == satisfies_braid(table, 2)
    binary_map_count += 1
    if decision_by_scan:
        binary_solution_count += 1

counterexample = (0, 0, 0, 1)
assert braid_left(counterexample, 2, (1, 1, 1)) == (0, 0, 1)
assert braid_right(counterexample, 2, (1, 1, 1)) == (0, 0, 0)
assert not satisfies_braid(counterexample, 2)
assert binary_map_count == 256
assert binary_solution_count == 43
print('swap inputs checked:', swap_input_count)
print('binary pair maps checked:', binary_map_count)
print('binary braid solutions:', binary_solution_count)
print('RESULT: PASS')
