# 対象ラベル: real_half_plus_half_is_original
# b/2 + b/2 = 2*(b/2) = b の 2 行の鎖を、b を不定元とする QQ[b_] で厳密に確かめる。
R.<b_> = PolynomialRing(QQ)
half = b_ / 2
rows = [half + half, 2 * half, b_]
assert all(a == c for a, c in zip(rows, rows[1:]))
# 各行が引く主張の当てはめ: a + a = 2a（a -> b/2）、2*(b/2) = b
assert half + half == 2 * half and 2 * half == b_
# 否定の対照: 2 で割らずに足すと b にならない。片方だけ半分にしても b にならない
assert b_ + b_ != b_ and half + b_ != b_
print("real_half_plus_half_is_original: 等号 2 行（厳密）")
print("negative controls (broken lines detected): 2")
print("RESULT: PASS")
