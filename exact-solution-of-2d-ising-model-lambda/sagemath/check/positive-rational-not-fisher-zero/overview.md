# SageMath Check: 正の有理点は Fisher 零点でない

## 対象

**対象ラベル**: `claim_positive_rational_not_fisher_zero`

- 実行日: 2026-08-14
- 結果: $L=1,2,3$ すべて通過（零点に正の有理数なし、正の有理点 11 個で値は正）
- 帰属: `ZZ[x]`、`QQ`、`QQbar` の厳密計算。浮動小数点を使わない。

## 何を確かめるか

主張 $q\in\mathbb{Q}_{>0}\Rightarrow q\notin\mathcal{F}_L$
（`claim_positive_rational_not_fisher_zero`）について、証明の各段を一段ずつ確かめる。

- 式変形の第 1〜2 行: 係数表示による和 $\sum_m\Omega_L(m)\,q^m$ を `QQbar` の演算で
  計算したものが、`QQ` での代入値 $Z_L(q)$ と同じ元であること
  （$\mathbb{Q}$ が $\overline{\mathbb{Q}}$ の部分体であることの検査）
- 第 3 行: $Z_L(q)\in\mathbb{Q}_{>0}$、したがって `QQbar` の零元と等しくないこと
- 結論: $Z_L$ の `QQbar` におけるすべての根について、それが正の有理数でないこと
  （実部が有理数の実根はすべて $\le0$ であることを厳密比較で確かめる）

検査点は $q\in\{1/2,\,1/3,\,2/5,\,3/7,\,9/10,\,1/40,\,1,\,3/2,\,2,\,5,\,41/40\}\subset\mathbb{Q}_{>0}$
（1 未満・1・1 超えを含む）。`QQ`・`QQbar` の等号・順序比較は厳密であり、数値近似を経由しない。

## 実行方法

```sh
sage check.sage
```
