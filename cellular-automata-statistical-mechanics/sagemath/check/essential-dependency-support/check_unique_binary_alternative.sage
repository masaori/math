# 対象ラベル: claim_flip_test_equivalence
# 2 元集合では、ある値と異なる値が入れ替え写像による値に一意に定まることを検査する。
# 帰属: 有限集合 A={0,1} の元の等号だけを使う。ℝ/ℂ 脱出なし。

A = (0, 1)
nu = {0: 1, 1: 0}

for a in A:
    alternatives = tuple(b for b in A if b != a)
    assert alternatives == (nu[a],)
    assert nu[nu[a]] == a

print("checked: A の各元について異なる元は nu(a) のみで、nu は対合")
print("RESULT: PASS")
