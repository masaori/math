# 対象ラベル: claim_prime_vector_integer_division
# 式ペア・判定: 全ての正の繊維対の非零刻みについて全素数係数の整除と有理数冪を照合
# 帰属: 有限集合・ZZ・QQ・素数上の有限台整数ベクトル。実数複素数への脱出なし。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))
accepted = rejected = 0
witness = None
for size, rule, mapping, slope, H, n, fixed, fibers, counts, D in calibration_rows():
    for u in sorted(D):
        for v in sorted(D):
            if u == v:
                continue
            d = ZZ(v-u)
            delta = sub(row_entropy(counts,v),row_entropy(counts,u))
            ratio = QQ(counts[v])/QQ(counts[u])
            assert delta == logarithm(ratio)
            divisible = all(z % d == 0 for z in delta.values())
            # 独立な判定: 既約分子と分母が |d| 乗の自然数であるか。
            magnitude = abs(d)
            root_num, exact_num = ratio.numerator().nth_root(magnitude,truncate_mode=True)
            root_den, exact_den = ratio.denominator().nth_root(magnitude,truncate_mode=True)
            assert divisible == (exact_num and exact_den)
            if divisible:
                result = divide(d,delta)
                assert scale(d,result) == delta
                expected_ratio = QQ(root_num)/QQ(root_den)
                if d < 0:
                    expected_ratio = 1/expected_ratio
                assert reconstruct(result) == expected_ratio
                accepted += 1
            else:
                p,z = next((p,z) for p,z in sorted(delta.items()) if z % d != 0)
                assert not d.divides(z)
                try:
                    divide(d,delta)
                except ValueError as error:
                    assert str(error) == 'integer division outside domain'
                else:
                    raise AssertionError('nondivisible entropy gap accepted')
                rejected += 1
                if witness is None:
                    witness = (size,rule,slope,n,u,v,counts[u],counts[v],p,z,d)
assert accepted > 0 and rejected > 0
print('division accepted:',accepted,'rejected:',rejected)
print('first obstruction (L,rule,slope,n,u,v,Omega_u,Omega_v,p,coefficient,gap):',witness)

print("RESULT: PASS")
