# 対象ラベル: abs_basic_properties
# (6) の x ≥ 0 の場合の √(x^2) = x と、x < 0 の場合の √((−x)^2) = −x の行を厳密に確かめる。
#   根拠: definition_of_sqrt_r_positive（s → x^2、s → (−x)^2）の「u ≥ 0 かつ u^2 = s を満たすただ一つの u」と
#         sqrt_nonnegative_existence_uniqueness の一意性。
# 帰属: x は QQ の元、平方根は AA（実代数的数）で厳密に計算する。浮動小数点は使わない。
#   一意性の検査は、u^2 = s の解を AA の多項式の根として列挙し、u ≥ 0 を満たすものがただ一つでそれが x（または −x）であることを見る。
R.<t> = AA[]
count = 0
neg = 0

def nonneg_roots(s):
    return [r for (r, m) in (t^2 - s).roots(AA) if r >= 0]

samples_pos = [QQ(1), QQ(2), QQ(1)/3, QQ(7)/2, QQ(10)^6, QQ(1)/10^9]

# x = 0（x ≥ 0 の場合に入る）: u^2 = 0 の非負の根はただ一つで 0
assert nonneg_roots(AA(0)) == [AA(0)] and AA(0).sqrt() == AA(0); count += 1

for x in samples_pos:
    # x ≥ 0: x ≥ 0 かつ x^2 = x^2 なので、ただ一つの元は x
    assert x >= 0
    assert nonneg_roots(AA(x)^2) == [AA(x)], f"x={x}: 非負の根がただ一つで x"
    assert AA(x^2).sqrt() == AA(x); count += 1
    # 否定の対照: −x は u^2 = x^2 を満たすが u ≥ 0 を満たさないので √(x^2) ではない
    assert AA(-x)^2 == AA(x)^2 and not (AA(-x) >= 0) and AA(x^2).sqrt() != AA(-x); neg += 1

for x in [-v for v in samples_pos]:
    # x < 0: −x ≥ 0 かつ (−x)^2 = (−x)^2 なので、ただ一つの元は −x
    assert x < 0 and -x >= 0
    assert nonneg_roots(AA(-x)^2) == [AA(-x)], f"x={x}: 非負の根がただ一つで −x"
    assert AA((-x)^2).sqrt() == AA(-x); count += 1
    # 否定の対照: x 自身は u^2 = (−x)^2 を満たすが u ≥ 0 を満たさない
    assert AA(x)^2 == AA(-x)^2 and not (AA(x) >= 0) and AA((-x)^2).sqrt() != AA(x); neg += 1

print(f"PASS: 等号 {count} 個、否定の対照 {neg} 件")
