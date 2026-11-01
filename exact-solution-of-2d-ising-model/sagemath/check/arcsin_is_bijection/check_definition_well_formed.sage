# 対象ラベル: arcsin_is_bijection
# 主張が扱う写像 def_arcsin が [-1,1] の各点でちょうど一つの式で定まることを、具体の y で厳密に確かめる。
# - 0 <= y <= 1 なら 1 - y^2 >= 0 で非負平方根が定まり、P := (sqrt(1-y^2), y) は単位円 C_unit 上にある。
# - -1 <= y' < 0 なら 0 < -y' <= 1 で、第二の式の右辺 -arcsin(-y') は第一の式で定まる。
# - 二つの式の範囲は重ならない。y = 0 は第一の式だけが扱い、P = A である。
# これらは定義の各式が意味を持つ条件の確認であり、作り方からほぼ直ちに従う。
load("_prelude.sage")

for y in Y_NONNEG:
    assert 1 - y^2 >= 0
    xP, yP = point_P(y)
    assert xP >= 0 and xP^2 + yP^2 == 1          # P ∈ C_unit（def_unit_circle）

first = [y for y in Y_ALL if 0 <= y <= 1]
second = [y for y in Y_ALL if -1 <= y < 0]
assert len(first) + len(second) == len(Y_ALL) and not set(first) & set(second)
for y in second:
    assert 0 < -y <= 1

assert point_P(AA(0)) == A_POINT

print(f"checked {len(Y_NONNEG)} values for the first formula and {len(second)} values for the second formula")
print("RESULT: PASS")
