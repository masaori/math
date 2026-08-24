# 対象ラベル: claim_zero_breakage_multiplicity_is_two
# 本文の三段を、有限箱の全配位と ZZ の整除性で一行ずつ確認する。
from itertools import product


def box_sites(box_side):
    return [
        (ZZ(a), ZZ(b), ZZ(c))
        for a in range(box_side)
        for b in range(box_side)
        for c in range(box_side)
    ]


def inner_edges(box_side):
    sites = set(box_sites(box_side))
    edges = []
    for start in sites:
        for direction in range(3):
            end = list(start)
            end[direction] += 1
            end = tuple(end)
            if end in sites:
                edges.append((start, end))
    return edges


def configurations(box_side):
    sites = box_sites(box_side)
    for values in product([ZZ(1), ZZ(-1)], repeat=len(sites)):
        yield dict(zip(sites, values))


def broken_count(configuration, edges):
    return ZZ(sum(configuration[start] != configuration[end] for start, end in edges))


print("== 段 1: 破れ数ゼロの配位は原点と同じ値を持つ ==")
for box_side in [1, 2]:
    sites = box_sites(box_side)
    edges = inner_edges(box_side)
    origin = (ZZ(0), ZZ(0), ZZ(0))
    for configuration in configurations(box_side):
        if broken_count(configuration, edges) == 0:
            assert all(configuration[site] == configuration[origin] for site in sites)
print("  PASS")

print("== 段 2: 二つの定値配位は破れ数ゼロである ==")
for box_side in [1, 2]:
    sites = box_sites(box_side)
    edges = inner_edges(box_side)
    for value in [ZZ(1), ZZ(-1)]:
        configuration = {site: value for site in sites}
        assert broken_count(configuration, edges) == 0
print("  PASS")

print("== 段 3: 破れ数ゼロの多重度は二である ==")
for box_side in [1, 2]:
    edges = inner_edges(box_side)
    omega_zero = ZZ(sum(broken_count(configuration, edges) == 0 for configuration in configurations(box_side)))
    assert omega_zero == 2
    for p in prime_range(3, 30):
        assert p % 2 == 1
        assert omega_zero % p != 0
print("  PASS")
print("ALL PASS")
