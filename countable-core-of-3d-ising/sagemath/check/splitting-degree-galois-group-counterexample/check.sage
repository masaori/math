# 対象ラベル: claim_splitting_degree_galois_group_do_not_determine_polynomial
# 本文の証明の各段を QQ の厳密計算で確認する。浮動小数点は使わない。

R.<X> = QQ[]

failures = []


def check(name, ok):
    status = "PASS" if ok else "FAIL"
    print(f"[{status}] {name}")
    if not ok:
        failures.append(name)


A = X - 1
B = X - 2

# 段 1: 定数係数が -1 と -2 なので A(X) ≠ B(X)
check("A の定数係数は -1", A[0] == QQ(-1))
check("B の定数係数は -2", B[0] == QQ(-2))
check("A(X) ≠ B(X)", A != B)

# 段 2: A の根は有理数 1、B の根は有理数 2（QQ の中で全根が取れる）
roots_A = A.roots(QQ)
roots_B = B.roots(QQ)
check("A の QQ 上の根は 1（重複度 1）", roots_A == [(QQ(1), 1)])
check("B の QQ 上の根は 2（重複度 1）", roots_B == [(QQ(2), 1)])

# 段 2 続き: どちらも QQ 上で既に一次式へ分解する
# （重複度込みの QQ 上の根の個数が次数に等しい）
check("A は QQ 上で一次式の積", sum(m for (_, m) in roots_A) == A.degree())
check("B は QQ 上で一次式の積", sum(m for (_, m) in roots_B) == B.degree())

# 段 2 続き: 分解体はどちらも QQ で、その次数は [QQ:QQ] = 1
K_A = A.splitting_field("tA")
K_B = B.splitting_field("tB")
check("A の分解体の QQ 上の次数は 1", K_A.degree() == 1)
check("B の分解体の QQ 上の次数は 1", K_B.degree() == 1)

# 段 3: Galois 群はどちらも一元群
# （次数 1 の分解体 QQ の QQ 自己同型は恒等写像だけ。
#  分解体を次数 1 の数体表示で作り、自己同型群の位数を数える）
S.<x> = QQ[]
F_A = NumberField(x - 1, "uA")  # = QQ の数体表示
F_B = NumberField(x - 1, "uB")
check("A の分解体の Galois 群の位数は 1", F_A.galois_group().order() == 1)
check("B の分解体の Galois 群の位数は 1", F_B.galois_group().order() == 1)
check(
    "二つの Galois 群は同型（どちらも一元群）",
    F_A.galois_group().order() == F_B.galois_group().order() == 1,
)

print()
if failures:
    print("FAIL:", failures)
    sys.exit(1)
print("ALL PASS")
