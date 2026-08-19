# 対象ラベル: claim_shifted_free_family_cross_power_equality_fails_at_two
# 証明の第二段: 素因数 2 の指数の比較。
# Z_2(2)=2*3^6*5^2（指数 1）、Z_3(2)=2*(奇数)（指数 1）なので、
# Z_2(2)^27 の素因数 2 の指数は 27、Z_3(2)^8 の指数は 8。27≠8 から破れが従う。
# 最後に自然数として直接 Z_2(2)^27 ≠ Z_3(2)^8 も確かめる。

value_2 = ZZ(36450)
value_3 = ZZ(942223653336523266)

# 本文の素因数分解の等式を一行ずつ確かめる。
assert value_2 == ZZ(2) * ZZ(3) ** 6 * ZZ(5) ** 2
assert factor(value_2) == factor(ZZ(2) * ZZ(3) ** 6 * ZZ(5) ** 2)

odd_cofactor = ZZ(471111826668261633)
assert value_3 == ZZ(2) * odd_cofactor
assert odd_cofactor % 2 == 1  # 一の位が 3 の奇数

# 素因数 2 の指数（2 進付値）。
assert value_2.valuation(2) == 1
assert value_3.valuation(2) == 1

# べきの指数倍: 27*1 と 8*1。
assert (value_2 ** 27).valuation(2) == 27
assert (value_3 ** 8).valuation(2) == 8
assert ZZ(27) != ZZ(8)

# 算術の基本定理による結論を、自然数の直接比較でも確認する。
assert value_2 ** 27 != value_3 ** 8

print("RESULT: PASS — 素因数 2 の指数 27≠8 から Z_2(2)^27 ≠ Z_3(2)^8 を ZZ 上で確認")
