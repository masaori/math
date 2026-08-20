# 二段 Fisher 零点形式的因子の係数総和の検算

**対象ラベル**: `theorem_quotient_tower_two_stage_fisher_zero_formal_divisor_coefficient_sum`

## 対象

- ファイル: `structured-latex/content/quotient-tower.ts`（ブロック `quotient_tower_theorem_two_stage_fisher_zero_formal_divisor_coefficient_sum`）
- 範囲: 重複度差の形式的因子の係数総和が細段多項式と粗段多項式の次数差に等しいこと

## チェック一覧

実行日: 2026-08-21

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `_prelude.sage` | 初回実行で既存の前処理が定義していない多項式名 `P_fine` を参照した | ERROR | `NameError: name 'P_fine' is not defined`。検算本体へ到達しなかった |
| `check_extend_by_zero.sage` | 有限台から二段零点台への零延長が係数総和を保つ | PASS | 二つの有限例で `ZZ` の係数総和が一致した |
| `check_distribute_difference.sage` | 重複度差の有限和を二つの段別重複度和の差へ分配する | PASS | 二つの有限例で `ZZ` の分配後の差が一致した |
| `check_stage_zero_supports.sage` | 各段の零点台外での零延長を除いて段別零点重複度和へ移す | PASS | 二つの有限例で `QQbar` 零点台上の段別重複度和が一致した |
| `check_multiplicity_sum_degree.sage` | 代数閉体上の零点重複度総和を各多項式の次数へ移す | PASS | 二つの有限例で段別重複度総和の差が次数差に一致した |

## 備考

- 互いに素な二段零点台と、共有零点 `-1` をもつ二段零点台の両方を `QQbar` と `ZZ` で厳密検算する。
- 初回の未定義名を、既存の前処理が定義する `fine_partition_polynomial` と `coarse_partition_polynomial` へ修正した。
- 複素平面への埋め込み、浮動小数点近似、距離、偏角、数値描画、極限、積分を用いない。
- Lean 具体版と Lean 必要十分版は未着手である。

## 実行方法

```sh
for f in countable-ising-on-hyperbolic-surfaces/sagemath/check/two-stage-quotient-tower-fisher-zero-formal-divisor-coefficient-sum/check_*.sage; do sage "$f"; done
```
