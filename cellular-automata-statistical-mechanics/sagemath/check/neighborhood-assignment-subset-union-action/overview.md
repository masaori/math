# SageMath 検算: 近傍割り当てが部分集合に定める合併作用

## 対象

**対象ラベル**: `claim_neighborhood_assignment_subset_union_map_composition`

- 併せて検証するラベル:
  `def_finite_stage_subset_space`、
  `def_neighborhood_assignment_subset_union_map`、
  `claim_identity_neighborhood_subset_union_map`、
  `claim_neighborhood_assignment_recovered_from_singletons`、
  `claim_neighborhood_assignment_subset_union_map_injective`、
  `claim_neighborhood_assignment_idempotent_iff_subset_union_map_idempotent`、
  `claim_neighborhood_assignment_subset_union_map_finite_decidable`、
  `def_composed_neighborhood`、
  `def_identity_neighborhood_assignment`
- 本文の証明を、合併写像の定義そのもの、合成、単位元、一元部分集合からの復元、単射性、
  冪等性の同値、有限決定の七つへ分け、最終式だけの一致で済ませない。

## チェック一覧

| ファイル | 検証内容 | ステータス |
| --- | --- | --- |
| `check_union_map_well_defined.sage` | 定義そのもの。`Sub(V)` の元数が `2^{|V|}` であること、`U_N(S)` が `Sub(V)` の元であること（`U_N` が `Sub(V)` の自己写像であること）、`w in U_N(S)` が「`S` の中に `w` を近傍に含む `v` が存在すること」と同値であること、空集合の像が空集合であることを分けて検査する | PASS |
| `check_composition.sage` | 本文の合成の証明。合併写像の定義による存在文への同値、合成近傍の定義による二段の存在文への展開、有限存在量化の並べ替え、`U_N(S)` を経由する形への書き換え、`U_M(U_N(S))` への同値、部分集合の外延性による各 `S` での等号、写像の外延性による全表の等号を分けて検査する。あわせて合成の向きが効いていること（`U_N ∘ U_M` では一致しない例があること）を証人つきで記録する | PASS |
| `check_identity.sage` | 本文の単位元の証明。合併写像の定義、一元集合への所属、等号による置換の各段と、部分集合・写像の外延性による恒等写像との一致を分けて検査する | PASS |
| `check_singleton_recovery.sage` | 本文の復元の証明。合併写像の定義、一元集合への所属、部分集合の外延性による `U_N({v}) = N(v)` の各段と、一元部分集合への値だけから割り当ての全表が復元できることを分けて検査する | PASS |
| `check_injectivity.sage` | 本文の単射性の証明。`N(v) = U_N({v})`、仮定による書き換え、`U_M({v}) = M(v)`、写像の外延性の各段を分けて検査する。あわせて相異なる割り当てが相異なる全表を与えること（割り当ての個数と表の個数の一致）を全数走査で確認する | PASS |
| `check_idempotence.sage` | 本文の同値の証明。順方向（合成の claim で書き換え、仮定 `N star N = N` を使う）と逆方向（合成の claim で書き換え、仮定を使い、単射性の claim を `N star N` と `N` に適用する）を分け、最後に二つの述語が全走査で一致することを検査する | PASS |
| `check_finite_decidability.sage` | 有限決定。入力集合の個数が `2^{|V|}` であること、各 `U_N(S)` がセルごとの所属判定だけで決まること、冪等性が全 `S` と全セルの所属判定の連言として決まり表の等号による判定と一致することを分けて検査する | PASS |

## 検証範囲

- 舞台元数は `|V| = 0, 1, 2, 3` である。近傍割り当ての総数は順に 1、2、16、512 で、
  合計 531 個を全て走った。合成の検査は割り当ての対を走るので合計 262,405 対である。
  単位元の検査だけは割り当てを走らないので `|V| = 4` まで含め、部分集合を 31 個走った。
- 合成冪等な割り当ては合計 137 個で、合併写像が冪等な割り当ての個数と完全に一致した。
  この個数は章「合成冪等な近傍割り当ての特徴づけ」の検算が同じ範囲で得た個数と一致する。
- `|V| = 4` は近傍割り当てが 65,536 個になるため、割り当てを走る検査では全走査していない。
- したがってこれは有限範囲の全数検査であって、任意の有限舞台に対する一般証明ではない。
  一般の場合の根拠は構造化記述の証明である。

## 走査で分かったこと（本文の記述との差）

- 本文の記述に修正を要する差は見つからなかった。
- 合成の向きについて補足を得た。本文は `U_{N star M} = U_M ∘ U_N` を主張しており、
  向きを逆にした `U_N ∘ U_M` では一致しない具体例が二元舞台に存在する
  （`N(0) = ∅`, `N(1) = {0}`, `M(0) = ∅`, `M(1) = {1}`）。本文は向きの必要性を
  主張していないので誤りではないが、この対応が反変であることは偶然ではない。

## 限界と帰属

- 有限集合、有限部分集合、有限写像表だけを使う。浮動小数点と `R/C` 脱出はない。
- 有限決定は判定手続きの一致まで検査したものであり、計算コストモデルそのものは検査していない。

## 実行方法

```bash
for file in sagemath/check/neighborhood-assignment-subset-union-action/check_*.sage; do sage "$file"; done
```
