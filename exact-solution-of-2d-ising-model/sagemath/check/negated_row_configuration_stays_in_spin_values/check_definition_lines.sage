# 対象ラベル: def_negated_row_configuration
# 定義の中の場合分け: s(m) = 1 のとき -s(m) = -1、s(m) = -1 のとき -s(m) = -(-1) = 1（real_double_negation, a -> 1）。
# どちらの場合も -s(m) は {-1, 1} に入り、-s は M_col 個の成分が {-1, 1} の写像になることを、
# M_col = 1..6 の全ての行配位 s で確かめる。
# 帰属: 整数 ZZ（{-1,1} の元と符号反転は ZZ の中で閉じて計算できる。本文の所属は R だが、
# 1 と -1 とその符号反転は ZZ の部分で厳密に表せるので、浮動小数点を使わない）。
import itertools

SPIN = [ZZ(-1), ZZ(1)]

# 一つ目の場合: s(m) = 1 の代入
assert -ZZ(1) == ZZ(-1)
# 二つ目の場合: s(m) = -1 の代入と real_double_negation (a -> 1)
assert -(ZZ(-1)) == -(-ZZ(1))
assert -(-ZZ(1)) == ZZ(1)
# real_double_negation の一般形を多項式環で
R.<a> = ZZ[]
assert -(-a) == a

count = 0
for M in range(1, 7):
    for s in itertools.product(SPIN, repeat=M):
        neg = tuple(-v for v in s)
        assert all(v in SPIN for v in neg)
        # -(-s) = s（negated_row_configuration_is_involutive と整合）
        assert tuple(-v for v in neg) == s
        count += 1
print("場合分けの等号 3 個と real_double_negation の一般形を確かめた")
print("M_col = 1..6 の行配位 %d 件で -s の全成分が {-1, 1} に入った" % count)

# 否定コントロール: 符号反転を恒等写像と取り違えても {-1,1} には入るが、二つ目の場合の 1 にならない
neg_controls = 0
if ZZ(-1) != ZZ(1):
    neg_controls += 1
# 符号反転を 2 倍と取り違えると {-1,1} から出る
if not all((2 * v) in SPIN for v in SPIN):
    neg_controls += 1
assert neg_controls == 2
print("negative controls (broken lines detected): %d" % neg_controls)
print("RESULT: PASS")
