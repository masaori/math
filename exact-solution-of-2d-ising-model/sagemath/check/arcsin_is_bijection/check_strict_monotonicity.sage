# 対象ラベル: arcsin_is_bijection
# 証明の「狭義単調増加」の段落（三つの場合）と、その前提の f の狭義単調増加を具体の y の組で確かめる。
#
# (厳密, AA) 0 <= y1 < y2 <= 1 について、P1 := point_P(y1), P2 := point_P(y2) が A から見て
#   P1, P2 の順に第一象限の弧の上に並ぶ（x 座標は減り y 座標は増える）。外部文献の命題（f の狭義単調増加）が
#   扱う並びがこれである。
# (R への脱出, RB) 全ての y で arcsin(y) を arcsin_enclosure で挟み、隣り合う y の区間が交わらず増える順に並ぶ。
#   負の側は定義の第二の式で作るので、証明の三つの場合（0 <= y1、y1 < 0 <= y2、y1 < y2 < 0）を全て含む。
load("_prelude.sage")

pairs = 0
for i in range(len(Y_NONNEG)):
    for j in range(i + 1, len(Y_NONNEG)):
        P1, P2 = point_P(Y_NONNEG[i]), point_P(Y_NONNEG[j])
        assert P1[0] > P2[0] and P1[1] < P2[1]
        pairs += 1

enc = [arcsin_enclosure(y) for y in Y_ALL]
cases = {"0<=y1": 0, "y1<0<=y2": 0, "y1<y2<0": 0}
for k in range(len(Y_ALL) - 1):
    y1, y2 = Y_ALL[k], Y_ALL[k + 1]
    assert enc[k][1] < enc[k + 1][0], (y1, y2)
    cases["0<=y1" if y1 >= 0 else ("y1<0<=y2" if y2 >= 0 else "y1<y2<0")] += 1

print(f"checked {pairs} ordered pairs exactly and {len(enc)} enclosures in increasing order {cases}")
print("RESULT: PASS")
