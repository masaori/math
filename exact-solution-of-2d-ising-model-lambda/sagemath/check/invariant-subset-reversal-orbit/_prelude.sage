from pathlib import Path
from functools import lru_cache
load(str(Path(__file__).resolve().parent.parent / "invariant-subset-reversal" / "_prelude.sage"))

isro_permutations = tuple(sorted({case[0] for case in isr_cases}))

def inverse_permutation(sigma):
    return tuple(sigma.index(i) for i in range(len(sigma)))

def reverse_on_subset(sigma, C):
    inverse = inverse_permutation(sigma)
    return tuple(inverse[i] if i in C else sigma[i] for i in range(len(sigma)))

@lru_cache(maxsize=None)
def iteration_until_repeat(sigma, i):
    values = []
    visited = set()
    value = i
    while value not in visited:
        visited.add(value)
        values.append(value)
        value = sigma[value]
    return tuple(values), value

@lru_cache(maxsize=None)
def orbit_support(sigma, i):
    forward, _ = iteration_until_repeat(sigma, i)
    backward, _ = iteration_until_repeat(inverse_permutation(sigma), i)
    return frozenset(forward) | frozenset(backward)

def orbit_length(sigma, i):
    return len(orbit_support(sigma, i))

@lru_cache(maxsize=None)
def paired_iteration_until_repeat(forward, backward, i):
    values = []
    visited = set()
    value = (i, i)
    while value not in visited:
        visited.add(value)
        values.append(value)
        value = (forward[value[0]], backward[value[1]])
    return tuple(values), value

def either_iterate_membership(forward, backward, i, j):
    values, _ = paired_iteration_until_repeat(forward, backward, i)
    return any(a == j or b == j for a, b in values)

def undirected_reachable(sigma, i):
    # 辺 {k, sigma(k)} を両向きに読む。逆置換も反復関数も使わない。
    neighbours = [set() for _ in sigma]
    for source, target in enumerate(sigma):
        neighbours[source].add(target)
        neighbours[target].add(source)
    reached = {i}
    pending = [i]
    while pending:
        current = pending.pop()
        for neighbour in neighbours[current]:
            if neighbour not in reached:
                reached.add(neighbour)
                pending.append(neighbour)
    return frozenset(reached)

def orbit_report(name, count, expected):
    assert count == expected, (name, count, expected)
    print(f"{name}: {count} checks; RESULT: PASS")
