# SageMath: Fourier 変換と多項式族押し出し・文字引き戻しの整合性の共通定義
# 対象ラベル: theorem_quotient_tower_fourier_pushforward_pullback_compatibility
# 帰属: F_2、Z、ZZ[u,v] と有限集合だけを用いる。

F2 = GF(2)
H_fine = tuple((F2(a), F2(b)) for a in (0, 1) for b in (0, 1))
H_coarse = tuple((F2(a),) for a in (0, 1))


def homology_pushforward(h):
    return (h[0],)


def character(coefficient, h):
    return coefficient[0] * h[0]


coarse_characters = H_coarse


def character_pullback(coefficient, h):
    return character(coefficient, homology_pushforward(h))


def integer_sign(field_value):
    assert field_value in F2
    return ZZ.one() if field_value == F2.zero() else -ZZ.one()


R = PolynomialRing(ZZ, names=("u", "v", "A_00", "A_01", "A_10", "A_11"))
u, v, A_00, A_01, A_10, A_11 = R.gens()
fine_family = {
    (F2(0), F2(0)): A_00,
    (F2(0), F2(1)): A_01,
    (F2(1), F2(0)): A_10,
    (F2(1), F2(1)): A_11,
}


def polynomial_family_pushforward(family):
    return {
        k: sum(
            (family[h] for h in H_fine if homology_pushforward(h) == k),
            R.zero(),
        )
        for k in H_coarse
    }


def fourier_component(index_set, family, evaluate_character):
    return sum(
        (integer_sign(evaluate_character(index)) * family[index] for index in index_set),
        R.zero(),
    )


pushed_family = polynomial_family_pushforward(fine_family)
