# 対象ラベル: claim_qbar_poly_extracted_root_distinct

R.<t> = PolynomialRing(QQbar)


def root_polynomial(n):
    return t^n + QQbar(-1)


def main():
    for n in [1, 2, 3, 5]:
        roots = [r for (r, m) in root_polynomial(n).roots(QQbar)]
        assert len(roots) == n
        for w in roots:
            f = root_polynomial(n)
            h = f // (t - w)
            assert f == (t - w) * h

            print(f"n={n}, w={w}: 仮定（係数の上界・分解）を確かめる")
            for k in range(h.degree() + 1, n + 2):
                if k > n:
                    assert h[k] == 0
            print("   通過")

            print(f"n={n}, w={w}: 鎖の各段と結論 w'≠w を確かめる")
            others = [r for r in roots if r != w]
            # h = A*g の分解を、残りの根の分け方を変えて複数試す
            for split in range(len(others) + 1):
                A = prod((t - r) for r in others[:split]) if split > 0 else R.one()
                g = h // A
                assert h == A * g                          # 本主張の仮定 h = Ag
                # 第 2 段: 評価は積を保つ
                assert h(w) == A(w) * g(w)
                # 一方の非零性（claim_root_polynomial_remaining_factor_value_ne_zero の再現）
                assert h(w) != 0
                # g の各根 w' について、aev_{w'}(g) = 0 かつ w' ≠ w
                for (wp, m) in g.roots(QQbar):
                    assert g(wp) == 0                      # 本主張の仮定
                    # 背理法の帰結: もし w' = w なら h(w) = A(w)*g(w) = A(w)*0 = 0 となり
                    # h(w) ≠ 0 と矛盾するので、w' ≠ w でなければならない
                    assert wp != w
            print("   通過")
    print("すべて通過")


main()
