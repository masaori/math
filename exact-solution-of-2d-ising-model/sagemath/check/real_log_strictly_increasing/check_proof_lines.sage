# 対象ラベル: real_log_strictly_increasing
# 証明の行: 背理法の二つの場合の鎖
#   (log v < log u の場合) v = exp(log v) < exp(log u) = u、
#   (log v = log u の場合) v = exp(log v) = exp(log u) = u、
# と主張 0 < u < v ⇒ log u < log v。
# 背理法の仮定は具体の点では偽なので、一つめの場合の鎖は、大小を入れ替えた組（仮定を満たす並び）で同じ形の鎖の
# 各行が成り立つこととして確かめる。二つめの場合の中の行 exp(log v) = exp(log u) は等しいものの置換で、計算を含まない。
# exp(log y) = y の行（像のボールが y を含む）は、囲みが exp(lo) < y < exp(hi) を確かめて作られているので構成上かならず成り立つ。
#   定義の書き写しの確認にとどまる。
# 帰属: log の値は RealBallField(512) へ脱出（実対数の値は QQ に収まらない）。本文の log の値は、有理数の端点を
#   本文の exp のボールで確かめた区間で挟む（_shared/positive_coupling_and_real_log.sage の real_log_enclosure）。
load("../../_shared/positive_coupling_and_real_log.sage")

pairs = [(QQ(1)/10^6, QQ(1)/1000), (QQ(1)/3, QQ(1)/2), (QQ(1), QQ(1000001)/1000000), (QQ(2), QQ(3)),
         (QQ(99)/100, QQ(1)), (QQ(1), QQ(7)), (QQ(10)^5, QQ(10)^6), (QQ(1)/7, QQ(13))]
for (u, v) in pairs:
    assert 0 < u < v
    lu = real_log_enclosure(u); lv = real_log_enclosure(v)
    # 主張
    assert lu < lv
    # 一つめの場合の鎖の形: 大小を入れ替えた組 (u', v') = (v, u) では log v' < log u' が成り立つ。
    up, vp = v, u
    lup = real_log_enclosure(up); lvp = real_log_enclosure(vp)
    assert lvp < lup
    evp = exp_ball_of_ball(lvp); eup = exp_ball_of_ball(lup)
    assert evp.contains_exact(vp)            # v' = exp(log v')（本文の exp で log v' を含む区間を写した像が v' を含む）
    assert evp < eup                          # exp(log v') < exp(log u')（real_exp_strictly_increasing の向き）
    assert eup.contains_exact(up)            # exp(log u') = u'
    assert vp < up                            # 鎖の結論 v' < u'（元の組では u < v と両立しない）
    # 二つめの場合の行 v = exp(log v)・exp(log u) = u の根拠 exp(log y) = y を、元の組の点で。
    assert exp_ball_of_ball(lu).contains_exact(u) and exp_ball_of_ball(lv).contains_exact(v)

# exp の狭義単調増加（real_exp_strictly_increasing）を、有理数の点で本文の exp のボールで。
for x0, y0 in [(QQ(-3), QQ(-2)), (QQ(-1)/100, QQ(0)), (QQ(0), QQ(1)/10^6), (QQ(2), QQ(5))]:
    assert exp_ball(x0) < exp_ball(y0)
print(f"{len(pairs)} 組 (u, v) で主張と exp(log y) = y が、入れ替えた組で一つめの場合の鎖の形が成り立つ")
print("RESULT: PASS")
