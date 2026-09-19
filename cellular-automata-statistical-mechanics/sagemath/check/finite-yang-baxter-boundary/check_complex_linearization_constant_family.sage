# 対象ラベル: claim_finite_braid_solution_gives_constant_complex_yang_baxter_family
# 判定: 複素線形化は有限表を基底列から復元でき、有限 braid 解の変換後行列は Yang–Baxter 等式を満たす。
# 帰属: ZZ 上の零一行列。ZZ→CC の係数埋め込みで等式は保たれるため、浮動小数点や CC の近似値は使わない。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

pair_map_count = ZZ(0)
recovered_column_count = ZZ(0)
solution_count = ZZ(0)
matrix_entry_count = ZZ(0)
for table in product(range(4), repeat=4):
    linearized = pair_linearization_matrix(table, 2, ZZ)
    recovered = tuple(
        next(target for target in range(4) if linearized[target, source] == 1)
        for source in range(4)
    )
    assert recovered == table
    assert all(sum(linearized[target, source] for target in range(4)) == 1 for source in range(4))
    recovered_column_count += 4
    pair_map_count += 1

    if satisfies_braid(table, 2):
        converted = swap_after(table, 2)
        left_matrix = triple_action_matrix(2, lambda triple: yang_baxter_left(converted, 2, triple), ZZ)
        right_matrix = triple_action_matrix(2, lambda triple: yang_baxter_right(converted, 2, triple), ZZ)
        assert left_matrix == right_matrix
        solution_count += 1
        matrix_entry_count += 2 * 8 * 8

assert pair_map_count == 256
assert recovered_column_count == 1024
assert solution_count == 43
assert matrix_entry_count == 5504
print('linearized finite tables checked:', pair_map_count)
print('basis columns recovered:', recovered_column_count)
print('constant-family Yang-Baxter matrices checked:', solution_count)
print('matrix entries compared:', matrix_entry_count)
print('RESULT: PASS')
