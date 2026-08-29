# 章「可逆な大域写像の巡回型」の検算で共有する補助。
# 帰属: 有限集合、有限写像表、有限置換、自然数の加減と大小比較、
# 有限列・有限集合・正の自然数の有限多重集合の等号だけを使う。
# 有限多重集合は昇順に整列したタプルで正準表現する。浮動小数点と R/C 脱出はない。

import itertools
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '..', 'conjugacy-class-code-image-bijection', '_common.sage'))


def injective_maps(size):
    """def_bijective_self_maps: 元数 size の配位集合上の単射な自己写像の全表。"""
    return tuple(itertools.permutations(range(size)))


def all_maps(size):
    """元数 size の配位集合上の全自己写像の表。"""
    return tuple(itertools.product(range(size), repeat=size))


def orbits_of(table):
    """def_recursive_preimage_tree_code_periodic_orbits: 𝒪_F。周期点の周期軌道の集合。"""
    mp = preperiod_period_tables(table)
    return periodic_orbits(table, periodic_set(mp))


def cycle_type(table):
    """def_reversible_cycle_type: ct(F) = {{ |O| : O ∈ 𝒪_F }}。整列タプルで表す。"""
    return tuple(sorted(len(orbit) for orbit in orbits_of(table)))


def partitions_of(total):
    """def_carrier_cardinality_partitions: 正の自然数からなり和が total の有限多重集合の全体。
    昇順整列タプルで正準表現する。"""
    def extend(remaining, least):
        if remaining == 0:
            yield ()
            return
        for part in range(least, remaining + 1):
            for rest in extend(remaining - part, part):
                yield (part,) + rest
    return tuple(sorted(extend(total, 1)))


def realize_partition(size, partition):
    """claim_reversible_cycle_type_realizes_every_partition の構成。
    A^V の元 0,1,...,size-1 を並べ、partition の各出現の値を長さとする連続した有限列へ切り分け、
    各有限列の中で次の元へ、末尾を先頭へ送る。"""
    assert sum(partition) == size
    table = [None] * size
    start = 0
    for length in partition:
        for offset in range(length):
            table[start + offset] = start + (offset + 1) % length
        start += length
    assert start == size
    return tuple(table)


def orbit_sequence(table, q):
    """基点 q から始めた周期軌道の並び (q, F q, ..., F^{π(q)-1} q)。"""
    period = preperiod_period_tables(table)[q][1]
    sequence = []
    value = q
    for _ in range(period):
        sequence.append(value)
        value = table[value]
    assert value == q
    return tuple(sequence)


def build_conjugacy_from_cycle_type(table_f, table_g):
    """claim_reversible_cycle_type_completeness の構成。
    ct(F) = ct(G) を前提に、同じ元数の周期軌道を重複度を保って対応させ、
    基点を一つずつ選んで h(F^r(q_O)) := G^r(q'_O) と定めた写像表を返す。"""
    assert cycle_type(table_f) == cycle_type(table_g)
    remaining_g = sorted(orbits_of(table_g), key=lambda orbit: (len(orbit), sorted(orbit)))
    h = [None] * len(table_f)
    for orbit_f in sorted(orbits_of(table_f), key=lambda orbit: (len(orbit), sorted(orbit))):
        matched = None
        for orbit_g in remaining_g:
            if len(orbit_g) == len(orbit_f):
                matched = orbit_g
                break
        assert matched is not None
        remaining_g.remove(matched)
        sequence_f = orbit_sequence(table_f, min(orbit_f))
        sequence_g = orbit_sequence(table_g, min(matched))
        assert len(sequence_f) == len(sequence_g) == len(orbit_f)
        for position in range(len(sequence_f)):
            assert h[sequence_f[position]] is None
            h[sequence_f[position]] = sequence_g[position]
    assert all(value is not None for value in h)
    return tuple(h)
