# SageMath Check: 破れた辺の双対像の偶次数性

## 対象

**対象ラベル**: `claim_dual_broken_edges_even`

- 併せて検証: `def_broken_edge_set`、`def_edge_subset_incidence_count`、`def_even_edge_subset`、`def_dual_edge_map`
- 範囲: 各配位の破れた辺集合を双対辺写像で送った像が、すべての双対頂点で偶数本の端点を持つこと

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
|---|---|---|---|
| `check.sage` | $L=1,2,3$ の全配位について、双対頂点の端点数と対応する格子面境界の破れ数の一致、境界スピン積、偶奇を厳密検査する | PASS | すべての双対像が偶部分グラフ |

## 備考

$L=1$ の自己ループでは同じ辺の二つの端点を別々に数える。本文の端点数の定義と同じく、`endpoints` の二項を反復することでこの重複度を保っている。有限集合、自然数、整数だけを使い、浮動小数点と $\mathbb{R}/\mathbb{C}$ は使わない。

## 実行方法

```sh
sage sagemath/check/dual-broken-edges-even/check.sage
```

**2026-08-12 実行: すべて通過。**
