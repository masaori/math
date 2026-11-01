# 対象ラベル: mat_mult_associative
# 主張 (AB)C = A(BC) を行列全体で比べる。左辺は本文の成分の式で組んだ積、右辺は Sage の行列積（独立な経路）で組む。
# 帰属: QQ 上の多項式環。
load("_prelude.sage")

count = 0
for m in DIMS:
  for n in DIMS:
    for p in DIMS:
      for q in DIMS:
        P, _, (A, B, C) = generic_ring([("a", m, n), ("b", n, p), ("c", p, q)])
        assert body_product(body_product(A, B), C) == A * (B * C)
        assert body_product(A, body_product(B, C)) == (A * B) * C
        count += 1
print(f"checked {count} shapes")
print("RESULT: PASS")
