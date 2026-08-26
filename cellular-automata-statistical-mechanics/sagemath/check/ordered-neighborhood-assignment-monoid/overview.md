# SageMath 検算: 近傍割り当ての包含順序と合成の単調性

## 対象

**対象ラベル**: `claim_finite_neighborhood_assignments_form_ordered_monoid`

- 併せて検証するラベル: `def_neighborhood_assignment_pointwise_inclusion`、
  `claim_neighborhood_assignment_pointwise_inclusion_partial_order`、
  `claim_composed_neighborhood_monotone`、
  `claim_neighborhood_assignment_pointwise_inclusion_finite_decidable`
- 本文の各段（反射律・反対称律・推移律、合成の単調性、包含判定の有限走査、順序モノイド）を
  別々の検算に分け、最終式だけの一致で済ませない。

## チェック一覧

| ファイル | 検証内容 | ステータス |
| --- | --- | --- |
| `check_partial_order.sage` | 点ごとの包含が反射的・反対称・推移的であること。証明の三段（各 `v` での包含、両包含からの写像の一致、`w` を追う推移）を分けて検査 | PASS |
| `check_composition_monotone.sage` | 合成近傍の単調性。証明の含意列（証人 `u` の取得、`N <= N'` による移送、`M <= M'` による移送、合成近傍の定義への復帰）を段ごとに検査し、片側だけを動かした単調性も別に検査 | PASS |
| `check_inclusion_decidability.sage` | `V x V` の全組を走査する判定手続きが定義どおりの包含と一致すること、走査回数が `|V|^2` であること | PASS |
| `check_ordered_monoid.sage` | 同じ舞台の上で、有限モノイドの公理・部分順序の三性質・積の単調性が同時に成り立つこと | PASS |

## 検証範囲

- 部分順序の反射律は `1 <= |V| <= 3` の全ての近傍割り当て（計 530 個）で検査した。
  反対称律は `1 <= |V| <= 2` の全ての組（計 260 組）、推移律は同じ範囲で包含が成り立つ
  三つ組（計 260 組）を検査した。`|V| = 3` では三つ組が `512^3` 通りとなるため走査していない。
- 合成の単調性は `1 <= |V| <= 2` の全ての四つ組のうち両側の包含が成り立つもの（計 6,570 組）、
  片側単調性は左右それぞれ 1,302 組を検査した。
- 包含判定の有限走査は `0 <= |V| <= 3` の全ての組（計 262,405 組、うち包含が成り立つものが
  19,768 組）で、定義による判定との一致と走査回数 `|V|^2` を検査した。
- 順序モノイドの同時検査は `0 <= |V| <= 2` に限る。元数はそれぞれ 1、2、16 個であり、
  包含が成り立つ組はそれぞれ 1、3、81 組である。

## 限界と帰属

- いずれも上記の有限範囲の全数検査であり、任意の有限舞台に対する一般証明ではない。
  一般の場合の根拠は構造化記述である。
- 有限集合、有限写像表、自然数の等号だけを使う。浮動小数点と `R/C` 脱出はない。

## 実行方法

```bash
for file in sagemath/check/ordered-neighborhood-assignment-monoid/check_*.sage; do sage "$file"; done
```
