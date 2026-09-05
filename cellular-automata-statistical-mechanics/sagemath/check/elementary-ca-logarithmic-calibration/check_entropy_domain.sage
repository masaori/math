# 対象ラベル: def_binary_ca_fiber_logarithmic_entropy
# 式ペア・判定: 有限像上の繊維と素因数指数の復元・零個入力の拒否
# 帰属: 有限集合・ZZ・QQ・素数上の有限台整数ベクトル。実数複素数への脱出なし。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))
checked = nonempty = empty = 0
for size, rule, mapping, slope, H, n, fixed, fibers, counts, D in calibration_rows():
    direct = Counter(H[x] for x in fixed)
    assert D == frozenset(direct)
    assert all(counts[u] == direct[u] for u in counts)
    for u in set(H) | {min(H)-1, max(H)+1}:
        if u in D:
            S = row_entropy(counts,u)
            assert reconstruct(S) == QQ(direct[u])
            assert all(p.is_prime() and z in ZZ for p,z in S.items())
            nonempty += 1
        else:
            try:
                row_entropy(counts,u)
            except ValueError as error:
                assert str(error) == 'positive rational required'
            else:
                raise AssertionError('empty fiber accepted')
            empty += 1
    checked += 1
assert nonempty > 0 and empty > 0
print('inputs:',checked,'positive fibers:',nonempty,'zero fibers:',empty)

print("RESULT: PASS")
