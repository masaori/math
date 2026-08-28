# SageMath 検算: 合併作用の像は合併保存写像の全体である

## 対象

**対象ラベル**: `claim_subset_union_map_image_is_union_preserving_maps`

- 併せて検証するラベル:
  `def_union_preserving_subset_map`、
  `claim_subset_union_map_preserves_empty`、
  `claim_subset_union_map_preserves_union`、
  `claim_union_preserving_map_determined_by_singletons`、
  `claim_union_preserving_map_representation_unique`、
  `claim_union_preserving_map_count`、
  `claim_union_preserving_map_finite_decidable`
- 本文の証明を、二条件の成立、一元部分集合による決定、像の特徴づけ、表現の一意性、個数、
  有限決定の六つへ分け、最終式だけの一致で済ませない。

## チェック一覧

| ファイル | 検証内容 | ステータス |
| --- | --- | --- |
| `check_union_map_preserves_conditions.sage` | `U_N` が空集合を保つことと、二項合併保存の存在量化・論理分配・外延性の各段 | PASS |
| `check_singleton_determination.sage` | 空集合の場合と `S' = S ∖ {u}` を使う帰納段階、一元部分集合の像の合併による全ての値の復元 | PASS |
| `check_image_characterization.sage` | 合併保存なら `N(v)=Phi({v})` から表現できる向きと、合併作用なら二条件を満たす向き | PASS |
| `check_representation_uniqueness.sage` | 一元部分集合からの復元、相異なる割り当てが相異なる表を与えること、一意性 | PASS |
| `check_count.sage` | 全単射に対応する個数等式 `|UP(V)|=|N(V)|=(2^|V|)^|V|=2^{|V|^2}` の各段 | PASS |
| `check_finite_decidability.sage` | 有限表の所属判定による二条件の決定と、真の場合の近傍割り当ての有限構成 | PASS |

## 検証範囲

- 全ての部分集合写像を走る検査は舞台元数 `0 <= |V| <= 2` で行う。写像数は順に 1、4、256 である。
- 近傍割り当てから作る像を走る検査は `0 <= |V| <= 3` の全 531 割り当てを対象とする。
- `|V| = 3` の部分集合写像全体は `8^8 = 16,777,216` 個あるため全走査していない。
  したがってこれは有限範囲の全数検査であって、任意の有限舞台に対する一般証明ではない。
  一般の場合の根拠は構造化記述の証明である。
- 合併保存写像の個数は `|V| = 0, 1, 2, 3` で順に 1、2、16、512 となり、
  それぞれ `2^{|V|^2}` と一致した。

## 限界と帰属

- 有限集合、有限部分集合、有限写像表、自然数の厳密等号だけを使う。浮動小数点と `R/C` 脱出はない。
- 有限決定は所属判定による手続きと本文の上界の一致を検査する。実行時間のコストモデルは扱わない。

## 実行方法

```bash
for file in sagemath/check/neighborhood-assignment-union-preserving-image/check_*.sage; do sage "$file"; done
```
