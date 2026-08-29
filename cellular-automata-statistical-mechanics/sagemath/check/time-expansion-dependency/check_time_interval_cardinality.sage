# 対象ラベル: def_finite_index_interval
# [0,tau]_NN={t in NN | t<=tau}={0,...,tau} と、その元の個数 tau+1 を検査する。
# 帰属: 非負整数と有限集合の等号だけを使う。R/C 脱出なし。

tested = 0
for tau in range(21):
    by_inequality = {t for t in range(tau + 2) if t <= tau}
    by_enumeration = set(range(tau + 1))
    assert by_inequality == by_enumeration
    assert len(by_inequality) == tau + 1
    tested += 1

print("time intervals checked: {}".format(tested))
print("RESULT: PASS")
