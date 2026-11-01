# 対象ラベル: arctan_argument_in_unit_interval
# 証明の最初の二つの鎖
#   1+x^2 >= 1 > 0                       （平方根の中身が定義域に入る）
#   s^2 = 1+x^2 > 0 = 0^2                （s ≠ 0、s >= 0 と合わせて s > 0）
# 第一の鎖の第一行は、一般の点で差 (1+x^2) - 1 が x^2 に等しいこと（x^2 >= 0 が根拠）と、具体の点の大小で確かめる。
# 第二の鎖の第一行は非負平方根の定義。具体の点で、作った s が s >= 0 かつ s^2 = 1+x^2 を満たすことを確かめる（自明に近い行）。
# s ≠ 0 の推論が s^2 ≠ 0^2 に依ることは、対照「s = 0 なら s^2 = 0^2」で示す。
load("_prelude.sage")

assert (1 + x^2) - 1 == x^2
for px in SAMPLE_X:
    assert px^2 >= 0 and 1 + px^2 >= 1 and QQ(1) > 0     # 第一の鎖
    ps = s_of(px)                                         # 1+x^2 >= 0 を確かめてから s を作る
    assert ps >= 0 and ps^2 == 1 + px^2                   # 非負平方根の定義
    assert ps^2 > 0 and 0 == AA(0)^2 and ps^2 != AA(0)^2  # 第二の鎖と s^2 ≠ 0^2
    assert ps != 0 and ps > 0                             # s ≠ 0 と s > 0
assert AA(0)^2 == 0                                       # 対照: s = 0 なら s^2 = 0^2
print(f"1+x^2 >= 1 > 0, s >= 0, s^2 = 1+x^2 > 0 = 0^2, s > 0 for {len(SAMPLE_X)} points; (1+x^2) - 1 = x^2 in QQ[x]")
print("RESULT: PASS")
