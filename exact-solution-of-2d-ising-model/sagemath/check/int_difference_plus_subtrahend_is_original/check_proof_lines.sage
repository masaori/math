# 対象ラベル: int_difference_plus_subtrahend_is_original
# x, y ∈ ℤ について (x - y) + y = (x + (-y)) + y = x + ((-y) + y) = x + 0 = x の 4 行の鎖を確かめる。
# 差は def_int_difference の y - z := y + (-z) で、計算する環の差を使わずに書く。
# 各行の根拠に書いた形（def_int_difference、加法の結合律、加法の逆元 (-y) + y = 0、和の単位元 y + 0 = y）を、
# 行に書いた代入で両辺を作って確かめる。
# 帰属: 多項式環 ZZ[x, y] と整数 ZZ。浮動小数点は使わない。

R.<x, y> = ZZ[]
ZERO = R(0)

def int_difference(p, q):
    # def_int_difference: p - q := p + (-q)
    return p + (-q)

lines = [
    int_difference(x, y) + y,     # 左辺 (x - y) + y
    (x + (-y)) + y,               # def_int_difference（y → x, z → y）
    x + ((-y) + y),               # 加法の結合律（y → x, z → -y, t → y）
    x + ZERO,                     # 加法の逆元 (-y) + y = 0
    x,                            # 和の単位元 y + 0 = y（y → x）
]
for k in range(len(lines) - 1):
    assert lines[k] == lines[k + 1], (k, lines[k], lines[k + 1])

# 各行の根拠の形の両辺（代入済み）
assert int_difference(x, y) == x + (-y)                    # def_int_difference
assert (x + (-y)) + y == x + ((-y) + y)                    # (y + z) + t = y + (z + t)
assert (-y) + y == ZERO                                    # (-y) + y = 0
assert x + ZERO == x                                       # y + 0 = y

# 整数の標本で主張と、組み込みの差との一致を確かめる。
m = 0
for a in range(-40, 41):
    for b in range(-40, 41):
        a = ZZ(a); b = ZZ(b)
        vals = [ZZ(l.subs(x=a, y=b)) for l in lines]
        assert all(v == a for v in vals)
        assert (a - b) + b == a
        assert int_difference(a, b) == a - b
        m += 1

# 否定コントロール: 差を p + q と取り違えると鎖の左辺は x + 2y になり x と一致しない。
assert (x + y) + y != x
# 否定コントロール: 加法の逆元の段で (-y) + y を y + y と取り違えると 3 行目と一致しない。
assert x + (y + y) != lines[2]

print(f"ZZ[x, y] で鎖の等号 {len(lines) - 1} 個と、各段の根拠の形の両辺 4 つを確かめた")
print(f"整数の標本 {m} 件で全ての行と主張が x に一致した")
print("negative controls (broken lines detected): 2")
print("RESULT: PASS")
