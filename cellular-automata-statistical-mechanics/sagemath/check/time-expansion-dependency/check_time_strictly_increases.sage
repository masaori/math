# 対象ラベル: claim_time_strictly_increases
# D_tau の時刻条件 t=s+1 から s<t が従うことを、tau<=20 の全時刻対で検査する。
# 帰属: 非負整数の等号と大小比較だけを使う。R/C 脱出なし。

tested_dependencies = 0
for tau in range(21):
    for s in range(tau + 1):
        for t in range(tau + 1):
            if t == s + 1:
                assert s < t
                tested_dependencies += 1

print("strict time increases checked: {}".format(tested_dependencies))
print("RESULT: PASS")
