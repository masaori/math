# 対象ラベル: arcsin_is_bijection
# ほかの検算が使う arcsin の値の挟み込み（内接折れ線 <= l(AP) <= 外接折れ線）が意味を持つことを確かめる。
# - 辺の数を 8 → 64 → 512 と細分すると、内接折れ線は真に長くなり、外接折れ線は真に短くなる。
# - いつでも内接 <= 外接で、512 辺で幅が 10^-5 未満になる。
# R への脱出: 弧の長さは実数なので RB の区間の端点で比べる。
load("_prelude.sage")

widths = []
for y in Y_NONNEG:
    prev_in, prev_out = None, None
    for n in [8, 64, 512]:
        L_in, L_out = inscribed_length(y, n), circumscribed_length(y, n)
        assert L_in.upper() <= L_out.lower() or (y == 0 and L_in == 0 and L_out == 0)
        if prev_in is not None and y > 0:
            assert L_in.lower() > prev_in.upper() and L_out.upper() < prev_out.lower(), (y, n)
        prev_in, prev_out = L_in, L_out
    w = prev_out.upper() - prev_in.lower()
    assert w < 1e-5, (y, w)
    widths.append(w)

print(f"checked {len(Y_NONNEG)} values of y in [0,1]; largest width at n=512: {max(widths):.3e}")
print("RESULT: PASS")
