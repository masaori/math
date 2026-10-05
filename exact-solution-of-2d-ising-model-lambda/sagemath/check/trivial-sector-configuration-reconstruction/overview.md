# SageMath Check: 自明セクターからの配位の復元

## 対象

**対象ラベル**: `claim_trivial_sector_configuration_reconstruction`

- 併せて検証: `def_broken_edge_set`、`def_dual_edge_map`、`def_torus_homology_sector`
- 範囲: 自明セクターの偶部分グラフが破れた辺集合の双対像として実現し、原像が全スピン反転の二配位であること

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
|---|---|---|---|
| `check_horizontal_interior_projection_addition.sage` | 非境界の横辺差：射影の加法保存 | PASS | 1,552 等式 |
| `check_horizontal_interior_projection_representative.sage` | 非境界の横辺差：代表を射影して元の座標へ | PASS | 1,552 等式 |
| `check_horizontal_interior_projection_one.sage` | 非境界の横辺差：一の射影を剰余類の一へ | PASS | 1,552 等式 |
| `check_horizontal_interior_representative_substitution.sage` | 非境界の横辺差：次の座標を射影の等式で置換 | PASS | 1,552 等式 |
| `check_horizontal_interior_representative_range.sage` | 非境界の横辺差：範囲内の代表の一意性 | PASS | 1,552 等式 |
| `check_horizontal_interior_path_expansion.sage` | 非境界の横辺差：二つの道和の定義を展開 | PASS | 1,552 等式 |
| `check_horizontal_interior_successor_representative.sage` | 非境界の横辺差：次の座標の代表を代入 | PASS | 1,552 等式 |
| `check_horizontal_interior_last_term.sage` | 非境界の横辺差：有限和の末尾の一項を分離 | PASS | 1,552 等式 |
| `check_horizontal_interior_associate_inner.sage` | 非境界の横辺差：先の道和の加法の結合則 | PASS | 1,552 等式 |
| `check_horizontal_interior_associate_outer.sage` | 非境界の横辺差：三項の加法の結合則 | PASS | 1,552 等式 |
| `check_horizontal_interior_commute.sage` | 非境界の横辺差：末尾の項と元の道和を交換 | PASS | 1,552 等式 |
| `check_horizontal_interior_regroup.sage` | 非境界の横辺差：同じ道和の二項を括る | PASS | 1,552 等式 |
| `check_horizontal_interior_double_zero.sage` | 非境界の横辺差：標数二で重複する道和を取消 | PASS | 1,552 等式 |
| `check_horizontal_interior_remove_zero.sage` | 非境界の横辺差：零との加法 | PASS | 1,552 等式 |
| `check_horizontal_interior_terminal_projection.sage` | 非境界の横辺差：末尾の代表を射影して元の座標へ | PASS | 1,552 等式 |
| `check.sage` | $L=1,2,3$ について、自明セクターの偶部分グラフ全体と全配位の双対破れ像全体が一致し、各原像が全スピン反転の二配位であることを厳密検査する | PASS | 全件一致 |
| `check_inverse_indicator.sage` | 双対逆写像と自然数指示関数の対応 | PASS | 4,674 辺 |
| `check_face_incidence_definition.sage` | 端点数を端点番号付き有限和へ | PASS | 2,337 頂点 |
| `check_face_incident_edges.sage` | 端点写像で四つの位置へ | PASS | 2,337 頂点 |
| `check_face_inverse_indicator.sage` | 四つの指示関数を双対原像へ | PASS | 2,337 頂点 |
| `check_face_inverse_formula.sage` | 双対逆写像の座標式を代入 | PASS | 2,337 頂点 |
| `check_face_reindex.sage` | 四項の有限和の位置を再添字付け | PASS | 2,337 頂点 |
| `check_face_indicator_projection.sage` | 面の四つの剰余類を定義で展開 | PASS | 2,337 頂点 |
| `check_face_projection_addition.sage` | 射影が四項の和を保つ | PASS | 2,337 頂点 |
| `check_face_incidence_substitution.sage` | 端点数の計算を代入 | PASS | 2,337 頂点 |
| `check_face_even_incidence.sage` | 偶部分グラフの端点数は二の倍数 | PASS | 2,337 頂点 |
| `check_face_even_projection_zero.sage` | 二の倍数の剰余類は零 | PASS | 2,337 頂点 |
| `check_base_vertical_indicator_projection.sage` | 基準列の縦辺：周期和の各項を定義で展開 | PASS | 265 部分グラフ |
| `check_base_vertical_projection_sum.sage` | 基準列の縦辺：射影が有限和を保つ | PASS | 265 部分グラフ |
| `check_base_vertical_reindex.sage` | 基準列の縦辺：周期添字を一つ戻す全単射 | PASS | 265 部分グラフ |
| `check_base_vertical_inverse_formula.sage` | 基準列の縦辺：双対逆写像の式へ戻す | PASS | 265 部分グラフ |
| `check_base_vertical_inverse_indicator.sage` | 基準列の縦辺：原像の指示関数を元の指示関数へ | PASS | 265 部分グラフ |
| `check_base_vertical_cut_count.sage` | 基準列の縦辺：単射な辺番号による境界辺の個数 | PASS | 265 部分グラフ |
| `check_base_vertical_remainder_projection.sage` | 基準列の縦辺：自然数と二で割った余りの射影は等しい | PASS | 265 部分グラフ |
| `check_base_vertical_winding_definition.sage` | 基準列の縦辺：巻き付き偶奇の定義 | PASS | 265 部分グラフ |
| `check_base_vertical_trivial_sector.sage` | 基準列の縦辺：自明セクターの巻き付き偶奇は零 | PASS | 265 部分グラフ |
| `check_base_vertical_zero_projection.sage` | 基準列の縦辺：零の射影は零 | PASS | 265 部分グラフ |
| `check_base_horizontal_indicator_projection.sage` | 基準行の横辺：周期和の各項を定義で展開 | PASS | 265 部分グラフ |
| `check_base_horizontal_projection_sum.sage` | 基準行の横辺：射影が有限和を保つ | PASS | 265 部分グラフ |
| `check_base_horizontal_reindex.sage` | 基準行の横辺：周期添字を一つ戻す全単射 | PASS | 265 部分グラフ |
| `check_base_horizontal_inverse_formula.sage` | 基準行の横辺：双対逆写像の式へ戻す | PASS | 265 部分グラフ |
| `check_base_horizontal_inverse_indicator.sage` | 基準行の横辺：原像の指示関数を元の指示関数へ | PASS | 265 部分グラフ |
| `check_base_horizontal_cut_count.sage` | 基準行の横辺：単射な辺番号による境界辺の個数 | PASS | 265 部分グラフ |
| `check_base_horizontal_remainder_projection.sage` | 基準行の横辺：自然数と二で割った余りの射影は等しい | PASS | 265 部分グラフ |
| `check_base_horizontal_winding_definition.sage` | 基準行の横辺：巻き付き偶奇の定義 | PASS | 265 部分グラフ |
| `check_base_horizontal_trivial_sector.sage` | 基準行の横辺：自明セクターの巻き付き偶奇は零 | PASS | 265 部分グラフ |
| `check_base_horizontal_zero_projection.sage` | 基準行の横辺：零の射影は零 | PASS | 265 部分グラフ |
| `check_invariance_local_row_abbreviation.sage` | 横辺の一項：局所記号へ移す | PASS | 9,348 頂点 |
| `check_invariance_local_row_add_zero.sage` | 横辺の一項：零を加える | PASS | 9,348 頂点 |
| `check_invariance_local_row_double_zero.sage` | 横辺の一項：零を同じ剰余類二項の和へ戻す | PASS | 9,348 頂点 |
| `check_invariance_local_row_associate_outer.sage` | 横辺の一項：外側の和を結合し直す | PASS | 9,348 頂点 |
| `check_invariance_local_row_commute.sage` | 横辺の一項：格子面の順序へ二項を交換する | PASS | 9,348 頂点 |
| `check_invariance_local_row_substitute_face.sage` | 横辺の一項：格子面の等式を代入する | PASS | 9,348 頂点 |
| `check_invariance_local_row_remove_zero.sage` | 横辺の一項：零を除く | PASS | 9,348 頂点 |
| `check_invariance_local_row_expand_abbreviations.sage` | 横辺の一項：局所記号を辺の指示関数へ戻す | PASS | 9,348 頂点 |
| `check_invariance_local_column_abbreviation.sage` | 縦辺の一項：局所記号へ移す | PASS | 9,348 頂点 |
| `check_invariance_local_column_add_zero.sage` | 縦辺の一項：零を加える | PASS | 9,348 頂点 |
| `check_invariance_local_column_double_zero.sage` | 縦辺の一項：零を同じ剰余類二項の和へ戻す | PASS | 9,348 頂点 |
| `check_invariance_local_column_associate_outer.sage` | 縦辺の一項：外側の和を結合し直す | PASS | 9,348 頂点 |
| `check_invariance_local_column_associate_inner.sage` | 縦辺の一項：内側の和を結合し直す | PASS | 9,348 頂点 |
| `check_invariance_local_column_commute.sage` | 縦辺の一項：格子面の順序へ二項を交換する | PASS | 9,348 頂点 |
| `check_invariance_local_column_substitute_face.sage` | 縦辺の一項：格子面の等式を代入する | PASS | 9,348 頂点 |
| `check_invariance_local_column_remove_zero.sage` | 縦辺の一項：零を除く | PASS | 9,348 頂点 |
| `check_invariance_local_column_expand_abbreviations.sage` | 縦辺の一項：局所記号を辺の指示関数へ戻す | PASS | 9,348 頂点 |
| `check_invariance_row_sum_substitute_local.sage` | 横辺の行和：隣の一項の等式を有限和へ代入する | PASS | 3,140 行・列 |
| `check_invariance_row_sum_split_outer_sum.sage` | 横辺の行和：外側の有限和を分配する | PASS | 3,140 行・列 |
| `check_invariance_row_sum_split_inner_sum.sage` | 横辺の行和：内側の有限和を分配する | PASS | 3,140 行・列 |
| `check_invariance_row_sum_reindex.sage` | 横辺の行和：巡回移動で有限和を再添字付けする | PASS | 3,140 行・列 |
| `check_invariance_row_sum_associate_right.sage` | 横辺の行和：和を右に結合する | PASS | 3,140 行・列 |
| `check_invariance_row_sum_commute_inner.sage` | 横辺の行和：内側の二項を交換する | PASS | 3,140 行・列 |
| `check_invariance_row_sum_associate_left.sage` | 横辺の行和：同じ和を左に結合する | PASS | 3,140 行・列 |
| `check_invariance_row_sum_cancel_double.sage` | 横辺の行和：標数二で同じ和の二項を消去する | PASS | 3,140 行・列 |
| `check_invariance_row_sum_remove_zero.sage` | 横辺の行和：零を除く | PASS | 3,140 行・列 |
| `check_invariance_column_sum_substitute_local.sage` | 縦辺の列和：隣の一項の等式を有限和へ代入する | PASS | 3,140 行・列 |
| `check_invariance_column_sum_split_outer_sum.sage` | 縦辺の列和：外側の有限和を分配する | PASS | 3,140 行・列 |
| `check_invariance_column_sum_split_inner_sum.sage` | 縦辺の列和：内側の有限和を分配する | PASS | 3,140 行・列 |
| `check_invariance_column_sum_reindex.sage` | 縦辺の列和：巡回移動で有限和を再添字付けする | PASS | 3,140 行・列 |
| `check_invariance_column_sum_regroup.sage` | 縦辺の列和：同じ有限和の二項をまとめる | PASS | 3,140 行・列 |
| `check_invariance_column_sum_cancel_double.sage` | 縦辺の列和：標数二で同じ和の二項を消去する | PASS | 3,140 行・列 |
| `check_invariance_column_sum_remove_zero.sage` | 縦辺の列和：零を除く | PASS | 3,140 行・列 |
| `check_period_row_base_projection.sage` | 横辺の行和：基底で射影の零を代入 | PASS | 265 部分グラフ |
| `check_period_row_base_zero.sage` | 横辺の行和：基底で座標の零を除く | PASS | 265 部分グラフ |
| `check_period_row_base_initial.sage` | 横辺の行和：基準周期和の零を適用 | PASS | 265 部分グラフ |
| `check_period_row_step_projection.sage` | 横辺の行和：帰納段階で射影の加法を展開 | PASS | 785 行・列 |
| `check_period_row_step_one.sage` | 横辺の行和：一の射影を代入 | PASS | 785 行・列 |
| `check_period_row_step_associate.sage` | 横辺の行和：座標の加法を結び直す | PASS | 785 行・列 |
| `check_period_row_step_invariance.sage` | 横辺の行和：一歩の不変性を適用 | PASS | 785 行・列 |
| `check_period_row_step_induction.sage` | 横辺の行和：帰納法の仮定を適用 | PASS | 785 行・列 |
| `check_period_row_representative_zero.sage` | 横辺の行和：任意の座標へ零を加える | PASS | 785 行・列 |
| `check_period_row_representative_inverse.sage` | 横辺の行和：座標の零を逆元との和に戻す | PASS | 785 行・列 |
| `check_period_row_representative_associate.sage` | 横辺の行和：任意座標の加法を結び直す | PASS | 785 行・列 |
| `check_period_row_representative_commute.sage` | 横辺の行和：一と任意座標を交換 | PASS | 785 行・列 |
| `check_period_row_representative_section.sage` | 横辺の行和：代表の射影へ置き換える | PASS | 785 行・列 |
| `check_period_row_representative_induction.sage` | 横辺の行和：非負代表へ帰納法の結論を適用 | PASS | 785 行・列 |
| `check_period_column_base_projection.sage` | 縦辺の列和：基底で射影の零を代入 | PASS | 265 部分グラフ |
| `check_period_column_base_zero.sage` | 縦辺の列和：基底で座標の零を除く | PASS | 265 部分グラフ |
| `check_period_column_base_initial.sage` | 縦辺の列和：基準周期和の零を適用 | PASS | 265 部分グラフ |
| `check_period_column_step_projection.sage` | 縦辺の列和：帰納段階で射影の加法を展開 | PASS | 785 行・列 |
| `check_period_column_step_one.sage` | 縦辺の列和：一の射影を代入 | PASS | 785 行・列 |
| `check_period_column_step_associate.sage` | 縦辺の列和：座標の加法を結び直す | PASS | 785 行・列 |
| `check_period_column_step_invariance.sage` | 縦辺の列和：一歩の不変性を適用 | PASS | 785 行・列 |
| `check_period_column_step_induction.sage` | 縦辺の列和：帰納法の仮定を適用 | PASS | 785 行・列 |
| `check_period_column_representative_zero.sage` | 縦辺の列和：任意の座標へ零を加える | PASS | 785 行・列 |
| `check_period_column_representative_inverse.sage` | 縦辺の列和：座標の零を逆元との和に戻す | PASS | 785 行・列 |
| `check_period_column_representative_associate.sage` | 縦辺の列和：任意座標の加法を結び直す | PASS | 785 行・列 |
| `check_period_column_representative_commute.sage` | 縦辺の列和：一と任意座標を交換 | PASS | 785 行・列 |
| `check_period_column_representative_section.sage` | 縦辺の列和：代表の射影へ置き換える | PASS | 785 行・列 |
| `check_period_column_representative_induction.sage` | 縦辺の列和：非負代表へ帰納法の結論を適用 | PASS | 785 行・列 |
| `check_horizontal_indicator_projection.sage` | 横辺の自然数指示関数を π₂ で写す | PASS | 2,337 頂点 |
| `check_vertical_indicator_projection.sage` | 縦辺の自然数指示関数を π₂ で写す | PASS | 2,337 頂点 |
| `check_parity_representative.sage` | 自然数代表 s₂ の帰属と π₂(s₂(a))=a | PASS | 二元の全件 |
| `check_path_parity_definition.sage` | 基点からの辺列の端点と所属数による道和の独立計算 | PASS | 2,337 頂点、うち空の道 265 個 |
| `check_spin_zero_substitution.sage` | 零代表を整数冪の指数へ代入 | PASS | 1 等式 |
| `check_spin_zero_power.sage` | 整数の零乗を評価 | PASS | 1 等式 |
| `check_spin_one_substitution.sage` | 一代表を整数冪の指数へ代入 | PASS | 1 等式 |
| `check_spin_one_power.sage` | 整数の一乗を評価 | PASS | 1 等式 |
| `check_configuration_definition.sage` | σ_A=(-1)^{s₂(t)} と二値スピンの対応 | PASS | 二元と全 2,337 頂点 |
| `check_spin_disagreement_four_cases.sage` | 二元の四通りによる符号不一致と和が一の同値 | PASS | 四通りすべて |
| `check_horizontal_difference.sage` | 横辺の道和差（空和と周期境界を含む） | PASS | 2,337 頂点 |
| `check_vertical_path_expansion.sage` | t(i+1,j)+t(i,j) から定義を展開 | PASS | 1,552 頂点 |
| `check_vertical_face_substitution.sage` | 横辺二項の有限和へ面の等式を各項代入 | PASS | 1,552 頂点 |
| `check_vertical_telescoping.sage` | 隣接二項の有限和を π(s(j)) と π(0) の端点和へ | PASS | 1,552 頂点 |
| `check_vertical_terminal_representative.sage` | 端点 π(s(j)) を j へ戻す | PASS | 1,552 頂点 |
| `check_vertical_zero_projection.sage` | 端点 π(0) を零へ戻す | PASS | 1,552 頂点 |
| `check_vertical_characteristic_two.sage` | 標数二で二つの b_v(i,0) を消去 | PASS | 1,552 頂点 |
| `check_vertical_periodic_boundary.sage` | 末尾の行で列和零から同じ縦辺差を確認 | PASS | 785 頂点 |
| `check_broken_definition.sage` | 破れた辺への所属と端点スピンの不一致 | PASS | 4,674 辺 |
| `check_broken_exponent_substitution.sage` | 端点スピンへ自然数指数による配位の定義を代入 | PASS | 4,674 辺 |
| `check_broken_parity.sage` | 整数冪の不一致と端点の道和の和が一の同値 | PASS | 4,674 辺 |
| `check_broken_membership.sage` | 端点の道和差を使い B への所属へ戻す | PASS | 4,674 辺 |
| `check_dual_image_substitution.sage` | δ_L(破れた辺集合)=δ_L(B) | PASS | 265 部分グラフ |
| `check_dual_image_inverse.sage` | δ_L(B)=A | PASS | 265 部分グラフ |

行和・列和の不変性を除く行別検算は辺部分集合を全列挙し、偶部分グラフ性と二つの巻き付き偶奇で自明セクターを選ぶ。
各 $A$ から双対辺写像の逆像 $B$ と基点付き道和 $t$ を直接構成し、配位の全列挙を使わず
自然数代表 $s_2$ による整数の冪で配位を復元する。計算は $\mathbb Z/2\mathbb Z$、
$\mathbb N$、$\mathbb Z$ 内で厳密に行う。

縦辺差の六等号は本文の条件 $s(i)<L-1$ で一行ずつ検査する。
末尾の行は別ファイルで列和の零性と縦辺差を検査し、$L=1$ の自己ループも含める。
横辺差は周期境界を含む全頂点で検査し、縦辺差の望遠鏡和には $s(j)=0$ の空和を含める。
有限個の格子サイズの検算を、一般の $L$ に対する証明とは扱わない。

## 実行方法

```sh
micromamba run -p /home/masaori/.local/share/math-mamba/envs/sage sage -c "__file__ = 'sagemath/check/trivial-sector-configuration-reconstruction/check.sage'; load(__file__)"
```

統合検算と行別検算をまとめて再実行する場合は、読み込み対象を `__file__` へ明示する。

```sh
micromamba run -p /home/masaori/.local/share/math-mamba/envs/sage sage -c "import glob; fs=sorted(glob.glob('sagemath/check/trivial-sector-configuration-reconstruction/check*.sage')); exec('for f in fs:\n    __file__ = f\n    load(f)')"
```

**2026-08-12 実行: すべて通過。**

2026-10-05 非境界の横辺差のレビュー: 代表の繰り上がりの五等号と道和差の十等号を
行別15本へ分け、全23,280等式が通過した。辺長一から三の自明セクター部分グラフ全265個を
列挙し、非境界の横辺の始点1,552個（辺長一は0個、二は16個、三は1,536個）を各行で検算した。
既存を含む全132ファイルも通過した。本文と独立の Lean 具体版は非境界の横辺差を扱い、
必要十分版は二点での道和表示・代表の増分・重複する道和の自己和零と加法の性質だけを残す。
横辺の周期境界、縦辺差以降のレビューと、存在構成全体の必要十分版・導出版は未了である。

2026-10-05 道和と配位の定義のレビュー: 辺番号の列と端点から道を独立に作り、
辺長一から三の全265自明セクター部分グラフについて、2,337頂点の所属数の偶奇が道和に一致した。
基点の空の道265個を含む。自然数代表が零・一である二場合の四等号を行別四本へ分け、
既存を含む全117ファイルの検算が通過した。Lean 具体版は整数冪の値域を二場合で独立に示して
配位を定義し、必要十分版は代表の二場合と評価写像の二点での値だけを残す。
横辺差・縦辺差・周期境界のレビューと、道和による存在構成全体の必要十分版は未了である。

2026-10-04 実行: 原像二点の検算を再実行し、追加した行別19本もすべて通過した。
自明セクターは $L=1,2,3$ でそれぞれ1、8、256個。縦辺差は内部の1,552頂点と
周期境界の785頂点を分けて検査し、所属の四同値は全4,674辺で一致した。

2026-10-04 格子面と基準二周期和の追加検算: 指示関数の対応1本、端点数5本、
格子面の射影5本、基準縦周期和10本、基準横周期和10本を加え、行別50本すべて通過した。
端点数は辺と端点番号の組を数えるため、$L=1$ でも自己ループの二端点を別々に数える。
格子面は全2,337頂点、基準周期和は全265部分グラフで、本文の各等号を個別に検査した。
通常のファイル指定による起動は Sage 10.9 の `__file__` が読み込み先を指さず失敗したため、
上記の明示的な `load` で再実行した。数学的な検査はすべて通過した。

2026-10-04 行和・列和の不変性の追加検算: 本文の局所二式を17等号、行和・列和を
16等号へ分け、行別33本を追加した。自明セクターという条件はこの不変性に不要なので、
$L=1,2,3$ の偶部分グラフをそれぞれ4、32、1,024個すべて検査した。
各局所等号は全9,348頂点、各行和・列和の等号は全3,140行・列で検査し、
追加分の全209,156等式が一致した。既存検算も含む84本（統合1本・行別83本）すべて通過した。

2026-10-04 全行・全列の周期和零の追加検算: 基底3等号・帰納段階5等号・任意代表への
適用6等号を各向きについて追加し、行別28本・全18,860等式が通過した。
$L=1,2,3$ の自明セクターの265部分グラフを対象とし、基底は各265件、
帰納段階と任意代表は各785件を検査した。帰納変数の有限検算は $0,\ldots,L-1$ に限り、
全自然数への帰納法は Lean 具体版と必要十分版で証明する。
既存も含む112本（統合1本・行別111本）を再実行し、すべて通過した。
本文と具体版は28等号が一対一で対応し、必要十分版は出発点・一歩・全点を覆う歩みだけを残す。
導出版で歩みと代表を実際の剰余類へ戻した。道和差と周期境界以降の本文レビュー、
および存在構成全体の Lean 必要十分版は残っている。
