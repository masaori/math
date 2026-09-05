# 有限表、ZZ、QQ だけで定義を実装する。主張の判定は各 check_*.sage に置く。
from itertools import product
from functools import cache

PRIMES = tuple(ZZ(p) for p in (2, 3, 5))
PROBE_PRIMES = tuple(ZZ(p) for p in (2, 3, 5, 7, 11, 13))

def clean(a):
    return {ZZ(p): ZZ(z) for p, z in a.items() if z != 0}

def coefficient(a, p):
    return a.get(p, ZZ(0))

def add(a, b):
    return clean({p: coefficient(a, p) + coefficient(b, p) for p in set(a) | set(b)})

def neg(a):
    return clean({p: -z for p, z in a.items()})

def sub(a, b):
    return add(a, neg(b))

def scale(d, a):
    return clean({p: ZZ(d) * z for p, z in a.items()})

@cache
def exponent(m, p):
    m = ZZ(m)
    if m <= 0:
        raise ValueError('positive integer required')
    return ZZ(dict(m.factor()).get(p, 0))

@cache
def valuation(q, p):
    q = QQ(q)
    if q <= 0:
        raise ValueError('positive rational required')
    return exponent(q.numerator(), p) - exponent(q.denominator(), p)

@cache
def logarithm(q):
    q = QQ(q)
    if q <= 0:
        raise ValueError('positive rational required')
    primes = set(dict(q.numerator().factor())) | set(dict(q.denominator().factor()))
    return clean({p: valuation(q, p) for p in primes})

def numerator_product(a):
    return prod((p ** max(z, 0) for p, z in a.items()), ZZ(1))

def denominator_product(a):
    return prod((p ** max(-z, 0) for p, z in a.items()), ZZ(1))

def reconstruct(a):
    return QQ(numerator_product(a)) / QQ(denominator_product(a))

def less_equal(a, b):
    return numerator_product(a) * denominator_product(b) <= numerator_product(b) * denominator_product(a)

def divide(d, a):
    d = ZZ(d)
    if d == 0 or any(z % d != 0 for z in a.values()):
        raise ValueError('integer division outside domain')
    return clean({p: z // d for p, z in a.items()})

@cache
def vectors(radius=1):
    return tuple(clean(dict(zip(PRIMES, z))) for z in product(range(-radius, radius + 1), repeat=3))

@cache
def rationals():
    return tuple(sorted({QQ(r)/QQ(s) for r in range(1, 13) for s in range(1, 13)}))

def vector_rows():
    for a in vectors():
        for p in PROBE_PRIMES:
            yield a, p

def vector_pairs():
    yield from product(vectors(), repeat=2)

def vector_triples():
    yield from product(vectors(), repeat=3)

def rational_rows():
    for q in rationals():
        r, s = q.numerator(), q.denominator()
        K = set(dict(r.factor())) | set(dict(s.factor()))
        yield q, r, s, K

def rational_pair_rows():
    for q, t in product(rationals(), repeat=2):
        r, s = q.numerator(), q.denominator()
        u, v = t.numerator(), t.denominator()
        g = gcd(r*u, s*v)
        for p in PROBE_PRIMES:
            yield q, t, r, s, u, v, g, p

def rational_probe_rows():
    for t in rationals():
        u, v = t.numerator(), t.denominator()
        for p in PROBE_PRIMES:
            yield t, u, v, p

# 各セルの近傍を舞台全体とする。配位順の index を通じて大域表を局所真理値表へ移す。
def ca_maps():
    for size in range(3):
        configs = tuple(product((0, 1), repeat=size))
        index = {x: i for i, x in enumerate(configs)}
        for mapping in product(range(len(configs)), repeat=len(configs)):
            local = tuple(tuple(configs[mapping[i]][z] for i in range(len(configs))) for z in range(size))
            yield size, configs, index, mapping, local

def global_value(local, index, x):
    return tuple(table[index[x]] for table in local)

@cache
def image_at(mapping, x, n):
    value = x
    for _ in range(n):
        value = mapping[value]
    return value

def fixed_set(mapping, n):
    if n < 1:
        raise ValueError('positive exponent required')
    return {x for x in range(len(mapping)) if image_at(mapping, x, n) == x}

@cache
def count_fixed(mapping, n):
    if n < 1:
        raise ValueError('positive exponent required')
    return ZZ(sum(image_at(mapping, x, n) == x for x in range(len(mapping))))

def conserved(mapping, H):
    return all(H[mapping[x]] == H[x] for x in range(len(mapping)))

def fiber(mapping, H, n, u):
    return {x for x in fixed_set(mapping, n) if H[x] == u}

def omega(mapping, H, n, u):
    return ZZ(len(fiber(mapping, H, n, u)))

def levels(mapping, H, n):
    return {H[x] for x in fixed_set(mapping, n)}

def entropy(mapping, H, n, u):
    value = omega(mapping, H, n, u)
    if value <= 0:
        raise ValueError('zero fiber outside entropy domain')
    return logarithm(QQ(value)/QQ(1))

def beta(mapping, H, n, u):
    return sub(entropy(mapping, H, n, u+1), entropy(mapping, H, n, u))

@cache
def rational_count(mapping, n):
    value = count_fixed(mapping, n)
    if value <= 0:
        raise ValueError('zero total outside free count domain')
    return QQ(value)/QQ(1)

def free_count(mapping, n):
    return logarithm(rational_count(mapping, n))

def ca_count_rows():
    for size, configs, index, mapping, local in ca_maps():
        for n in range(1, 2*len(mapping)+1):
            yield size, mapping, n

def fiber_rows():
    for size, configs, index, mapping, local in ca_maps():
        for raw_H in product((-1, 0, 1, 2), repeat=len(mapping)):
            H = tuple(ZZ(z) for z in raw_H)
            if not conserved(mapping, H):
                continue
            for n in range(1, 2*len(mapping)+1):
                fixed = fixed_set(mapping, n)
                D = levels(mapping, H, n)
                yield size, mapping, H, n, fixed, D

def adjacent_rows():
    for size, mapping, H, n, fixed, D in fiber_rows():
        for u in D:
            if u+1 in D:
                lo, hi = omega(mapping, H, n, u), omega(mapping, H, n, u+1)
                yield mapping, H, n, u, lo, hi

# 反例の自己近傍規則は、全近傍表の列挙と独立に構成する。
GAP_CONFIGS = tuple(product((0, 1), repeat=2))
GAP_INDEX = {x: i for i, x in enumerate(GAP_CONFIGS)}
GAP_H = (ZZ(0), ZZ(2), ZZ(2), ZZ(4))

def gap_restrict(x, z):
    return {z: x[z]}

def gap_local(y, z):
    return y[z]

def gap_global(x):
    return tuple(gap_local(gap_restrict(x, z), z) for z in range(2))

GAP_MAP = tuple(GAP_INDEX[gap_global(x)] for x in GAP_CONFIGS)

def gap_rows():
    for n in range(1, 17):
        yield GAP_MAP, GAP_H, n

def gap_induction_rows():
    for n in range(17):
        for x in range(4):
            yield GAP_MAP, n, x
