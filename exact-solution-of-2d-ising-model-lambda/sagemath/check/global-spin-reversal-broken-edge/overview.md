# SageMath Check: 全スピン反転は各辺の破れを保つ

## 対象

**対象ラベル**: `def_global_spin_reversal`・`claim_global_spin_reversal_preserves_broken_edge`

- ファイル: `structured-latex/content/main-text.ts`
- 範囲: 全スピン反転の定義と、各辺の両端が相異なることの二段の同値

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
|---|---|---|---|
| `check_endpoints.sage` | $L=1,2,3,4$ の全配位・全辺で、反転後の不等式、整数の負号を付けた不等式、反転前の不等式が一致すること | PASS | 合計 2,106,500 本の配位つき辺で一致 |

## 備考

スピン値は `ZZ`、格子・配位・辺は有限集合だけで表した。浮動小数点と $\mathbb{R}/\mathbb{C}$ は使わない。

## 実行方法

```sh
sage sagemath/check/global-spin-reversal-broken-edge/check_endpoints.sage
```

**2026-08-12 実行: すべて通過。**

2026-09-06: プログラミングによる検証はレビュー時と表記統一後の二回とも終了コード 0。一辺一から四の全 2,106,500 本で二段の同値と反転後のスピンの所属を再現した。LLM による検証では、本文と Lean 二版が両端への同じ単射の適用で一致し、後続の原像の数え上げで再利用される主張として維持した。
