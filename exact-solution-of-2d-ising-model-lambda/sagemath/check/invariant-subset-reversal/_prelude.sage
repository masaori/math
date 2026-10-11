from itertools import permutations

# 範囲は空集合から六元集合まで。部分集合は像の集合等号で列挙する。
if "isr_cases" not in globals():
    isr_cases = []
    for n in range(7):
        for sigma in permutations(range(n)):
            inv = tuple(sigma.index(i) for i in range(n))
            for mask in range(1 << n):
                C = frozenset(i for i in range(n) if (mask >> i) & 1)
                if frozenset(sigma[i] for i in C) != C:
                    continue
                f = tuple(inv[i] if i in C else sigma[i] for i in range(n))
                g = tuple(sigma[i] if i in C else inv[i] for i in range(n))
                r = f
                rinv = tuple(r.index(i) for i in range(n))
                rr = tuple(rinv[i] if i in C else r[i] for i in range(n))
                isr_cases.append((sigma,C,inv,f,g,r,rinv,rr))
    assert len(isr_cases) == 5913

def isr_report(name, count, expected):
    assert count == expected, (name, count, expected)
    print("PASS " + name + ": " + str(count))
