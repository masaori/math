# 対象ラベル: claim_enumerated_ordered_subfield_is_maximal
# 有限標本では初項、延長、制限、取込、有限候補内の極大性を検算する。
sqrt2 = AA(2).sqrt()
sqrt3 = AA(3).sqrt()
coefficients = range(-2, 3)
f0 = {AA(a) + AA(b) * sqrt2 for a in coefficients for b in coefficients}
f1 = {AA(a) + AA(b) * sqrt2 + AA(c) * sqrt3 + AA(d) * sqrt2 * sqrt3
      for a in coefficients for b in coefficients
      for c in coefficients for d in coefficients}
c0 = {z for z in f0 if z > 0}
c1 = {z for z in f1 if z > 0}
assert sqrt2 * sqrt2 == 2
assert f0 <= f1
assert c1 & f0 == c0
assert sqrt3 in f1
for z in f1:
    assert (z in c1) == (z > 0)
print('PASS: 二次体の初項と一段の延長・制限・取込の有限標本')
