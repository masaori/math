from itertools import combinations

# 対象ラベル: claim_alternating_cycle_matching_sign
# 有限番号集合の完全マッチングと長短の標識を ZZ の符号で検算する。
def matchings(vertices):
    if not vertices:
        yield ()
        return
    first = vertices[0]
    for second in vertices[1:]:
        rest = tuple(v for v in vertices if v != first and v != second)
        for tail in matchings(rest):
            yield ((first, second),) + tail

def matching_sign(pairs):
    word = [v for pair in sorted(tuple(sorted(p)) for p in pairs) for v in pair]
    inversions = sum(word[i] > word[j] for i in range(len(word)) for j in range(i + 1, len(word)))
    return ZZ(-1) ** inversions

def mate_map(pairs):
    result = {}
    for a, b in pairs:
        result[a] = b
        result[b] = a
    return result

def cycle_rhs(pairs, base, short_common):
    d = mate_map(pairs)
    z = mate_map(base)
    shared = set(tuple(sorted(p)) for p in pairs) & set(base)
    inactive = set(v for pair in shared - short_common for v in pair)
    unseen = set(d) - inactive
    rhs = ZZ(1)
    while unseen:
        start = min(unseen)
        c = [start]
        while True:
            next_d = d[c[-1]]
            next_z = z[next_d]
            c.append(next_d)
            if next_z == start:
                break
            c.append(next_z)
        assert len(set(c)) == len(c)
        unseen.difference_update(c)
        alpha_d = prod(ZZ(1) if c[2*r] < c[2*r+1] else ZZ(-1) for r in range(len(c)//2))
        alpha_0 = prod(ZZ(1) if c[2*r+1] < c[(2*r+2)%len(c)] else ZZ(-1) for r in range(len(c)//2))
        rhs *= -alpha_d*alpha_0
    return rhs

cases = 0
for n in range(1, 5):
    base = tuple((2*i, 2*i+1) for i in range(n))
    for pairs in matchings(tuple(range(2*n))):
        common = sorted(set(tuple(sorted(p)) for p in pairs) & set(base))
        for size in range(len(common)+1):
            for chosen in combinations(common, size):
                lhs = matching_sign(pairs) * matching_sign(base)
                rhs = cycle_rhs(pairs, base, set(chosen))
                assert lhs == rhs, (n, pairs, chosen, lhs, rhs)
                cases += 1
print('RESULT: PASS; exact ZZ cases =', cases)
