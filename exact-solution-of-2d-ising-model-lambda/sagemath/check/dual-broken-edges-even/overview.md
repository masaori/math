# SageMath Check: 破れた辺の双対像の偶次数性

## 対象

**対象ラベル**: `claim_dual_broken_edges_even`

- 併せて検証: `def_broken_edge_set`、`def_edge_subset_incidence_count`、`def_even_edge_subset`、`def_dual_edge_map`
- 範囲: 各配位の破れた辺集合を双対辺写像で送った像が、すべての双対頂点で偶数本の端点を持つこと

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
|---|---|---|---|
| `check_edge_sign.sage` | 破れ指示子の冪と辺の両端のスピン積 | PASS | 9,348 配位・辺の組 |
| `check_incidence_definition.sage` | 端点数の定義を二つの端点を数える和へ開く | PASS | 4,674 配位・頂点の組 |
| `check_endpoint_incidence.sage` | 端点条件の和を四つの双対辺指示子へ書き換える | PASS | 4,674 配位・頂点の組 |
| `check_dual_preimages.sage` | 四つの双対辺指示子を各辺の唯一の原像へ書き換える | PASS | 4,674 配位・頂点の組 |
| `check_boundary_order.sage` | 原像の指示子の加法の順を入れ替える | PASS | 4,674 配位・頂点の組 |
| `check_degree_substitution.sage` | 端点数の等式を符号の指数へ代入する | PASS | 4,674 配位・頂点の組 |
| `check_power_addition.sage` | 和の冪を四つの冪の積へ分ける | PASS | 4,674 配位・頂点の組 |
| `check_edge_products.sage` | 各冪を辺の両端のスピン積へ代入する | PASS | 4,674 配位・頂点の組 |
| `check_endpoint_products.sage` | 各辺の端点を四つのスピン値へ代入する | PASS | 4,674 配位・頂点の組 |
| `check_square_regrouping.sage` | 八因子を四つの平方へ並べ替える | PASS | 4,674 配位・頂点の組 |
| `check_spin_squares.sage` | 四つの平方をそれぞれ一へ置換する | PASS | 4,674 配位・頂点の組 |
| `check_unit_product.sage` | 一を四つ掛けた値は一 | PASS | 1 等式 |
| `check_even_count.sage` | 符号が一である端点数に自然数の半分を与える | PASS | 4,674 配位・頂点の組 |
| `check.sage` | $L=1,2,3$ の全配位について、双対頂点の端点数と対応する格子面境界の破れ数の一致、境界スピン積、偶奇を厳密検査する | PASS | すべての双対像が偶部分グラフ |

## 備考

$L=1$ の自己ループでは同じ辺の二つの端点を別々に数える。本文の端点数の定義と同じく、`endpoints` の二項を反復することでこの重複度を保っている。有限集合、自然数、整数だけを使い、浮動小数点と $\mathbb{R}/\mathbb{C}$ は使わない。

## 実行方法

プロジェクト直下で実行する。`check.sage` は全行別検査の後に全配位の検査を行う。

```sh
micromamba run -p /home/masaori/.local/share/math-mamba/envs/sage sage sagemath/check/dual-broken-edges-even/check.sage
```

**2026-08-12 実行: すべて通過。**

2026-10-04: 本文の指数への代入と冪の加法則を別々の行へ分けた。既存検査を再実行し、一辺一から三の全530配位で通過した。元の等号と根拠、自己ループの端点の重複度は保っている。

2026-10-04 レビュー: 行別13本を追加し、計60,763件の厳密等式・偶奇判定がすべて通過した。
一辺一から三の全530配位についての既存の偶部分グラフ検査も通過した。
本文の双対写像の代入と加法の交換、端点の代入と平方への整理、平方の置換と一の乗法をそれぞれ別の行へ分けた。

初回実行は `__file__` が SageMath のインストール先を指して検査ファイルを読み込めず ERROR になった。
数式の検査には到達していない。プロジェクト直下から既定の相対パスで読み込む形へ直し、上記再実行で通過した。
