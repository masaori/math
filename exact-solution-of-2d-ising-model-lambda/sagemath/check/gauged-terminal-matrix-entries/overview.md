# 対角相似した端末行列の成分

**対象ラベル**: `claim_gauged_terminal_matrix_entries`。定義は `def_gauged_terminal_matrix`。

円分体 $\mathbb Q(\zeta_8)$ とその一変数多項式環で計算し、浮動小数点も変数への数値代入も使わない。
辺長一・二・三、四ねじれ、四乗が負の一である四根を調べる。
端点・反転・後続条件から遷移行列と Kac–Ward 行列を構成して行列積を求め、
本文の成分式から作った行列と独立に比較する。一辺一で二条件が重なる64成分も調べる。

零項の四等号は、乗じる行または列の相異なる多項式を一度ずつ調べる。
同じ多項式値を取る添字だけを重複排除し、各対角成分以外の位置を網羅する。
残る成分の計算鎖は全成分を調べる。有限例の検算であり、一般の辺長の証明は本文と Lean が担う。

| ファイル | 計算鎖 | ステータス | 等式数 |
|---|---|---|---:|
| `check_left_zero_mapped_entry.sage` | 左側の零項：定数多項式の成分 | PASS | 120,768 |
| `check_left_zero_diagonal_zero.sage` | 左側の零項：非対角成分の零 | PASS | 120,768 |
| `check_left_zero_embedded_zero.sage` | 左側の零項：定数埋込みの零の保存 | PASS | 120,768 |
| `check_left_zero_absorb_zero.sage` | 左側の零項：零の乗法 | PASS | 120,768 |
| `check_left_entry_finite_sum.sage` | 左側の積の成分：行列積を有限和へ開く | PASS | 25,088 |
| `check_left_entry_select_row.sage` | 左側の積の成分：一行の選択 | PASS | 25,088 |
| `check_left_entry_embedded_diagonal.sage` | 左側の積の成分：対角成分の埋込み | PASS | 25,088 |
| `check_left_entry_diagonal_weight.sage` | 左側の積の成分：対角重みの代入 | PASS | 25,088 |
| `check_right_zero_mapped_entry.sage` | 右側の零項：定数多項式の成分 | PASS | 93,872 |
| `check_right_zero_diagonal_zero.sage` | 右側の零項：非対角成分の零 | PASS | 93,872 |
| `check_right_zero_embedded_zero.sage` | 右側の零項：定数埋込みの零の保存 | PASS | 93,872 |
| `check_right_zero_absorb_zero.sage` | 右側の零項：零の乗法 | PASS | 93,872 |
| `check_right_entry_finite_sum.sage` | 右側の積の成分：行列積を有限和へ開く | PASS | 25,088 |
| `check_right_entry_select_column.sage` | 右側の積の成分：一列の選択 | PASS | 25,088 |
| `check_right_entry_embedded_diagonal.sage` | 右側の積の成分：対角成分の埋込み | PASS | 25,088 |
| `check_right_entry_diagonal_weight.sage` | 右側の積の成分：対角重みの代入 | PASS | 25,088 |
| `check_main_definition.sage` | 変換成分の主鎖：変換行列の定義 | PASS | 25,088 |
| `check_main_right_entry.sage` | 変換成分の主鎖：右側の成分の代入 | PASS | 25,088 |
| `check_main_left_entry.sage` | 変換成分の主鎖：左側の成分の代入 | PASS | 25,088 |
| `check_main_associate_inside.sage` | 変換成分の主鎖：内側の乗法の結合 | PASS | 25,088 |
| `check_main_commute_right.sage` | 変換成分の主鎖：成分と右側の重みの交換 | PASS | 25,088 |
| `check_main_associate_middle.sage` | 変換成分の主鎖：中間の乗法の結合 | PASS | 25,088 |
| `check_main_associate_outer.sage` | 変換成分の主鎖：外側の乗法の結合 | PASS | 25,088 |
| `check_main_embed_pair.sage` | 変換成分の主鎖：二つの重みの積の埋込み | PASS | 25,088 |
| `check_main_embed_scalar.sage` | 変換成分の主鎖：全体のスカラーとの積の埋込み | PASS | 25,088 |
| `check_main_weight_definition.sage` | 変換成分の主鎖：成分重みの定義 | PASS | 25,088 |
| `check_main_terminal_entry.sage` | 変換成分の主鎖：既存の端末成分の代入 | PASS | 25,088 |

実行方法（プロジェクト直下）:

```sh
sage -c "__file__ = 'sagemath/check/gauged-terminal-matrix-entries/check.sage'; load(__file__)"
```

2026-10-04 実行: 行別27本・計1,335,232等式と、48行列の全25,088成分の独立比較が通過した。一辺一の条件重複64成分も通過した。
