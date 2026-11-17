# 対象ラベル: claim_precone_adjoin_element_is_precone
# QQ 上の多項式環での厳密計算だけを使う。浮動小数点を使わない。
# 証明の式変形を一行ずつ、不定元 t1, t2, t3, t4, a の多項式の等号として確かめる
# （z1 = t1 + a*t2、z2 = t3 + a*t4）。あわせて F = E = QQ、T = 非負の有理数のモデルで、
# T<a> が a の符号で決まる集合（a ≥ 0 なら T、a < 0 なら QQ 全体）になり、T と a を含むことを標本で見る。

R.<t1, t2, t3, t4, a> = PolynomialRing(QQ)

# 包含 T ⊆ T<a> と所属 a ∈ T<a> の表示
assert t1 == t1 + a * 0
assert a == 0 + a * 1
print("包含と所属の表示: t = t + a*0、a = 0 + a*1 が通過", flush=True)

# 和で閉じること
z1 = t1 + a * t2
z2 = t3 + a * t4
assert z1 + z2 == (t1 + t3) + (a * t2 + a * t4)
assert (t1 + t3) + (a * t2 + a * t4) == (t1 + t3) + a * (t2 + t4)
print("和の式変形: 二行が通過", flush=True)

# 積で閉じること
line1 = z1 * z2
line2 = t1 * t3 + t1 * (a * t4) + (a * t2) * t3 + (a * t2) * (a * t4)
line3 = (t1 * t3 + (a * a) * (t2 * t4)) + a * (t1 * t4 + t2 * t3)
assert line1 == line2
assert line2 == line3
print("積の式変形: 二行が通過", flush=True)

# モデル: F = E = QQ、T = 非負の有理数。T<a> の所属は「t + a*t' = z を満たす t, t' ≥ 0 がある」。
SAMPLES = [QQ(0), QQ(1), QQ(-1), QQ(2), QQ(-3), QQ(1)/2, QQ(-5)/7, QQ(7)/3]


def in_adjoin(alpha, z):
    # alpha ≥ 0 なら T<alpha> = T、alpha < 0 なら t' を大きく取って任意の z に届く。
    if alpha >= 0:
        return z >= 0
    t_prime = max(QQ(0), -z / (-alpha)) if z < 0 else QQ(0)
    t = z - alpha * t_prime
    assert t >= 0 and t_prime >= 0 and t + alpha * t_prime == z
    return True


for alpha in SAMPLES:
    for z in SAMPLES:
        if z >= 0:
            assert in_adjoin(alpha, z)
    assert in_adjoin(alpha, alpha)
print("モデル（T = 非負の有理数）: 標本 %d 個の a で T ⊆ T<a> と a ∈ T<a> が通過" % len(SAMPLES), flush=True)
print("claim_precone_adjoin_element_is_precone: 全検査通過")
