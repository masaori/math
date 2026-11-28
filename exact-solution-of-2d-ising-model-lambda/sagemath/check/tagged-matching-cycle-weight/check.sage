from itertools import product

# 対象ラベル: claim_tagged_matching_cycle_weight
# 主鎖の各行を、任意の閉路長・向き直しの符号・位相に代入して照合する。
K = CyclotomicField(8)
zeta = K.gen()
R = PolynomialRing(K, 'x')
x = R.gen()

cases = 0
for lengths in ((1,), (2,), (3,), (1, 2), (1, 1, 3)):
    count = len(lengths)
    for orientations in product((-1, 1), repeat=2 * count):
        for phase_exponents in product(range(8), repeat=count):
            alpha_d = [ZZ(orientations[2 * i]) for i in range(count)]
            alpha_0 = [ZZ(orientations[2 * i + 1]) for i in range(count)]
            phase = [R(zeta ** phase_exponents[i]) for i in range(count)]
            k = lengths
            # 交互閉路の符号比（sgn(D0) = 1）から sgn(D) を決める。
            sign_d = ZZ(-1) ** count * prod((alpha_d[i] * alpha_0[i] for i in range(count)), ZZ(1))
            # 閉路ごとの等式: 短い寄与の積 = x^k C((-1)^k α_0) C(Φ)。
            short_products = [x**k[i] * (-1)**k[i] * alpha_0[i] * phase[i] for i in range(count)]
            # 主鎖の (-1)^{|T|} を閉路ごとの (-1)^{k_C} に分けた行と、閉路ごとの等式を代入した行。
            line4 = sign_d * prod(((-1)**k[i] * alpha_d[i] * short_products[i] for i in range(count)), R.one())
            line5 = sign_d * prod(((-1)**k[i] * alpha_d[i] * (-1)**k[i] * alpha_0[i] * x**k[i] * phase[i]
                                   for i in range(count)), R.one())
            line6 = sign_d * prod(((-1)**(2 * k[i]) * alpha_d[i] * alpha_0[i] * x**k[i] * phase[i]
                                   for i in range(count)), R.one())
            line8 = ZZ(-1) ** count * prod((alpha_d[i] * alpha_0[i] for i in range(count)), ZZ(1)) * prod(
                ((-1)**(2 * k[i]) * alpha_d[i] * alpha_0[i] * x**k[i] * phase[i] for i in range(count)), R.one())
            line9 = prod((-(-1)**(2 * k[i]) * alpha_d[i]**2 * alpha_0[i]**2 * x**k[i] * phase[i]
                          for i in range(count)), R.one())
            line10 = prod((-x**k[i] * phase[i] for i in range(count)), R.one())
            assert line4 == line5 == line6 == line8 == line9 == line10
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

def eta(first, second):
    return ZZ(1) if first < second else ZZ(-1)

matching_cases = 0
long_weight_cases = 0
for n in range(1, 5):
    base = tuple((2*i, 2*i + 1) for i in range(n))
    assert all(weight(*pair) == 1 for pair in base)
    # 証明の補助: 長い対の重みは昇順へ直す符号である（w_{e,ι(e)} = η(e,ι(e))）。
    for a, b in base:
        for v, w in ((a, b), (b, a)):
            assert weight(v, w) == eta(v, w)
            long_weight_cases += 1
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
            cycle_lengths = []
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
                cycle_lengths.append(k)
                # 証明の補助: 閉路ごとの短い対の重みの積は (-1)^k α_0(C)（割り算を使わない形）。
                alpha_0 = prod((eta(c[2*r + 1], c[(2*r + 2) % (2*k)]) for r in range(k)), ZZ(1))
                assert prod((weight(c[2*r], c[2*r + 1]) for r in range(k)), K(1)) == (-1)**k * alpha_0
                phase_product = K(1)
                for r in range(k):
                    first, second = c[2*r], c[2*r + 1]
                    pair = tuple(sorted((first, second)))
                    oriented_entry = short_entry(pair) if first < second else -short_entry(pair)
                    phase_product *= oriented_entry / weight(first, second)
                rhs *= -R(phase_product) * x**k
            assert lhs == rhs, (n, pairs, short, lhs, rhs)
            # 証明の補助: |T| は閉路の長さの和である。
            assert len(short) == sum(cycle_lengths)
            matching_cases += 1

print(f'PASS: {long_weight_cases} long pair weights')
print(f'PASS: {matching_cases} tagged matching assignments')
