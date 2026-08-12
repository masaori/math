# SageMath Check: 破れた辺の双対像の巻き付き偶奇

## 対象

**対象ラベル**: `claim_dual_broken_edges_winding_zero`

- 併せて検証: `def_broken_edge_set`、`def_dual_edge_map`、`def_torus_winding_parities`
- 範囲: 破れた辺集合の双対像の二つの巻き付き偶奇がともに零であること

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
|---|---|---|---|
| `check.sage` | $L=1,2,3,4$ の全配位について、双対像の境界辺数を元の周期閉路の破れ数へ対応させ、二つの偶奇を厳密検査する | PASS | すべて自明セクター |

## 実行方法

```sh
sage sagemath/check/dual-broken-edges-winding-zero/check.sage
```

**2026-08-12 実行: すべて通過。**
