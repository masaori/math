# 対象ラベル: claim_finitely_many_values_limit_quantity_only_at_one
# 合成の対偶側の裏取り。有理点 1 以外の有限標本では、一辺 1 と 2 の量が既に相異なる。
# 相異なる値をとる以上、閾値 1 以後で定数という形の末尾定数性はこの標本では成り立たない。
# 本文の合成により、末尾定数でない点では有限値域と極限量の存在は両立しない。
load("_prelude.sage")

ok = True

for q in OFF_ONE_SAMPLES:
    if finite_box_values_agree(ZZ(1), ZZ(2), q):
        ok = False
        print("FAIL: q=%s で一辺 1 と 2 の量が一致してしまう" % q)

# 標本の中で一致するのは有理点 1 だけであることを併せて確かめる。
if not finite_box_values_agree(ZZ(1), ZZ(2), QQ(1)):
    ok = False
    print("FAIL: 有理点 1 で一辺 1 と 2 の量が一致しない")

print("RESULT: %s" % ("PASS" if ok else "FAIL"))
