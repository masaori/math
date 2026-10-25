# 対象ラベル: claim_matching_pair_even_sum
# 有限集合の大きさ 0, 2, 4, 6 について独立な不定元を使い、
# 偶数軌道置換の和と順序付きマッチング対の和を厳密に比較する。
from itertools import permutations


def matchings(vertices):
    if not vertices:
        yield ()
        return
    first = vertices[0]
    for k in range(1, len(vertices)):
        second = vertices[k]
        rest = vertices[1:k] + vertices[k + 1:]
        for tail in matchings(rest):
            yield ((first, second),) + tail


def even_cycles(p):
    seen = set()
    for i in range(len(p)):
        if i in seen:
            continue
        j = i
        cycle = []
        while j not in seen:
            seen.add(j)
            cycle.append(j)
            j = p[j]
        if len(cycle) % 2:
            return False
    return True


def sign(word):
    inversions = sum(word[i] > word[j]
                     for i in range(len(word)) for j in range(i + 1, len(word)))
    return (-1) ** inversions


for n in (0, 2, 4, 6):
    names = ['a_%s_%s' % (i, j) for i in range(n) for j in range(i + 1, n)]
    R = PolynomialRing(QQ, names) if names else QQ
    gens = R.gens() if names else ()
    A = {}
    for i in range(n):
        A[i, i] = R(0)
    for index, (i, j) in enumerate((i, j) for i in range(n) for j in range(i + 1, n)):
        A[i, j] = gens[index]
        A[j, i] = -gens[index]

    even_sum = R(0)
    for p in permutations(range(n)):
        if even_cycles(p):
            term = R(sign(p))
            for i in range(n):
                term *= A[i, p[i]]
            even_sum += term

    pair_sum = R(0)
    all_matchings = list(matchings(tuple(range(n))))
    for D in all_matchings:
        word_D = tuple(x for pair in D for x in pair)
        term_D = R(sign(word_D))
        for i, j in D:
            term_D *= A[i, j]
        for E in all_matchings:
            word_E = tuple(x for pair in E for x in pair)
            term_E = R(sign(word_E))
            for i, j in E:
                term_E *= A[i, j]
            pair_sum += term_D * term_E
    assert even_sum == pair_sum, n
    print('PASS: |J| = %s, 偶数軌道の和 = マッチング対の和' % n)
