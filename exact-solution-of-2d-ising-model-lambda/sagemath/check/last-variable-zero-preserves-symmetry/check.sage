# 節「対称式の基本定理」の四つのブロックを一行ずつ確かめる。
# 対象ラベル: def_last_fixed_permutation_extension, claim_last_fixed_permutation_extension_is_bijection,
#             claim_last_variable_zero_commutes_with_variable_permutation, claim_last_variable_zero_preserves_symmetry
# 帰属: 添字は自然数の有限集合、係数環は QQbar（代数的数）。浮動小数点は使わない。

import itertools

failures = []
passes = 0
def check(cond, msg):
    global passes
    if not cond:
        failures.append(msg)
    else:
        passes += 1

s2 = QQbar(2).sqrt()

def ring(m):
    if m == 0:
        return PolynomialRing(QQbar, 'Z', 0)
    return PolynomialRing(QQbar, ['X%d' % k for k in range(m)])

def perms(n):
    # 𝔓_n を ℕ_{<n} 上の値の組で列挙する。
    return [tuple(p) for p in itertools.permutations(range(n))]

def pe(f, n):
    # def_last_fixed_permutation_extension: k < n なら f(k)、n なら n。
    return tuple(f[k] for k in range(n)) + (n,)

def inverse(f):
    g = [None] * len(f)
    for k, v in enumerate(f):
        g[v] = k
    return tuple(g)

def ms(y, R_from, R_to):
    # def_qbar_multivariate_substitution: X_k ↦ y(k)。
    return R_from.hom([R_to(v) for v in y], R_to)

def z_values(n, R0):
    return list(R0.gens()) + [R0(0)]

def xv(f, R):
    X = R.gens()
    return [X[f[k]] for k in range(len(f))]

def vs(f, R):
    return ms(xv(f, R), R, R)

# 定義: pe_n(f) は ℕ_{<n+1} の各元にただ一つの値を与え、値は ℕ_{<n+1} にある。
for n in range(0, 4):
    for f in itertools.product(range(n), repeat=n):
        e = pe(f, n)
        check(len(e) == n + 1 and all(0 <= v <= n for v in e), "pe well-defined n=%d" % n)
        check(all(e[k] == f[k] for k in range(n)) and e[n] == n, "pe values n=%d" % n)

# 主張「置換の末尾を固定する延長は置換である」: 準備（g∘f = id なら pe(g)∘pe(f) = id）を
# 全ての写像の組で、結論を全ての置換で確かめる。
for n in range(0, 4):
    maps = list(itertools.product(range(n), repeat=n))
    for f in maps:
        for g in maps:
            if all(g[f[k]] == k for k in range(n)):
                ef, eg = pe(f, n), pe(g, n)
                for j in range(n):
                    vals = [eg[ef[j]], eg[f[j]], g[f[j]], j]
                    check(all(vals[i] == vals[i + 1] for i in range(len(vals) - 1)), "bij chain j<n n=%d" % n)
                vals = [eg[ef[n]], eg[n], n]
                check(all(vals[i] == vals[i + 1] for i in range(len(vals) - 1)), "bij chain j=n n=%d" % n)
for n in range(0, 5):
    for r in perms(n):
        e, ei = pe(r, n), pe(inverse(r), n)
        check(sorted(e) == list(range(n + 1)), "pe bijection n=%d" % n)
        check(all(ei[e[j]] == j and e[ei[j]] == j for j in range(n + 1)), "pe inverse n=%d" % n)

def samples(R):
    X = R.gens()
    m = len(X)
    out = [R(0), R(3), (1 + s2) * X[-1]]
    if m >= 2:
        out.append(X[0]**2 * X[-1] - s2 * X[0] + QQbar(2)/7)
        out.append(X[1]**3 * X[0] + 5 * X[-1] * X[0]**2 - 1)
    if m >= 3:
        out.append(X[2]**2 * X[0] - (2 - s2) * X[1] * X[2] + X[0] * X[1]**4)
    if m >= 4:
        out.append(X[3] * X[0] * X[1] - X[2]**3 + s2 * X[3]**2)
    return out

# 主張「末尾の変数への零代入は末尾を固定する変数の置換と入れ替わる」。
for n in range(0, 4):
    R1 = ring(n + 1)
    R0 = ring(n)
    z = z_values(n, R0)
    lz = ms(z, R1, R0)
    X0 = R0.gens()
    X1 = R1.gens()
    for r in perms(n):
        e = pe(r, n)
        v0 = vs(r, R0)
        v1 = vs(e, R1)
        ms_xv = ms(xv(r, R0), R0, R0)
        ms_z = ms(z, R1, R0)
        # 準備の j < n の式鎖。
        for j in range(n):
            vals = [ms_xv(z[j]), ms_xv(X0[j]), xv(r, R0)[j], X0[r[j]], z[r[j]],
                    ms_z(X1[r[j]]), ms_z(X1[e[j]]), ms_z(xv(e, R1)[j])]
            check(all(vals[i] == vals[i + 1] for i in range(len(vals) - 1)), "values j<n n=%d" % n)
        # 準備の j = n の式鎖。
        vals = [ms_xv(z[n]), ms_xv(R0(0)), R0(0), z[n], ms_z(X1[n]), ms_z(X1[e[n]]), ms_z(xv(e, R1)[n])]
        check(all(vals[i] == vals[i + 1] for i in range(len(vals) - 1)), "values j=n n=%d" % n)
        # 本体の式鎖。合成した値の写像 ms_{xv}∘z_n と ms_{z_n}∘xv' による代入も直接作る。
        comp_left = ms([ms_xv(z[j]) for j in range(n + 1)], R1, R0)
        comp_right = ms([ms_z(xv(e, R1)[j]) for j in range(n + 1)], R1, R0)
        for P in samples(R1):
            vals = [v0(lz(P)), ms_xv(lz(P)), ms_xv(ms_z(P)), comp_left(P), comp_right(P),
                    ms_z(ms(xv(e, R1), R1, R1)(P)), ms_z(v1(P)), lz(v1(P))]
            check(all(vals[i] == vals[i + 1] for i in range(len(vals) - 1)), "commute chain n=%d" % n)

# 主張「対称な多項式の末尾の変数に零を代入しても対称である」。
def symmetrize(P, R, m):
    return sum(vs(r, R)(P) for r in perms(m))

for n in range(0, 4):
    R1 = ring(n + 1)
    R0 = ring(n)
    lz = ms(z_values(n, R0), R1, R0)
    for Q in samples(R1):
        P = symmetrize(Q, R1, n + 1)
        check(all(vs(t, R1)(P) == P for t in perms(n + 1)), "sample symmetric n=%d" % n)
        L = lz(P)
        for r in perms(n):
            e = pe(r, n)
            vals = [vs(r, R0)(L), lz(vs(e, R1)(P)), L]
            check(all(vals[i] == vals[i + 1] for i in range(len(vals) - 1)), "symmetry chain n=%d" % n)

# 対照: 対称でない P では lz_n(P) が対称とは限らない。P = X_0^2 + X_1（n = 2）では lz_2(P) = X_0^2 + X_1 は 0 と 1 の入れ替えで変わる。
R1 = ring(3); R0 = ring(2)
X = R1.gens()
P = X[0]**2 + X[1]
L = ms(z_values(2, R0), R1, R0)(P)
check(vs((1, 0), R0)(L) != L, "non-symmetric control")
# 対照: 末尾を固定しない置換 (0 2) では入れ替わりが崩れる。
lz = ms(z_values(2, R0), R1, R0)
check(vs((0, 1), R0)(lz(X[2])) != lz(vs((2, 1, 0), R1)(X[2])), "non-fixing permutation control")

if failures:
    print("FAIL", len(failures))
    for f in failures[:20]:
        print(" ", f)
else:
    print("PASS", passes)
