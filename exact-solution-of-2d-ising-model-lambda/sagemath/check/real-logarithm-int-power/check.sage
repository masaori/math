# 対象ラベル: claim_real_logarithm_int_power
# 帰属: QQ 上の多項式環（不定元 ℓ_p は素数 p の実対数 log_ℝ(ι(p)) を表す記号）による厳密計算。
#       実対数の値そのものは計算しない。主張の証明が log_ℝ について使うのは「乗法を加法へ移す」だけなので、
#       正の有理数 u = Π p^{e_p} に L(u) := Σ e_p ℓ_p を対応させる写像（乗法を加法へ移す）を実対数の
#       模型として、証明の各段を記号のまま確かめる。浮動小数点は使わない。

PRIMES = [2, 3, 5, 7, 11, 13]
R = PolynomialRing(QQ, ["l%d" % p for p in PRIMES])
ELL = {p: R.gen(i) for i, p in enumerate(PRIMES)}


def L(u):
    # 乗法を加法へ移す写像の模型: 正の有理数の素因数分解の指数を係数とする ℓ_p の形式和
    u = QQ(u)
    assert u > 0
    return sum((QQ(e) * ELL[p] for p, e in u.factor()), R(0))


checks = 0
# 前提: 模型が「乗法を加法へ移す」を満たすこと（def_real_logarithm の性質）
units = [QQ(1), QQ(2), QQ(3), QQ(1) / 2, QQ(12), QQ(9) / 10, QQ(77) / 8, QQ(1) / 13, QQ(26) / 15]
for u in units:
    for v in units:
        assert L(u * v) == L(u) + L(v)
        checks += 1

# 準備 log(1) = 0: log(1) = log(1·1) = log(1) + log(1)、移項
assert L(1) == L(1 * 1)
assert L(1 * 1) == L(1) + L(1)
assert L(1) + L(1) - L(1) == 0
assert L(1) == 0
checks += 4

for u in units:
    # 自然数冪の帰納法 log(u^n) = n·log(u)
    # n = 0
    assert L(u ** 0) == L(1)
    assert L(1) == 0
    assert 0 == QQ(0) * L(u)
    checks += 3
    for n in range(0, 8):
        # 帰納法の仮定 log(u^n) = n log(u) を確かめたうえで n+1 へ
        assert L(u ** n) == QQ(n) * L(u)
        assert L(u ** (n + 1)) == L(u ** n * u)          # u^{n+1} = u^n · u
        assert L(u ** n * u) == L(u ** n) + L(u)         # 乗法を加法へ
        assert L(u ** n) + L(u) == QQ(n) * L(u) + L(u)   # 帰納法の仮定
        assert QQ(n) * L(u) + L(u) == (QQ(n) + 1) * L(u) # 分配則
        assert (QQ(n) + 1) * L(u) == QQ(n + 1) * L(u)    # ι は加法を保つ
        checks += 6
    # 逆数 log(v^{-1}) = -log(v)
    v = u
    assert 0 == L(1)
    assert L(1) == L(v * v ** (-1))
    assert L(v * v ** (-1)) == L(v) + L(v ** (-1))
    assert L(v ** (-1)) == -L(v)
    checks += 4
    # 主張を k の符号で分ける
    for k in range(-8, 9):
        if k >= 0:
            assert L(u ** k) == QQ(k) * L(u)
            checks += 1
        else:
            n = -k - 1
            assert L(u ** k) == L((u ** (n + 1)) ** (-1))            # 整数冪の定義
            assert L((u ** (n + 1)) ** (-1)) == -L(u ** (n + 1))    # 逆数
            assert -L(u ** (n + 1)) == -(QQ(n + 1) * L(u))          # 帰納法
            assert -(QQ(n + 1) * L(u)) == (-QQ(n + 1)) * L(u)       # -(st) = (-s)t
            assert (-QQ(n + 1)) * L(u) == QQ(-(n + 1)) * L(u)       # ι(-r) = -ι(r)
            assert QQ(-(n + 1)) * L(u) == QQ(k) * L(u)              # k = -(n+1)
            checks += 6
        # 結論
        assert L(u ** k) == QQ(k) * L(u)
        checks += 1

print("PASS: claim_real_logarithm_int_power, checks =", checks)
