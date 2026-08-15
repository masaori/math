# 対象ラベル: claim_discriminant_does_not_determine_polynomial
# 本文の証明の各段を ZZ・ZZ[X] の厳密計算で確認する。浮動小数点は使わない。

R.<X> = ZZ[]

failures = []


def check(name, ok):
    status = "PASS" if ok else "FAIL"
    print(f"[{status}] {name}")
    if not ok:
        failures.append(name)


A = X^2 - X
B = X^2 + X

# 段 1: 一次係数が -1 と 1 なので A(X) ≠ B(X)
check("A の一次係数は -1", A[1] == ZZ(-1))
check("B の一次係数は 1", B[1] == ZZ(1))
check("A(X) ≠ B(X)", A != B)

# 段 2: 分配法則による因数分解 A(X) = X(X-1)、B(X) = X(X+1)
check("A(X) = X·(X-1)", A == X * (X - 1))
check("B(X) = X·(X+1)", B == X * (X + 1))

# 段 2 続き: 各積の二つの一次因子は相異なる
check("A の一次因子 X と X-1 は相異なる", X != X - 1)
check("B の一次因子 X と X+1 は相異なる", X != X + 1)

# 段 2 続き: したがってどちらも重複因子を持たない（square-free）
check("A は square-free", A.is_squarefree())
check("B は square-free", B.is_squarefree())

# 段 2 続き: square-free 部分は多項式自身である
check("A の square-free 部分は A 自身", A.radical() == A)
check("B の square-free 部分は B 自身", B.radical() == B)

# 段 3: 二次式 aX^2+bX+c の判別式 b^2-4ac を整数として計算する
# A(X) = 1·X^2 + (-1)·X + 0
disc_A_by_formula = ZZ((-1)^2 - 4 * 1 * 0)
# B(X) = 1·X^2 + 1·X + 0
disc_B_by_formula = ZZ(1^2 - 4 * 1 * 0)
check("A の係数は (a,b,c) = (1,-1,0)", (A[2], A[1], A[0]) == (ZZ(1), ZZ(-1), ZZ(0)))
check("B の係数は (a,b,c) = (1,1,0)", (B[2], B[1], B[0]) == (ZZ(1), ZZ(1), ZZ(0)))
check("disc(A) = (-1)^2 - 4·1·0 = 1", disc_A_by_formula == ZZ(1))
check("disc(B) = 1^2 - 4·1·0 = 1", disc_B_by_formula == ZZ(1))

# 段 3 続き: 公式の値が SageMath の判別式（終結式由来）と一致する（独立な方法による校正）
check("disc(A) は Sage の discriminant と一致", A.discriminant() == disc_A_by_formula)
check("disc(B) は Sage の discriminant と一致", B.discriminant() == disc_B_by_formula)

# 段 4: 相異なる二つの多項式が同じ判別式を持つ
check("disc(A) = disc(B) かつ A ≠ B", disc_A_by_formula == disc_B_by_formula and A != B)

print()
if failures:
    print("FAIL:", failures)
    sys.exit(1)
print("ALL PASS")
