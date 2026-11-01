# 対象ラベル: radial_normalization_exists_unique
# 共通の準備。二通りの帰属で確かめる。
#
# (一般の点) x, y を QQ 上の不定元とし、その有理関数体 F = QQ(x,y) の上で、
#   r を r^2 = x^2+y^2 を満たす元として持つ商環 K = F[r]/(r^2-(x^2+y^2)) を置く。
#   K では r^2 = x^2+y^2 ≠ 0 なので r は可逆で、r^{-1} = r/(x^2+y^2) である。
#   これは「r := sqrt(x^2+y^2) は r^2 = x^2+y^2 を満たす」（正の平方根の定義）だけを使った計算で、
#   r の正負や大小は使わない。等号は厳密に決定できる。
#
# (具体の点) x, y を AA（実代数的数）に取る。AA は可算で、sqrt・四則・等号・大小がすべて厳密に決定できる。
#   正の平方根の値（r > 0）と大小比較（x^2+y^2 > 0、r' = r）はこちらで確かめる。
#
# 浮動小数点と RR / CC への脱出はない。

F.<x, y> = FractionField(PolynomialRing(QQ, ['x', 'y']))
_P.<rr> = PolynomialRing(F)
K.<r> = _P.quotient(rr^2 - (x^2 + y^2))
s = x^2 + y^2                      # F の元
r_inv = r / s                      # K における r の逆元（r * r_inv = r^2/s = 1）
assert r * r_inv == 1

# r が可逆であることだけを持つ環 V = F[rv, t]/(rv*t - 1)。t が r^{-1} に当たる。
# r^2 = x^2+y^2 を使わない行（約分・四則）はこちらで確かめ、K へ移すのは r^2 = x^2+y^2 を使う行だけにする。
# V へ写す前の多項式環 F[rv, t] は関係式を持たないので、どの行が関係式 rv*t = 1 を使うかの対照に使う。
FV.<rv, t> = PolynomialRing(F)
V = FV.quotient(rv * t - 1)
def V_to_K(e):
    """V の元を、rv ↦ r, t ↦ r^{-1} で K へ写す（rv*t - 1 ↦ r*r^{-1} - 1 = 0 なので well-defined）。"""
    return e.lift()(r, r_inv)

# 具体の点: (0,0) 以外の実代数的数の対。座標軸上・負の座標・無理数の座標を含める。
SAMPLE_POINTS = [
    (AA(3), AA(4)), (AA(1), AA(1)), (AA(-2), AA(0)), (AA(0), AA(-5)),
    (AA(-7), AA(24)), (AA(1)/3, AA(-1)/7), (AA(2).sqrt(), AA(1)),
    (AA(-3).nth_root(3), AA(5).sqrt()), (AA(10)^6, AA(10)^-6),
]

def normalize(px, py):
    """証明の定め方どおりに r := sqrt(x^2+y^2), x_c := x/r, y_c := y/r を AA で作る。"""
    pr = (px^2 + py^2).sqrt()
    return pr, px / pr, py / pr

# 一意性の検算に使う「別の」組 (r', (x_c', y_c'))。r' > 0、(x_c', y_c') は単位円上の実代数的数の点。
UNIT_POINTS = [
    (AA(1), AA(0)), (AA(0), AA(-1)), (AA(3)/5, AA(4)/5), (AA(-5)/13, AA(12)/13),
    (1/AA(2).sqrt(), -1/AA(2).sqrt()), (AA(1)/2, AA(3).sqrt()/2),
]
RADII = [AA(1), AA(2), AA(1)/3, AA(2).sqrt(), AA(7)^5]
