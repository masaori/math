# 対象ラベル: claim_eventually_constant_only_at_one
# 合成の「末尾定数ならば有理点 1」の向きの、有限標本による裏取り。
# 有理点 1 以外では隣接箱の冪等式が既に最初の組で破れる。冪等式の末尾成立が末尾定数性と
# 同値であることは本文で示してあるので、破れは末尾定数性が成り立たないことの証拠になる。
load("_prelude.sage")

ok = True

for q in OFF_ONE_SAMPLES:
    if cross_power_identity_holds(ZZ(1), q):
        ok = False
        print("FAIL: q=%s で一辺 1 と 2 の冪等式が成り立ってしまう" % q)

# 有理点 1 だけがこの標本の中で冪等式を満たすことも併せて確かめる。
if not cross_power_identity_holds(ZZ(1), QQ(1)):
    ok = False
    print("FAIL: 有理点 1 で一辺 1 と 2 の冪等式が成り立たない")

print("RESULT: %s" % ("PASS" if ok else "FAIL"))
