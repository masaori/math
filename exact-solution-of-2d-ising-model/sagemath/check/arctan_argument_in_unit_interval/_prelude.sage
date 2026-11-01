# 対象ラベル: arctan_argument_in_unit_interval
# 共通の準備。二通りの帰属で確かめる。浮動小数点と RR / CC への脱出はない。
#
# (一般の点) x を QQ 上の不定元とする多項式環 QQ[x]。不等式の行（1+x^2 >= 1、x^2 <= 1+x^2）は、
#   差が x^2 や 1 という「非負と分かっている式」に厳密に等しいことで確かめる。
# (具体の点) x を AA（実代数的数）に取る。AA は可算で、平方根・絶対値・四則・等号・大小がすべて厳密に決定できる。
#   s := sqrt(1+x^2) は、定義域 1+x^2 >= 0 を確かめてから AA の平方根で作り、証明が使う性質（s >= 0, s^2 = 1+x^2）を作った値について確かめる。

Px.<x> = PolynomialRing(QQ)

SAMPLE_X = [
    AA(0), AA(1), AA(-1), AA(1)/3, AA(-7)/2, AA(10)^6, -AA(10)^-6,
    AA(2).sqrt(), -AA(5).nth_root(3), AA(3).sqrt() - 2,
]

def s_of(px):
    """証明の s := sqrt(1+x^2)（非負平方根）を AA で作る。
    AA の sqrt は負の数にも例外を出さず QQbar の値を返すので、定義域 1+x^2 >= 0 を先に確かめ、
    値が AA に留まることも確かめる。"""
    assert 1 + px^2 >= 0
    ps = (1 + px^2).sqrt()
    assert ps.parent() is AA
    return ps
