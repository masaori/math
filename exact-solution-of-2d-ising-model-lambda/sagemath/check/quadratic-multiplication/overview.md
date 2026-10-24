# SageMath Check: 二次体の乗法による閉性と積の表示

## 対象

**対象ラベル**: `claim_quadratic_multiplication_mem`, `claim_quadratic_multiplication_representation`

- 本文: `structured-latex/content/main-text.ts` の「二次体の台集合の乗法による閉性」と「二次体の積の表示」。
- 範囲: 閉性の三補助式の十一等号、積の計算の十八等号、二係数と積の三所属、および積の表示の三等号と一所属を一行一ファイルで確認する。
- 帰属: `QQ` / `QQbar` の厳密計算。平方根は多項式 `t^2 - 2` の両根を取り、包含写像は `j = QQbar` とする。
- 標本: 分子 −2〜2、分母 1〜2 から作る七有理数の四つ組と両平方根、各行 4,802 件。有限標本の検算であり、一般の係数の主張は Lean で保証する。

## チェック一覧

| ファイル | 本文の行 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_aux_first_associate.sage` | 補助式: 第一混合項の結合則 | PASS | 4,802 等式 |
| `check_aux_second_associate_left.sage` | 補助式: 第二混合項の左結合解除 | PASS | 4,802 等式 |
| `check_aux_second_commute.sage` | 補助式: 第二混合項の中央交換 | PASS | 4,802 等式 |
| `check_aux_second_associate_right.sage` | 補助式: 第二混合項の再結合 | PASS | 4,802 等式 |
| `check_aux_square_associate_outer.sage` | 補助式: 二平方根項の外側結合 | PASS | 4,802 等式 |
| `check_aux_square_associate_inner.sage` | 補助式: 二平方根項の内側結合 | PASS | 4,802 等式 |
| `check_aux_square_commute_inner.sage` | 補助式: 二平方根項の中央交換 | PASS | 4,802 等式 |
| `check_aux_square_associate_middle.sage` | 補助式: 有理係数像どうしの結合 | PASS | 4,802 等式 |
| `check_aux_square_associate_factors.sage` | 補助式: 二平方根の結合 | PASS | 4,802 等式 |
| `check_aux_square_substitute.sage` | 補助式: 平方根の仮定の代入 | PASS | 4,802 等式 |
| `check_aux_square_commute_coefficient.sage` | 補助式: 二の像の移動 | PASS | 4,802 等式 |
| `check_representation.sage` | 表示の同時代入 | PASS | 4,802 等式 |
| `check_distribute_left.sage` | 左因子の分配 | PASS | 4,802 等式 |
| `check_distribute_first.sage` | 第一項の分配 | PASS | 4,802 等式 |
| `check_distribute_second.sage` | 第二項の分配 | PASS | 4,802 等式 |
| `check_replace_first.sage` | 第一補助式の代入 | PASS | 4,802 等式 |
| `check_replace_second.sage` | 第二補助式の代入 | PASS | 4,802 等式 |
| `check_replace_square.sage` | 平方根積の補助式の代入 | PASS | 4,802 等式 |
| `check_commute_right.sage` | 右の二項の交換 | PASS | 4,802 等式 |
| `check_associate_outer.sage` | 外側の和の結合解除 | PASS | 4,802 等式 |
| `check_associate_middle.sage` | 中央の和の結合 | PASS | 4,802 等式 |
| `check_commute_middle.sage` | 中央の二項の交換 | PASS | 4,802 等式 |
| `check_associate_inner.sage` | 内側の和の結合解除 | PASS | 4,802 等式 |
| `check_group_coefficients.sage` | 定数項の結合 | PASS | 4,802 等式 |
| `check_factor_radical.sage` | 平方根因子の分配則 | PASS | 4,802 等式 |
| `check_map_products.sage` | 四つの係数積の包含保存 | PASS | 4,802 等式 |
| `check_map_double_product.sage` | 二倍の包含保存 | PASS | 4,802 等式 |
| `check_map_first_sum.sage` | 定数係数の和の包含保存 | PASS | 4,802 等式 |
| `check_map_second_sum.sage` | 平方根係数の和の包含保存 | PASS | 4,802 等式 |
| `check_first_coefficient_membership.sage` | 定数係数の有理数への所属 | PASS | 4,802 所属 |
| `check_second_coefficient_membership.sage` | 平方根係数の有理数への所属 | PASS | 4,802 所属 |
| `check_product_membership.sage` | 有理係数を証人とする積の所属 | PASS | 4,802 所属 |
| `check_product_representation_membership.sage` | 積が二次体に属すること | PASS | 4,802 所属 |
| `check_product_representation_reconstruction.sage` | 表示写像から積の値を復元する等号 | PASS | 4,802 等式 |
| `check_product_representation_value.sage` | 閉性の証明の鎖の始点と終点 | PASS | 4,802 等式 |
| `check_product_representation_unique.sage` | 表示一意性による係数対の一致 | PASS | 4,802 等式 |
| `check.sage` | 既存の閉性・積の表示の統合検算 | PASS | 両立49組、補助式・積・表示4,802組 |

## 積の表示の係数抽出

`_representation_prelude.sage` は数体 `K = QQ[r]/(r^2 - 2)` の中で二元を掛け、実際の積の `{1,r}` 基底座標を取り出す。各平方根 `s` に対して埋込み `r ↦ s` を明示し、入力と積を `QQbar` の元へ対応させる。期待する積公式は座標抽出に使わず、最後の係数対との比較にだけ使うため、両平方根の符号を区別して検算できる。

本文の表示復元は Lean の `quadraticRepresentation_spec`、積の値は閉性で証明済みの `quadraticMul_value`、係数対の一意性は `quadraticRepresentationUnique` と `Prod.ext` に対応する。必要十分版 `mul_representation_of_spec_necSuf` も同じ二等号と一意性適用を並べ、導出版は表示の復元・一意性と `quadraticMul_value_from_necSuf` を供給する。

## 実行結果

2026-10-24: 「二次体の積の表示」の四層レビューで、行別4ファイルを個別に再実行し、三等号14,406件と一所属4,802件が通過した。本文と独立な具体版、表示復元・値の等式・係数一意性を用いる必要十分版の対応を確認した。結論相当の仮定を返すだけの未使用の旧必要十分版を除き、公理依存検査を現行の `mul_representation_of_spec_necSuf` へ接続した。具体版・必要十分版・導出版の対象ビルドも通過した。

2026-10-24: 閉性の四層レビューに合わせ、行別36ファイル（各4,802件）と統合検算（包含の両立49組、補助式・積・表示4,802組）を再実行し、すべて通過した。閉性の必要十分版は、積の表示を仮定せず、包含写像の和・積の保存と結合・可換・分配則から係数の証人を構成する。対応する Lean の具体版・必要十分版・導出版の対象ビルドも通過した。

2026-10-11: 積の表示の行別4ファイルを個別に実行してすべて通過。三等号14,406件と一所属4,802件を検算した。

2026-10-11: 行別32ファイルと既存統合検算を実行してすべて通過。行別検算は等式139,258件、所属14,406件。

初回の行別実行は SageMath が共通ファイルを異なるディレクトリから探して停止した。プロジェクトルートからの相対読込へ修正し、32ファイルを個別に再実行して通過した。

## 既存検算の記録

2026-08-13: `check.sage` が積・和の両立 49 組、三補助式・積の鎖・積の表示 4,802 組を通過した。積の表示の一意性は `claim_quadratic_representation_unique` に依存する。

## 実行方法

プロジェクトルートで各ファイルを個別に実行する。

```sh
sage sagemath/check/quadratic-multiplication/check_representation.sage
```

全行を実行する場合:

```sh
for f in sagemath/check/quadratic-multiplication/check_*.sage; do
  sage "$f" || exit
done
sage sagemath/check/quadratic-multiplication/check.sage
```
