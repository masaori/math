"""Cl_{2n}(C) = M_{2^n}(C) を Jordan-Wigner 生成元で確認する（純 Python、係数は Gauss 整数）。

  e_{2k-1} = sz^{(k-1)} (x) sx (x) 1^{(n-k)}
  e_{2k}   = sz^{(k-1)} (x) sy (x) 1^{(n-k)}

確認すること:
  (1) e_i e_j + e_j e_i = 2 delta_ij  (Clifford 関係式)
  (2) {e_S = prod_{i in S} e_i} が M_{2^n}(C) の基底になる（4^n 個・一次独立）
"""

def mul(A, B):
    n = len(A)
    return tuple(tuple(sum(A[i][k] * B[k][j] for k in range(n)) for j in range(n))
                 for i in range(n))

def add(A, B):
    return tuple(tuple(a + b for a, b in zip(ra, rb)) for ra, rb in zip(A, B))

def kron(A, B):
    na, nb = len(A), len(B)
    return tuple(tuple(A[i // nb][j // nb] * B[i % nb][j % nb]
                       for j in range(na * nb)) for i in range(na * nb))

I2 = ((1, 0), (0, 1))
SX = ((0, 1), (1, 0))
SY = ((0, -1j), (1j, 0))
SZ = ((1, 0), (0, -1))

def eye(n):
    return tuple(tuple(1 if i == j else 0 for j in range(n)) for i in range(n))

def generators(n):
    """Cl_{2n} の 2n 個の生成元を M_{2^n} の元として返す。"""
    gens = []
    for k in range(1, n + 1):
        for P in (SX, SY):
            M = ((1,),)
            for j in range(1, n + 1):
                M = kron(M, SZ if j < k else (P if j == k else I2))
            gens.append(M)
    return gens

def rank(rows):
    """複素ベクトルの一次独立な本数（Gauss 消去）。"""
    rows = [list(r) for r in rows]
    m, piv = len(rows), 0
    for col in range(len(rows[0])):
        p = next((r for r in range(piv, m) if abs(rows[r][col]) > 1e-9), None)
        if p is None:
            continue
        rows[piv], rows[p] = rows[p], rows[piv]
        inv = 1 / rows[piv][col]
        rows[piv] = [v * inv for v in rows[piv]]
        for r in range(m):
            if r != piv and abs(rows[r][col]) > 1e-9:
                f = rows[r][col]
                rows[r] = [a - f * b for a, b in zip(rows[r], rows[piv])]
        piv += 1
    return piv

for n in (1, 2, 3):
    d, g = 2 ** n, generators(n)
    ok = True
    for i in range(2 * n):
        for j in range(2 * n):
            want = 2 if i == j else 0
            got = add(mul(g[i], g[j]), mul(g[j], g[i]))
            for a in range(d):
                for b in range(d):
                    if abs(got[a][b] - (want if a == b else 0)) > 1e-9:
                        ok = False
    prods = []
    for S in range(2 ** (2 * n)):            # 生成元の部分集合すべて
        M = eye(d)
        for i in range(2 * n):
            if S >> i & 1:
                M = mul(M, g[i])
        prods.append([M[a][b] for a in range(d) for b in range(d)])
    print(f"n={n}: Cl_{{{2*n}}} -> M_{2**n}(C)  Clifford関係式={ok}  "
          f"積の個数={len(prods)}  一次独立な本数={rank(prods)}  dim M_{2**n}={d*d}")
