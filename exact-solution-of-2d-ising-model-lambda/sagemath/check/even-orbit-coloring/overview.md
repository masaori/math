# SageMath Check: 偶数軌道の最小元を起点とする二色付け

**対象ラベル**: `def_even_orbit_minimum`, `def_even_orbit_coordinate`, `def_even_orbit_coloring`, `claim_even_orbit_minimum_color`, `claim_even_orbit_coloring`

有限番号集合の要素数 0〜6 の全置換から、全軌道の要素数が偶数のものを選ぶ。該当数は要素数 0, 2, 4, 6 に対してそれぞれ 1, 1, 9, 225。空集合も含む計236置換、元を指定した1,388件を用いる。末端358件、非末端1,030件を別々に検算する。

軌道は訪問済み集合、周期は最初の正の帰還時刻、座標は周期未満の反復の全列挙から計算する。二色付けは得られた座標の偶奇から定義し、後続座標の公式や所属反転を計算に用いない。すべて整数・有限集合の厳密計算であり、有限標本の検算を一般の証明とはしない。

| ファイル | 本文の行 | 状態 | 件数 |
|---|---|---|---|
| `check_coordinate_bound.sage` | 座標の範囲 | PASS | 1388 |
| `check_coordinate_value.sage` | 座標による元の復元 | PASS | 1388 |
| `check_coordinate_unique.sage` | 周期未満の座標の一意性 | PASS | 1388 |
| `check_period_cardinality.sage` | 最小周期と軌道の要素数 | PASS | 1388 |
| `check_period_even.sage` | 最小周期の偶数性 | PASS | 1388 |
| `check_successor_orbit.sage` | 後続元と元の軌道の一致 | PASS | 1388 |
| `check_successor_minimum.sage` | 軌道の最小元の不変性 | PASS | 1388 |
| `check_successor_period.sage` | 最小元からの周期の不変性 | PASS | 1388 |
| `check_successor_substitute.sage` | 元の表示の代入 | PASS | 1388 |
| `check_iterate_commute.sage` | 置換と反復の交換 | PASS | 1388 |
| `check_iterate_successor.sage` | 反復回数の後続 | PASS | 1388 |
| `check_interior_bound.sage` | 非末端の後続座標の範囲 | PASS | 1030 |
| `check_interior_value.sage` | 非末端の後続元の表示 | PASS | 1030 |
| `check_interior_coordinate.sage` | 非末端の後続座標の一意性 | PASS | 1030 |
| `check_interior_parity.sage` | 非末端の偶奇反転 | PASS | 1030 |
| `check_terminal_exponent.sage` | 末端の反復回数の代入 | PASS | 358 |
| `check_terminal_period.sage` | 一周期後の帰還 | PASS | 358 |
| `check_terminal_zero.sage` | 零回反復の表示 | PASS | 358 |
| `check_terminal_coordinate.sage` | 末端の後続座標は零 | PASS | 358 |
| `check_terminal_odd.sage` | 末端の座標は奇数 | PASS | 358 |
| `check_terminal_successor_even.sage` | 末端の後続座標は偶数 | PASS | 358 |
| `check_minimum_coordinate.sage` | 最小元の座標は零 | PASS | 1388 |
| `check_minimum_membership.sage` | 最小元は二色付け集合に属する | PASS | 1388 |
| `check_alternating_membership.sage` | 後続写像による所属の反転 | PASS | 1388 |
| `check_orbit_basepoint.sage` | 軌道内の任意の始点への変更 | PASS | 6424 |
| `check_minimum_le_forward.sage` | 軌道内の最小元の第一不等式 | PASS | 6424 |
| `check_minimum_le_reverse.sage` | 軌道内の最小元の第二不等式 | PASS | 6424 |
| `check_minimum_equal.sage` | 軌道内の最小元の等号 | PASS | 6424 |
| `check_minimum_orbit_membership.sage` | 最小元の元軌道への所属 | PASS | 1388 |
| `check_point_minimum_orbit_membership.sage` | 元の最小元軌道への所属 | PASS | 1388 |
| `check_minimum_idempotent.sage` | 最小元の最小元 | PASS | 1388 |
| `check_minimum_period_substitute.sage` | 最小元の周期の代入 | PASS | 1388 |
| `check_minimum_period_abbreviation.sage` | 最小元の周期の略記 | PASS | 1388 |
| `check_minimum_zero_iteration.sage` | 最小元の零回反復 | PASS | 1388 |
| `check_positive_period.sage` | 最小周期の正値性 | PASS | 1388 |
| `check_minimum_remainder_substitute.sage` | 最小元の座標零の剰余への代入 | PASS | 1388 |
| `check_zero_remainder.sage` | 零の剰余 | PASS | 1388 |
| `check_one_iteration_recurse.sage` | 一回反復の再帰 | PASS | 1388 |
| `check_one_iteration_zero.sage` | 一回反復の零回計算 | PASS | 1388 |
| `check_successor_orbit_membership.sage` | 後続元の軌道への所属 | PASS | 1388 |
| `check_successor_coordinate_bound.sage` | 後続座標の範囲 | PASS | 1388 |
| `check_successor_basepoint_substitute.sage` | 後続座標の最小元代入 | PASS | 1388 |
| `check_successor_coordinate_spec.sage` | 後続座標の復元 | PASS | 1388 |
| `check_period_remainder_cardinality.sage` | 周期と長さの剰余 | PASS | 1388 |
| `check_orbit_even_hypothesis.sage` | 最小元の軌道長の偶数性 | PASS | 1388 |
| `check_interior_even_substitute.sage` | 非末端で元座標が偶数: 後続座標代入 | PASS | 694 |
| `check_interior_even_mod_add.sage` | 非末端で元座標が偶数: 和の剰余 | PASS | 694 |
| `check_interior_even_mod_zero.sage` | 非末端で元座標が偶数: 零代入 | PASS | 694 |
| `check_interior_even_evaluate.sage` | 非末端で元座標が偶数: 計算 | PASS | 694 |
| `check_interior_odd_substitute.sage` | 非末端で元座標が奇数: 後続座標代入 | PASS | 336 |
| `check_interior_odd_mod_add.sage` | 非末端で元座標が奇数: 和の剰余 | PASS | 336 |
| `check_interior_odd_mod_one.sage` | 非末端で元座標が奇数: 一代入 | PASS | 336 |
| `check_interior_odd_evaluate.sage` | 非末端で元座標が奇数: 計算 | PASS | 336 |
| `check_terminal_exponent_equal.sage` | 末端の後続回数は周期 | PASS | 358 |
| `check_terminal_iteration_equal.sage` | 末端の一歩の等号 | PASS | 358 |
| `check_terminal_remainder_nonzero.sage` | 末端の座標の剰余は非零 | PASS | 358 |
| `check_terminal_equivalence.sage` | 末端の剰余の同値 | PASS | 358 |
| `check_membership_successor_definition.sage` | 後続元所属と剰余零の同値 | PASS | 1388 |
| `check_membership_parity_equivalence.sage` | 後続座標と元座標の剰余の同値 | PASS | 1388 |
| `check_membership_complement_definition.sage` | 元座標非零と補集合所属の同値 | PASS | 1388 |
| `check_terminal_contradiction_zero.sage` | 末端偶数仮定の反証: zero | 対象事例なし | 0 |
| `check_terminal_contradiction_exponent.sage` | 末端偶数仮定の反証: exponent | 対象事例なし | 0 |
| `check_terminal_contradiction_mod_add.sage` | 末端偶数仮定の反証: mod_add | 対象事例なし | 0 |
| `check_terminal_contradiction_substitute.sage` | 末端偶数仮定の反証: substitute | 対象事例なし | 0 |
| `check_terminal_contradiction_evaluate.sage` | 末端偶数仮定の反証: evaluate | 対象事例なし | 0 |
| `check_empty_coloring.sage` | 空集合の第一色 | PASS | 1 |
| `check_coloring_subset.sage` | 第一色の部分集合性 | PASS | 236 |
| `check_habitats.sage` | 最小元・周期・座標・余りの所属 | PASS | 1388 |
| `check_minimum_general.sage` | 偶数長条件なしの最小元所属 | PASS | 5039 |

## 実行方法

プロジェクト直下で各 `check_*.sage` を単独実行する。

```sh
for f in sagemath/check/even-orbit-coloring/check_*.sage; do
  sage "$f" || exit
done
```

## 反証の枝

末端で座標が偶数であるという追加仮定は、対象の全置換で成立しない。対応する五ファイルは条件を満たす事例が零件であることを記録するだけで、反証の各等号を数値検証済みとはしない。この枝の論理的妥当性は Lean が担う。末端の座標が奇数になることと両辺が真になる同値は、別ファイルで358件を検算する。

最小元の第一色への所属は、偶数長条件を外した要素数0〜6の全874置換・5,039元についても独立に検査する（長さ一・奇数長の軌道を含む）。

## 実行結果

2026-10-24: 69ファイルを個別に起動し、すべて終了コード0。64ファイルは非空の対象集合について等号・所属・順序・同値を検算し、反証の枝の5ファイルは事例が存在しないことだけを確認した。一般の論証と反証の枝は Lean の検証対象である。

`check_minimum_general.sage` の初回起動はリポジトリ直下から行ったため、プロジェクト直下を基準とする共通ファイルを読めず停止した。実行方法に従ってプロジェクト直下で再実行し、全874置換・5,039元で通過した。検証条件やコードの緩和はしていない。
