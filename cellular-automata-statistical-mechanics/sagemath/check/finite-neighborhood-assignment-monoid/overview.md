# SageMath 検算: 有限近傍割り当ての合成モノイド

## 対象

**対象ラベル**: `claim_finite_neighborhood_assignments_form_monoid`

- 併せて検証するラベル: `def_finite_neighborhood_assignment_space`、
  `def_identity_neighborhood_assignment`、
  `claim_identity_neighborhood_assignment_is_composition_identity`、
  `claim_composed_neighborhood_associative`、
  `claim_finite_neighborhood_assignment_monoid_cardinality_decidable`、
  `def_noncommutative_neighborhood_assignment_witness`、
  `claim_neighborhood_assignment_composition_not_commutative`
- 本文の各段（両側単位律、結合律、元数と合成表の有限決定、非可換の明示反例）を別々の検算に分け、
  最終式だけの一致で済ませない。

## チェック一覧

| ファイル | 検証内容 | ステータス |
| --- | --- | --- |
| `check_identity_unit.sage` | 自己近傍割り当てが両側単位元であること。証明の二段（一元集合を添字とする合併、一元集合の合併）を分けて検査 | PASS |
| `check_associativity.sage` | 合成近傍の結合律。左右の値を、証明中の二重の存在量化から直接構成した集合とそれぞれ照合 | PASS |
| `check_monoid_cardinality_and_table.sage` | 合成に関する閉性、単位元の所属、元数 `(2^|V|)^|V| = 2^(|V|^2)`、合成表の有限構成と単位元の行・列 | PASS |
| `check_noncommutative_witness.sage` | 3 セル舞台の明示反例で `(N*M)(a) = {c}`、`(M*N)(a)` が空であること、および可換でない組の個数 | PASS |

## 検証範囲

- 両側単位律は `1 <= |V| <= 3` の全ての近傍割り当て（計 530 個）について検査した。
- 結合律は `1 <= |V| <= 2` の全ての三つ組（計 4,104 組）について検査した。
  `|V| = 3` では三つ組が `512^3` 通りとなるため走査していない。
- 元数は `0 <= |V| <= 4` について列挙個数と `2^(|V|^2)` の一致を検査した。
  閉性と単位元の所属は `1 <= |V| <= 3` の全ての組（計 262,404 組）で検査した。
  合成表の全数構成は `0 <= |V| <= 2` に限る。
- 非可換の反例は本文が指定した一つの有限対象なので、全数検査が主張の範囲を尽くす。
  併せて `1 <= |V| <= 3` の全ての組を走査し、可換でない組が `|V| = 1` では 0 個、
  `|V| = 2` では 156 個、`|V| = 3` では 245,214 個であることを記録した。

## 限界と帰属

- 単位律・結合律・閉性・合成表は上記の有限範囲の全数検査であり、任意の有限舞台に対する
  一般証明ではない。一般の場合の根拠は構造化記述である。
- 有限集合、有限写像表、自然数の等号だけを使う。浮動小数点と `R/C` 脱出はない。

## 実行方法

```bash
for file in sagemath/check/finite-neighborhood-assignment-monoid/check_*.sage; do sage "$file"; done
```
