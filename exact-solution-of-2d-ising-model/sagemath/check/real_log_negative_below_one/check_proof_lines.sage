# 対象ラベル: real_log_negative_below_one
# 証明の鎖: log y < log 1 = log(exp 0) = 0、と主張 0 < y < 1 ⇒ log y < 0。
# 帰属: exp 0 は本文の部分和で QQ の中で厳密（S_N(0) = 1）。log y の値は RealBallField(512) へ脱出し、有理数の端点を
#   本文の exp のボールで確かめた区間で挟む（real_log_enclosure）。log 1 = 0 は log(exp 0) = 0 から QQ で決まる。
load("../../_shared/positive_coupling_and_real_log.sage")

# exp 0 = 1（scalar_exp_zero）: 本文の 1 行 1 列の行列の部分和 S_N([0]) の成分は、すべての N で 1。
for N in [0, 1, 5, 40]:
    assert entry11(matrix_partial_sum(one_by_one(QQ, QQ(0)), N)) == 1
assert exp_ball(0).contains_exact(1) and exp_ball(0).rad() == 0
# log 1 = log(exp 0) = 0（逆写像）。log 1 は QQ の 0。
log_one = QQ(0)
points = [QQ(1)/10^9, QQ(1)/1000, QQ(1)/3, QQ(1)/2, QQ(9)/10, QQ(999999)/1000000]
for y in points:
    assert 0 < y < 1
    ly = real_log_enclosure(y)
    assert ly < log_one                              # 1 行目 log y < log 1（real_log_strictly_increasing）
    assert ly < 0                                    # 主張
print(f"exp 0 = 1 が厳密に、{len(points)} 点で log y を挟む区間の上端が 0 より小さい")
print("RESULT: PASS")
