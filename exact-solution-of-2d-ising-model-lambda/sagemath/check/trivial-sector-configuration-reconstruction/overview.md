# SageMath Check: 自明セクターからの配位の復元

## 対象

**対象ラベル**: `claim_trivial_sector_configuration_reconstruction`

- 併せて検証: `def_broken_edge_set`、`def_dual_edge_map`、`def_torus_homology_sector`
- 範囲: 自明セクターの偶部分グラフが破れた辺集合の双対像として実現し、原像が全スピン反転の二配位であること

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
|---|---|---|---|
| `check.sage` | $L=1,2,3$ について、自明セクターの偶部分グラフ全体と全配位の双対破れ像全体が一致し、各原像が全スピン反転の二配位であることを厳密検査する | PASS | 全件一致 |

## 実行方法

```sh
sage sagemath/check/trivial-sector-configuration-reconstruction/check.sage
```

**2026-08-12 実行: すべて通過。**
