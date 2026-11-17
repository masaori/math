# 対象ラベル: claim_precone_adjoin_one_side_avoids_minus_one
# QQ 上の多項式環での厳密計算だけを使う。浮動小数点を使わない。
# 証明の式変形を一行ずつ確かめる。代入の行は、仮定の二式
#   -1 = t1 + a*t2、-1 = t3 + (-a)*t4
# が生成するイデアルに差が属することで確かめる。
# あわせて F = E = QQ、T = 非負の有理数のモデルで、どの標本の a でも
# -1 ∉ T<a> または -1 ∉ T<-a> が成り立つことを見る（a ≠ 0 では片方だけが -1 を含む）。

R.<t1, t2, t3, t4, a> = PolynomialRing(QQ)
I = R.ideal([t1 + a * t2 + 1, t3 + (-a) * t4 + 1])

# 移項の二式
assert (a * t2 - (-1 - t1)) in I
assert ((-a) * t4 - (-1 - t3)) in I
print("移項の二式: 仮定のイデアルで通過", flush=True)

head = t1 + t3 + t1 * t3
line0 = R(-1)
line1 = head - (1 + t1 + t3 + t1 * t3)
line2 = head - (-1 - t1) * (-1 - t3)
line3 = head - (a * t2) * ((-a) * t4)
line4 = head + (a * a) * (t2 * t4)
assert line0 == line1
assert line1 == line2
assert (line2 - line3) in I
assert line3 == line4
print("-1 の書き直し: 四行が通過（代入の行は仮定のイデアルで）", flush=True)

SAMPLES = [QQ(0), QQ(1), QQ(-1), QQ(2), QQ(-3), QQ(1)/2, QQ(-5)/7, QQ(7)/3]


def minus_one_in_adjoin(alpha):
    # T = 非負の有理数。-1 = t + alpha*t'（t, t' ≥ 0）となる証人があるのは alpha < 0 のときだけ。
    if alpha < 0:
        t_prime = 1 / (-alpha)
        t = QQ(0)
        assert t + alpha * t_prime == -1
        return True
    return False


for alpha in SAMPLES:
    assert (not minus_one_in_adjoin(alpha)) or (not minus_one_in_adjoin(-alpha))
print("モデル（T = 非負の有理数）: 標本 %d 個の a で片側が -1 を含まないことが通過" % len(SAMPLES), flush=True)
print("claim_precone_adjoin_one_side_avoids_minus_one: 全検査通過")
