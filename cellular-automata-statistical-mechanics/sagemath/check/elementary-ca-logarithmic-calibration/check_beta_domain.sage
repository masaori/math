# 対象ラベル: def_binary_ca_unit_logarithmic_difference
# 式ペア・判定: 両端が正の隣接入力の受理と欠落入力の拒否
# 帰属: 有限集合・ZZ・QQ・素数上の有限台整数ベクトル。実数複素数への脱出なし。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))
accepted = rejected = empty_domains = 0
for size, rule, mapping, slope, H, n, fixed, fibers, counts, D in calibration_rows():
    adjacent = {u for u in D if u+1 in D}
    empty_domains += not adjacent
    # これ以外の整数は両端とも正の像に入り得ない。全 Z を走査したとはしない。
    for u in set(H) | {z-1 for z in H}:
        if u in adjacent:
            beta_value = row_beta(counts,u)
            assert reconstruct(beta_value) == QQ(counts[u+1])/QQ(counts[u])
            accepted += 1
        else:
            try:
                row_beta(counts,u)
            except ValueError as error:
                assert str(error) == 'positive rational required'
            else:
                raise AssertionError('missing endpoint accepted')
            rejected += 1
assert accepted > 0 and rejected > 0 and empty_domains > 0
print('adjacent:',accepted,'missing endpoint:',rejected,'empty domains:',empty_domains)

print("RESULT: PASS")
