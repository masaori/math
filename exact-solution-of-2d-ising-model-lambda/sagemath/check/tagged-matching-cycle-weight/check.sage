from itertools import product

# 対象ラベル: claim_tagged_matching_cycle_weight
# 先行する符号比較とゲージ比を、任意の閉路長・向き直し・位相に代入する。
K = CyclotomicField(8)
zeta = K.gen()
R = PolynomialRing(K, 'x')
x = R.gen()

cases = 0
for lengths in ((1,), (2,), (3,), (1, 2), (1, 1, 3)):
    count = len(lengths)
    for orientations in product((-1, 1), repeat=2 * count):
        for phase_exponents in product(range(8), repeat=count):
            cycle_terms = []
            for index, length in enumerate(lengths):
                alpha_d = ZZ(orientations[2 * index])
                alpha_0 = ZZ(orientations[2 * index + 1])
                phase = zeta ** phase_exponents[index]
                # 第一行: 符号比、短い寄与の負号、昇順への二度の向き直し。
                gauge_ratio = K(-1) ** length
                first = R((-1) ** (1 + length) * alpha_d**2 * alpha_0**2
                          * gauge_ratio * phase) * x**length
                # 第二行: 向き直し符号の平方は一。
                second = R((-1) ** (1 + length) * gauge_ratio * phase) * x**length
                # 第三行: 対角変換因子の比は (-1)^k。
                third = R((-1) ** (1 + length) * (-1) ** length * phase) * x**length
                # 第四行: 二つの長さ依存の符号が相殺する。
                fourth = -R(phase) * x**length
                assert first == second == third == fourth
                cycle_terms.append(first)
            assert prod(cycle_terms, R.one()) == prod(
                (-R(zeta ** phase_exponents[i]) * x**lengths[i]
                 for i in range(count)), R.one())
            cases += 1

print(f'PASS: {cases} exact cyclotomic cycle-family assignments')

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
    word = [v for pair in sorted(pairs) for v in pair]
    inversions = sum(word[i] > word[j] for i in range(len(word)) for j in range(i + 1, len(word)))
    return ZZ(-1) ** inversions

def gauge(index):
    return K(1) if index % 2 == 0 else zeta ** (-2)

def weight(first, second):
    return zeta**2 * gauge(second) / gauge(first)

matching_cases = 0
for n in range(1, 5):
    base = tuple((2*i, 2*i + 1) for i in range(n))
    assert all(weight(*pair) == 1 for pair in base)
    for pairs in matchings(tuple(range(2*n))):
        # 基準と共通する対も、長い標識・短い標識のいずれにもできる。
        shared = set(pairs) & set(base)
        for mask in range(2 ** len(shared)):
            short = (set(pairs) - set(base)) | {
                pair for index, pair in enumerate(sorted(shared)) if (mask >> index) & 1
            }
            def short_entry(pair):
                return weight(*pair) * zeta ** ((pair[0] + 2*pair[1]) % 8)
            lhs = R(matching_sign(pairs) * (-1)**len(short)
                    * prod((short_entry(pair) for pair in short), K(1))) * x**len(short)
            mate = {v: w for a, b in pairs for v, w in ((a, b), (b, a))}
            base_mate = {v: w for a, b in base for v, w in ((a, b), (b, a))}
            active = set(v for pair in short for v in pair)
            rhs = R.one()
            while active:
                start = min(active)
                c = [start]
                while True:
                    other = mate[c[-1]]
                    following = base_mate[other]
                    c.append(other)
                    if following == start:
                        break
                    c.append(following)
                active.difference_update(c)
                k = len(c) // 2
                phase_product = K(1)
                for r in range(k):
                    first, second = c[2*r], c[2*r + 1]
                    pair = tuple(sorted((first, second)))
                    oriented_entry = short_entry(pair) if first < second else -short_entry(pair)
                    phase_product *= oriented_entry / weight(first, second)
                rhs *= -R(phase_product) * x**k
            assert lhs == rhs, (n, pairs, short, lhs, rhs)
            matching_cases += 1

print(f'PASS: {matching_cases} tagged matching assignments')
