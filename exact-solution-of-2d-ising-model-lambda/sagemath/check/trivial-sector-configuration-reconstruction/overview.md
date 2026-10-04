# SageMath Check: 自明セクターからの配位の復元

## 対象

**対象ラベル**: `claim_trivial_sector_configuration_reconstruction`

- 併せて検証: `def_broken_edge_set`、`def_dual_edge_map`、`def_torus_homology_sector`
- 範囲: 自明セクターの偶部分グラフが破れた辺集合の双対像として実現し、原像が全スピン反転の二配位であること

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
|---|---|---|---|
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
| `check_horizontal_indicator_projection.sage` | 横辺の自然数指示関数を π₂ で写す | PASS | 2,337 頂点 |
| `check_vertical_indicator_projection.sage` | 縦辺の自然数指示関数を π₂ で写す | PASS | 2,337 頂点 |
| `check_parity_representative.sage` | 自然数代表 s₂ の帰属と π₂(s₂(a))=a | PASS | 二元の全件 |
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

行別検算は辺部分集合を全列挙し、偶部分グラフ性と二つの巻き付き偶奇で自明セクターを選ぶ。
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

**2026-08-12 実行: すべて通過。**

2026-10-04 実行: 原像二点の検算を再実行し、追加した行別19本もすべて通過した。
自明セクターは $L=1,2,3$ でそれぞれ1、8、256個。縦辺差は内部の1,552頂点と
周期境界の785頂点を分けて検査し、所属の四同値は全4,674辺で一致した。

2026-10-04 格子面と基準二周期和の追加検算: 指示関数の対応1本、端点数5本、
格子面の射影5本、基準縦周期和10本、基準横周期和10本を加え、行別50本すべて通過した。
端点数は辺と端点番号の組を数えるため、$L=1$ でも自己ループの二端点を別々に数える。
格子面は全2,337頂点、基準周期和は全265部分グラフで、本文の各等号を個別に検査した。
通常のファイル指定による起動は Sage 10.9 の `__file__` が読み込み先を指さず失敗したため、
上記の明示的な `load` で再実行した。数学的な検査はすべて通過した。
行和・列和の不変性以降の本文レビュー、および存在構成全体の Lean 必要十分版は今回の検算範囲に含めない。
