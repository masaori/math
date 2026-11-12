# 対象ラベル: claim_cut_realization_preserves_multiplication
# 本文の各行を実代数的数（AA）の有限例で厳密に検算する。<_R は AA の順序で代用する。
# 下切断の実数上限・実数内の有理数の稠密性そのものは有限例では検証できず、本文の脱出による。
count = 0
negative = 0
positives = [AA(2).sqrt(), AA(3).sqrt(), AA(5).sqrt() / 3, AA(7).sqrt() / 2, AA(1) / 3,
             AA(3).sqrt() - 1, AA(1) / 1000]

def pinch(x, eta):
    # 有理幅 eta の挟み込み（下側が負になりうる取り方も含める）。
    n = 2 * (ceil(1 / eta) + 1)
    r = QQ(floor(n * x) - 1) / n
    s = QQ(floor(n * x) + 1) / n
    assert AA(r) < x < AA(s) and s - r < eta
    return r, s

# 準備: 正錐の閉性と有理数の順序の反映。
for u in positives:
    for v in positives:
        w = u.sqrt(); z = v.sqrt()
        assert u * v - 0 == (w * w) * (z * z) == (w * z) * (w * z) and w * z != 0
        assert (u + v) - u == v - 0 and u < u + v and 0 < u + v
        count += 4
grid = [QQ(k) / 7 for k in range(-20, 21)]
for t in grid:
    for s in grid:
        if AA(t) < AA(s):
            assert t < s
            count += 1
        else:
            negative += 1

for a in positives:
    for b in positives:
        # 幅 1 の挟み込みの上側 B_a, B_b と K := B_a + B_b > 0。
        _, Ba = pinch(a, QQ(1))
        _, Bb = pinch(b, QQ(1))
        assert 0 < a < AA(Ba) and 0 < b < AA(Bb) and 0 < Ba and 0 < Bb
        K = Ba + Bb
        count += 1
        for k in range(1, 9):
            eta = QQ(1) / (2**k)
            data = []
            for x, B in [(a, Ba), (b, Bb)]:
                r, s = pinch(x, eta)
                if r <= 0:
                    negative += 1
                r1 = max(r, 0); s1 = min(s, B)
                # 取り替えた下側・上側。
                assert AA(r1) < x < AA(s1) and 0 <= r1 and s1 <= B
                assert s1 - r1 <= s - r < eta
                assert 0 < s1 and r1 < s1
                count += 4
                data.append((r1, s1))
            (ra, sa), (rb, sb) = data
            # 積の挟み込みの二つの分解と各項の符号。
            assert a * b - ra * rb == a * (b - rb) + rb * (a - ra)
            assert a * (b - rb) > 0 and rb * (a - ra) >= 0
            assert AA(ra * rb) < a * b
            assert sa * sb - a * b == sa * (sb - b) + b * (sa - a)
            assert sa * (sb - b) > 0 and b * (sa - a) > 0
            assert a * b < AA(sa * sb)
            count += 6
            # 実数での比較の有限の写し（実代数的数の値そのもので代用）。
            assert AA(ra * rb) <= a * b <= AA(sa * sb)
            assert AA(ra) * AA(rb) <= a * b <= AA(sa) * AA(sb)
            count += 2
            # 区間の幅の式変形。
            w0 = sa * sb - ra * rb
            assert w0 == (sa - ra) * sb + ra * (sb - rb)
            assert (sa - ra) * sb + ra * (sb - rb) < eta * sb + ra * (sb - rb)
            assert eta * sb + ra * (sb - rb) <= eta * Bb + ra * eta
            assert eta * Bb + ra * eta <= eta * Bb + Ba * eta
            assert eta * Bb + Ba * eta == eta * K
            count += 5
            # 否定の対照: 上側を B で切らないと幅の評価に B を使えない例。
            if pinch(a, eta)[1] > Ba:
                negative += 1
        # 結論の段: q > 0、eta := q/K で (q/K)K = q。
        for q in [QQ(1) / m for m in range(1, 20)]:
            assert (q / K) * K == q and q / K > 0
            count += 1

# 零と符号の反転、場合分け。
signed = positives + [-x for x in positives] + [AA(0)]
for x in signed:
    for y in signed:
        assert (-x) * y == -(x * y) and x * (-y) == -(x * y)
        assert x + (-x) == 0
        count += 2
        if x != 0 and y != 0:
            x0 = x if x > 0 else -x
            y0 = y if y > 0 else -y
            assert x0 > 0 and y0 > 0 and (x == x0 or x == -x0) and (y == y0 or y == -y0)
            count += 1
        if x < 0:
            assert (-x) - 0 == 0 - x and -x > 0
            count += 1
print('checked', count, 'negative controls', negative)
print('RESULT: PASS')
