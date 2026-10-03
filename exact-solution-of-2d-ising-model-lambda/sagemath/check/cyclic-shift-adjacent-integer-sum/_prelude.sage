# 帰属: 添字・値は ZZ、表は有限な整数行列。
def rem(m, x):
    return ZZ(x) % ZZ(m)

def rho(m, k, j):
    return rem(m, j + k)

index_cases = [(ZZ(m), ZZ(k), ZZ(j))
               for m in range(1, 13) for k in range(-2*m, 2*m + 1)
               for j in range(m)]

def table_cases():
    for m in range(1, 9):
        tables = [matrix(ZZ, m, m, lambda i, j: (i - j) * (i + j + 1) - 3)]
        for p in range(m):
            for q in range(m):
                a = zero_matrix(ZZ, m, m)
                a[p, q] = 1
                tables.append(a)
        for k in range(-2*m, 2*m + 1):
            for a in tables:
                yield ZZ(m), ZZ(k), a
