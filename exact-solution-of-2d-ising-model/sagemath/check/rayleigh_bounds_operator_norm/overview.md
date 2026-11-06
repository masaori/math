# SageMath Check: rayleigh_bounds_operator_norm

## 対象

**対象ラベル**: `rayleigh_bounds_operator_norm` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/thermodynamic_limit_row_limit_and_max_eigenvalue.ts`
- ブロック: `maxeig_007_claim_operator_bound`（`‖W_ℝx‖ ≤ c(M_col)‖x‖`、`‖(W_ℝ)^kx‖ ≤ c(M_col)^k‖x‖`。`W_ℝ` は `def_W_real`）
- 範囲: 証明の一つ目の鎖 6 行、二つ目の鎖 6 行とその各行の側の条件、場合分け（`‖Wx‖ = 0` の側と `‖Wx‖ > 0` の側の割り算・冪の指数法則・`nonnegative_real_order_from_squares` の 3 行）、
  `k = 0`、帰納法の段の鎖 5 行、主張そのもの。
- 記号は証明のとおり `c := c(M_col)`、`y := W_ℝx`。下の表とコードの `W`・`P` は `W_ℝ`（成分が QQ の実数の行列）を指す。

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス |
|---|---|---|---|
| 置き方 `y := Wx`（成分 `y_k = Σ_l W_kl x_l`（`mat_mult`）、`y ∈ ℝ^n`） | `_lines.sage` | `matvec` で成分の式から作り、Sage の組み込みの積 `P*x` と比べる（QQ） | **PASS** |
| 一つ目の鎖 1→2（`y := Wx` の置き換え） | `_lines.sage` | 上の `y` の比較が受け持つ | **PASS** |
| 一つ目の鎖 2→3（`def_matrix_norm` と `(√a)^2 = a`） | `_lines.sage` | `‖y‖` を AA の平方根で作って二乗したものと `Σ_k |y_k|^2` | **PASS** |
| 一つ目の鎖 3→4（`|y_k|^2 = y_ky_k`） | `_lines.sage` | 絶対値の平方の和と積の和 | **PASS** |
| 一つ目の鎖 4→5（`y = Wx` の成分、`mat_mult`） | `_lines.sage` | 左の因子を組み込みの積の `y`、右の因子を成分の式 `Σ_l W_kl x_l` にした和 | **PASS** |
| 一つ目の鎖 5→6（分配則と乗法の結合則） | `_lines.sage` | 二重和 `Σ_kΣ_l y_kW_klx_l` | **PASS** |
| 一つ目の鎖 6→7（`def_real_bilinear_value`） | `_lines.sage` | `bil(y, W, x)`（定義どおり左から足す）。さらに組み込みの行列積 `y^⊤(Wx)` と比べる | **PASS** |
| 二つ目の鎖 1→2・2→3（冪、一つ目の鎖） | `_lines.sage` | `‖y‖^4`、`(‖y‖^2)^2`、`(y^⊤Wx)^2` | **PASS** |
| 二つ目の鎖 3→4（`psd_cauchy_schwarz` を `P = W` に） | `_lines.sage` | `(y^⊤Wx)^2 ≤ (x^⊤Wx)(y^⊤Wy)` を AA で比較 | **PASS** |
| 二つ目の鎖 4→5（`x^⊤Wx ≤ c‖x‖^2` と `0 ≤ y^⊤Wy`） | `_lines.sage` | 側の条件 2 つと行の不等号 | **PASS** |
| 二つ目の鎖 5→6（`y^⊤Wy ≤ c‖y‖^2` と `0 ≤ c‖x‖^2`） | `_lines.sage` | 側の条件 2 つと行の不等号 | **PASS** |
| 二つ目の鎖 6→7（`y = Wx`、乗法の可換則・結合則） | `_lines.sage` | `‖Wx‖` を組み込みの積と内積から作り直して比べる | **PASS** |
| 場合分け `‖Wx‖ = 0` の側（`0 ≤ c‖x‖`） | `_lines.sage` | 特異な `P` の核の `x ≠ 0` で通る（`check_generic_…`） | **PASS** |
| `‖Wx‖^2 ≤ c^2‖x‖^2`（`‖Wx‖^2 > 0` で割る）、`c^2‖x‖^2 = (c‖x‖)^2`、`‖Wx‖ ≤ c‖x‖`（`nonnegative_real_order_from_squares`、`‖Wx‖ ≥ 0`・`c‖x‖ ≥ 0`） | `_lines.sage` | 両辺を `‖Wx‖^2` で割った値の等号 2 つ、`‖Wx‖ ≥ 0`・`c‖x‖ ≥ 0`・`c^2‖x‖^2 = (c‖x‖)^2`、`‖Wx‖^2 ≤ (c‖x‖)^2` と両方の不等号。場合分けの件数をログに出す（一般の行列で `‖Wx‖ = 0` の側 13 件、`> 0` の側 144 件） | **PASS** |
| `k = 0` の鎖 3 行（`def_exp` (1) の `W^0 := I`、`identity_matrix_is_left_unit_of_mat_mult`、`c^0 = 1`） | `_lines.sage` | `W^0 := I` で作る | **PASS** |
| 帰納法の鎖 1→2（`def_exp` (1) の `W^{k+1} := W^kW`） | `_lines.sage` | 冪を `def_exp` (1) の漸化式で作り、Sage の冪 `P**(k+1)`（別の実装）と比べる。左辺のノルムは `P**(k+1)` から、右辺は `W^kW` から作る | **PASS** |
| 帰納法の鎖 2→3（`mat_mult_associative`） | `_lines.sage` | `‖(W^kW)x‖` と `‖W^k(Wx)‖` | **PASS** |
| 帰納法の鎖 3→4（帰納法の仮定を `Wx` に） | `_lines.sage` | `‖W^k(Wx)‖ ≤ c^k‖Wx‖` | **PASS** |
| 帰納法の鎖 4→5（`‖Wx‖ ≤ c‖x‖` と `c^k ≥ 0`） | `_lines.sage` | 側の条件と行の不等号 | **PASS** |
| 帰納法の鎖 5→6（冪の指数法則） | `_lines.sage` | `c^k(c‖x‖) = c^{k+1}‖x‖` | **PASS** |
| 主張（`‖Wx‖ ≤ c‖x‖`、`‖W^kx‖ ≤ c^k‖x‖`） | 両方の `check_*.sage` | 一般の半正定値行列は `k ≤ 3`、本文の `W` は `M_col = 2` で `k ≤ 3`、`M_col = 3` で `k ≤ 2` | **PASS** |

`_lines.sage` の `check_proof_lines` を二つの検算が呼ぶ。

- `check_generic_positive_semidefinite_matrices.sage`: 証明が使う `W` の性質は「成分が実数で対称」「半正定値」「`c` は上限」だけなので、
  `P := A^⊤A`（`A` は整数の `n'×n` 行列、`n = 2..5`、`n' = n−1, n, n+1`）の有理行列 157 組で確かめる。`n' < n` の `P` は特異で、
  核の `x ≠ 0` で場合分けの `‖Wx‖ = 0` の側を通す。等号 4986 個、不等号 3730 個。
- `check_symmetrized_transfer_matrix.sage`: 本文の `W = (BV_2)B`（`def_symmetrized_transfer_matrix`）を `K_1 := 2 log y`、`K_2 := log x`
  （`x, y ∈ {2, 3}`、`M_col = 2, 3`）で作る。`B = Σ_λ y^λP_λ(D)` と `V_2`（成分 `x^n`）は QQ なので `W` は QQ の行列である。因子の順に組み込みの積で作った `BV_2B` とも比べる。等号 716 個、不等号 528 個。

## `c(M_col)` の作り方

`def_rayleigh_sup` の `c = sup{x^⊤Wx | ‖x‖ = 1}` を、`W` の特性多項式の最大の実根として AA で作り（`_prelude.sage` の `rayleigh_sup_exact`）、
それが上限であることを二つの厳密な判定で確かめる。

- 上界: `cI − W` の特性多項式が実根だけを持ち（根の重複度の和が `n`）、係数の符号が弱く交代する。実根だけの多項式では、これは根が全て `≥ 0`
  であることと同値なので、`cI − W` は半正定値で、全ての `x` で `x^⊤Wx ≤ c‖x‖^2`。
- 到達: `cI − W` の核の元 `v ≠ 0`（AA）で `v^⊤Wv = c‖v‖^2`。よって `c` より小さい数は上界でない。

「実対称行列のレイリー商の上限は最大固有値」と「実対称で固有値が全て ≥ 0 なら半正定値」（スペクトル定理による）は本文に無い（本文は上限が達成されることを主張しない）。ここでは `c` の値を作る独立な経路として使い、
上の二つの判定で、その値が `def_rayleigh_sup` の上限であることをその場で確かめている。

## 否定コントロール（6 件、`check_generic_…`）

- `c` の代わりに 2 番目に大きい固有値 `c'` を `check_proof_lines` に渡すと、`c` の固有ベクトルで検算自身が落ちる（`c` が上限であることが効いている）。
- 半正定値の判定 `real_rooted_with_signs` は、`c'I − P` と `diag(1, −1)` で偽を返す（2 件）。
- 半正定値でない対称な `diag(1, −1)` では、Cauchy–Schwarz の行が `x = (1, 0)`、`y = (1, 1)` で外れる（半正定値性が効いている）。
- 対称でない `[[1, 0], [2, 1]]`（`x^⊤Px = (x_1 + x_2)^2 ≥ 0`）でも Cauchy–Schwarz の行が `x = (1, 0)`、`y = (0, 1)` で外れる（対称性が効いている）。
- `‖x‖` の冪を取り違えた `‖Px‖ ≤ c‖x‖^2` は `P = I`、`x = (1/2, 0)` で外れる。

## 構成上かならず一致する比較（写し間違いの検出だけに効く）

- 一つ目の鎖 2→3・3→4・5→6 と二つ目の鎖 1→2、帰納法の鎖 5→6 は、AA と QQ の冪・積・和の計算規則だけで必ず一致する（自明な恒等式）。
- 一つ目の鎖 4→5 の右の因子 `Σ_l W_kl x_l` は `y` を作った式そのものなので、`y` と組み込みの積 `P*x` の比較が通れば必ず一致する。中身はその比較にある。
- `k = 0` の鎖は `W^0 := I` で作るので構成上一致する。中身は、`W^0` と Sage の単位行列、`Ix = x` の比較にある。
- 一つ目の鎖 6→7 の `bil` は 5→6 の二重和と同じ左結合の和なので、その比較は構成上一致する。中身は、組み込みの行列積 `y^⊤(Wx)` との比較にある。
- `W^{k+1} = W^kW` は冪を `def_exp` (1) の漸化式で作るので構成上一致する。中身は、Sage の冪 `P**(k+1)` との比較にある。

## 証明の修正（2026-11-04）

- 旧い一つ目の鎖は `‖Wx‖^2 = (Wx)^⊤(Wx) = y^⊤(Wx)` で止まり、二つ目の鎖が使う `y^⊤Wx`（`def_real_bilinear_value` の二重和）との等号が無かった。
  `‖Wx‖^2 = Σ|y_k|^2 = Σy_ky_k = Σ_ky_kΣ_lW_klx_l = Σ_kΣ_ly_kW_klx_l = y^⊤Wx` の 6 行（`‖Wx‖^2 = ‖y‖^2` の置き換えを含む）にした。
- 旧い帰納法の段の 1 行目 `‖W^{k+1}x‖ = ‖W(W^kx)‖` は、`def_exp` (1) の `W^{k+1} := W^kW` から `W^kW = WW^k` を要するが、その主張は本文に無い。
  `W^{k+1}x = (W^kW)x = W^k(Wx)` とし、帰納法の仮定（全ての `x`）を `Wx` に当てる順にした。主張は不変。
- レビューの指摘で、`y` の成分と鎖の行に `mat_mult` を引き、`‖Wx‖^2 = ‖y‖^2` を独立の行にし、`k = 0` を 3 行の鎖にし、帰納法で `x` を取り直す一文を足した。

## 証明の修正（2026-11-06）

- 主張と証明の `W` を `def_W_real` の `W_ℝ` に替えた（`psd_cauchy_schwarz` は実数の行列を取る）。`psd_cauchy_schwarz` の仮定を `W_real_is_symmetric` と、
  新しく足した主張 `W_real_is_positive_semidefinite`（検算は `sagemath/check/W_real_is_positive_semidefinite/`）で満たす。
- 最後の段の「平方の単調性」を `c^2‖x‖^2 = (c‖x‖)^2` の行と `nonnegative_real_order_from_squares` に割った。検算に `‖Wx‖^2 ≤ (c‖x‖)^2` を足した。

## 計算の帰属と範囲

- 成分・ベクトルは QQ、`c` とノルムは AA（代数的数と、その平方根）。等号・不等号は全て AA の厳密計算で、浮動小数点は使わない。
- ℝ への脱出は、本文の `W` について `K_1`・`K_2` の選び方と、上限 `c`・ノルムの値（どちらも実数）である。選んだ値では、それらは AA に入る。
- 範囲外: `M_col ≥ 4` の本文の `W`、上に挙げた以外の結合定数と `x`、`k ≥ 4`。一般の場合は人手証明が担う。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh rayleigh_bounds_operator_norm
```

実行ログは `sagemath/check/rayleigh_bounds_operator_norm/logs/` に保存する。
