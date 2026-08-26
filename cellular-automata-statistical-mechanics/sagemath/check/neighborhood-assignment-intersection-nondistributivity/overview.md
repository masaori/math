# SageMath 検算: 近傍割り当ての点ごとの積と合成の非分配性

## 対象

**対象ラベル**: `claim_neighborhood_assignment_intersection_and_distributivity_finite_decidable`

- 併せて検証するラベル: `def_neighborhood_assignment_pointwise_intersection`、
  `def_full_neighborhood_assignment`、
  `claim_neighborhood_assignment_pointwise_intersection_laws`、
  `claim_neighborhood_assignment_pointwise_union_intersection_lattice`、
  `claim_composition_not_left_distributive_over_pointwise_intersection`、
  `claim_composition_not_right_distributive_over_pointwise_intersection`
- 本文の各段（積の可換・結合・冪等・単位、分配束の二つの分配律と最小上界・最大下界、
  左右それぞれの明示反例、有限決定可能性）を別々の検算に分け、最終式だけの一致で済ませない。

## チェック一覧

| ファイル | 検証内容 | ステータス |
| --- | --- | --- |
| `check_intersection_laws.sage` | 点ごとの積の可換律・結合律・冪等律と `U_V` の単位律。証明の四つの式変形（点ごとの定義への展開、集合の共通部分の法則、写像の外延性）を段ごとに分けて検査 | PASS |
| `check_lattice.sage` | 積の和に対する分配律と和の積に対する分配律を、各 `v, w` の所属の真理値の一致として検査。併せて和が包含順序の最小上界、積が最大下界であることを、上界性・下界性と普遍性に分けて検査 | PASS |
| `check_left_nondistributivity.sage` | 三元舞台での `(N⊓M)*L ≠ (N*L)⊓(M*L)`。左辺は空集合を添字とする合併、右辺は `L(b) ∩ L(c)` として、本文の式変形を段ごとに検査 | PASS |
| `check_right_nondistributivity.sage` | 三元舞台での `L'*(N'⊓M') ≠ (L'*N')⊓(L'*M')`。左辺は `(N'⊓M')(b) ∪ (N'⊓M')(c)`、右辺は `(N'(b)∪N'(c)) ∩ (M'(b)∪M'(c))` として、本文の式変形を段ごとに検査 | PASS |
| `check_finite_decidability.sage` | 積の全演算表が有限走査で決まり値が再び `N(V)` に属すること、分配する三つ組と分配しない三つ組の個数が有限走査で確定すること、本文の二つの明示反例が有限回の所属判定で反例と判定されること | PASS |

## 検証範囲

- 積の冪等律・単位律は `0 <= |V| <= 3` の全ての近傍割り当て（計 531 個）で検査した。
- 積の可換律は `0 <= |V| <= 2` の全ての組（計 261 組）、結合律は同じ範囲の全ての三つ組（計 4,105 組）で検査した。
  `|V| = 3` では三つ組が `512^3` 通りとなるため走査していない。
- 分配束の二つの分配律は `0 <= |V| <= 2` の全ての三つ組（計 4,105 組）で検査した。
  最小上界は 631 組、最大下界は 631 組の該当例で普遍性を検査した。
- 左右の分配性の全数走査は `0 <= |V| <= 2` に限る。三つ組の個数は `|V| = 0, 1, 2` でそれぞれ
  1、8、4,096 であり、積の演算表はそれぞれ 1、4、256 項である。
- `|V| = 3` は全数走査していない。本文の二つの明示反例だけを個別に検査した。

## 走査で分かったこと（本文の記述との差）

- **非分配性の反例が最初に現れる舞台は `|V| = 2` である。** `|V| = 0, 1` では反例が無く、
  `|V| = 2` では 4,096 三つ組のうち左分配・右分配それぞれ 420 個が反例になる。
  最小の反例の一つは `N(0)=∅, N(1)={0}`、`M(0)=∅, M(1)={1}`、`L(0)=L(1)={0}` である。
- したがって本文が挙げた三元の反例は最小ではない。本文はどの反例も最小であるとは主張していないため、
  これは記述の誤りではない。最小性を主張として立てるかどうかは次の対象の判断に回す。

## 限界と帰属

- いずれも上記の有限範囲の全数検査であり、任意の有限舞台に対する一般証明ではない。
  一般の場合の根拠は構造化記述である。
- 有限集合、有限写像表、自然数の等号だけを使う。浮動小数点と `R/C` 脱出はない。

## 実行方法

```bash
for file in sagemath/check/neighborhood-assignment-intersection-nondistributivity/check_*.sage; do sage "$file"; done
```
