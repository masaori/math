# 単変数化で潰れる二点データ:
# 「同じ分配多項式は異なる二点データを区別しない」の証明の各段を確認する。
# 対象ラベル: claim_same_partition_different_pair_data
# すべて ZZ / ZZ[X] と有限集合の厳密計算。浮動小数点・実対数・無限和は使わない。

import itertools

failures = []


def record(name, ok):
    print(("PASS" if ok else "FAIL") + ": " + name)
    if not ok:
        failures.append(name)


R = PolynomialRing(ZZ, "X")
X = R.gen()

# 自由境界の箱 L=2: 頂点は {0,1}^3、内部辺は各座標方向の後続が箱内にある組
L = 2
V = [(x, y, z) for x in range(L) for y in range(L) for z in range(L)]
E = []
for p in V:
    for d in range(3):
        q = list(p)
        q[d] += 1
        q = tuple(q)
        if q in V:
            E.append((p, q))

record("頂点数 #V_2 = 8", len(V) == 8)
record("内部辺数 #E_2 = 12", len(E) == 12)

a = (0, 0, 0)
b = (1, 0, 0)  # 隣接点対 (a,b)
c = (1, 1, 1)  # 対角点対 (a,c)

# 全 2^8 配位の有限列挙。破れ数ごとに、分配多項式の係数と、
# 標識点対ごとの一致・不一致の配位数を数える
n_edges = len(E)
Z_coeffs = [ZZ(0) for _ in range(n_edges + 1)]
eq_count = {"ab": [ZZ(0)] * (n_edges + 1), "ac": [ZZ(0)] * (n_edges + 1)}
ne_count = {"ab": [ZZ(0)] * (n_edges + 1), "ac": [ZZ(0)] * (n_edges + 1)}

for vals in itertools.product([ZZ(1), ZZ(-1)], repeat=len(V)):
    sigma = dict(zip(V, vals))
    m = sum(ZZ(1) for (p, q) in E if sigma[p] != sigma[q])
    Z_coeffs[m] += 1
    for name, (u, v) in [("ab", (a, b)), ("ac", (a, c))]:
        if sigma[u] == sigma[v]:
            eq_count[name][m] += 1
        else:
            ne_count[name][m] += 1

# 段 1: 標識は頂点・辺・配位・破れ数を変えないので、分配多項式は標識に依らず同じ Z_2(X)。
# 数え上げが標識点対に一切依存していないこと（eq+ne が両標識で同じ多重度になること）で確認する
Z2 = sum(Z_coeffs[m] * X**m for m in range(n_edges + 1))
ok = all(
    eq_count[name][m] + ne_count[name][m] == Z_coeffs[m]
    for name in ("ab", "ac")
    for m in range(n_edges + 1)
)
record("段1: 一致数+不一致数が標識に依らず多重度に一致（分配多項式は共通）", ok)
record("段1: Z_2(1) = 2^8（全配位数の校正）", Z2(ZZ(1)) == ZZ(2) ** 8)

# 段 2: 破れ数 4 の配位の分割。本文の表の四つの整数
record("段2: (a,b) の m=4 一致配位数 = 20", eq_count["ab"][4] == 20)
record("段2: (a,b) の m=4 不一致配位数 = 10", ne_count["ab"][4] == 10)
record("段2: (a,c) の m=4 一致配位数 = 12", eq_count["ac"][4] == 12)
record("段2: (a,c) の m=4 不一致配位数 = 18", ne_count["ac"][4] == 18)

# 段 3: 符号付き多項式 P_{2;u,v}(X) ∈ ZZ[X] の四次係数と、二つの多項式の不一致
P = {
    name: sum((eq_count[name][m] - ne_count[name][m]) * X**m for m in range(n_edges + 1))
    for name in ("ab", "ac")
}
record("段3: P_{2;a,b} の四次係数 = 20-10 = 10", P["ab"][4] == ZZ(10))
record("段3: P_{2;a,c} の四次係数 = 12-18 = -6", P["ac"][4] == ZZ(-6))
record("段3: P_{2;a,b}(X) ≠ P_{2;a,c}(X)", P["ab"] != P["ac"])
record("定義の確認: P は次数 #E_2 以下の ZZ[X] の元", all(P[n].degree() <= n_edges and P[n] in R for n in ("ab", "ac")))

print()
if failures:
    print("RESULT: FAIL (%d)" % len(failures))
    sys.exit(1)
print("RESULT: ALL PASS")
