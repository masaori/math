# 対象ラベル: phi_cartesian_after_phi_polar_is_identity
# 証明の場合分けの各鎖を一行ずつ確かめる。S := √(x²+y²)、t := y/x、U := √(1+t²)、α := arctan(t) と書く。
#
# 各場合の最初の二行は (φc∘φp)(x,y) = φc(φp(x,y))（写像の合成の定義）と、φp(x,y) を def_phi_polar の値に置く行である。
# 下では二つをまとめて「行 0 → 1」と書く。よって検算の行 k（k ≥ 1）は本文の行 k+1 に当たる（合成の定義は検算では関数の合成そのものなので、比べるものが無い）。
# x > 0 の鎖（行 0 〜 行 8）:
#   行 0: (φc∘φp)(x,y)
#   行 1: φc([(S, α)])                                    （写像の合成の定義、def_phi_polar の x > 0）
#   行 2: (S cos α, S sin α)                              （def_phi_cartesian）
#   行 3: (S/U, S t/U)                                    （cos_arctan_sin_arctan）
#   行 4: (S x/(xU), S y/(xU))                            （分母と分子に x を掛ける）
#   行 5: (S x/(X U), S y/(X U)),  X := √(x²)             （x > 0 なので x = X）
#   行 6: (S x/W, S y/W),  W := √(x²(1+t²))               （√a√b = √(ab)）
#   行 7: (S x/S, S y/S)                                  （x²(1+t²) = x²+y²）
#   行 8: (x, y)                                          （S ≠ 0 で約分）
# x < 0 の二つの鎖（y ≥ 0 は α+π、y < 0 は α-π）は本文の四行（検算では最初の二行をまとめて三行）で同じ式 (-S cos α, -S sin α) に着き、そこから共通の鎖:
#   行 c0: (-S cos α, -S sin α)
#   行 c1: (-S/U, -S t/U)                                 （cos_arctan_sin_arctan）
#   行 c2: (-S x/(xU), -S y/(xU))                         （分母と分子に x を掛ける）
#   行 c3: (-S x/(-X' U), -S y/(-X' U)),  X' := √((-x)²)  （x < 0 なので x = -X'。negative_number_to_sqrt）
#   行 c4: (S x/(X' U), S y/(X' U))                       （負号の相殺）
#   行 c5: (S x/(X U), S y/(X U)),  X := √(x²)            （(-x)² = x²）
#   行 c6: (S x/W, S y/W)                                 （√a√b = √(ab)）
#   行 c7: (S x/S, S y/S)                                 （x²(1+t²) = x²+y²）
#   行 c8: (x, y)                                         （S ≠ 0 で約分）
# x = 0 の三つの鎖は具体の値で一行ずつ。
#
# (一般の点) QQ 上の有理関数体で、平方根を不定元 S, U, X, Xp, W とし、各行で根拠に挙げた関係だけを代入して比べる。
# (具体の点) (x, y) を AA で直接与え、各行を別々に計算して比べる。α が π の有理数倍になる点では、
#   α を「[-π/2, π/2] に入り sin α = t/U を満たす qπ」として探し（def_arctan・arcsin_is_bijection・def_sin）、
#   cos α・sin α を 1 の冪根から QQbar で作るので、行 2 → 3（cos_arctan_sin_arctan）と cos(α±π) = -cos α の行も独立に確かめられる。
#   α が π の有理数倍にならない点（(2,1) など）では、行 3 以降と c1 以降の代数の行だけを確かめる。
load("../../_shared/polar_trigonometry_exact.sage")

# ---------------- 一般の点 ----------------
G.<x, y, S, U, X, Xp, W> = PolynomialRing(QQ)
F = G.fraction_field()
x, y, S, U, X, Xp, W = [F(v) for v in (x, y, S, U, X, Xp, W)]
t = y / x
# x > 0 の鎖
r3 = (S / U, S * t / U)
r4 = (S * x / (x * U), S * y / (x * U))
assert r3 == r4                                                             # 行 3 → 4: 有理関数として等しい
r5 = (S * x / (X * U), S * y / (X * U))
assert tuple(c.subs(X=x) for c in r5) == r4                                 # 行 4 → 5: x = X だけを使う
r6 = (S * x / W, S * y / W)
assert tuple(c.subs(W=X * U) for c in r6) == r5                             # 行 5 → 6: W = X·U だけを使う
assert x ^ 2 * (1 + t ^ 2) == x ^ 2 + y ^ 2                                 # 行 6 → 7 の根拠の式
r7 = (S * x / S, S * y / S)
assert tuple(c.subs(W=S) for c in r6) == r7                                 # 行 6 → 7: W = S だけを使う
assert r7 == (x, y)                                                         # 行 7 → 8: 約分
# x < 0 の共通の鎖
c1 = (-S / U, -S * t / U)
c2 = (-S * x / (x * U), -S * y / (x * U))
assert c1 == c2                                                             # 行 c1 → c2
c3 = (-S * x / (-Xp * U), -S * y / (-Xp * U))
assert tuple(c.subs(Xp=-x) for c in c3) == c2                               # 行 c2 → c3: x = -X' だけを使う
c4 = (S * x / (Xp * U), S * y / (Xp * U))
assert c3 == c4                                                             # 行 c3 → c4: 負号の相殺
c5 = (S * x / (X * U), S * y / (X * U))
assert tuple(c.subs(Xp=X) for c in c4) == c5                                # 行 c4 → c5: X' = X だけを使う（(-x)² = x²）
assert (-x) ^ 2 == x ^ 2
assert tuple(c.subs(W=X * U) for c in r6) == c5                             # 行 c5 → c6
assert tuple(c.subs(W=S) for c in r6) == r7 and r7 == (x, y)                # 行 c6 → c7 → c8

# ---------------- 具体の点 ----------------
def find_alpha(tt):
    """[-π/2, π/2] に入り sin α = tt/√(1+tt²) を満たす α = qπ（q の分母は 24 まで）。無ければ None。
    arcsin は単射なので、見つかれば α = arcsin(tt/√(1+tt²)) = arctan(tt)（def_arctan）。"""
    target = tt / sqrt_aa(1 + tt ^ 2)
    hits = [k for k in range(-12, 13) if cos_sin(k * pi_ / 24)[1] == target]
    assert len(hits) <= 1
    return hits[0] * pi_ / 24 if hits else None

def chain_tail_common(xx, yy, sign):
    """x > 0（sign = +1）の行 3 〜 8、x < 0（sign = -1）の行 c1 〜 c8 を AA で一行ずつ作り、隣どうしを比べる。"""
    SS, tt = sqrt_aa(xx ^ 2 + yy ^ 2), yy / xx
    UU = sqrt_aa(1 + tt ^ 2)
    XX = sqrt_aa(xx ^ 2)
    WW = sqrt_aa(xx ^ 2 * (1 + tt ^ 2))
    rows = [(sign * SS / UU, sign * SS * tt / UU), (sign * SS * xx / (xx * UU), sign * SS * yy / (xx * UU))]
    if sign == -1:
        XXp = sqrt_aa((-xx) ^ 2)
        assert xx == -XXp                                        # negative_number_to_sqrt
        rows += [(-SS * xx / (-XXp * UU), -SS * yy / (-XXp * UU)), (SS * xx / (XXp * UU), SS * yy / (XXp * UU))]
        assert XXp == XX                                         # (-x)² = x²
    else:
        assert xx == XX                                          # x > 0 と平方根の一意性
    rows += [(SS * xx / (XX * UU), SS * yy / (XX * UU))]
    assert XX * UU == WW                                         # √a√b = √(ab)
    rows += [(SS * xx / WW, SS * yy / WW)]
    assert WW == SS                                              # x²(1+t²) = x²+y²
    rows += [(SS * xx / SS, SS * yy / SS), (xx, yy)]
    assert SS != 0
    for a, b in zip(rows, rows[1:]):
        assert a == b
    return rows[0]

s3, s2, s6 = AA(3).sqrt(), AA(2).sqrt(), AA(6).sqrt()
POS = [(AA(1), AA(0)), (AA(1), AA(1)), (s3, AA(1)), (AA(1), -s3), (5 * s3, AA(-5)), ((s6 + s2) / 4, (s6 - s2) / 4),
       (AA(2), AA(1)), (AA(3), AA(-7))]
NEG_UP = [(AA(-2), AA(0)), (-s3, AA(1)), (AA(-2), 2 * s3), (AA(-2), AA(1))]
NEG_DOWN = [(AA(-1), AA(-1)), (-AA(7) / 2, -7 * s3 / 2), (AA(-3), AA(-1))]

n_full = n_alg = 0
for xx, yy in POS + NEG_UP + NEG_DOWN:
    sign = 1 if xx > 0 else -1
    head = chain_tail_common(xx, yy, sign)                       # 行 3（または c1）の値
    SS, tt = sqrt_aa(xx ^ 2 + yy ^ 2), yy / xx
    alpha = find_alpha(tt)
    n_alg += 1
    if alpha is None:
        continue
    c, s = cos_sin(alpha)
    shift = Ang(0) if xx > 0 else (pi_ if yy >= 0 else -pi_)
    row1 = (SS, alpha + shift)                                   # def_phi_polar の該当する場合
    assert phi_polar_equals((xx, yy), row1)
    row2 = phi_cartesian(row1)                                   # (S cos(α+shift), S sin(α+shift))
    if xx > 0:
        assert row2 == (SS * c, SS * s)                          # 行 1 → 2
        assert (c, s) == (1 / sqrt_aa(1 + tt ^ 2), tt / sqrt_aa(1 + tt ^ 2))   # 行 2 → 3: cos_arctan_sin_arctan
        assert (SS * c, SS * s) == head
    else:
        cs_shift = cos_sin(alpha + shift)
        assert cs_shift == (-c, -s)                              # cos(α±π) = -cos α, sin(α±π) = -sin α
        assert row2 == (-SS * c, -SS * s)                        # 二行目 → 三行目（共通の式 c0）
        assert (c, s) == (1 / sqrt_aa(1 + tt ^ 2), tt / sqrt_aa(1 + tt ^ 2))   # 行 c0 → c1
        assert (-SS * c, -SS * s) == head
    n_full += 1

# x = 0 の三つの鎖
for yy in (AA(3), AA(1) / 7, s2):                                # x = 0, y > 0
    assert phi_polar_equals((AA(0), yy), (yy, pi_ / 2))          # 行 0 → 1（def_phi_polar）
    rows = [phi_cartesian((yy, pi_ / 2)), (yy * cos_sin(pi_ / 2)[0], yy * cos_sin(pi_ / 2)[1]), (yy * 0, yy * 1), (AA(0), yy)]
    assert cos_sin(pi_ / 2) == (0, 1)
    assert all(a == b for a, b in zip(rows, rows[1:])) and rows[-1] == (0, yy)
for yy in (AA(-3), -AA(1) / 2, -s3):                             # x = 0, y < 0
    assert phi_polar_equals((AA(0), yy), (-yy, -pi_ / 2))        # 行 0 → 1（def_phi_polar）
    rows = [phi_cartesian((-yy, -pi_ / 2)), ((-yy) * cos_sin(-pi_ / 2)[0], (-yy) * cos_sin(-pi_ / 2)[1]),
            ((-yy) * 0, (-yy) * (-1)), (AA(0), yy)]
    assert cos_sin(-pi_ / 2) == (0, -1)
    assert all(a == b for a, b in zip(rows, rows[1:])) and rows[-1] == (0, yy)
rows = [phi_cartesian(ZERO), (0 * cos_sin(Ang(0))[0], 0 * cos_sin(Ang(0))[1]), (AA(0), AA(0))]   # x = y = 0
assert all(a == b for a, b in zip(rows, rows[1:]))
assert phi_polar_equals((AA(0), AA(0)), ZERO)

print(f"general-point rows as rational-function identities; algebraic rows on {n_alg} points, full chains on {n_full} points; x = 0 cases on 7 points")
print("RESULT: PASS")
