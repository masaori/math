# 対象ラベル: claim_second_limit_candidate_has_tail_cross_power_failure
# 主張の結論の証拠が、小さい閾値について実際に有理数の不等式として得られることを確かめる。
# 閾値 K ごとに L,M >= max{K,1} を満たす二箱の組を取り、有理点 1 以外の標本で交差冪等式が破れることを見る。
load("_prelude.sage")

ok = True

for K in THRESHOLDS:
    bound = max(K, ZZ(1))
    pairs = [(L, M) for (L, M) in AVAILABLE_BOX_PAIRS if L >= bound and M >= bound]
    if len(pairs) == 0:
        ok = False
        print("FAIL: 閾値 K=%s に対して使える二箱の組が無い" % K)
        continue
    for q in OFF_ONE_SAMPLES:
        found = False
        for (L, M) in pairs:
            if not cross_power_identity_holds(L, M, q):
                found = True
                break
        if not found:
            ok = False
            print("FAIL: 閾値 K=%s、有理点 q=%s で交差冪等式の破れが見つからない" % (K, q))

print("RESULT: %s" % ("PASS" if ok else "FAIL"))
