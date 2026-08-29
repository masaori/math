# SageMath 検算: 可逆な大域写像の巡回型

## 対象

**対象ラベル**: `claim_reversible_conjugacy_classes_bijection_partitions`

- 併せて検証するラベル: `def_bijective_self_maps`、`claim_bijective_self_map_all_elements_periodic`、`claim_periodic_orbit_card_eq_min_period`、`def_reversible_cycle_type`、`claim_bijective_self_map_orbits_partition_carrier`、`claim_reversible_cycle_type_sum`、`claim_reversible_cycle_type_conjugacy_invariance`、`claim_reversible_cycle_type_completeness`、`def_carrier_cardinality_partitions`、`claim_reversible_cycle_type_realizes_every_partition`、`def_bijective_self_map_conjugacy_classes`
- 元数 1・2・4・8 の配位集合、すなわちセル数 0・1・2・3 の固定舞台上の単射な自己写像 40,347 個を検査する。周期軌道の元数と最小周期の一致は、単射に限らない全自己写像 261 個（元数 1・2・4）で検査する。
- 有限写像表、有限置換、有限集合、正の自然数の有限多重集合だけを列挙し、浮動小数点を使わない。

## チェック一覧

| ファイル | 検証内容 | ステータス |
| --- | --- | --- |
| `check_reversible_maps_all_periodic.sage` | 単射な自己写像の個数と、可逆な大域写像で全配位が周期点になること | PASS |
| `check_orbit_card_eq_min_period.sage` | 反復による写像 θ の像が周期軌道であること、θ の単射性、周期軌道の元数と最小周期の一致 | PASS |
| `check_orbits_partition_configurations.sage` | 周期軌道の合併が配位集合であること、相異なる二軌道が交わらないこと | PASS |
| `check_cycle_type_sum.sage` | 巡回型の要素が正であること、重複度つき和が $2^{\|V\|}$ であること | PASS |
| `check_cycle_type_conjugacy_invariance.sage` | 共役全単射が周期軌道の全単射を導き、巡回型を保存すること | PASS |
| `check_cycle_type_completeness.sage` | 巡回型が等しい対での共役全単射の構成と共役条件、異なる対での共役全単射の非存在 | PASS |
| `check_partition_realization_and_quotient_bijection.sage` | 各分割の巡回置換による実現と、共役類と分割の対応（個数一致・類と巡回型の繊維の一致） | PASS |

## 限界と帰属

- 元数 1・2・4・8 の全数検査であり、任意の有限舞台に対する一般証明ではない。一般の場合の根拠は構造化記述である。
- 共役全単射の非存在は、元数 1・2・4 について有限置換の全数走査で確認した。元数 8 では、同じ巡回型を持つ代表と各写像の間で構成が共役条件を満たすことだけを検査した。
- 有限集合、自然数、有限写像表、有限置換、有限列・有限集合・有限多重集合の等号だけを使う。浮動小数点と `R/C` 脱出はない。

## 実行方法

```bash
for file in sagemath/check/reversible-global-map-cycle-type/check_*.sage; do sage "$file"; done
```
