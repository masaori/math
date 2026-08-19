# 二段 Fisher 零点形式的因子の段別差表示の検算

**対象ラベル**: `theorem_quotient_tower_two_stage_fisher_zero_formal_divisor_stage_difference`

## 対象

- ファイル: `structured-latex/content/quotient-tower.ts`（ブロック `quotient_tower_theorem_two_stage_fisher_zero_formal_divisor_stage_difference`）
- 範囲: 二段重複度差の形式的因子と、細段零点因子から粗段零点因子を引いた形式和との一致

## チェック一覧

実行日: 2026-08-20

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_stage_difference.sage` | 構造化本文側の作業ディレクトリから、リポジトリ直下を前提とする相対パスで初回実行した | ERROR | 対象ファイルが見つからず、検算本体は実行されなかった |
| `check_stage_difference.sage` | `QQbar` 上の二つの段別零点因子を `ZZ` 係数の有限台写像として構成し、その差を重複度差の形式的因子と照合する | PASS | 互いに素な零点台と共有零点 `-1` をもつ例の両方で一致し、共有零点は相殺された |

## 備考

- 各段の零点台外では重複度を零延長し、有限台写像の係数ごとの差を取った。
- 複素平面への埋め込み、浮動小数点近似、距離、偏角、数値描画、極限、積分を用いない。
- Lean 具体版と Lean 必要十分版は未着手である。

## 実行方法

```sh
sage countable-ising-on-hyperbolic-surfaces/sagemath/check/two-stage-quotient-tower-fisher-zero-formal-divisor-stage-difference/check_stage_difference.sage
```
