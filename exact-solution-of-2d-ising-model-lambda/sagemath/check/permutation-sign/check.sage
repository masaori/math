# 対象ラベル: def_row_permutation / def_inversion_count / def_permutation_sign
#             claim_permutation_sign_mul
#
# 本文（structured-latex/content/main-text.ts）の章「固有値の代数性」の
#   定義   行配位の置換、転倒数、そして符号（S_L, P_L, inv, sgn）
#   主張   符号は合成について乗法的である
# を、小さい L で総当たりに確かめる。
#
# 確かめること。
#   1. sgn(phi ∘ psi) = sgn(phi) * sgn(psi)。
#   2. 本文の符号が、順序 ≺ の取り方に依存しないこと。
#      具体的には、行配位を列挙順で番号付けて得られる置換について SageMath 自身が
#      計算する符号（Permutation(...).signature()）と一致することを確かめる。
#      本文の inv は順序 ≺ についての転倒数なので、この 2 つは作り方が独立である
#      （一致は「符号が順序の取り方によらない」という空でない主張の裏取りになる）。
#   3. 証明が使う準備（psi が定める P_L の全単射 Psi と、各対について A, B, C に
#      属するものの個数が偶数であること）を、対ごとに直接確かめる。
#
# 走らせる範囲（打ち切りを隠さない）。
#   L = 1: 置換 2 個。全て・全対を走る。
#   L = 2: 置換 24 個。全て・全対（576 通り）を走る。
#   L = 3: 置換 40320 個。2 は全ての置換について走る。
#          1 と 3 は全対が 1.6 * 10^9 通りになるので、列挙順の先頭 60 個の置換から作る
#          3600 通りに限る（標本であることを結果にも書く）。
#
# 厳密計算のみ（ZZ）。浮動小数点は使わない。
# 本文がこの章で R へ脱出していないので、検証側にも脱出を持ち込まない。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '..', '..', '_shared', 'defs.sage'))

def check_sign_multiplicative(L, perms, pairs):
    """claim_permutation_sign_mul: sgn(phi ∘ psi) = sgn(phi) * sgn(psi)。"""
    signs = {id(phi): permutation_sign(L, phi, pairs) for phi in perms}
    for phi in perms:
        for psi in perms:
            composed = compose_row_permutations(L, phi, psi)
            assert (
                permutation_sign(L, composed, pairs) == signs[id(phi)] * signs[id(psi)]
            ), (L, phi, psi)


def check_sign_independent_of_order(L, perms, pairs):
    """本文の符号が、SageMath が独立に計算する符号と一致すること。

    行配位を列挙順で 1, ..., 2^L と番号付け、phi をその番号の置換として書き直して
    SageMath の signature() に渡す。本文の inv は順序 ≺ についての転倒数なので、
    番号の付け方（列挙順）とは独立である。
    """
    configs = list(row_configurations(L))
    position = {row_config_key(L, tau): n + 1 for n, tau in enumerate(configs)}
    for phi in perms:
        as_list = [
            position[row_config_key(L, apply_row_permutation(L, phi, tau))]
            for tau in configs
        ]
        assert permutation_sign(L, phi, pairs) == ZZ(Permutation(as_list).signature()), (
            L, as_list
        )


def check_proof_preparations(L, perms, pairs):
    """証明の準備: Psi が P_L の全単射であることと、各対で A, B, C の個数が偶数であること。"""
    pair_keys = set((row_config_key(L, a), row_config_key(L, b)) for (a, b) in pairs)
    for psi in perms:
        # Psi: P_L -> P_L。像が P_L に入り、単射であること（有限集合なので全単射）。
        images = set()
        for (tau, tau_other) in pairs:
            image = psi_image(L, psi, tau, tau_other)
            key = (row_config_key(L, image[0]), row_config_key(L, image[1]))
            assert key in pair_keys, (L, key)
            images.add(key)
        assert len(images) == len(pairs), (L, len(images), len(pairs))
    for phi in perms:
        for psi in perms:
            composed = compose_row_permutations(L, phi, psi)
            for (tau, tau_other) in pairs:
                in_a = row_config_less(
                    L,
                    apply_row_permutation(L, composed, tau_other),
                    apply_row_permutation(L, composed, tau),
                )
                in_b = row_config_less(
                    L,
                    apply_row_permutation(L, psi, tau_other),
                    apply_row_permutation(L, psi, tau),
                )
                image = psi_image(L, psi, tau, tau_other)
                in_c = row_config_less(
                    L,
                    apply_row_permutation(L, phi, image[1]),
                    apply_row_permutation(L, phi, image[0]),
                )
                assert sum(1 for t in (in_a, in_b, in_c) if t) % 2 == 0, (
                    L, in_a, in_b, in_c
                )


def psi_image(L, psi, tau, tau_other):
    """証明の準備の写像 Psi。psi の像を ≺ について並べ直した対を返す。"""
    a = apply_row_permutation(L, psi, tau)
    b = apply_row_permutation(L, psi, tau_other)
    if row_config_less(L, a, b):
        return (a, b)
    assert row_config_less(L, b, a), (L, tau, tau_other)
    return (b, a)


def run(L, multiplicative_sample=None):
    pairs = ordered_pairs(L)
    perms = list(row_permutations(L))
    check_sign_independent_of_order(L, perms, pairs)
    if multiplicative_sample is None:
        sample = perms
        note = "全 %d 個" % len(perms)
    else:
        sample = perms[:multiplicative_sample]
        note = "列挙順の先頭 %d 個（標本。全 %d 個)" % (len(sample), len(perms))
    check_sign_multiplicative(L, sample, pairs)
    check_proof_preparations(L, sample, pairs)
    print(
        "L = %d: 置換 %d 個・順序対 %d 個。SageMath の符号との一致を"
        "全ての置換で確認。乗法性と証明の準備は %s の対で確認" % (
            L, len(perms), len(pairs), note
        )
    )


run(1)
run(2)
run(3, multiplicative_sample=60)
print("すべてのアサーションが成立した（L = 1, 2, 3。厳密計算のみ）")
