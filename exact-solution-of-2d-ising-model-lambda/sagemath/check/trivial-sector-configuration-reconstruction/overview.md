# SageMath Check: 自明セクターからの配位の復元

## 対象

**対象ラベル**: `claim_trivial_sector_configuration_reconstruction`

- 併せて検証: `def_broken_edge_set`、`def_dual_edge_map`、`def_torus_homology_sector`
- 範囲: 自明セクターの偶部分グラフが破れた辺集合の双対像として実現し、原像が全スピン反転の二配位であること

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
|---|---|---|---|
| `check.sage` | $L=1,2,3$ について、自明セクターの偶部分グラフ全体と全配位の双対破れ像全体が一致し、各原像が全スピン反転の二配位であることを厳密検査する | PASS | 全件一致 |
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
sage sagemath/check/trivial-sector-configuration-reconstruction/check.sage
```

**2026-08-12 実行: すべて通過。**

2026-10-04 実行: 原像二点の検算を再実行し、追加した行別19本もすべて通過した。
自明セクターは $L=1,2,3$ でそれぞれ1、8、256個。縦辺差は内部の1,552頂点と
周期境界の785頂点を分けて検査し、所属の四同値は全4,674辺で一致した。
