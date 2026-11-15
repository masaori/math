# 対象ラベル: abs_basic_properties
# (1) の x = 0, y < 0 の鎖と (6) の x < 0 の鎖で、平方根の中身を一行ずつ確かめる（t は y または x）。
#   t^2 = t·t           （square_of_real_number_is_product、r → t）
#   t·t = (-t)·(-t)     （real_negation_times_negation_is_product、a, b → t を右辺から左辺へ）
#   (-t)·(-t) = (-t)^2  （square_of_real_number_is_product、r → -t を右辺から左辺へ）
# -t を不定元 nt に置き、real_negation_times_negation_is_product を当てる段だけを nt = -t で確かめる。
# 帰属: 多項式環 QQ[t, nt]。浮動小数点は使わない。
R.<t, nt> = QQ[]
n = 0
lines = [t^2, t * t, nt * nt, nt^2]
assert lines[0] == lines[1]; n += 1                       # square_of_real_number_is_product（r → t）
assert lines[1] == lines[2].subs(nt=-t); n += 1           # real_negation_times_negation_is_product（a, b → t）
assert lines[2] == lines[3]; n += 1                       # square_of_real_number_is_product（r → -t）
# 対照: 片方の因子だけ符号を反転した t·(-t) は t·t と一致しない
assert t * t != (t * nt).subs(nt=-t)
# 2 つの鎖（t → y、t → x）は同じ 3 行を t の置き換えで共用する
print("negation-square rows of abs_basic_properties: %d equalities in t, shared by (1) x = 0, y < 0 (t -> y) and (6) x < 0 (t -> x)" % n)
print("negative controls (broken lines detected): 1")
print("RESULT: PASS")
