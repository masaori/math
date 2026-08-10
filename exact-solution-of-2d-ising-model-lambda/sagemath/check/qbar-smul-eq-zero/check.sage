# 対象ラベル: claim_qbar_smul_eq_zero
#   併せて引く定義: def_algebraic_numbers, def_qbar_vector, def_qbar_vector_smul,
#                   def_qbar_zero_vector, def_row_configuration
#
# 本文（structured-latex/content/main-text.ts の章「固有値の代数性」）の主張
# 「零でない列ベクトルのスカラー倍が零ベクトルならば、スカラーは 0 である」
# （z ⊙ v = o_L かつ v != o_L ならば z = 0）を、小さい L で確かめる。
#
# 計算はすべて厳密に行う（浮動小数点は使わない）。代数的数の全体 Qbar は SageMath の
# QQbar（厳密な代数的数の体）で表す。列ベクトルは R_L から QQbar への写像であり、
# ここでは行配位（長さ L の +1/-1 の並び）をキーとする辞書で表す。
#
# 何を確かめるか（人手証明の段に 1 対 1 で対応させる）:
#   1. 添字集合。行配位の全体 R_L が 2^L 個の元をもつこと。
#   2. 準備の段。v != o_L ならば v(tau_1) != o_L(tau_1) = 0 を満たす tau_1 が取れること。
#   3. 第 1 の鎖の 3 段。z*v(tau_1) = (z ⊙ v)(tau_1) = o_L(tau_1) = 0。
#   4. 第 2 の鎖の 5 段。1 を掛ける → 逆元を差し込む → 結合則 → 第 1 の鎖の結果を代入
#      → 零元との積、で z = 0 が出ること。
#   5. 主張そのもの。z ⊙ v = o_L かつ v != o_L ならば z = 0 であること。
#   6. 仮定 v != o_L が外せないこと。v = o_L のときは z != 0 でも z ⊙ v = o_L になること。
#   7. 主張が空虚でないこと。z != 0 かつ v != o_L のとき z ⊙ v != o_L であること
#      （すなわち仮定 z ⊙ v = o_L を満たす組が z = 0 の場合に限られていること）。

Ls = [1, 2, 3]

# 代入に使う代数的数（0 を含むものと含まないもの）。定数・有理数・無理数・虚数を混ぜる。
scalars_nonzero = [QQbar(2), QQbar(-1) / QQbar(3), QQbar(2).sqrt(), QQbar(-1).sqrt()]
scalars = [QQbar(0)] + scalars_nonzero


def row_configs(L):
    """行配位の全体 R_L（長さ L の +1/-1 の並び）を、実行のたび同じ順序で返す。"""
    out = []
    for mask in range(2 ** L):
        out.append(tuple(1 if (mask >> y) & 1 == 0 else -1 for y in range(L)))
    return out


def zero_vector(L):
    """零ベクトル o_L。"""
    return {tau: QQbar(0) for tau in row_configs(L)}


def smul(L, z, v):
    """スカラー倍 z ⊙ v（各点での積）。"""
    return {tau: z * v[tau] for tau in row_configs(L)}


def sample_vectors(L):
    """検証に使う列ベクトルの族。零ベクトルと、零でないものを添字の順番から作る。"""
    taus = row_configs(L)
    out = [zero_vector(L)]
    # 1 か所だけ零でないもの（各点を 1 度ずつ試す）。
    for k, tau0 in enumerate(taus):
        v = {tau: QQbar(0) for tau in taus}
        v[tau0] = scalars_nonzero[k % len(scalars_nonzero)]
        out.append(v)
    # 全成分が零でないもの。
    out.append({tau: scalars_nonzero[k % len(scalars_nonzero)]
                for k, tau in enumerate(taus)})
    # 一部が零のもの。
    out.append({tau: (QQbar(0) if k % 2 == 0 else scalars_nonzero[k % len(scalars_nonzero)])
                for k, tau in enumerate(taus)})
    return out


print("== 零でない列ベクトルのスカラー倍が零ベクトルならばスカラーは 0 ==")

for L in Ls:
    taus = row_configs(L)
    o = zero_vector(L)

    # ---- 1. 添字集合 --------------------------------------------------------
    assert len(taus) == 2 ** L, "R_L の元の個数が 2^L でない"
    assert len(set(taus)) == 2 ** L, "R_L に重複がある"

    count_prep = 0
    count_chain1 = 0
    count_chain2 = 0
    count_claim = 0
    count_nonvacuous = 0

    for v in sample_vectors(L):
        is_zero_vector = all(v[tau] == QQbar(0) for tau in taus)

        # ---- 2. 準備の段 ----------------------------------------------------
        if not is_zero_vector:
            candidates = [tau for tau in taus if v[tau] != o[tau]]
            assert len(candidates) >= 1, "v != o_L なのに値の異なる点が取れない"
            tau1 = candidates[0]
            assert o[tau1] == QQbar(0), "零ベクトルの値が 0 でない"
            assert v[tau1] != QQbar(0), "取った点で v の値が 0 になっている"
            count_prep += 1

        for z in scalars:
            zv = smul(L, z, v)
            smul_is_zero = all(zv[tau] == QQbar(0) for tau in taus)

            # ---- 6. 仮定 v != o_L が外せないこと ---------------------------
            if is_zero_vector:
                assert smul_is_zero, "零ベクトルのスカラー倍が零ベクトルでない"
                continue

            tau1 = [tau for tau in taus if v[tau] != o[tau]][0]

            if smul_is_zero:
                # ---- 3. 第 1 の鎖の 3 段 -----------------------------------
                lhs = z * v[tau1]
                assert lhs == zv[tau1], "第 1 の鎖の第 1 段（スカラー倍の定義）が破れた"
                assert zv[tau1] == o[tau1], "第 1 の鎖の第 2 段（仮定の代入）が破れた"
                assert o[tau1] == QQbar(0), "第 1 の鎖の第 3 段（零ベクトルの定義）が破れた"
                assert lhs == QQbar(0), "z * v(tau_1) = 0 が出ていない"
                count_chain1 += 1

                # ---- 4. 第 2 の鎖の 5 段 -----------------------------------
                inv = v[tau1] ** (-1)
                s1 = z * QQbar(1)
                s2 = z * (v[tau1] * inv)
                s3 = (z * v[tau1]) * inv
                s4 = QQbar(0) * inv
                assert z == s1, "第 2 の鎖の第 1 段（1 は積の単位元）が破れた"
                assert s1 == s2, "第 2 の鎖の第 2 段（逆元の差し込み）が破れた"
                assert s2 == s3, "第 2 の鎖の第 3 段（積の結合則）が破れた"
                assert s3 == s4, "第 2 の鎖の第 4 段（z * v(tau_1) = 0 の代入）が破れた"
                assert s4 == QQbar(0), "第 2 の鎖の第 5 段（零元との積）が破れた"
                count_chain2 += 1

                # ---- 5. 主張そのもの ---------------------------------------
                assert z == QQbar(0), "主張が破れた（z != 0 なのに z ⊙ v = o_L）"
                count_claim += 1
            else:
                # ---- 7. 主張が空虚でないこと -------------------------------
                assert z != QQbar(0), "z = 0 なのに z ⊙ v が零ベクトルでない"
                count_nonvacuous += 1

    print(
        "L=%d: R_L は %d 元。値の異なる点が取れた組 %d 件、"
        "第 1 の鎖 %d 件・第 2 の鎖 %d 件・主張 %d 件が成立し、"
        "z != 0 かつ v != o_L で z ⊙ v != o_L になる組が %d 件あった"
        % (L, len(taus), count_prep, count_chain1, count_chain2, count_claim,
           count_nonvacuous)
    )

print("すべて通過")
