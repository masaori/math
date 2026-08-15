# 対象ラベル: claim_distinct_roots_do_not_determine_polynomial
# 対象ラベル: claim_roots_leading_coefficient_multiplicities_determine_polynomial
# 本文の反例と一意性の各段を QQbar[X] の厳密計算で確認する。浮動小数点は使わない。

R.<X> = QQbar[]

failures = []


def check(name, ok):
    status = "PASS" if ok else "FAIL"
    print(f"[{status}] {name}")
    if not ok:
        failures.append(name)


def distinct_roots(F):
    return set(r for r, m in F.roots(QQbar))


# 反例 1: 最高次係数を落とす
A = X - 1
B = 2 * X - 2
check("[X]A=1 と [X]B=2 が異なる", A[1] == 1 and B[1] == 2 and A[1] != B[1])
check("A(X) ≠ B(X)", A != B)
check("A(1)=0, B(1)=0", A(1) == 0 and B(1) == 0)
check("A と B の相異なる零点集合はどちらも {1}", distinct_roots(A) == {QQbar(1)} and distinct_roots(B) == {QQbar(1)})

# 反例 2: 代数的重複度を落とす
C = X - 1
D = (X - 1) ** 2
check("deg C=1, deg D=2", C.degree() == 1 and D.degree() == 2)
check("C(X) ≠ D(X)", C != D)
check("C(1)=0, D(1)=0", C(1) == 0 and D(1) == 0)
check("C と D の相異なる零点集合はどちらも {1}", distinct_roots(C) == {QQbar(1)} and distinct_roots(D) == {QQbar(1)})

# 一意性: 零点・重複度・最高次係数からの有限積表示
sqrt2 = QQbar(2).sqrt()
F = 3 * (X - 1) ** 2 * (X - sqrt2) * (X + sqrt2) ** 3
roots_mult = F.roots(QQbar)
c = F.leading_coefficient()
G = c * prod((X - r) ** m for r, m in roots_mult)
check("F の最高次係数は 3", c == 3)
check("有限積 c∏(X-r)^{μ(r)} は F に等しい", G == F)
check("各因子 (X-r)^{μ(r)} の最高次係数は 1", all(((X - r) ** m).leading_coefficient() == 1 for r, m in roots_mult))
check("因子の有限積の最高次係数は 1", prod((X - r) ** m for r, m in roots_mult).leading_coefficient() == 1)
# 同じ三つのデータを持つ二つの多項式は等しい: 別の順序で組み立てても同一
H = c * prod((X - r) ** m for r, m in reversed(roots_mult))
check("同じ (R, μ, c) から組み立てた多項式は等しい", H == F)

if failures:
    raise SystemExit("FAIL: " + ", ".join(failures))
print("ALL PASS")
