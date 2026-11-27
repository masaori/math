# 対象ラベル: real_product_of_positives_is_positive
# 0 < a かつ 0 < b ならば 0 < a·b を示す証明の各行を確かめる。
# 準備（< の定義 def_real_strict_order の前半・後半と等号の対称律）、順序と乗法の両立 (0 ≤ x ∧ 0 ≤ y) ⇒ 0 ≤ xy、
# real_product_of_nonzero_is_nonzero の a·b ≠ 0、< の定義を右辺から左辺へ当てる結びを、有理数と代数的実数の標本で確かめる。
# 帰属: 有理数 QQ、代数的実数 AA。浮動小数点は使わない。

vals = [QQ(-3), QQ(-1)/2, QQ(0), QQ(2)/7, QQ(1), QQ(5)] + [AA(2).sqrt(), -AA(3).sqrt(), AA(5).sqrt() - 2]
prep = 0; mono = 0; nz = 0; concl = 0; claim = 0
for a in vals:
    for b in vals:
        # 順序と乗法の両立（公理の形）
        if 0 <= a and 0 <= b:
            assert 0 <= a * b; mono += 1
        # real_product_of_nonzero_is_nonzero の形
        if a != 0 and b != 0:
            assert a * b != 0; nz += 1
        if 0 < a and 0 < b:
            # 準備: < の定義から 0 ≤ a・0 ≠ a、対称律の対偶で a ≠ 0（b も同じ）
            assert (0 <= a and 0 != a) and a != 0; prep += 1
            assert (0 <= b and 0 != b) and b != 0; prep += 1
            # 本体: 0 ≤ a·b と 0 ≠ a·b
            assert 0 <= a * b and 0 != a * b; concl += 1
            # 結び: < の定義を右辺から左辺へ
            assert (0 < a * b) == (0 <= a * b and 0 != a * b); claim += 1
            assert 0 < a * b; claim += 1

# 否定コントロール: 仮定のどちらかを外すと主張は偽。≤ の両立だけでは狭義にならない（a = 0）。
neg = 0
assert not (0 < QQ(-1) * QQ(2)); neg += 1
assert not (0 < QQ(0) * QQ(2)); neg += 1
assert (0 <= QQ(0) * QQ(2)) and not (0 != QQ(0) * QQ(2)); neg += 1

print("準備を標本 %d 件、順序と乗法の両立を %d 件、0 でない積を %d 件、本体を %d 件、結びと主張を %d 件で確かめた" % (prep, mono, nz, concl, claim))
print("negative controls (broken lines detected): %d" % neg)
print("RESULT: PASS")
