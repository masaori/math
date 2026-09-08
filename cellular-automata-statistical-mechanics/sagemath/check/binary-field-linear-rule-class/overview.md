# SageMath 検算: 有限舞台上で二元体線形な局所規則族

## 対象

**対象ラベル**: `claim_binary_field_linear_global_map_preserves_zero`

- 併せて検証するラベル: `claim_binary_field_linear_global_map_additive`、
  `claim_binary_field_linear_global_map_preserves_scalar_multiplication`、
  `claim_binary_field_linear_membership_finite_decidable`、`claim_general_binary_rule_need_not_preserve_zero`。
- 局所線形性から大域写像の三保存則へ至る等号、三条件による有限所属判定、一セル反例を分離して検算する。

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_global_preservation.sage` | 全ての局所線形規則族について、零保存・加法保存・スカラー倍保存を各有限配位で検査する | PASS | 二セル以下の全有限近傍割り当てと全係数族で成立 |
| `check_finite_decision.sage` | 零・加法・スカラー倍の三条件の全走査と、係数表として表せる線形写像の全数列挙を比較する | PASS | 二元以下の近傍の全局所真理値表で一致 |
| `check_general_counterexample.sage` | 一セル上の状態入れ替え規則が零を保存せず線形でないことを検査する | PASS | 二つの入力を持つ有限表全体で主張の反例を尽くす |

## 範囲と限界

- 二セル以下では全ての近傍部分集合の割り当てと、各近傍上の全係数族を列挙する。これは指定範囲の
  二元体線形な局所規則族を尽くすが、任意の有限舞台についての一般証明ではない。
- 有限決定の検算は二元以下の各近傍上の全局所真理値表を尽くし、本文の三条件による判定を、
  係数表の存在による独立な判定と照合する。
- 有限集合と二元体の有限演算だけを使う。対数、除算、浮動小数点、全配位の極限、実数体・複素数体は使わない。
- これは明示した有限範囲のプログラミングによる検証であり、一般命題の証明とは区別する。

## 実行方法

```bash
for file in sagemath/check/binary-field-linear-rule-class/check_*.sage; do sage "$file"; done
```
