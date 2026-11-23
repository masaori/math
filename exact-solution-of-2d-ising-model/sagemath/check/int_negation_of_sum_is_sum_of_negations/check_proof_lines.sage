# 対象ラベル: int_negation_of_sum_is_sum_of_negations
# x, y ∈ ℤ について -(x + y) = (-x) + (-y) の 10 行の鎖を確かめる。
# 各行の根拠に書いた形（和の単位元、加法の逆元、加法の結合律、加法の交換律）を、行に書いた代入で両辺を作って確かめる。
# 帰属: 多項式環 ZZ[x, y] と整数 ZZ。浮動小数点は使わない。

R.<x, y> = ZZ[]
ZERO = R(0)
nxy = -(x + y)

lines = [
    -(x + y),                                  # 左辺
    nxy + ZERO,                                # 和の単位元 x + 0 = x（x → -(x + y)）を右辺から左辺へ
    nxy + (x + (-x)),                          # 加法の逆元 x + (-x) = 0 を右辺から左辺へ
    nxy + ((x + ZERO) + (-x)),                 # 和の単位元 x + 0 = x を右辺から左辺へ
    nxy + ((x + (y + (-y))) + (-x)),           # 加法の逆元（x → y）を右辺から左辺へ
    nxy + (((x + y) + (-y)) + (-x)),           # 加法の結合律（t → -y）を右辺から左辺へ
    nxy + ((x + y) + ((-y) + (-x))),           # 加法の結合律（x → x + y, y → -y, t → -x）
    (nxy + (x + y)) + ((-y) + (-x)),           # 加法の結合律（x → -(x + y), y → x + y, t → (-y) + (-x)）を右辺から左辺へ
    ZERO + ((-y) + (-x)),                      # 加法の逆元 (-x) + x = 0（x → x + y）
    (-y) + (-x),                               # 和の単位元 0 + x = x
    (-x) + (-y),                               # 加法の交換律（x → -y, y → -x）
]
for k in range(len(lines) - 1):
    assert lines[k] == lines[k + 1], (k, lines[k], lines[k + 1])

# 各行の根拠の形の両辺（代入済み）
assert nxy + ZERO == nxy
assert x + (-x) == ZERO
assert x + ZERO == x
assert y + (-y) == ZERO
assert (x + y) + (-y) == x + (y + (-y))
assert ((x + y) + (-y)) + (-x) == (x + y) + ((-y) + (-x))
assert (nxy + (x + y)) + ((-y) + (-x)) == nxy + ((x + y) + ((-y) + (-x)))
assert nxy + (x + y) == ZERO
assert ZERO + ((-y) + (-x)) == (-y) + (-x)
assert (-y) + (-x) == (-x) + (-y)

# 整数の標本で全ての行と主張を確かめる。
m = 0
for a in range(-40, 41):
    for b in range(-40, 41):
        a = ZZ(a); b = ZZ(b)
        vals = [ZZ(l.subs(x=a, y=b)) for l in lines]
        assert all(v == -(a + b) for v in vals)
        assert -(a + b) == (-a) + (-b)
        m += 1

# 否定コントロール: 符号反転を和へ配るときに片方の符号を落とすと (-x) + y になり、左辺と一致しない。
assert -(x + y) != (-x) + y
# 否定コントロール: 加法の逆元の段で x + (-x) を x + x と取り違えると 2 行目と一致しない。
assert nxy + (x + x) != lines[1]

print(f"ZZ[x, y] で鎖の等号 {len(lines) - 1} 個と、各段の根拠の形の両辺 10 個を確かめた")
print(f"整数の標本 {m} 件で全ての行と主張が -(x + y) に一致した")
print("negative controls (broken lines detected): 2")
print("RESULT: PASS")
