# SageMath Check: 偶部分グラフに対応するスピン単項式の和

## 対象

**対象ラベル**: `claim_even_subgraph_spin_sum`

- 併せて検証: `def_edge_subset_incidence_count`、`def_even_edge_subset`、`def_even_subgraph_polynomial`、`def_edge_subset_spin_sum`
- 範囲: 辺の部分集合の各頂点における端点の偶奇と、全配位にわたるスピン単項式の和

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
|---|---|---|---|
| `check.sage` | $L=1,2$ は全辺部分集合・全配位、$L=3$ は全辺部分集合について頂点ごとの厳密因数分解を検査する | PASS | 偶部分グラフなら $2^{L^2}$、それ以外なら $0$ |

## 備考

端点を辺の両端の番号つきで数えるため、$L=1$ の自己ループも次数へ二回寄与する。すべて `ZZ` の厳密計算であり、浮動小数点と $\mathbb{R}/\mathbb{C}$ は使わない。

## 実行方法

```sh
sage sagemath/check/even-subgraph-spin-sum/check.sage
```

**2026-08-12 実行: すべて通過。**
