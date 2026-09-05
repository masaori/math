# claim_stage_realized_cycle_types_decidable の巡回型計算手順を、一様規則へ制限して校正する。
# 巡回舞台 Z/LZ（L = 3..8）の上で、局所真理値表 256 通りの大域写像を全数構成し、
# 可逆なものを抽出して巡回型を全数計算し、実現される巡回型が分割全体の真部分集合に
# とどまることを舞台の大きさごとに確かめる。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_common.sage'))

STAGE_SIZES = (3, 4, 5, 6, 7, 8)

reversible_rules_by_size = {}
realized_by_size = {}
for length in STAGE_SIZES:
    reversible_rules = []
    realized = set()
    seen_global_maps = set()
    for rule_number in range(256):
        map_table = global_map_table(local_table(rule_number), length)
        seen_global_maps.add(map_table)
        if is_bijective(map_table):
            reversible_rules.append(rule_number)
            realized.add(cycle_type(map_table))
    reversible_rules_by_size[length] = tuple(reversible_rules)
    realized_by_size[length] = realized

    # 巡回型は台の元数 2^L の分割である。
    for partition in realized:
        assert sum(partition) == 2 ** length, (length, partition)
    # 一様・半径 1 という規則クラスでの制限。近傍だけによる制限とは区別する。
    assert len(realized) < partition_count(2 ** length), (length, len(realized))
    # L >= 3 では三つの近傍位置が異なり、全入力を配位へ延長できる。
    # したがって異なる局所真理値表は異なる大域写像を与える（この規則クラスでの検査）。
    assert len(seen_global_maps) == 256, (length, len(seen_global_maps))

# 全数計算の結果（舞台の大きさ 3..8 の範囲での事実）。可逆になる規則の集合は
# 舞台の大きさに依存する。
REVERSIBLE_BY_SIZE = {
    3: (15, 27, 29, 39, 43, 45, 51, 53, 57, 71, 75, 77, 83, 85, 89, 99, 101, 113,
        142, 154, 156, 166, 170, 172, 178, 180, 184, 198, 202, 204, 210, 212, 216,
        226, 228, 240),
    4: (15, 51, 85, 105, 150, 170, 204, 240),
    5: (15, 45, 51, 75, 85, 89, 101, 105, 150, 154, 166, 170, 180, 204, 210, 240),
    6: (15, 51, 85, 170, 204, 240),
    7: (15, 45, 51, 75, 85, 89, 101, 105, 150, 154, 166, 170, 180, 204, 210, 240),
    8: (15, 51, 85, 105, 150, 170, 204, 240),
}
for length in STAGE_SIZES:
    assert reversible_rules_by_size[length] == REVERSIBLE_BY_SIZE[length], (
        length,
        reversible_rules_by_size[length],
    )

# 舞台の大きさ 3..8 のすべてで可逆な規則はちょうど 6 個であり、
# 舞台の大きさ 6 ではそれ以外に可逆な規則が無い。
always_reversible = set(REVERSIBLE_BY_SIZE[STAGE_SIZES[0]])
for length in STAGE_SIZES[1:]:
    always_reversible &= set(REVERSIBLE_BY_SIZE[length])
assert always_reversible == {15, 51, 85, 170, 204, 240}
assert set(REVERSIBLE_BY_SIZE[6]) == always_reversible

# 可逆性は舞台の大きさに依存する。舞台の大きさ 3 で可逆な規則 27 は、
# 舞台の大きさ 4 では可逆でない。有限校正はこの依存を全数で示す。
assert 27 in set(REVERSIBLE_BY_SIZE[3])
assert 27 not in set(REVERSIBLE_BY_SIZE[4])

# 恒等写像（規則 204）は常に不動点だけからなる巡回型を与える。
identity_type = tuple([1] * (2 ** 3))
assert identity_type in realized_by_size[3]

# 台の元数 2^L の分割全体に比べて、実現される巡回型は極端に少ない。
summary = {
    length: (len(realized_by_size[length]), partition_count(2 ** length))
    for length in STAGE_SIZES
}
for length, (realized_count, all_count) in summary.items():
    assert realized_count < all_count

print(
    "PASS stages={} always_reversible={} realized_vs_partitions={}".format(
        STAGE_SIZES, sorted(always_reversible), summary
    )
)
