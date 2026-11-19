# 節「二つの整数倍のずらしの値から和と積を取り出す」の三つの主張の式鎖を一行ずつ確かめる。
# 対象ラベル: claim_pigeonhole_one_more_than_cardinality, claim_two_shifted_values_determine_product,
#             claim_two_shifted_values_determine_sum_and_product
# 帰属: 鳩の巣は ZZ の非負元。和と積は二次体 Q(√2)・Q(√5)・Q(i)（代数的数の部分体）の元で、部分体 K は Q。
# 浮動小数点は使わない。
import itertools

failures = []
passes = 0
def check(cond, msg):
    global passes
    if not cond:
        failures.append(msg)
    else:
        passes += 1

# --- 鳩の巣: |P| = N の有限集合 P = {0,...,N-1} と、ℕ_{<N+1} から P への全ての写像 ---
for N in range(0, 6):
    P = list(range(N))
    dom = list(range(N + 1))
    count = 0
    for values in itertools.product(P, repeat=N + 1):
        phi = dict(zip(dom, values))
        found = any(phi[c] == phi[cp] for c in dom for cp in dom if c < cp)
        check(found, "pigeonhole N=%d phi=%s" % (N, values))
        # 証明の式鎖: 単射なら |像| = N+1、像 ⊂ P なので |像| ≤ N。ここでは |像| ≤ N < N+1 を確かめる
        image = set(values)
        check(len(dom) == N + 1, "dom card N=%d" % N)
        check(image.issubset(set(P)) and len(image) <= len(P), "image subset N=%d" % N)
        check(len(image) < len(dom), "image smaller than domain N=%d" % N)
        count += 1
    check(count == N ** (N + 1), "map count N=%d" % N)
# 対照: 定義域が N 個なら単射が存在する（個数がちょうど一つ多いことが効いている）
for N in range(1, 6):
    check(len(set(range(N))) == N, "control injective N=%d" % N)

# --- 和と積: K = Q、α, β は二次体の元 ---
def in_Q(z):
    return z.is_rational() if hasattr(z, 'is_rational') else z in QQ

fields = [QuadraticField(2, 'r2'), QuadraticField(5, 'r5'), QuadraticField(-1, 'ii')]
samples = []
for F in fields:
    g = F.gen()
    # α, β を t^2 - s t + p の二根（s, p ∈ Q）に取ると、全ての c で α+β+cαβ ∈ Q
    for s in [QQ(0), QQ(1), QQ(-3), QQ(5)/2]:
        for p in [QQ(1), QQ(-2), QQ(7)/3]:
            R.<t> = F[]
            f = t^2 - s*t + p
            rts = f.roots()
            if len(rts) == 2:
                samples.append((F, rts[0][0], rts[1][0]))
    # 一般の元（α+β, αβ が Q に入らない）
    samples.append((F, g, F(1)))
    samples.append((F, 1 + g, 2 - 3*g))

for (F, a, b) in samples:
    for c in range(-3, 4):
        for cp in range(-3, 4):
            if c == cp:
                continue
            u = a + b + c*a*b
            up = a + b + cp*a*b
            if not (in_Q(u) and in_Q(up)):
                continue
            # 積の主張の式鎖
            check(c - cp != 0, "c-c' nonzero")
            check(in_Q(F(c - cp)), "c-c' in K")
            line1 = ((c - cp)*a*b) / (c - cp)
            check(a*b == line1, "product line1")
            line2 = ((a + b + c*a*b) - (a + b + cp*a*b)) / (c - cp)
            check(line1 == line2, "product line2")
            line3 = (u - up) / (c - cp)
            check(line2 == line3, "product line3")
            check(in_Q(line3), "product membership")
            # 和の主張の式鎖
            check(in_Q(F(c)), "c in K")
            s1 = (a + b + c*a*b) - c*a*b
            check(a + b == s1, "sum line1")
            s2 = u - c*a*b
            check(s1 == s2, "sum line2")
            check(in_Q(s2), "sum membership")

# 対照: 一つの値だけでは積は K に入らない。α = √2, β = -2 + √2, c = 1 で α+β+αβ = 0 ∈ Q だが αβ ∉ Q
F = fields[0]; r2 = F.gen()
a = r2; b = -2 + r2
check(a + b + 1*a*b == 0, "control one value in Q")
check(not in_Q(a*b), "control product not in Q")
# 同じ α, β で別の c' では値が Q に入らない（主張の前提が二つ要る）
check(all(not in_Q(a + b + cp*a*b) for cp in range(-5, 6) if cp != 1), "control other c' not in Q")

print("PASS %d" % passes if not failures else "FAIL %d: %s" % (len(failures), failures[:5]))
