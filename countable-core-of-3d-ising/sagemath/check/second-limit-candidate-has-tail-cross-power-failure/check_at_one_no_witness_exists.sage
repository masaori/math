# 対象ラベル: claim_second_limit_candidate_has_tail_cross_power_failure
# 仮定 q≠1 が落とせないことを確かめる。有理点 1 では同じ二箱の組で交差冪等式が成り立ち、破れの証拠は得られない。
load("_prelude.sage")

ok = True

for (L, M) in AVAILABLE_BOX_PAIRS:
    if not cross_power_identity_holds(L, M, QQ(1)):
        ok = False
        print("FAIL: 有理点 1、二箱 (%s,%s) で交差冪等式が破れてしまう" % (L, M))

print("RESULT: %s" % ("PASS" if ok else "FAIL"))
