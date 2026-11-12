# 対象ラベル: claim_cut_realization_preserves_addition
# 本文の各行を実代数的数（AA）の有限例で厳密に検算する。<_R は AA の順序で代用する。
# 下切断の実数上限・実数内の有理数の稠密性そのものは有限例では検証できず、本文の脱出による。
count = 0
negative = 0
examples = [
    (AA(2).sqrt(), -AA(3).sqrt()),
    (AA(5).sqrt(), AA(7).sqrt()),
    (AA(-3)/2, AA(4)/3),
    (AA(3).sqrt() - 1, AA(1)/3),
]
grid = [QQ(k) / 12 for k in range(-60, 61)]

def lower_cut_close(x, r, s):
    # 切断の挟み込みの有限の写し: r <_R x <_R s のとき、下切断の元 t（格子上）について
    # t <_R s（推移律）、t < s（s < t・s = t は三分法の排他性に反する）、ι(t) ≤ ι(s)。
    global count, negative
    for t in grid:
        if AA(t) < x:
            assert AA(t) < AA(s)
            assert not (s < t) and s != t and t < s
            count += 2
        else:
            negative += 1
    # r ∈ C_x。
    assert AA(r) < x
    count += 1

for a, b in examples:
    for k in range(1, 9):
        epsilon = QQ(1) / (2**k)
        n = 2**(k + 2)
        ra = QQ(floor(n*a) - 1) / n
        sa = QQ(floor(n*a) + 1) / n
        rb = QQ(floor(n*b) - 1) / n
        sb = QQ(floor(n*b) + 1) / n
        # 挟み込みの結論。
        assert AA(ra) < a < AA(sa) and AA(rb) < b < AA(sb)
        assert 0 < sa - ra < epsilon and 0 < sb - rb < epsilon
        count += 2
        # 加法移送: (v+w)-(u+w) = v-u、(w+v)-(w+u) = v-u。
        assert (a + rb) - (ra + rb) == a - AA(ra)
        assert (a + b) - (a + rb) == b - AA(rb)
        assert (a + sb) - (a + b) == AA(sb) - b
        assert (sa + sb) - (a + sb) == AA(sa) - a
        count += 4
        # 各段の狭義順序と推移律。
        assert AA(ra + rb) < a + rb < a + b
        assert a + b < a + sb < AA(sa + sb)
        assert AA(ra + rb) < a + b < AA(sa + sb)
        count += 3
        # 有理数の和と R の和の一致。
        assert AA(ra + rb) == AA(ra) + AA(rb) and AA(sa + sb) == AA(sa) + AA(sb)
        count += 1
        # 切断の挟み込みを a, b, a+b に当てる。
        lower_cut_close(a, ra, sa)
        lower_cut_close(b, rb, sb)
        lower_cut_close(a + b, ra + rb, sa + sb)
        # B - A = (s_a - r_a) + (s_b - r_b) < 2ε。
        assert (sa + sb) - (ra + rb) == (sa - ra) + (sb - rb)
        assert (sa + sb) - (ra + rb) < 2 * epsilon
        count += 2
        # 区間 [A, B] に二つの値（ここでは実代数的数の値そのもの）が入る。
        A = AA(ra + rb); B = AA(sa + sb)
        assert A <= a + b <= B
        count += 1
        # 否定の対照: 幅を ε で取ると 2ε ではなく ε を超える例がある（2 倍は省けない）。
        if (sa + sb) - (ra + rb) >= epsilon:
            negative += 1
    # 結論の段: d > 0 なら 0 < q < d の有理数 q を取り、ε := q/2 で 2·(q/2) = q。
    for q in [QQ(1)/m for m in range(1, 30)]:
        assert 2 * (q / 2) == q and q / 2 > 0
        count += 1
print('checked', count, 'negative controls', negative)
print('RESULT: PASS')
