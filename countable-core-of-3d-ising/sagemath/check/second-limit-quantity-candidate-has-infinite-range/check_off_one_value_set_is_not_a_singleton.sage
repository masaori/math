# 対象ラベル: claim_second_limit_quantity_candidate_has_infinite_range
# 主張の結論「値の集合は無限集合」の必要条件を有限標本で確かめる。
# 有理点 1 以外の標本では、一辺 1 と 2 の量が既に相異なるので値の集合は一点ではない。
# すなわち、対偶で仮定される「値の集合が有限（とくに一点）」という形は、これらの点では
# 少なくとも一点集合としては成り立たない。値の一致は交差冪の有理数等式で判定する（根を作らない）。
load("_prelude.sage")

ok = True

for q in OFF_ONE_SAMPLES:
    if finite_box_values_agree(ZZ(1), ZZ(2), q):
        ok = False
        print("FAIL: q=%s で一辺 1 と 2 の量が一致してしまい、値の集合が一点でありうる" % q)

print("RESULT: %s" % ("PASS" if ok else "FAIL"))
