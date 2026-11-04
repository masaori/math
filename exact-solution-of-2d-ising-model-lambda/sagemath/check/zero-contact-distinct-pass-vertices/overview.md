# SageMath Check: 接触対が零と通過頂点の相異性

**対象ラベル**: `claim_zero_contact_iff_distinct_pass_vertices`

長さ 1〜5、通過頂点の値が三種類の全 363 列で、添字対の個数が零であることと値の単射性が同値であると検算した。最初と最後の通過頂点だけが一致する列 `(0,1,0)` も接触対を一つ数える。

- 実行: `sage sagemath/check/zero-contact-distinct-pass-vertices/check.sage`
- 状態: PASS（2026-11-04）
- 計算: `ZZ` の有限和と有限列挙だけ。
