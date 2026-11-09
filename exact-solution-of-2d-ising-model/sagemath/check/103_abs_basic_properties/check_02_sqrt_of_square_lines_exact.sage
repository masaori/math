# 対象ラベル: abs_basic_properties
# (1) の x = 0, y > 0 の場合の √(y^2) = y と、x = 0, y < 0 の場合の √((−y)^2) = −y の行を厳密に確かめる。
#   根拠: definition_of_sqrt_r_positive（s → y^2、s → (−y)^2）の「u ≥ 0 かつ u^2 = s を満たすただ一つの u」と
#         sqrt_nonnegative_existence_uniqueness の一意性。
# 帰属: y は QQ の元、平方根は AA（実代数的数）で厳密に計算する。浮動小数点は使わない。
#   一意性の検査は、u^2 = s の解を AA の多項式の根として列挙し、u ≥ 0 を満たすものがただ一つでそれが y（または −y）であることを見る。
R.<t> = AA[]
count = 0
neg = 0

def nonneg_roots(s):
    return [r for (r, m) in (t^2 - s).roots(AA) if r >= 0]

samples_pos = [QQ(1), QQ(2), QQ(1)/3, QQ(7)/2, QQ(10)^6, QQ(1)/10^9]
for y in samples_pos:
    # x = 0, y > 0: y ≥ 0 かつ y^2 = y^2 なので、ただ一つの元は y
    assert y > 0 and y >= 0
    roots = nonneg_roots(AA(y)^2)
    assert roots == [AA(y)], f"y={y}: 非負の根がただ一つで y"
    assert AA(y^2).sqrt() == AA(y); count += 1
    # 否定の対照: −y は u^2 = y^2 を満たすが u ≥ 0 を満たさないので √(y^2) ではない
    assert AA(-y)^2 == AA(y)^2 and not (AA(-y) >= 0) and AA(y^2).sqrt() != AA(-y); neg += 1

for y in [-v for v in samples_pos]:
    # x = 0, y < 0: −y ≥ 0 かつ (−y)^2 = (−y)^2 なので、ただ一つの元は −y
    assert y < 0 and -y >= 0
    roots = nonneg_roots(AA(-y)^2)
    assert roots == [AA(-y)], f"y={y}: 非負の根がただ一つで −y"
    assert AA((-y)^2).sqrt() == AA(-y); count += 1
    # 否定の対照: y 自身は u^2 = (−y)^2 を満たすが u ≥ 0 を満たさない
    assert AA(y)^2 == AA(-y)^2 and not (AA(y) >= 0) and AA((-y)^2).sqrt() != AA(y); neg += 1

print(f"PASS: 等号 {count} 個、否定の対照 {neg} 件")
