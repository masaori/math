# 対象ラベル: claim_torus_homology_sector_partition
# 有限辺集合の全列挙と、集合の共通部分から計算する巻き付き偶奇。

from pathlib import Path
from operator import xor

_sector_partition_dir = Path('sagemath/check/torus-homology-sector-partition').resolve()
load(str(_sector_partition_dir / '../../_shared/defs.sage'))


def sector_partition_even_subsets(L):
    edge_list = tuple(range(1, 2 * L * L + 1))
    incidence_masks = []
    for vertex in vertices(L):
        incidence_mask = int(0)
        for position, edge in enumerate(edge_list):
            for endpoint in endpoints(L, edge):
                if endpoint == vertex:
                    incidence_mask = xor(incidence_mask, int(1) << int(position))
        incidence_masks.append(incidence_mask)
    for mask in range(int(1) << len(edge_list)):
        if all((int(mask) & incidence_mask).bit_count() % 2 == 0
               for incidence_mask in incidence_masks):
            yield frozenset(edge for position, edge in enumerate(edge_list)
                            if int(mask) & (int(1) << int(position)))


def sector_partition_witness(L, subset):
    horizontal = frozenset(edge_number_horizontal(L, i, -1) for i in range(L))
    vertical = frozenset(edge_number_vertical(L, -1, j) for j in range(L))
    return (ZZ(len(subset & horizontal)) % 2,
            ZZ(len(subset & vertical)) % 2)


def sector_partition_membership(L, subset, candidate):
    # 四候補を各境界辺の指示関数で判定し、witness の辞書振り分けには依存しない。
    a, b = candidate
    return (all(sum(ZZ(endpoint == vertex) for edge in subset
                    for endpoint in endpoints(L, edge)) % 2 == 0
                for vertex in vertices(L))
            and sum(ZZ(edge_number_horizontal(L, i, -1) in subset)
                for i in range(L)) % 2 == a
            and sum(ZZ(edge_number_vertical(L, -1, j) in subset)
                    for j in range(L)) % 2 == b)


def sector_partition_rows():
    for L in (1, 2, 3):
        for subset in sector_partition_even_subsets(L):
            witness = sector_partition_witness(L, subset)
            candidates = tuple((ZZ(a), ZZ(b)) for a in (0, 1) for b in (0, 1)
                               if sector_partition_membership(L, subset, (a, b)))
            yield L, subset, witness, candidates
