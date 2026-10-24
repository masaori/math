# SageMath Check: 臨界点は Fisher 零点でない

**対象ラベル**: `claim_critical_point_not_fisher_zero`

$L\in\{1,2,3\}$ の全配位から多重度を数え、$s^2=2$ の二つの根について
$x_c=-1+s$ での評価 $\mathrm{Ev}^F_{x_c}(Z_L)=\sum_m\Omega_L(m)x_c^m$ が
零でないこと、$x_c$ が $Z_L$ の $\overline{\mathbb Q}$ における根の一覧に
現れないこと、値の表示 $\mathrm{rep}_s(\xi)$ が $(0,0)$ でなく正錐の条件を
満たすこと、および $(0,0)$ が正錐の三条件をすべて破ることを厳密計算で
確認する。浮動小数点は使わない。

```sh
sage sagemath/check/critical-point-not-fisher-zero/check.sage
```

**2026-08-18 実行: すべて通過。**


## 書式統一後の行別検算

2026-10-24: 本文の係数表示と評価定義、正錐と二次体の所属、
零表示と係数組の一致を別行へ分離した。記号の包含写像と零の所属も明示した。
`check_lines.sage` は次の十九行を実行する。各ファイルは単独でも実行できる。

| 本文の行 | ファイル |
|---|---|
| 係数表示への置換 | `check_coefficient_representation.sage` |
| 評価の定義 | `check_evaluation_definition.sage` |
| 有限和の値の定義 | `check_sum_definition.sage` |
| 値の正錐所属 | `check_positive_membership.sage` |
| 値の二次体所属 | `check_field_membership.sage` |
| 零点集合と評価零の同値 | `check_zero_set_definition.sage` |
| 値と評価の一致 | `check_value_evaluation.sage` |
| 評価零から値零への転送 | `check_zero_value_transfer.sage` |
| 零元の表示 | `check_zero_representation.sage` |
| 組の定義 | `check_pair_definition.sage` |
| 零表示から零組 | `check_zero_pair.sage` |
| 非零組条件の否定 | `check_nonzero_pair_condition.sage` |
| 零組の第一成分 | `check_first_coordinate.sage` |
| 零での非反射性 | `check_order_irreflexivity.sage` |
| 正の第一成分条件の否定 | `check_positive_first_condition.sage` |
| 負の第一成分条件の否定 | `check_negative_first_condition.sage` |
| 零表示の正錐非所属 | `check_zero_not_positive.sage` |
| 所属と非所属の両立不能 | `check_contradiction.sage` |
| 臨界点の零点非所属 | `check_not_fisher_zero.sage` |

入力は辺長一・二・三の全配位から独立に組んだ分配多項式と、平方が二となる二つの根である。
表示係数は評価値の最小多項式から回収し、入力した表示をそのまま答えとして使わない。
背理法の仮定「臨界点が零点である」は標本では成り立たない。
零点集合の定義は臨界点と実際の各根で同値を確かめ、零表示に関する行は零元で別途検査する。
矛盾の行は所属と非所属の連言が偽であることを検査する。
これらは有限標本と論理式の検算であり、一般の背理法の証明は Lean が担う。

必要十分版は零表示の非正値性を丸ごと仮定せず、具体版と同じ三分岐を内部で処理する。
要求する順序の性質は零での狭義順序の非反射性だけであり、全順序や体構造は要求しない。

実行結果（2026-10-24）: 統合検算の六組と行別十九本がすべて通過した。
行別「評価の定義」の単独 CLI 起動も通過した。
`lake build Ising2DLambda.FisherZero.CriticalPointNotFisherZeroFromNecSuf`、
本文検査（1,114ブロック、未解決参照なし）、検算対応検査（669件）が通過した。
