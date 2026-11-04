# 対象ラベル: real_inclusion_preserves_sum_over_binary_words（Σ_{ε∈{0,1}^r} (x_ε)_C = (Σ_{ε∈{0,1}^r} x_ε)_C）
# 証明の各行:
#   r = 1:   Σ_{ε∈{0,1}^1} (x_ε)_C = (x_(1))_C + (x_(0))_C              (def_sum_over_binary_words_of_complex_numbers)
#                                  = (x_(1) + x_(0))_C                  (real_inclusion_preserves_sum)
#                                  = (Σ_{ε∈{0,1}^1} x_ε)_C              (def_sum_over_binary_words_of_real_numbers を右辺から左辺へ)
#   r → r+1: Σ_{ε∈{0,1}^{r+1}} (x_ε)_C = Σ_{ε'} ((x_(ε',1))_C + (x_(ε',0))_C)   (def_sum_over_binary_words_of_complex_numbers)
#                                  = Σ_{ε'} (x_(ε',1) + x_(ε',0))_C     (real_inclusion_preserves_sum を各項へ)
#                                  = (Σ_{ε'} (x_(ε',1) + x_(ε',0)))_C   (帰納法の仮定)
#                                  = (Σ_{ε∈{0,1}^{r+1}} x_ε)_C          (def_sum_over_binary_words_of_real_numbers を右辺から左辺へ)
# {0,1}^r の元は長さ r のタプル、(ε', e) は ε' の末尾に e を付けたタプルで表す。
# ℂ は definition_of_cc どおり実数の対で持ち（_shared/complex_as_real_pairs.sage）、ℂ の和と ℝ の和は
# どちらも定義の帰納法どおりに（最後の成分で 1 を 0 より先に）足す別々の関数で組む。
# 帰属: x_ε は QQ 上の多項式環の不定元（厳密計算）。不定元で成り立つ多項式の等号は、実数を代入しても成り立つ。浮動小数点はない。
load("../../_shared/complex_as_real_pairs.sage")
import itertools


def words(r):
    return [tuple(w) for w in itertools.product([1, 0], repeat=r)]


def complex_sum(r, z):
    """def_sum_over_binary_words_of_complex_numbers（和は cc_add）。"""
    if r == 1:
        return cc_add(z((1,)), z((0,)))
    return complex_sum(r - 1, lambda ep: cc_add(z(ep + (1,)), z(ep + (0,))))


def real_sum(r, x):
    """def_sum_over_binary_words_of_real_numbers。"""
    if r == 1:
        return x((1,)) + x((0,))
    return real_sum(r - 1, lambda ep: x(ep + (1,)) + x(ep + (0,)))


MAX_R = 5
count = 0
neg = 0
for r in range(1, MAX_R + 1):
    ws = words(r)
    P = PolynomialRing(QQ, [f"x_{''.join(map(str, w))}" for w in ws])
    xv = dict(zip(ws, P.gens()))
    x = lambda w: xv[w]
    if r == 1:
        lines = [
            complex_sum(1, lambda w: iota(x(w), P)),
            cc_add(iota(x((1,)), P), iota(x((0,)), P)),
            iota(x((1,)) + x((0,)), P),
            iota(real_sum(1, x), P),
        ]
    else:
        # 帰納法の仮定（r - 1 の族 ε' ↦ x_(ε',1) + x_(ε',0) で成り立つこと）をまず確かめる
        xp = lambda ep: x(ep + (1,)) + x(ep + (0,))
        assert complex_sum(r - 1, lambda ep: iota(xp(ep), P)) == iota(real_sum(r - 1, xp), P)
        # 否定コントロール: 帰納法の仮定の行の族を x_(ε',1) + x_(ε',1) に替えると、次の行と一致しない
        bad = lambda ep: x(ep + (1,)) + x(ep + (1,))
        assert iota(real_sum(r - 1, bad), P) != iota(real_sum(r, x), P)
        neg += 1
        lines = [
            complex_sum(r, lambda w: iota(x(w), P)),
            complex_sum(r - 1, lambda ep: cc_add(iota(x(ep + (1,)), P), iota(x(ep + (0,)), P))),
            complex_sum(r - 1, lambda ep: iota(xp(ep), P)),
            iota(real_sum(r - 1, xp), P),
            iota(real_sum(r, x), P),
        ]
    for t in range(len(lines) - 1):
        assert lines[t] == lines[t + 1], (r, t)
        count += 1
    # 比べる側: Sage の sum と一致する
    assert lines[-1] == (sum(P.gens()), P(0))
    # 否定コントロール: 項を一つ落とすと一致しない
    assert real_sum(r, lambda w: 0 if w == ws[0] else x(w)) != real_sum(r, x)
    neg += 1
    print(f"r = {r}: 隣り合う行の等号を不定元で確かめた")
print(f"checked {count} lines")
print(f"negative controls: {neg}")
print("RESULT: PASS")
