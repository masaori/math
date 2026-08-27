# SageMath 検算: 有限近傍割り当てモノイドの可逆元

## 対象

**対象ラベル**: `claim_invertible_neighborhood_assignments_are_permutations`

- 併せて検証するラベル:
  `def_invertible_neighborhood_assignment`、
  `def_permutation_neighborhood_assignment`、
  `claim_invertible_neighborhood_assignment_inverse_unique`、
  `claim_invertible_neighborhood_assignment_cardinality_decidable`、
  `def_composed_neighborhood`、
  `def_identity_neighborhood_assignment`、
  `def_finite_neighborhood_assignment_space`
- 本文の証明を、可逆性から各 `N(v)` が一元集合であることを出す前半、そこから置換 `sigma` を作り
  `N = P_sigma` を出す後半、逆向き（全単射から `P_sigma` が可逆）、個数と有限決定の四つへ分け、
  最終式だけの一致で済ませない。

## チェック一覧

| ファイル | 検証内容 | ステータス |
| --- | --- | --- |
| `check_invertible_forces_singleton.sage` | 本文の前半。`(N star M)(v) = {v}` から証人 `u in N(v)` と `N(v) != ∅` を出す段、`M(u) ⊆ {v}` の段、`(M star N)(u) = {u}` が空でないことから `M(u) != ∅` を出す段、`M(u) = {v}` の段、`{u} = (M star N)(u) = ∪_{x in M(u)} N(x) = N(v)` の三つの等号を分けて検査し、`N(v)` が一元集合であることを出す | PASS |
| `check_permutation_from_invertible.sage` | 本文の後半。一元集合 `N(v)` の唯一の元として `sigma(v)` を置く段、`M(sigma(v)) = {v}` を経由する単射性の段、有限性から全単射を出す段、`N = P_sigma` の段、`N = P_tau` なら `tau = sigma` という一意性を分けて検査する | PASS |
| `check_permutation_assignment_is_invertible.sage` | 本文の逆向きの式変形を一行ずつ検査する。合成近傍と `P_sigma` の定義による展開、一元集合を添字とする合併、`sigma^{-1} ∘ sigma = id_V`、自己近傍割り当ての定義の各行を分け、逆向きの合成 `P_{sigma^{-1}} star P_sigma = I_V` も同じ形で検査し、写像の外延性から両合成の等号と可逆性を出す | PASS |
| `check_units_cardinality_finite_decision.sage` | 全数走査で得た可逆元全体が `{P_sigma}` に一致すること、`sigma |-> P_sigma` の単射性と個数が `n!` になること、各可逆元の逆元が唯一で `P_{sigma^{-1}}` に等しいこと、表との有限比較による可逆性判定が全数走査の判定と一致すること、割り当ての等号が `|V|^2` 回の所属判定へ展開できることを分けて検査する | PASS |

## 検証範囲

- 舞台元数は `|V| = 0, 1, 2, 3` である。近傍割り当ての総数は順に 1、2、16、512 で、合計 531 個を
  全て走った。可逆性の判定は各割り当てについて全ての `M ∈ N(V)` との合成を突き合わせている。
- 見つかった可逆元は各舞台で 1、1、2、6 個であり、`n!` と一致した。`N star M = I_V = M star N` を
  満たす順序対は合計 10 組で、いずれも `M` が一意に定まった。
- `|V| = 4` は近傍割り当てが 65,536 個、その順序対が 4,294,967,296 組になるため全走査していない。
- したがってこれは有限範囲の全数検査であって、任意の有限舞台に対する一般証明ではない。
  一般の場合の根拠は構造化記述の証明である。

## 走査で分かったこと（本文の記述との差）

- 逆元が一意であることを走査が示したのに対し、前 tick の本文は個数の claim で「各逆元を決定できる」と
  述べるだけで一意性を主張していなかった。本 tick で `claim_invertible_neighborhood_assignment_inverse_unique`
  （単位律と結合律から `M = M star I_V = M star (N star M') = (M star N) star M' = I_V star M' = M'`）を
  本文へ追加し、個数の claim がそれを引くようにした。
- `|V| = 0` では可逆元は空の割り当て一つで、これは `I_V` と一致する。`0! = 1` と整合する。
- 上記以外に本文の記述に修正を要する差は見つからなかった。

## 限界と帰属

- 有限集合、有限部分集合、有限写像表、`ZZ` の等号だけを使う。浮動小数点と `R/C` 脱出はない。
- 有限決定は判定の手続き（可逆元の有限表との比較、写像の等号を `|V|^2` 回の所属判定へ展開すること）
  まで検査したものであり、計算コストモデルそのものは検査していない。

## 実行方法

```bash
for file in sagemath/check/neighborhood-assignment-monoid-units/check_*.sage; do sage "$file"; done
```
