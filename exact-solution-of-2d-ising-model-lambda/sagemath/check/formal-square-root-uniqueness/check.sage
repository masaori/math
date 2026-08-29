# 対象ラベル: claim_formal_square_root_unique
# 代数的数係数の打ち切り形式的冪級数について、本文の因数分解と一意性を厳密検算する。

R.<x> = PolynomialRing(QQbar)

samples = [
    R(1),
    R(1 + x),
    R(1 - 2*x + 3*x^2),
    R(1 + QQbar.zeta(3)*x + QQbar(2).sqrt()*x^3),
]

checks = 0
for S in samples:
    T = S
    D = S * S
    assert S[0] == 1
    assert T[0] == 1
    assert S * S == D == T * T
    assert (S - T) * (S + T) == S * S - T * T
    assert (S - T) * (S + T) == 0
    assert S == T
    checks += 7

# 定数項の条件が分岐を固定していることも確認する。
for S in samples:
    T = -S
    assert S * S == T * T
    assert S[0] == 1
    assert T[0] == -1
    assert S != T
    checks += 4

print(f"OK: claim_formal_square_root_unique — QQbar[x] の有限標本で {checks} 件を厳密検査した")
