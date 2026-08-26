# SageMath 検算: 近傍割り当ての点ごとの和と合成の分配性

## 対象

**対象ラベル**: `claim_finite_neighborhood_assignments_form_idempotent_semiring`

- 併せて検証するラベル: `def_empty_neighborhood_assignment`、
  `def_neighborhood_assignment_pointwise_union`、
  `claim_neighborhood_assignment_pointwise_union_laws`、
  `claim_neighborhood_assignment_inclusion_iff_union_eq`、
  `claim_composed_neighborhood_distributes_over_pointwise_union`、
  `claim_empty_neighborhood_assignment_is_composition_absorbing`
- 本文の各段（和の可換・結合・冪等・単位、包含順序の特徴づけ、合成の左右分配、空近傍の両側吸収、
  冪等半環）を別々の検算に分け、最終式だけの一致で済ませない。

## チェック一覧

| ファイル | 検証内容 | ステータス |
| --- | --- | --- |
| `check_union_laws.sage` | 点ごとの和の可換律・結合律・冪等律と `O_V` の単位律。証明の各式変形（点ごとの定義への展開、集合の合併の法則、写像の外延性）を段ごとに分けて検査 | PASS |
| `check_order_characterization.sage` | `N <= M` と `N⊔M = M` の同値。順方向は各 `v` での `N(v) ∪ M(v) = M(v)`、逆方向は `w ∈ N(v)` を追う所属の含意列として別々に検査し、全組で両者の真理値が一致することも検査 | PASS |
| `check_distributivity.sage` | 合成近傍の右分配 `(N⊔M)*L = (N*L)⊔(M*L)` と左分配 `L*(N⊔M) = (L*N)⊔(L*M)`。証人 `u` の場合分けと存在量化の論理和への分配を、所属の同値列として段ごとに検査 | PASS |
| `check_absorbing.sage` | `O_V*N = O_V = N*O_V`。左は空集合を添字とする合併、右は空集合だけの合併として、二つの式変形を分けて検査 | PASS |
| `check_idempotent_semiring.sage` | 同じ舞台の上で、和の冪等可換モノイド・合成のモノイド・両側分配・空近傍の吸収が同時に成り立つこと。両演算の値が再び `N(V)` に属し、和と合成の表が有限走査で決定できること | PASS |

## 検証範囲

- 和の冪等律・単位律と空近傍の両側吸収は `0 <= |V| <= 3` の全ての近傍割り当て（計 531 個）で検査した。
- 和の可換律は `0 <= |V| <= 2` の全ての組（計 261 組）、結合律は同じ範囲の全ての三つ組（計 4,105 組）で検査した。
  `|V| = 3` では三つ組が `512^3` 通りとなるため走査していない。
- 包含順序の特徴づけは `0 <= |V| <= 3` の全ての組（計 262,405 組、うち包含が成り立つものが
  19,768 組）で、両方向と真理値の一致を検査した。
- 左右の分配律は `0 <= |V| <= 2` の全ての三つ組（各 4,105 組）で検査した。
- 冪等半環の同時検査は `0 <= |V| <= 2` に限る。元数はそれぞれ 1、2、16 個であり、
  和の表と合成の表はそれぞれ 1、4、256 項である。

## 限界と帰属

- いずれも上記の有限範囲の全数検査であり、任意の有限舞台に対する一般証明ではない。
  一般の場合の根拠は構造化記述である。
- 有限集合、有限写像表、自然数の等号だけを使う。浮動小数点と `R/C` 脱出はない。

## 実行方法

```bash
for file in sagemath/check/neighborhood-assignment-union-distributivity/check_*.sage; do sage "$file"; done
```
