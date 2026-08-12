# SageMath Check: 周期トーラスの四つの辺セクター

## 対象

**対象ラベル**: `claim_torus_homology_sector_partition`

- 併せて検証: `def_torus_winding_parities`, `def_torus_homology_sector`
- 範囲: 二つの周期境界を横切る辺の個数の偶奇と、偶部分グラフの四セクターへの一意な分割

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
|---|---|---|---|
| `check.sage` | $L=1,2,3$ の全辺部分集合から偶部分グラフを取り、二つの偶奇で四セクターへ一意に分かれることを検査する | PASS | 偶部分グラフは各セクターにただ一度だけ属し、四セクターはいずれも空でない |

## 備考

辺は番号つきで扱うため、$L=1$ の二つの自己ループも別々に数える。すべて有限集合と整数の剰余の厳密計算であり、浮動小数点と $\mathbb{R}/\mathbb{C}$ は使わない。

## 実行方法

```sh
sage sagemath/check/torus-homology-sector-partition/check.sage
```

**2026-08-12 実行: すべて通過。**
