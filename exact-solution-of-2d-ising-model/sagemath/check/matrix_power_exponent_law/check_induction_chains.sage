# 対象ラベル: matrix_power_exponent_law
# 人手証明の二つの鎖を、A の成分を QQ 上の不定元とした n = 1..3 の行列と、QQ(i) の具体の行列で 1 行ずつ確かめる。
#   q = 0:      A^{p+0} = A^p = A^p I = A^p A^0
#   q → q+1:    A^{p+(q+1)} = A^{(p+q)+1} = A^{p+q}A = (A^pA^q)A = A^p(A^qA) = A^pA^{q+1}
# 冪は def_exp (1) の A^0 := I、A^{m+1} := A^mA で、積は mat_mult の成分の式で組む（共通の準備 matrix_operations_by_definition.sage）。
# Sage の冪 A**k と行列積 * は、比べる側にだけ使う。
load("../../_shared/matrix_operations_by_definition.sage")
set_random_seed(20261104)

steps = 0


def eq(a, b, what):
    global steps
    assert a == b, what
    steps += 1


def power_by_def_exp(A, k):
    """def_exp (1) の冪: A^0 := I、A^{m+1} := A^m A（積は mat_mult の成分の式）。"""
    X = body_identity(A.base_ring(), A.nrows())
    for _ in range(k):
        X = body_product(X, A)
    return X


def check_chains(A, pmax, qmax, what):
    n = A.nrows()
    R = A.base_ring()
    I = body_identity(R, n)
    pw = [power_by_def_exp(A, k) for k in range(pmax + qmax + 2)]
    for k in range(len(pw)):
        eq(pw[k], A**k, f"{what}: def_exp (1) の冪と Sage の冪 k={k}")
    eq(I, identity_matrix(R, n), f"{what}: def_identity_matrix と Sage の単位行列")
    for p in range(pmax + 1):
        # q = 0 の鎖
        L = [pw[p + 0], pw[p], body_product(pw[p], I), body_product(pw[p], pw[0])]
        for a, b in zip(L, L[1:]):
            eq(a, b, f"{what}: q=0 の鎖 p={p}")
        # 帰納法の段
        for q in range(qmax):
            eq(pw[p + q], body_product(pw[p], pw[q]), f"{what}: 帰納法の仮定 p={p}, q={q}")
            L = [pw[p + (q + 1)],
                 pw[(p + q) + 1],
                 body_product(pw[p + q], A),
                 body_product(body_product(pw[p], pw[q]), A),
                 body_product(pw[p], body_product(pw[q], A)),
                 body_product(pw[p], pw[q + 1])]
            for a, b in zip(L, L[1:]):
                eq(a, b, f"{what}: 帰納法の段 p={p}, q={q}")
            # 主張そのものを Sage の冪と積で
            eq(A**(p + q + 1), A**p * A**(q + 1), f"{what}: 主張（組み込み）p={p}, q={q+1}")


for n in range(1, 4):
    P, _, (A,) = generic_ring([("a", n, n)])
    check_chains(A, 3 if n < 3 else 2, 3 if n < 3 else 2, f"不定元 n={n}")
K.<i> = QuadraticField(-1)
for n in range(1, 6):
    A = matrix(K, n, n, [QQ(randint(-4, 4)) + QQ(randint(-4, 4)) * i for _ in range(n * n)])
    check_chains(A, 5, 5, f"QQ(i) n={n}")

# 否定コントロール: 指数を 1 ずらした A^{p+q} = A^pA^{q+1} は、A = [[1,1],[0,1]]（A^k = [[1,k],[0,1]]）の p = q = 1 で外れる
# （検算が指数の取り違えを見分けること）。
B = matrix(QQ, [[1, 1], [0, 1]])
assert power_by_def_exp(B, 2) != body_product(power_by_def_exp(B, 1), power_by_def_exp(B, 2))
print(f"  {steps} 段（不定元の n = 1..3、QQ(i) の n = 1..5。厳密計算）")
print("  否定コントロール 1 件: 指数を 1 ずらした A^{p+q} = A^pA^{q+1} は外れる")
print("RESULT: PASS")
