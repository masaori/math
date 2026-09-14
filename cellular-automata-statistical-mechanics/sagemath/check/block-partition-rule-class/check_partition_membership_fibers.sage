# 対象ラベル: claim_block_partition_blocks_are_membership_fibers
# 併せて検証: def_block_partition
# 分割条件を全候補から有限走査し、各ブロックが所属ブロック写像の繊維に一致することを検査する。
# 帰属: 有限集合、有限部分集合、ZZ。対数、除算、浮動小数点、R/C 脱出はない。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

candidate_count = ZZ(0)
partition_count = ZZ(0)
fiber_comparison_count = ZZ(0)
expected_partition_counts = (1, 1, 2, 5, 15)

for cell_count in range(5):
    cells = tuple(range(cell_count))
    subsets = nonempty_subsets(cells)
    partitions = block_partitions(cells)
    candidate_count += ZZ(2) ** ZZ(len(subsets))
    assert len(partitions) == expected_partition_counts[cell_count]
    for partition in partitions:
        assert is_block_partition(cells, partition)
        for block in partition:
            fiber = tuple(cell for cell in cells if membership_block(partition, cell) == block)
            assert fiber == block
            fiber_comparison_count += 1
        partition_count += 1

assert candidate_count == ZZ(32907)
assert partition_count == ZZ(24)
assert fiber_comparison_count == ZZ(51)
print('candidate families scanned:', candidate_count)
print('block partitions checked:', partition_count)
print('membership fibers checked:', fiber_comparison_count)
print('RESULT: PASS')
