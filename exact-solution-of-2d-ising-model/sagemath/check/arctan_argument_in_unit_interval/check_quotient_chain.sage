# 対象ラベル: arctan_argument_in_unit_interval
# |x/s| = |x|/|s| = |x|/s <= s/s = 1
# 具体の点で、隣り合う行の値をそれぞれ別の式から作って厳密に比べる。
#   第一行: 左辺は商 x/s の絶対値、右辺は |x| を |s| で割ったもの（絶対値の商）
#   第二行: s > 0 なので |s| = s
#   第三行: |x| <= s と s > 0 から、|x|/s <= s/s
#   第四行: s/s は割り算が作った時点で 1 に簡約されるので、確かめているのは約分の前提 s != 0 だけである。
# 対照: 分母が負なら割る向きが変わる（|x| <= s を -s で割ると |x|/(-s) >= s/(-s)）。
load("_prelude.sage")

for px in SAMPLE_X:
    ps = s_of(px)
    assert ps != 0 and ps > 0
    assert abs(px / ps) == abs(px) / abs(ps)        # 第一行
    assert abs(ps) == ps                            # 第二行
    assert abs(px) / ps <= ps / ps                  # 第三行
    assert ps / ps == 1                             # 第四行
    assert abs(px) / (-ps) >= ps / (-ps)            # 対照
print(f"|x/s| = |x|/|s| = |x|/s <= s/s = 1 for {len(SAMPLE_X)} points")
print("RESULT: PASS")
