# 対象ラベル: claim_factorization_type_determines_root_minimal_degrees
# 本文の証明の各段を ZZ・QQbar の厳密計算で確認する。浮動小数点は使わない。

R.<X> = ZZ[]

failures = []


def check(name, ok):
    status = "PASS" if ok else "FAIL"
    print(f"[{status}] {name}")
    if not ok:
        failures.append(name)


P = X^2 + 1
Q = X^3 - 2
F = 6 * P^2 * Q

# 段 1: 正規化した相異なる既約因子の次数を確認する。
check("P=X^2+1 は原始的で最高次係数が正", P.content() == 1 and P.leading_coefficient() > 0)
check("Q=X^3-2 は原始的で最高次係数が正", Q.content() == 1 and Q.leading_coefficient() > 0)
check("P と Q は QQ 上既約", P.is_irreducible() and Q.is_irreducible())
check("P と Q は相異なる", P != Q)
check("F=6 P^2 Q", F == 6 * P^2 * Q)

# 段 2: 標数 0 上の既約因子は重根を持たず、次数個の相異なる零点を持つ。
roots_P = P.roots(QQbar)
roots_Q = Q.roots(QQbar)
check("P は重根を持たない", P.is_squarefree())
check("Q は重根を持たない", Q.is_squarefree())
check("P は次数 2 個の相異なる零点を持つ", len(roots_P) == P.degree() and all(m == 1 for _, m in roots_P))
check("Q は次数 3 個の相異なる零点を持つ", len(roots_Q) == Q.degree() and all(m == 1 for _, m in roots_Q))

# 段 3: 各零点のモニック最小多項式の次数は、その既約因子の次数に等しい。
check("P の各零点の最小多項式次数は 2", all(a.minpoly().degree() == P.degree() for a, _ in roots_P))
check("Q の各零点の最小多項式次数は 3", all(a.minpoly().degree() == Q.degree() for a, _ in roots_Q))

# 段 4: F における各零点の代数的重複度は因子の指数に等しい。
roots_F = F.roots(QQbar)
check("P の零点は F で重複度 2", all(F(a) == 0 and m == 2 for a, m in roots_F if a.minpoly().degree() == 2))
check("Q の零点は F で重複度 1", all(F(a) == 0 and m == 1 for a, m in roots_F if a.minpoly().degree() == 3))

# 段 5: 代数的重複度込みの最小多項式次数の多重集合を組み立てる。
actual_degrees = sorted(a.minpoly().degree() for a, m in roots_F for _ in range(m))
expected_degrees = sorted([P.degree()] * (2 * P.degree()) + [Q.degree()] * Q.degree())
check("次数 2 が 4 回、次数 3 が 3 回現れる", actual_degrees == expected_degrees == [2, 2, 2, 2, 3, 3, 3])

print()
if failures:
    print("FAIL:", failures)
    sys.exit(1)
print("ALL PASS")
