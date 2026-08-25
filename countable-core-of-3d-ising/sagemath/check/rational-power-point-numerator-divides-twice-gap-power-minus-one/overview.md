# SageMath Check: 点数乗表示の分子が頂点数差の点数乗から一を引いた数の二倍を割る

## 対象

**対象ラベル**: `claim_rational_power_point_numerator_divides_twice_gap_power_minus_one`

- ファイル: `structured-latex/content/partition-values.ts`
- 範囲: 隣接箱の頂点数差、二箱の合同を結ぶ変形、差の因数分解から得る整除
- 併せて検証: `claim_rational_power_base_congruences`、`claim_zero_breakage_multiplicity_is_two`

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_vertex_gap.sage` | 隣接する三次元箱の頂点数差は `3L^2+3L+1` | PASS | 正の箱サイズ 256 件で一致 |
| `check_congruence_chain.sage` | 二箱の共通剰余から `2c^g` と `2` の合同を得る | PASS | 条件を満たす有限標本で一致 |
| `check_factor_and_divisibility.sage` | `2c^g-2=2(c^g-1)` と零合同からの整除 | PASS | 条件を満たす有限標本で一致 |

## 備考

- `ZZ` の厳密計算だけを使う。
- 箱の大きさの極限、浮動小数点、実対数、指数関数、無限和、級数、積分、微分は使わない。
- 実行日: 2026-08-25。三検査とも `RESULT: PASS`。

## 実行方法

```bash
for f in sagemath/check/rational-power-point-numerator-divides-twice-gap-power-minus-one/check_*.sage; do sage "$f"; done
```
