# 対象ラベル: claim_finite_braid_solution_gives_constant_complex_yang_baxter_family
# 判定: U の隣接 braid 条件と R=P∘U の非隣接 Yang–Baxter 条件が全二元写像で同値である。
# 帰属: 有限集合、有限写像表。複素線形化前の基底写像を厳密比較し、浮動小数点は使わない。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

pair_map_count = ZZ(0)
braid_solution_count = ZZ(0)
yang_baxter_solution_count = ZZ(0)
triple_comparison_count = ZZ(0)
for table in product(range(4), repeat=4):
    converted = swap_after(table, 2)
    braid_result = satisfies_braid(table, 2)
    yang_baxter_result = satisfies_yang_baxter(converted, 2)
    assert braid_result == yang_baxter_result
    for triple in all_triples(2):
        assert (braid_left(table, 2, triple) == braid_right(table, 2, triple)) == (
            yang_baxter_left(converted, 2, triple) == yang_baxter_right(converted, 2, triple)
        )
        triple_comparison_count += 1
    pair_map_count += 1
    braid_solution_count += ZZ(braid_result)
    yang_baxter_solution_count += ZZ(yang_baxter_result)

assert pair_map_count == 256
assert braid_solution_count == 43
assert yang_baxter_solution_count == 43
assert triple_comparison_count == 2048
print('pair maps checked:', pair_map_count)
print('triple comparisons checked:', triple_comparison_count)
print('solutions in each convention:', braid_solution_count)
print('RESULT: PASS')
