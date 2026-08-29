# SageMath 検算: 点ごとの積に対する合成の非分配反例の最小舞台

## 対象

**対象ラベル**: `theorem_minimal_carrier_size_for_composition_intersection_nondistributivity`

- 併せて検証するラベル:
  `claim_subsingleton_neighborhood_composition_equals_intersection`、
  `claim_subsingleton_neighborhood_composition_distributes_over_intersection`、
  `def_two_element_intersection_nondistributivity_witnesses`、
  `claim_two_element_composition_intersection_nondistributivity`
- 本文の各段（一元以下の舞台での合成と点ごとの積の一致、そこから従う左右の分配律、
  二元舞台の左右の明示証人の式変形、最小舞台元数）を別々の検算に分け、
  最終式だけの一致で済ませない。

## チェック一覧

| ファイル | 検証内容 | ステータス |
| --- | --- | --- |
| `check_subsingleton_composition_equals_intersection.sage` | `|V| <= 1` の全ての組で `N*M = N⊓M`。合成の所属と存在文の同値、`|V| <= 1` から従う `u = v = w`、存在文と論理積の両方向の含意、点ごとの積への所属、外延性による写像の等号を段ごとに分けて検査 | PASS |
| `check_subsingleton_distributivity.sage` | `|V| <= 1` の全ての三つ組で左右の分配律。合成と点ごとの積の一致による書き換え、共通部分の交換・結合・冪等律、再びの書き換えを段ごとに分けて検査 | PASS |
| `check_two_cell_witnesses.sage` | 二元舞台の左右の明示証人。左は `((N⊓M)*L)(b) = ∪_{u ∈ ∅} L(u) = ∅` と `((N*L)⊓(M*L))(b) = L(a) ∩ L(b) = {a}`、右は `(L'*(N'⊓M'))(b) = (N'⊓M')(a) ∪ (N'⊓M')(b) = ∅` と `((L'*N')⊓(L'*M'))(b) = {a} ∩ {a} = {a}` を段ごとに検査 | PASS |
| `check_minimal_cell_count.sage` | `|V| = 0, 1, 2` の全三つ組を走査し、反例個数が `0, 0, 420`（左右とも）であること、最小舞台元数が自然数の集合の最小元として左右とも `2` になること、走査した三つ組数が `|N(V)|^3` に一致することを検査 | PASS |

## 検証範囲

- 一元以下の主張は `|V| = 0, 1` の全数検査である。組は 5 組、三つ組は 9 組で尽きる。
- 最小性の走査は `|V| = 0, 1, 2` の全三つ組（それぞれ 1、8、4,096 組）に限る。
  `|V| = 3` 以降は走査していないが、最小性の主張には `|V| <= 2` の情報だけで足りる。
- 二元舞台の証人検査は本文が定めた二組の証人だけを個別に検査したものであり、
  二元舞台の反例全体の分類ではない。

## 走査で分かったこと（本文の記述との差）

- `|V| = 2` の 4,096 三つ組のうち、左分配の反例は 420 個、右分配の反例も 420 個である。
  本文が挙げた二組の証人はそのうちの各一つである。本文は反例が一意であるとは主張していないため、
  これは記述との差ではない。
- 前章 `neighborhood-assignment-intersection-nondistributivity` の走査記録
  （`|V| = 2` で左右それぞれ 420 個）と個数が一致する。

## 限界と帰属

- 一元以下の場合は全数検査で尽きているが、二元舞台の証人検査は個別例の検査であり、
  任意の有限舞台に対する一般証明ではない。一般の場合の根拠は構造化記述である。
- 有限集合、有限写像表、自然数の等号だけを使う。浮動小数点と `R/C` 脱出はない。

## 実行方法

```bash
for file in sagemath/check/neighborhood-assignment-intersection-minimal-counterexample/check_*.sage; do sage "$file"; done
```
