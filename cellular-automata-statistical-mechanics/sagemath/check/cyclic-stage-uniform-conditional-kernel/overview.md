# SageMath 検算: 有限窓内の一様条件付き再標本化核と有限固定点等式

## 対象

**対象ラベル**: `theorem_cyclic_stage_uniform_conditional_kernel_invariance`

- 併せて検証するラベル: `claim_cyclic_stage_window_image_cardinality`、
  `claim_cyclic_stage_uniform_conditional_kernel_normalized`。
- 有限巡回舞台内の窓の元数、窓外一致類の元数、条件付き再標本化核の行和、
  一様有限舞台分布の有限固定点等式を本文の段ごとに分けて検算する。

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_outside_agreement_class_cardinality.sage` | 窓の像と各窓外一致類の元数 | PASS | 28 舞台・窓対、7,279 一致類、延べ 72,818 配位で一致 |
| `check_kernel_row_normalization.sage` | 条件付き再標本化核の各行の有限和 | PASS | 15,474 行、26,545,284 核成分を覆う分割和で正規化 |
| `check_uniform_fixed_point.sage` | 一様有限舞台分布への核の作用と固定点等式 | PASS | 15,474 固定点等式、26,545,284 核成分を覆う分割和で一致 |

## 範囲と限界

- 窓の像と窓外一致類は `0 <= s <= m <= 6`、核の行和と有限固定点等式は
  `0 <= s <= m <= 5` の全舞台・全窓・全有限配位を列挙する。
- これは明記した有限範囲のプログラミングによる検証であり、任意の自然数添字についての一般証明ではない。
  一般の場合の根拠は構造化記述の証明にある。
- この核は窓外を固定して窓内を一様に選び直す有限有理核である。無限舞台の Gibbs 仕様、条件付き期待値、
  ほとんど至る所の等号、Gibbs 測度との対応、数学的な近似は検算しない。
- 全て有限集合、`ZZ`、`QQ`、有限和で厳密に検査する。除算は正の二冪を分母とする有理数内だけで行う。
  対数、浮動小数点、全配位の逆極限、極限、実数体、複素数体は使わない。

## 実行方法

```bash
for file in cellular-automata-statistical-mechanics/sagemath/check/cyclic-stage-uniform-conditional-kernel/check_*.sage; do sage "$file"; done
```
