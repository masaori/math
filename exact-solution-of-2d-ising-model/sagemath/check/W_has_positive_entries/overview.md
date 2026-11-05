# SageMath Check: W_has_positive_entries

## 対象

**対象ラベル**: `W_has_positive_entries` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/thermodynamic_limit_column_limit_and_closed_form.ts`
- ブロック: `maxeig_004_claim_W_has_positive_entries`（`W` の成分はすべて正）
- 範囲: 証明の準備（`m^+` と周期的な延長、`d(μ)・b(μ)・e(μ,μ')・v(μ,μ')` と `b, v > 0`）、Step 1（`D_pq` の鎖 4 行、`D_kk` の鎖 7 行、
  `X_pq` の鎖 3 行、`B_pq` の鎖 2 行、`B_kk` の鎖 7 行）、Step 2（`(V_2)_kl` の鎖 3 行）、Step 3（0 になる項の鎖 2 行ずつ、`W_kl` の鎖 9 行、`w > 0` の 2 行）、
  主張そのものと、任意の `k, l` への言い換え。
- 記号は証明のとおり `n := 2^{M_col}`、`B := V_1^{1/2} = exp(X)`、`X := ((1/2)K_1)_ℂ D`、`D := Σ_m σ_m^zσ_{m+1}^z`、`k := ν(ι(μ))`、`l := ν(ι(μ'))`、
  `W := (BV_2)B`。

## 証明の行との対応

| 証明の行 | 検査内容 | ステータス |
|---|---|---|
| 準備: `σ_{m+1}^z = σ_{m^+}^z`（`def_site_pauli_periodic_extension`）、`μ(m+1) = μ(m^+)`（周期規約） | `M_col = 2..5` の全ての `m`・`μ` で、周期的な延長で作った側と `m^+` で作った側を比べる | **PASS** |
| Step 1 の `D_pq` の鎖（`p ≠ q`）: `finite_sum_of_matrices_entrywise`・`σ_{m+1}^z = σ_{m^+}^z`・`site_sigma_z_product_is_diagonal`・`finite_sum_of_complex_zeros` | `D` を `σ_m^zσ_{m+1}^z` の有限和（Pauli 行列は `def_kronecker` の成分の式で作る）として作り、各行の値を全ての `p, q` で比べる。3 行目は各項が 0 であることも見る | **PASS** |
| Step 1 の `D_kk` の鎖 7 行（`site_sigma_z_product_diagonal_entry`・`real_inclusion_preserves_product`・`real_inclusion_preserves_finite_sum`・周期規約・`d(μ)` の定義） | 全ての `μ` で `k = ν(ι(μ))`（`def_config_basis_iso`・`def_kronecker` の式）を作り、各行を比べる。3 行目は各項 `(σ_m^zσ_{m^+}^z)_{kk} = μ(m)μ(m^+)` も個別に見る | **PASS** |
| Step 1 の `X_pq` の鎖 3 行（`def_matrix_scalar_multiple`・`D_pq = 0`・`complex_times_zero_is_zero`） | `K_1` を `QQ[K_1]` の不定元に置き、`X = (K_1/2)D` の成分で各行を比べる | **PASS** |
| Step 1 の `B_pq = 0`（`p ≠ q`）と `B_kk = b(μ)_ℂ` の鎖 7 行（`exp_of_diagonal_matrix`・`def_matrix_scalar_multiple`・`real_inclusion_preserves_product`・`complex_exp_of_real_argument`） | 下の (B) で `B = exp(X)` を `D` の固有値の射影から作り（対角成分の公式を通らない独立な経路）、`B_pq = 0` を確かめる。`B_kk` の鎖は、2〜5 行目の exp の肩（`X_kk`、`((1/2)K_1)D_kk`、`((1/2)K_1)d(μ)`）を `QQ[K_1]` の元として作り、`K_1 = 2 log y` の実数の exp の値 `y^{2c}`（肩 `cK_1`）に写して各行を比べる。`BB = V_1`（`V_1` は `def_transfer_matrix` の成分から作る）も見る | **PASS** |
| Step 2 の鎖 3 行（`config_numbering_equals_kronecker_numbering`・`def_transfer_matrix`・`e, v` の定義） | `V_2` を `def_transfer_matrix` の成分から作り（行・列番号から `μ` を 2 進展開で復元する経路）、`(V_2)_{ν(ι(μ)),ν(ι(μ'))} = (V_2)_{ord(μ),ord(μ')} = X2^{e(μ,μ')}` を全ての `μ, μ'` で比べる | **PASS** |
| Step 3 の 0 になる項の鎖（`(BV_2)_{kt}B_{tl}`（`t ≠ l`）と `B_{ks}(V_2)_{sl}`（`s ≠ k`）、`complex_times_zero_is_zero`・`complex_zero_times_is_zero`） | 全ての `t ≠ l`・`s ≠ k` で各行を比べる | **PASS** |
| Step 3 の鎖 9 行（`def_symmetrized_transfer_matrix`・`mat_mult`・`finite_sum_with_single_nonzero_term` 二回・Step 1・Step 2・`real_inclusion_preserves_product` 二回） | `W = (BV_2)B` を行列の積で作り、1〜7 行目の値を全ての `μ, μ'` で比べる。単独の非零項の行は、`t ≠ l`（`s ≠ k`）の項が全て 0 であることと和が残る一項に等しいことを見る。8〜9 行目は下の「構成上かならず成り立つ比較」 | **PASS** |
| `w = Π_{j=1}^3 r_j > 0`（`def_finite_product_of_real_numbers`・`finite_product_of_positive_reals_is_positive`）と主張 `W_kl = w_ℂ` | `w = (r_1r_2)r_3` を比べる。(A) では `b(μ)`・`v(μ,μ')`・`w` が係数 1 の単項式（`Y, X2 > 0` で正）であること、(B) では `b, v, w ∈ QQ` が正であることと `W_kl = w` を見る | **PASS** |
| 主張の言い換え（`config_numbering_equals_kronecker_numbering`・`row_configuration_numbering_bijective`） | `μ ↦ ν(ι(μ))` の像が `{1,…,2^{M_col}}` の全体で、`ν(ι(μ)) = ord(μ)` であること | **PASS** |

## 計算の帰属と範囲

- (A) 一般の結合定数: `Y := exp((1/2)K_1)`、`X2 := exp(K_2)` を Laurent 多項式環 `QQ[Y^{±1}, X2^{±1}]` の不定元に置く（`X2` は行列 `X` と別の記号）。`d(μ)`・`e(μ,μ')` は整数なので
  `b(μ) = Y^{d(μ)}`、`v(μ,μ') = X2^{e(μ,μ')}`（実数の exp の指数法則 `exp(nt) = exp(t)^n` を肩が整数倍のときにだけ使う）。`K_1, K_2` の値に依らない形で
  Step 2・Step 3 の行を確かめる。この場合の `B` は対角成分の公式 `B_kk = Y^{d(μ)}` から作るので、Step 1 の `B` の行は (A) では構成上成り立つ。
- (B) 具体の結合定数: `K_1 := 2 log y`、`K_2 := log x`（`M_col = 2..4` で `(x, y) = (2, 3), (3, 2), (3/2, 2), (3, 3)`、`M_col = 5` で `(2, 3)`）。
  `exp((1/2)K_1λ) = y^λ`・`exp(K_2λ) = x^λ` は `QQ` の元で、`B` は固有値の射影から作る。
- **ℝ への脱出は、実数の exp の値を不定元か有理数に置く一点だけ**で、以後の等号・不等号は全て `QQ[Y^{±1}, X2^{±1}]`・`QQ[K_1]`・`QQ` の厳密計算である。浮動小数点は使わない。
- 範囲外: `M_col ≥ 6`、(B) の上に挙げた以外の結合定数。一般の場合は人手証明が担う。`exp_of_diagonal_matrix`・`complex_exp_of_real_argument` は
  極限で定まる exp についての主張で、ここでは exp の値を固有値の射影（(B)）か単項式（(A)）で与えるので、極限そのものは確かめない。

## 構成上かならず成り立つ比較

写し間違いの検出だけに効き、中身の検査にはならない比較:

- 実数から複素数への包含 `(·)_ℂ` は、計算環（`ZZ`・`QQ`・`QQ[K_1]`・`QQ[Y^{±1}, X2^{±1}]`）の中では恒等写像になる。そのため包含の主張で書き換えた行
  （`D_kk` の鎖の 4・5 行目、`B_kk` の鎖の 5 行目、Step 3 の鎖の 8・9 行目）は必ず成り立つ。中身は、包含が積と有限和を保つという本文の主張にある。
- (A) では `B` を対角成分の公式 `B_kk = Y^{d(μ)}` から作るので、Step 1 の `B` の行は (A) では必ず成り立つ。`B` の行の検査は (B) が受け持つ。
- `exp_of_t` は exp の値を肩 `cK_1` から `y^{2c}` で与えるので、`B_kk` の鎖の 3〜5 行目の一致は、肩どうしの一致（`QQ[K_1]` の等号）の検査である。
  6 行目（`complex_exp_of_real_argument`）の `y^{2·d(μ)/2} = y^{d(μ)}` は、exp の値をこの写し方で与えたので必ず成り立つ。
- `w = (r_1r_2)r_3` の比較は、`w` を同じ式で作るので必ず成り立つ（`def_finite_product_of_real_numbers` の並びの写し間違いの検出だけに効く）。

## 否定コントロール

- `V_2` の成分を `K_2` の符号を取り違えた `X2^{−e(μ,μ')}` と比べると外れる（`e(μ,μ') ≠ 0` の全ての組）。
- 平方根でない `V_1` で挟んだ `(V_1V_2)V_1` の成分は `w` と外れる（各 `M_col`・結合定数）。
- 対角でない行列（`V_2` 自身）の積の和に単独の非零項の行を当てると、0 でない項が見つかって落ちる。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh W_has_positive_entries
```

実行ログは `sagemath/check/W_has_positive_entries/logs/` に保存する。
