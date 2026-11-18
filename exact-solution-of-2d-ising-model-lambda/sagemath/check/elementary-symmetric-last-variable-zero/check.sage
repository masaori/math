# 「末尾の変数に零を代入すると基本対称式は一つ少ない変数の基本対称式になる」の式変形を一行ずつ確かめる。
# 対象ラベル: claim_last_variable_zero_elementary_symmetric
# 帰属: 係数環は QQbar（代数的数）。多項式環 QQbar[X_0, ..., X_n] の等号は係数の比較で厳密に判定する。
# 浮動小数点は使わない。n = 0, ..., 5、j = 0, ..., n + 2（j > n + 1 の空和を含む）を総当たりする。

from itertools import combinations

failures = []
passes = 0
def check(cond, msg):
    global passes
    if not cond:
        failures.append(msg)
    else:
        passes += 1

def ring(n):
    # Qbar[X_{<n}]。変数の無い n = 0 の環は、係数の族が指数（空写像）一つだけで決まるので QQbar で表す。
    if n == 0:
        return QQbar, []
    R = PolynomialRing(QQbar, ['X%d' % k for k in range(n)])
    return R, list(R.gens())

def es(n, j):
    # 定義: es_{n,j} = Σ_{S ⊆ ℕ_{<n}, |S| = j} ∏_{k ∈ S} X^{(n)}_k
    R, X = ring(n)
    return sum((prod((X[k] for k in S), R(1)) for S in combinations(range(n), j)), R(0))

def lz(n, P):
    # 定義: lz_n は X^{(n+1)}_k (k < n) に X^{(n)}_k を、X^{(n+1)}_n に 0 を代入する写像。
    R1, X1 = ring(n + 1)
    R0, X0 = ring(n)
    vals = list(X0) + [R0(0)]
    return R0(P(*vals))

for n in range(0, 6):
    R1, X1 = ring(n + 1)
    R0, X0 = ring(n)
    for j in range(0, n + 3):
        subsets = list(combinations(range(n + 1), j))
        B1 = [S for S in subsets if n in S]
        B0 = [S for S in subsets if n not in S]
        # 第一の等号: lz_n(es_{n+1,j}) = lz_n(Σ_{S} ∏ X^{(n+1)}_k)
        lhs = lz(n, es(n + 1, j))
        line1 = lz(n, sum((prod((X1[k] for k in S), R1(1)) for S in subsets), R1(0)))
        check(lhs == line1, "n=%d j=%d 第一の等号" % (n, j))
        # 第二の等号: B_1 と B_0 への分割
        line2 = lz(n, sum((prod((X1[k] for k in S), R1(1)) for S in B1), R1(0))
                   + sum((prod((X1[k] for k in S), R1(1)) for S in B0), R1(0)))
        check(line1 == line2, "n=%d j=%d 第二の等号" % (n, j))
        # 第三の等号: lz_n は和と積を保つ
        line3 = sum((prod((lz(n, X1[k]) for k in S), R0(1)) for S in B1), R0(0)) \
              + sum((prod((lz(n, X1[k]) for k in S), R0(1)) for S in B0), R0(0))
        check(line2 == line3, "n=%d j=%d 第三の等号" % (n, j))
        # 第四の等号: lz_n(X^{(n+1)}_k) = X^{(n)}_k (k < n)、lz_n(X^{(n+1)}_n) = 0
        for k in range(n):
            check(lz(n, X1[k]) == X0[k], "n=%d k=%d lz の値" % (n, k))
        check(lz(n, X1[n]) == R0(0), "n=%d lz(X_n) = 0" % n)
        line4 = sum((R0(0) * prod((X0[k] for k in S if k != n), R0(1)) for S in B1), R0(0)) \
              + sum((prod((X0[k] for k in S), R0(1)) for S in B0), R0(0))
        check(line3 == line4, "n=%d j=%d 第四の等号" % (n, j))
        # 第五の等号: B_1 の項は零、B_0 は ℕ_{<n} の j 元部分集合の全体
        check(sorted(B0) == sorted(combinations(range(n), j)), "n=%d j=%d B_0 の一致" % (n, j))
        line5 = es(n, j)
        check(line4 == line5, "n=%d j=%d 第五の等号" % (n, j))
        check(lhs == es(n, j), "n=%d j=%d 主張" % (n, j))
        if j == n + 1:
            check(es(n, j) == R0(0), "n=%d es_{n,n+1} = 0" % n)

if failures:
    print("FAIL", len(failures))
    for f in failures[:20]:
        print("  ", f)
else:
    print("PASS", passes)
