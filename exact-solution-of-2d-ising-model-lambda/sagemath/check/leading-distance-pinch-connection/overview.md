# SageMath Check: 先頭距離の詰め寄りは詰め寄りの述語を導く

**対象ラベル**: `claim_leading_distance_pinching_implies_predicate`

- 式変形の恒等式の段（`4η−((α−q)²+β²)` の二段の並べ替え）を `QQ` 係数多項式環で記号的に検査する。
- `R` のモデルを `AA` に取り、`L=2` の実際の Fisher 零点と `ε ∈ {3, 2, 3/2}`（仮定
  `d₁(2) < η = ε²/4` が実際に成り立つ標本）について、η の取り方・有理近似 `q` の構成・
  証人の平方 `c₁², c₂², g², z₁², z₂², z₃²` の正値性・鎖の最終等式
  `ε²−dsq(ξ,q)=z₃²` と `dsq(ξ,q)<ε²` を厳密に検査する。

`QQ`・`QQbar`・`AA` だけを使い、浮動小数点は使わない。

```sh
sage sagemath/check/leading-distance-pinch-connection/check.sage
```

**2026-08-18 実行: すべて通過。**
