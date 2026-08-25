# SageMath 検算: 自己近傍舞台の可逆大域写像群

## 対象

**対象ラベル**: `claim_self_neighborhood_reversible_maps_classified_by_flip_sets`

- 併せて検証するラベル: `def_finite_self_neighborhood_flip_map`、`claim_general_self_neighborhood_pointwise_form`、`claim_binary_bijection_is_identity_or_negation`、`claim_general_self_neighborhood_reversible_pointwise_bijective`、`claim_self_neighborhood_flip_composition_symmetric_difference`、`claim_self_neighborhood_reversible_maps_finite_commutative_group`、`claim_self_neighborhood_reversible_map_cycle_types_general`
- 1 セルから 5 セルまでの自己近傍舞台について、全 1,364 局所規則族と全 62 反転集合を走査し、
  本文の各 claim を段ごとに分けて検査する。

## チェック一覧

| ファイル | 検証内容 | ステータス |
| --- | --- | --- |
| `check_pointwise_form_and_binary_bijection.sage` | 大域写像の点ごとの表示、2 元集合上の全単射が恒等写像か否定写像に限ること、可逆な大域写像の各セルの値写像が全単射であること | PASS |
| `check_classification_by_flip_sets.sage` | 反転集合から大域写像への対応が対合を与えること、単射性、可逆大域写像全体への全射性、元数 `2^|V|` | PASS |
| `check_composition_symmetric_difference.sage` | 合成が反転集合の対称差に一致すること、および合成の可換性 | PASS |
| `check_finite_commutative_group.sage` | 閉性、結合性、可換性、単位元が恒等写像であること、各元が自分自身の逆元であること、元数 | PASS |
| `check_cycle_types.sage` | 空の反転集合の巡回型が `2^|V|` 個の 1、空でない反転集合の写像に固定点が無く巡回型が `2^(|V|-1)` 個の 2 であること | PASS |

## 限界と帰属

- 1 セルから 5 セルまでの有限範囲の全数検査であり、任意の有限自己近傍舞台に対する一般証明ではない。
  一般の場合の根拠は構造化記述である。
- 有限集合、有限写像表、自然数、有限多重集合の等号だけを使う。浮動小数点と `R/C` 脱出はない。

## 実行方法

```bash
for file in sagemath/check/self-neighborhood-reversible-map-group/check_*.sage; do sage "$file"; done
```
