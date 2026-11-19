# 節「一次因子の積の係数と根の基本対称式」の三つのブロックの式鎖を一行ずつ確かめる。
# 対象ラベル: def_qbar_multivariate_point_value, claim_point_value_elementary_symmetric_last_split,
#             claim_linear_factor_product_coefficient_elementary_symmetric
# 帰属: 値は円分体 Q(ζ_12)（代数的数の部分体）の元。浮動小数点は使わない。
import itertools

failures = []
passes = 0
def check(cond, msg):
    global passes
    if not cond:
        failures.append(msg)
    else:
        passes += 1

K.<z> = CyclotomicField(12)
pool = [K(0), K(1), K(-2), K(1)/3, z, z^2 - 1, 2*z^3 + z, -z^5 + K(1)/2]

def subsets(m, i):
    return [frozenset(S) for S in itertools.combinations(range(m), i)]

def es_value_by_subsets(beta, m, i):
    # 準備の式の右辺: Σ_{S ⊆ ℕ_{<m}, |S| = i} ∏_{k ∈ S} β(k)
    return sum((prod(beta[k] for k in S) for S in subsets(m, i)), K(0))

def es_poly(m, i):
    # 定義どおりの多変数多項式 es_{m,i} ∈ K[X_{<m}]
    if m == 0:
        R = PolynomialRing(K, 'X', 1)  # 変数 0 個の代わりに定数だけを使う
        return R(1) if i == 0 else R(0), R
    R = PolynomialRing(K, ['X%d' % k for k in range(m)])
    X = R.gens()
    return sum((prod(X[k] for k in S) for S in subsets(m, i)), R(0)), R

def mev(P, R, beta, m):
    # 点での値: Σ_a mco_a(P) ∏_k β(k)^{a(k)}
    if m == 0:
        return K(P.constant_coefficient())
    total = K(0)
    for a, c in P.dict().items():
        a = (a,) if m == 1 and not isinstance(a, tuple) else tuple(a)
        total += c * prod(beta[k] ** a[k] for k in range(m))
    return total

# --- 点での値: 和と積を保つこと、定数と変数の値（標本） ---
for m in range(1, 4):
    R = PolynomialRing(K, ['X%d' % k for k in range(m)])
    X = R.gens()
    for beta in itertools.islice(itertools.product(pool[:4], repeat=m), 30):
        P = X[0]^2 + z*X[m-1] - 3
        Q = X[0]*X[m-1] + K(1)/2
        check(mev(P + Q, R, beta, m) == mev(P, R, beta, m) + mev(Q, R, beta, m), "mev sum")
        check(mev(P * Q, R, beta, m) == mev(P, R, beta, m) * mev(Q, R, beta, m), "mev product")
        check(mev(R(z), R, beta, m) == z, "mev const")
        for k in range(m):
            check(mev(X[k], R, beta, m) == beta[k], "mev variable")

# --- 準備の式と末尾の分割 ---
for n in range(0, 5):
    for alpha in itertools.islice(itertools.product(pool, repeat=n + 1), 60):
        alpha = list(alpha)
        alpha_lt = alpha[:n]
        for j in range(0, n + 2):
            # 準備の式（m = n+1, i = j+1 と m = n）
            P, R = es_poly(n + 1, j + 1)
            lhs = mev(P, R, alpha, n + 1)
            l1 = es_value_by_subsets(alpha, n + 1, j + 1)
            check(lhs == l1, "prep n=%d j=%d" % (n, j))
            # 添字の集合を A（n を含まない）と B（含む）に分ける
            A = [S for S in subsets(n + 1, j + 1) if n not in S]
            B = [S for S in subsets(n + 1, j + 1) if n in S]
            check(len(A) + len(B) == len(subsets(n + 1, j + 1)), "partition count")
            l2 = sum((prod(alpha[k] for k in S) for S in A), K(0)) + sum((prod(alpha[k] for k in S) for S in B), K(0))
            check(l1 == l2, "split n=%d j=%d" % (n, j))
            # A の表示と ι の全単射
            check(set(A) == set(subsets(n, j + 1)), "A = subsets of N_<n")
            iota_img = [S | frozenset([n]) for S in subsets(n, j)]
            check(sorted(map(sorted, iota_img)) == sorted(map(sorted, B)) and len(set(iota_img)) == len(iota_img), "iota bijection")
            l3 = sum((prod(alpha[k] for k in T) for T in subsets(n, j + 1)), K(0)) + sum((prod(alpha[k] for k in (T | frozenset([n]))) for T in subsets(n, j)), K(0))
            check(l2 == l3, "reindex n=%d j=%d" % (n, j))
            l4 = sum((prod(alpha_lt[k] for k in T) for T in subsets(n, j + 1)), K(0)) + sum((alpha[n] * prod(alpha_lt[k] for k in T) for T in subsets(n, j)), K(0))
            check(l3 == l4, "extract factor n=%d j=%d" % (n, j))
            l5 = sum((prod(alpha_lt[k] for k in T) for T in subsets(n, j + 1)), K(0)) + alpha[n] * sum((prod(alpha_lt[k] for k in T) for T in subsets(n, j)), K(0))
            check(l4 == l5, "distribute n=%d j=%d" % (n, j))
            P1, R1 = es_poly(n, j + 1)
            P0, R0 = es_poly(n, j)
            l6 = mev(P1, R1, alpha_lt, n) + alpha[n] * mev(P0, R0, alpha_lt, n)
            check(l5 == l6, "prep back n=%d j=%d" % (n, j))
            check(lhs == l6, "last split n=%d j=%d" % (n, j))

# --- 一次因子の積の係数 ---
T.<t> = K[]
def ac(f, k):
    return f[k] if k >= 0 else None

def ev(n, j, w):
    P, R = es_poly(n, j)
    return mev(P, R, w[:n], n)

for w in itertools.islice(itertools.product(pool, repeat=6), 200):
    w = list(w)
    # 準備: 番号が一以上の係数の式と番号零の係数の式
    for C in [T(1), t^2 - z*t + 3, (K(1)/2)*t^3 + z^4]:
        v = w[0]
        for k in range(0, 5):
            check(ac(C * (t - v), k + 1) == ac(C, k) - v * ac(C, k + 1), "coeff succ")
        check(ac(C * (t - v), 0) == -v * ac(C, 0), "coeff zero")
    Pi = [prod((t - w[i] for i in range(n)), T(1)) for n in range(0, 6)]
    for n in range(0, 6):
        for j in range(0, n + 1):
            check(ac(Pi[n], n - j) == (-1)^j * ev(n, j, w), "vieta n=%d j=%d" % (n, j))
    # 帰納法の一歩の各行
    for n in range(0, 5):
        check(Pi[n + 1] == Pi[n] * (t - w[n]), "last factor")
        # j = 0
        check(ac(Pi[n], n + 1) == 0, "coeff bound")
        chain = [ac(Pi[n + 1], n + 1), ac(Pi[n], n) - w[n] * ac(Pi[n], n + 1), ac(Pi[n], n) - w[n] * 0, ac(Pi[n], n),
                 ev(n, 0, w), K(1), ev(n + 1, 0, w)]
        check(all(x == chain[0] for x in chain), "j=0 chain n=%d" % n)
        # 1 ≤ j ≤ n
        for i in range(0, n):
            c0 = ac(Pi[n + 1], (n + 1) - (i + 1))
            c1 = ac(Pi[n], n - (i + 1)) - w[n] * ac(Pi[n], n - i)
            c2 = (-1)^(i + 1) * ev(n, i + 1, w) - w[n] * (-1)^i * ev(n, i, w)
            c3 = (-1)^(i + 1) * (ev(n, i + 1, w) + w[n] * ev(n, i, w))
            c4 = (-1)^(i + 1) * ev(n + 1, i + 1, w)
            check(c0 == c1 == c2 == c3 == c4, "middle chain n=%d i=%d" % (n, i))
        # j = n+1
        d0 = ac(Pi[n + 1], 0)
        d1 = -w[n] * ac(Pi[n], 0)
        d2 = -w[n] * (-1)^n * ev(n, n, w)
        d3 = (-1)^(n + 1) * (0 + w[n] * ev(n, n, w))
        d4 = (-1)^(n + 1) * (ev(n, n + 1, w) + w[n] * ev(n, n, w))
        d5 = (-1)^(n + 1) * ev(n + 1, n + 1, w)
        check(ev(n, n + 1, w) == 0, "es_{n,n+1} = 0")
        check(d0 == d1 == d2 == d3 == d4 == d5, "top chain n=%d" % n)

# 対照: 符号 (-1)^j を落とすと一般には一致しない
w = [K(1), K(2), K(3)]
Pi3 = (t - 1) * (t - 2) * (t - 3)
check(ac(Pi3, 2) != ev(3, 1, w + [K(0)] * 3), "control without sign")

if failures:
    print("FAIL", len(failures))
    for f in failures[:20]:
        print(f)
else:
    print("PASS", passes)
