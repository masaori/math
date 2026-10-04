# SageMath Check: 高温展開の多項式恒等式

## 対象

**対象ラベル**: `claim_high_temperature_polynomial_identity`

- 併せて検証: `def_high_temperature_polynomial`
- 範囲: 一辺の二項表示、全辺への積、二項展開、有限和の交換、スピン和の代入、偶部分グラフへの制限、共通因子の消去の各行

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
|---|---|---|---|
| `check.sage` | $L=1,2$ の全配位で一辺表示を全辺へ掛けた等式を検査し、全辺部分集合から作った $H_L$ と $2^{L^2}Z_L$ を比較する | PASS | 両辺は `ZZ[x]` で一致 |
| `check_one_edge_intact.sage` | 一辺の二値評価の同じスピンの場合 | PASS | `ZZ[x]` で一致 |
| `check_one_edge_broken.sage` | 一辺の二値評価の異なるスピンの場合 | PASS | `ZZ[x]` で一致 |
| `check_product_edge_evaluation.sage` | 全辺の積へ一辺の二値評価を代入 | PASS | `ZZ[x]` で一致 |
| `check_product_broken_set.sage` | 破れた辺の定義で条件を書き換える | PASS | `ZZ[x]` で一致 |
| `check_product_split.sage` | 条件の真偽で有限積を分ける | PASS | `ZZ[x]` で一致 |
| `check_product_constants.sage` | 二つの一定値の有限積を評価 | PASS | `ZZ[x]` で一致 |
| `check_product_power.sage` | 積の自然数冪を分ける | PASS | `ZZ[x]` で一致 |
| `check_product_associate.sage` | 乗法の結合則 | PASS | `ZZ[x]` で一致 |
| `check_product_power_add.sage` | 自然数指数の加法法則 | PASS | `ZZ[x]` で一致 |
| `check_product_complement_card.sage` | 補集合と部分集合の個数の和 | PASS | `ZZ[x]` で一致 |
| `check_product_lattice_card.sage` | 格子の辺数を代入 | PASS | `ZZ[x]` で一致 |
| `check_product_broken_count.sage` | 破れた辺の個数を破れボンド数に戻す | PASS | `ZZ[x]` で一致 |
| `check_sum_product.sage` | 全辺積の評価を配位和へ代入 | PASS | `ZZ[x]` で一致 |
| `check_sum_constant_out.sage` | 配位に依らない因子を有限和の外へ出す | PASS | `ZZ[x]` で一致 |
| `check_sum_partition_definition.sage` | 分配多項式の定義 | PASS | `ZZ[x]` で一致 |
| `check_subset_expansion.sage` | 各配位の辺積を部分集合にわたる和へ展開 | PASS | `ZZ[x]` で一致 |
| `check_subset_product_split.sage` | 選んだ辺の積から一定の因子を分離 | PASS | `ZZ[x]` で一致 |
| `check_subset_constant_products.sage` | 一定値の有限積を冪へ | PASS | `ZZ[x]` で一致 |
| `check_subset_complement_card.sage` | 補集合の個数を差へ | PASS | `ZZ[x]` で一致 |
| `check_subset_lattice_card.sage` | 格子の辺数を代入 | PASS | `ZZ[x]` で一致 |
| `check_subset_associate.sage` | 乗法の結合則 | PASS | `ZZ[x]` で一致 |
| `check_sum_order.sage` | 二つの有限和の順序を入れ替える | PASS | `ZZ[x]` で一致 |
| `check_sum_spin_factor.sage` | 配位に依らない因子をスピン和の外へ | PASS | `ZZ[x]` で一致 |
| `check_sum_spin_definition.sage` | スピン単項式の和の定義 | PASS | `ZZ[x]` で一致 |
| `check_sum_spin_evaluation.sage` | 既証明のスピン和の二値評価 | PASS | `ZZ[x]` で一致 |
| `check_sum_remove_zero.sage` | 零項を除いて偶部分グラフだけに制限 | PASS | `ZZ[x]` で一致 |
| `check_sum_commute_factor.sage` | 各項の定数因子を交換 | PASS | `ZZ[x]` で一致 |
| `check_sum_even_factor.sage` | 辺部分集合に依らない因子を和の外へ | PASS | `ZZ[x]` で一致 |
| `check_sum_high_temperature_definition.sage` | 高温展開の整数多項式の定義 | PASS | `ZZ[x]` で一致 |
| `check_normalization_associate.sage` | 共通因子を左へ結合する | PASS | `ZZ[x]` で一致 |
| `check_normalization_power_add.sage` | 自然数指数を加える | PASS | `ZZ[x]` で一致 |
| `check_normalization_exponent.sage` | 指数の整数算術 | PASS | `ZZ[x]` で一致 |
| `check_common_sum_evaluations.sage` | 同じ配位和の二つの計算を等置 | PASS | `ZZ[x]` で一致 |
| `check_cancel_common_factor.sage` | 非零の定数因子を消去 | PASS | `ZZ[x]` で一致 |

## 備考

端点は番号つきで数えるため、$L=1$ の自己ループも二つの端点を持つ。すべて `ZZ[x]` の厳密計算であり、浮動小数点と $\mathbb{R}/\mathbb{C}$ は使わない。

各配位と辺部分集合の組における積の整理は、有限和へ入れる前に全4,104組で確かめる。
有限和の各行は独立に評価し、スピン和の二値評価も全260辺部分集合で比較する。
`_prelude.sage` は各式の値を用意し、表の各ファイルが対応する一組の等式を検査する。
`check.sage` は元からある端点比較を保ち、表の行別ファイルもすべて実行する。

## 実行方法

```sh
sage -c "__file__='sagemath/check/high-temperature-polynomial-identity/check.sage'; load(__file__)"
```

**2026-08-12 実行: すべて通過。**

**2026-10-04 再実行: すべて通過。** 一辺一・二の全18配位の辺積と、全260辺部分集合から作る高温展開多項式を `ZZ[x]` で比較した。本文の式変形の表記統一後も恒等式が一致する。

**2026-10-04 行別検査を追加して再実行: 34本すべて通過。** 本文の各等式と場合分けを検査した。
対象は一辺一・二の全18配位・全260辺部分集合・全4,104組であり、一般の辺長の証明を有限検算で代替しない。
