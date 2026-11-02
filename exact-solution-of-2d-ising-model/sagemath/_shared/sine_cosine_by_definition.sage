# 共通: def_sin・def_cos の sin・cos を、角度が π の有理数倍 qπ（q ∈ QQ, -1/2 ≤ q ≤ 1/2）の点で厳密に作る。
# sin(qπ) は 1 の冪根 e^{iqπ} の虚部として AA で作り、cos は本文の定義 cos θ := √(1 - (sin θ)²) どおりに作る
# （e^{iqπ} の実部との一致もあわせて確かめる）。
# 角度 qπ そのものは π を含むので AA に入らない。角度との大小は π を囲むボール（RealBallField(256) の pi()。
# Arb の π は区間として厳密に π を含む）で、上端と下端を比べて判定する。許容誤差は置かない。
RBF256 = RealBallField(256)
PI_BALL = RBF256.pi()

def sin_exact(q):
    """def_sin の sin(qπ)（-1/2 ≤ q ≤ 1/2）。AA の元。"""
    q = QQ(q)
    assert -QQ(1)/2 <= q <= QQ(1)/2
    m, d = q.numerator(), q.denominator()
    z = QQbar.zeta(2 * d) ^ (m % (2 * d))
    return AA(z.imag())

def sqrt_nonneg(x):
    """definition_of_sqrt_r_positive: y ≥ 0 かつ y² = x のただ一つの y。"""
    x = AA(x)
    assert x >= 0
    y = x.sqrt()
    assert y >= 0 and y ^ 2 == x
    return y

def cos_exact(q):
    """def_cos の cos(qπ) := √(1 - sin(qπ)²)。e^{iqπ} の実部と一致することも確かめる。"""
    q = QQ(q)
    c = sqrt_nonneg(1 - sin_exact(q) ^ 2)
    m, d = q.numerator(), q.denominator()
    assert c == AA((QQbar.zeta(2 * d) ^ (m % (2 * d))).real())
    return c

def angle_ball(q):
    """角度 qπ を囲むボール。"""
    return RBF256(QQ(q)) * PI_BALL

def ball(x):
    """AA の元を囲むボール。"""
    return RBF256(x)

def surely_ge(a, b):
    """ボール a, b について a ≥ b が確定するか（a の下端 ≥ b の上端）。"""
    return (a - b).lower() >= 0

def surely_gt(a, b):
    return (a - b).lower() > 0

# π の有理数倍の点の並び: [0, π/2] を 12 等分した点の q（分母を 24 の約数に抑え、AA の次数を小さく保つ）。
HALF_GRID = [QQ(k) / 24 for k in range(13)]

