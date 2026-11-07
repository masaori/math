# SageMath Check: limit_of_log_Z_in_N_row

## 対象

**対象ラベル**: `limit_of_log_Z_in_N_row` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/thermodynamic_limit_row_limit_and_max_eigenvalue.ts`
- ブロック: `freeenergy_003_claim_limit_in_N_row`（`lim_{N_row→∞} (1/(ι(M_col)ι(N_row))) log Z(K_1,K_2) = (1/ι(M_col)) log c(M_col)`。`ι = ι_{ℤ→ℝ}` は `inclusion_zz_to_rr`）
- 範囲: 準備（`Z > 0`、`c > 0`、`ι(M_col), ι(N_row) ≥ 1`、`ι(M_col)ι(N_row) > 0`）、含意の鎖の十行、極限の段（`log 2 > log 1 = log(exp 0) = 0` の三行、`log 2/ε > 0`、`0 < log 2/ε < ι(N_0) ⟹ 0 < ι(N_0) ⟹ N_0 > 0 ⟹ N_0 ≥ 1`、`log 2 = (log 2/ε)ε < ι(N_0)ε`、`ι(N_0) ≤ ι(N_row)`、`|a_N − a| ≤ (log 2)/ι(N) ≤ (log 2)/ι(N_0) < ε` の三行）と主張

## 証明の行との対応

| 証明の行 | 検査内容 | ステータス |
|---|---|---|
| 準備: `Z ∈ ℝ_{>0}`、`c ∈ ℝ_{>0}`、`ι(M_col) ≥ 1`、`ι(N_row) ≥ 1`、`ι(M_col)ι(N_row) > 0` | `Z`（QQ）と `c`（AA）の正値性。`ι` は定義の再帰（`sagemath/_shared/inclusion_zz_to_rr_by_definition.sage`）で作り QQ で | **PASS** |
| 一行目 `c^N ≤ Z ≤ 2^M c^N`（`partition_function_sandwich`） | QQ・AA の厳密な比較。冪は `def_power_of_real_number` の再帰 | **PASS** |
| 二行目（log の単調性） | 各辺の log をボールで作り二つの不等号。一行目の狭義の不等号から log の狭義の不等号が出ること | **PASS** |
| 三〜六行目（`real_log_of_power`・`real_log_of_product`） | 変わった辺の等号（`log(c^N) = ι(N) log c`、`log(2^M c^N) = log(2^M) + log(c^N)`、`log(2^M) = ι(M) log 2`）と各行の二つの不等号 | **PASS** |
| 七行目（`ι(M)ι(N)` で割る）・八行目（約分） | 各行の二つの不等号と、八行目の左辺・右辺の約分の等号 | **PASS** |
| 九行目（`(1/ι(M)) log c` を引く）・十行目（`def_real_absolute_value` の `q ≥ 0` の場合） | 二つの不等号、引いた辺の等号、差が非負で `|d| = d` | **PASS** |
| 極限の段（`log 2 > log 1`、`exp(0)` のボールが 1 を含み `log 1 = 0`、`log 2/ε > 0`、`log 2/ε < ι(N_0)` と `0 < ι(N_0)`、`N_0 > 0`（`ℤ_{≤0}` の `-50..0` で `ι ≤ 0`）と `N_0 ≥ 1`、`log 2 = (log 2/ε)ε < ι(N_0)ε`、`ι(N_0) ≤ ι(N_row)`、三行の鎖） | `ε ∈ {1, 1/2, 1/10, 1/40}` と `N_0 := ⌊(log 2)/ε⌋ + 1 ∈ ℤ`、`N_row = N_0..60`。`N = N_0` の二行目は等号、`N > N_0` は狭義 | **PASS** |
| 主張 | `N_row = 60` で `|a_60 − a|` が 1.6e-11〜3.4e-3（`(log 2)/60 ≈ 1.2e-2` 以下） | **PASS** |

パラメータは `K_1 := 2 log y`、`K_2 := log x` で `(M_col, x, y)` ∈ {2, 3} × {(2,2), (3,2), (2,3), (3,3)} と `(3, 3/2, 5/4)` の 8 組、
`N_row = 1..60`。比較は 21504 個。

## 計算の帰属と範囲

- **厳密**: `Z` は QQ の元である（`K_1 = 2 log y`、`K_2 = log x` で Boltzmann 重みが `y^{2h} x^{v}` になる）。`M_col·N_row ≤ 12` の 40 格子では
  `def_partition_function_2d_ising` の全ての配位の和で作り、`tr(W^{N_row})`（`Z_equals_trace_of_W`）と一致することを確かめた。
  それより大きい格子は `tr(W^{N_row})` で作る。`W` は `rayleigh_bounds_operator_norm/_prelude.sage` の `W_exact`（QQ の行列）、
  `c` は同じ準備の `rayleigh_sup_exact`（特性多項式の最大の実根を AA で作り、上界であることと到達することを確かめる。
  最大固有値と上限の一致は本文に無く、証明も使わない。`c` の値を作る独立な経路として使う）。一行目と準備は QQ・AA の厳密な比較である。
- **ℝ への脱出（`RealBallField(512)`）**: log を含む二行目以降と極限の段。値が QQ・AA に入らないためである（実対数による脱出）。
  log は Arb の log で、各行の両辺は別々に計算する。大小は差のボールの下端の符号、等号は差のボールが 0 を含み半径が 2^-200 未満であることで判定し、
  許容誤差は置かない（`sagemath/_shared/log_integral_by_balls.sage`）。`N_0` の候補は浮動小数点の `log(2.0)` で作るが、`N_0 ε > log 2` はボールで確かめる。
- 確かめられない行: 極限の段の「ℝ のアルキメデス性より `N_0` を取る」は存在の主張で、選んだ `ε` での証人を示すだけである。
  `N_row ≥ N_0` の全てではなく `N_row ≤ 60` までを確かめる。
  二行目の根拠のうち `u = v` の側は、選んだパラメータでは起きない（`c^N < Z < 2^M c^N` が常に狭義）ので確かめていない。

## 否定コントロール（4 件、`(M_col, x, y) = (2, 3, 2)`）

- 極限値を `(1/M) log(2c)` に替えると、`|a_N − a'| ≤ (log 2)/N` が破れる `N ≤ 60` がある。
- 上界の `2^M` を `1` にした `Z ≤ c^N` は `N = 1..20` のどれでも成り立たない。
- 五行目の根拠を `log(2^M) = (M+1) log 2` と書き違えると等号が破れる。
- 下界の `c` を `1.05c` にした `(1.05c)^N ≤ Z` は破れる `N < 200` がある。

## 構成上かならず一致する比較（写し間違いの検出だけに効く）

- 七〜九行目の約分・引き算の等号と、十行目の絶対値は、ボールの四則で必ず一致する。
- 中身は、一行目（`Z` と `c` を別々の経路で作る）、三〜六行目の log の等号（冪・積の値の log と log の和を別々に計算する）、
  各行の不等号、極限の段と主張にある。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh limit_of_log_Z_in_N_row
```

実行ログは `logs/` に保存する。
