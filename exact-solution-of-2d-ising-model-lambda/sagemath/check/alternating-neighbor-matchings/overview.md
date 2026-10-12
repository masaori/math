# 交互の二色付けからの完全マッチングの行別検算

**対象ラベル**: `def_alternating_neighbor_pairs`, `claim_alternating_neighbor_matchings`

本文 `structured-latex/content/main-text.ts` の「交互の二色付けから二つの完全マッチングが得られる」の25行に各一ファイルを対応させる。内訳は、逆置換の色反転3行、隣接点写像の色反転4行、非不動点1行、対合性の二分岐8行、二写像の対合所属2行、二つの族の一致と完全マッチング所属6行、順序付き対の直積所属1行である。

大きさ0から6の集合 `J = (2, 5, ..., 3n - 1)` について全置換と全部分集合を列挙し、交互条件 `sigma(i) in C iff i not in C` だけで入力を抽出する。逆置換は各点の原像を独立に探索して作る。隣接点写像は所属側で置換、非所属側で逆置換を使い、第二の写像は向きを入れ替える。入力の抽出には不動点の不存在・対合性・完全マッチング性を使わない。

対は `frozenset`、族はその `frozenset` として重複を除く。完全マッチングは、各対の二元性と台集合への包含、各点を含む対がただ一つあることを直接判定する。対合性を完全マッチング判定の代用にしない。順序付き対は二成分のタプルとし、同じ族が二度現れる場合も保持する。

有限集合とその写像・命題の厳密な検算であり、実数・複素数や浮動小数点を使わない。これは指定した有限範囲の検算であり、一般の有限集合についての証明は本文と Lean に置く。

| ファイル | 本文の行 | 状態 | 結果 |
|---|---|---|---|
| `check_inverse_double_negation.sage` | 逆置換の色反転: 二重否定 | PASS | 4420 同値 |
| `check_inverse_color_negation.sage` | 逆置換の色反転: 仮定の両辺を否定 | PASS | 4420 同値 |
| `check_inverse_right_inverse.sage` | 逆置換の色反転: 右逆性 | PASS | 4420 同値 |
| `check_color_inside_definition.sage` | 所属側の色反転: 写像の定義 | PASS | 2210 同値 |
| `check_color_inside_hypothesis.sage` | 所属側の色反転: 交互条件 | PASS | 2210 同値 |
| `check_color_outside_definition.sage` | 非所属側の色反転: 写像の定義 | PASS | 2210 同値 |
| `check_color_outside_inverse.sage` | 非所属側の色反転: 逆置換の色反転 | PASS | 2210 同値 |
| `check_no_fixed_point.sage` | 不動点がない | PASS | 4420 判定 |
| `check_involution_inside_color.sage` | 所属側の対合性: 像の非所属 | PASS | 2210 判定 |
| `check_involution_inside_inner_definition.sage` | 所属側の対合性: 内側の定義 | PASS | 2210 等式 |
| `check_involution_inside_outer_definition.sage` | 所属側の対合性: 外側の定義 | PASS | 2210 等式 |
| `check_involution_inside_left_inverse.sage` | 所属側の対合性: 左逆性 | PASS | 2210 等式 |
| `check_involution_outside_color.sage` | 非所属側の対合性: 逆像の所属 | PASS | 2210 判定 |
| `check_involution_outside_inner_definition.sage` | 非所属側の対合性: 内側の定義 | PASS | 2210 等式 |
| `check_involution_outside_outer_definition.sage` | 非所属側の対合性: 外側の定義 | PASS | 2210 等式 |
| `check_involution_outside_right_inverse.sage` | 非所属側の対合性: 右逆性 | PASS | 2210 等式 |
| `check_forward_involution.sage` | 第一の写像の対合所属 | PASS | 747 判定 |
| `check_backward_involution.sage` | 第二の写像の対合所属 | PASS | 747 判定 |
| `check_forward_family_definition.sage` | 第一の族と二元軌道の族の一致 | PASS | 747 等式 |
| `check_forward_orbit_matching.sage` | 第一の二元軌道の族の完全マッチング所属 | PASS | 747 判定 |
| `check_forward_neighbor_matching.sage` | 第一の隣接対の族の完全マッチング所属 | PASS | 747 判定 |
| `check_backward_family_definition.sage` | 第二の族と二元軌道の族の一致 | PASS | 747 等式 |
| `check_backward_orbit_matching.sage` | 第二の二元軌道の族の完全マッチング所属 | PASS | 747 判定 |
| `check_backward_neighbor_matching.sage` | 第二の隣接対の族の完全マッチング所属 | PASS | 747 判定 |
| `check_ordered_pair.sage` | 順序付き対の直積所属 | PASS | 747 判定 |

`_prelude.sage` に入力列挙と定義を置き、`check.sage` で本文の順に25ファイルを読み込む。統合実行では空集合、二周期、四周期、六周期、非連結の周期の組、大きさごとの全候補数と交互入力数も照合する。二周期で同じマッチングが二成分になること、四周期・六周期では二成分が異なることを検査する。

実行コマンド（プロジェクトのルート）:

```sh
/home/masaori/.local/share/math-mamba/envs/sage/bin/sage sagemath/check/alternating-neighbor-matchings/check.sage
/home/masaori/.local/share/math-mamba/envs/sage/bin/sage sagemath/check/alternating-neighbor-matchings/check_inverse_color_negation.sage
```

各ファイルの CLI 起動では、自分と同じディレクトリに `_prelude.sage` がある場合だけ `__file__` を使い、それ以外は `sys.argv[0]` から場所を求める。別の作業ディレクトリから絶対パスでの起動も検査する。

2026-10-12 01:12 UTC 実行: 統合実行と個別代表3本がすべて PASS。統合はプロジェクト直下から相対パス、および `/tmp` から絶対パスで実行した。個別代表は、逆置換の仮定否定をプロジェクト直下から相対パス、第一の族の完全マッチング所属と順序付き対を `/tmp` から絶対パスで実行した。

全50,363候補から交互条件を満たす747入力を得た。点は4,420例で、所属側・非所属側は各2,210例。本文25行の合計50,923件（同値22,100件・等式14,754件・判定14,069件）が通過した。

| 集合の大きさ | 全置換と全部分集合の組 | 交互条件を満たす入力 |
|---|---|---|
| 0 | 1 | 1 |
| 1 | 2 | 0 |
| 2 | 8 | 2 |
| 3 | 48 | 0 |
| 4 | 384 | 24 |
| 5 | 3,840 | 0 |
| 6 | 46,080 | 720 |

| 置換の周期の長さ | 入力数 |
|---|---|
| 空集合 | 1 |
| 二周期 | 2 |
| 二周期が二つ | 12 |
| 四周期 | 12 |
| 二周期が三つ | 120 |
| 二周期と四周期 | 360 |
| 六周期 | 240 |

二成分が同じ族となる順序付き対は135入力で確認した。判定器についても、一元集合からなる対、点を被覆しない族、同一点を二つの対が被覆する族をそれぞれ拒否することを確認した。
