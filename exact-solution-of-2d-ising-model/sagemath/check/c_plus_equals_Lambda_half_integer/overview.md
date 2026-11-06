# SageMath Check: c_plus_equals_Lambda_half_integer

## 対象

**対象ラベル**: `c_plus_equals_Lambda_half_integer`

- ファイル: `structured-latex/content/thermodynamic_limit_column_limit_and_closed_form.ts`
- ブロック: `closing_009_theorem_c_plus_equals_Lambda_half`（c_+(M_col) = Λ̌_max = Λ^{(1/2)}_{M_col} で、上限は達成される）
- 範囲: 証明の準備 1〜4、Step 0 の二本の鎖、Step 1 の四本の鎖と ℝ の鎖、Step 2 の全ての段、Step 3 の鎖、結びの鎖、主張の式そのもの。
- 記号（証明と同じ）: `n := 2^{M_col}`、`ι^n := ι^n_{ℝ→ℂ}`（`def_real_vector_inclusion`、`ι^n(x) = ((x_k)_ℂ)_k`）、`W_ℝ`（`def_W_real`、`((W_ℝ)_kl)_ℂ = W_kl`）、`ε_ℝ`（`def_epsilon_real`）、`u := ι^n(x)`、`w_ε := Q̌_εu`、`q̄ := (conj(q_k))_k`。

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス |
|---|---|---|---|
| 準備 1 の `((W_ℝ)_kl)_ℂ = W_kl`（`def_W_real`） | `check_step0_step1_chains.sage` | `W_ℝ`（`QQ`）を `E_1` へ移したものが `W` に等しい | **PASS** |
| 準備 2 の鎖 7 行（`(x^⊤W_ℝx)_ℂ` から `u^*Wu`） | `check_step0_step1_chains.sage` | `x^⊤W_ℝx` を `def_real_bilinear_value` の成分の式（`real_bilinear`）で、`u^*Wu` を `def_conjugate_bilinear_value` の成分の式（`conj_bilinear`）で、間の行を行の括弧どおりに組む | **PASS** |
| 準備 3 の鎖 4 行、準備 4 の鎖 3 行 | `check_step0_step1_chains.sage` | 成分が複素数の `u` 2 本と `A = V^{(+)}, W` で、`QQbar` の本物の複素共役で | **PASS** |
| 準備 4 の後半（`‖ι^n(x)‖^2 = ‖x‖^2`） | `check_step0_step1_chains.sage` | Step 1 の二本目の鎖の最後の 2 行に含めた | **PASS** |
| Step 0 の `P^{(+)}y` の鎖 6 行と `Wy` の鎖 5 行、根拠の `WP^{(+)} = V^{(+)}P^{(+)}` | `check_step0_step1_chains.sage` | `F^{(+)}` の元を軌道ごとの係数（複素数を含む 3 組）で作り、`εy = y` を確かめてから各行を本文の定め方（`body_product`・`body_scalar`・`body_sum`）で組む（`E_1`） | **PASS** |
| Step 1 の `u = Σ_εw_ε` の鎖 4 行、`V^{(+)}u = Σ_ε(Λ̌_ε)_ℂw_ε` の鎖 5 行、二つの成分の式 | `check_step0_step1_chains.sage` | `E_1` で。Λ̌_ε は `E_1` の元 `lam[ε]` | **PASS** |
| Step 1 の `(x^⊤W_ℝx)_ℂ` の鎖 11 行 | `check_step0_step1_chains.sage` | 1〜8 行目は `E_1`、`u^*Q̌_εu = (‖w_ε‖^2)_ℂ` から先は `QQbar`・`AA` | **PASS** |
| Step 1 の `(Σ_ε‖w_ε‖^2)_ℂ = (‖x‖^2)_ℂ` の鎖 8 行 | `check_step0_step1_chains.sage` | 同じ | **PASS** |
| `inclusion_rr_to_cc_is_injective` で ℝ へ戻した等式、各項の不等式、ℝ の鎖（≤ の行と 3 本の等号） | `check_step0_step1_chains.sage` | `AA` で | **PASS** |
| Step 2: `dim im Q̌_{(1,…,1)} = 1`、`q ≠ 0`、`V^{(+)}q = (Λ̌_max)_ℂq`、`q ∈ F^{(+)}`、`Wq = V^{(+)}q` | `check_step2_step3_and_claim.sage` | `E_1` と `QQbar` で | **PASS** |
| Step 2: `((W_ℝ)_kl)_ℂ = W_kl`・`((ε_ℝ)_kl)_ℂ = ε_kl`、`(Wq̄)_k` の鎖 10 行と、その `W → ε`・`W_ℝ → ε_ℝ` の版、`q̄ ∈ F^{(+)}`、`V^{(+)}q̄ = Wq̄ = (Λ̌_max)_ℂq̄`、`q̄ = zq` | `check_step2_step3_and_claim.sage` | `QQbar` で成分ごと。固有空間の次元が 1 であることも確かめる | **PASS** |
| Step 2: `conj(p_k)` の鎖 4 行、`conj(p'_k)` の鎖 7 行、`p` の鎖 2 行（`p = q + zq = (1+z)q`）、`p'` の鎖 3 行（`p' = i(q − zq) = i((1−z)q) = (i(1−z))q`）、同時に 0 にならないこと、`v = cq ≠ 0`、`conj(v_k) = v_k` と `b_k = 0`、`ι^n(r) = v`、`‖r‖^2 > 0`、`‖x_0‖ = 1`、`ι^n(x_0) = ((1/‖r‖)_ℂc)q` | `check_step2_step3_and_claim.sage` | `QQbar`・`AA` で。証明の q は任意の生成元なので、q に `1, 1+2i, i` を掛けた三つの生成元で行う（`1` は `q̄ = q`、`1+2i` は q が実でない場合、`i` は `p = 0` で `p'` を使う場合） | **PASS** |
| Step 3: `u_0 ∈ im Q̌_{(1,…,1)}`、`u_0 ∈ F^{(+)}`、`V^{(+)}u_0 = (Λ̌_max)_ℂu_0`、`(x_0^⊤W_ℝx_0)_ℂ` の鎖 8 行、`x_0^⊤W_ℝx_0 = Λ̌_max` | `check_step2_step3_and_claim.sage` | `QQbar`・`AA` で | **PASS** |
| 結び: `θ^{(1/2)}_{M,μ} = θ̃_μ`、`c_+ = Λ̌_max = Λ^{(1/2)}_{M_col} = 閉形式`、上限が `x_0` で達成 | `check_step2_step3_and_claim.sage` | `c_+(M_col)` を、`F^{(+)} ∩ ℝ^n` の正規直交基底 `(e_k + e_{π(k)})/√2` での `W_ℝ` の制限の最大固有値として Λ̌ を経由せずに作る（`rayleigh_bounds_operator_norm` の `rayleigh_sup_exact`。上界と到達を確かめる）。閉形式の `exp(γ(θ̃_μ))` と `(2 sinh 2K_2)^{M_col/2}` は結合定数と 1 の冪根から直接作る | **PASS** |

- `check_step0_step1_chains.sage`: 等号 1758 件、不等号・真偽 348 件、否定コントロール 48 件。
- `check_step2_step3_and_claim.sage`: 等号 4227 件、不等号・真偽 102 件、否定コントロール 24 件（q̄ ≠ q の生成元 12 件、p' を使った生成元 6 件）。

## 計算の帰属と範囲

- **結合定数**: `K_1 := 2 log y`、`K_2 := log x`、`(x, y) ∈ {(2, 2), (3, 3/2), (5/4, 3)}`、`M_col = 2, 3`。
- **厳密**: すべて。`ε`・`ň_μ`・`Q̌_ε` は本文の ψ̌ から数体 `E_1` に作る（`../max_eigenvector_in_even_sector/_prelude.sage` の `MaxSetting`）。
  `V^{(+)}`（`def_V_plus`）と `W`（`def_symmetrized_transfer_matrix`、`../rayleigh_bounds_operator_norm/_prelude.sage` の `W_exact`）は成分が `QQ`。
  `V^{(+)}Q̌_ε = Λ̌_εQ̌_ε` の Λ̌_ε は `E_1` の元として持ち、その `QQbar` での像が `AA` の `Λ̌_ε` に等しいことを確かめてから使う。
  ノルム・平方根・不等号は `AA`、複素共役は `QQbar` の `conjugate`。浮動小数点は使わない（表示用の `RR` を除く）。
- **Step 1 の x と共役**: Step 1 の `x` は `F^{(+)} ∩ ℚ^n` の `‖x‖ = 1` の元 4 本（単位球面の有理点から作る）なので、`u = ι^n(x)` の成分の複素共役は恒等写像であり、
  Step 1 の `u^*Au` は共役を恒等写像として `E_1` の中で組む。共役が効く準備 3・準備 4 は、成分が複素数の `u` で `QQbar` の本物の共役を使って別に確かめる。
- **ℝ への脱出**: `K_1`・`K_2` の選び方と、`exp(γ(θ̃_μ)) = γ_1 + √(γ_1^2−1)`（`def_gamma_theta`・`def_arccosh` の実対数の中身）を代数的数として作る一点。
- **範囲外**: `M_col ≥ 4`（ψ̌ を数体に作る費用が大きい。`check_number_operators_commute` の overview の「計算の帰属と範囲」と同じ理由）、他の結合定数。
  Step 1 の「x は任意だったので」と上限の性質は、選んだ 4 本の x と、主張の確認での `W_ℝ` の制限の上界（`cI − G` が半正定値）で見る。
  「有限個の複素数の和の順序の入れ替え」と「各項の不等式を足し合わせる」の行は、具体の値で両辺を比べるだけで、一般の主張は確かめていない。

## 構成上かならず成り立つ比較

次の比較は、Sage の計算規則か作り方だけで必ず成り立つ。写し間違いだけを検出する。

- 準備 2 の 2→3・3→4・4→5・5→6 行目（有理数の `(·)_ℂ` は `QQ → E_1` の埋め込みで、和と積を保ち、共役は恒等写像。`u` は `x` の埋め込み）と 7→8 行目（`conj_bilinear` がその式そのもの）。中身は 6→7 行目（`((W_ℝ)_kl)_ℂ = W_kl`）。
- 準備 3 の鎖の全ての行（ℂ の結合則・分配則と `mat_mult` の成分の式で、Sage の計算規則だけで成り立つ）、準備 4 の鎖の 3→4 行目（平方根を取ってから 2 乗する）。
- Step 0 の `P^{(+)}y` の 1→2 行目（`P^{(+)}` を `½(I+ε)` で作っている）、2→3・3→4・4→5 行目（スカラーの括り出し・分配・`Iy = y`）、6→7 行目。中身は 5→6 行目（`εy = y`）。`Wy` の鎖は全て中身のある比較である（結合律の行は `body_product` の計算規則でも成り立つ）。
- Step 1 の `u = Σ_εw_ε` の 4→5 行目、`V^{(+)}u` の鎖の 5→6 行目、`(x^⊤W_ℝx)_ℂ` の鎖の 1→2 行目（準備 2 で確かめた値の再掲）、
  `Σ‖w_ε‖^2` の鎖の 1→2 行目と 8→9 行目、ℝ の鎖の 4→5 行目（`‖x‖ = 1` の x を選んでいる）。
- Step 2 の `(Wq̄)_k` の鎖で `W_ℝ` を通る 2→3・3→4・4→5 行目（`W` を `QQ` で作っているので構成上成り立つ。`ε` の側は、ψ̌ の数体から作った `ε` の成分が実であることと `((ε_ℝ)_kl)_ℂ = ε_kl` を別に確かめている）。
- Step 2 の `conj(p_k)` の鎖の 1→2 行目と最後の行、`conj(p'_k)` の鎖の 1→2・3→4（`conj(i) = −i`）・6→7・7→8 行目、`conj(i) = −i`、`p` の鎖と `p'` の鎖の全ての行（直前の `q̄ = zq` から算術だけで従う。中身は `q̄ = zq` の側）、
  `‖x_0‖ = 1`（`x_0 := r/‖r‖` の作り方）、`ι^n(x_0)` の鎖。
- Step 3 の鎖の 6→7・7→8・8→9 行目（`‖x_0‖ = 1` の作り方）。結びの `θ^{(1/2)}_{M,μ}/π = θ̃_μ/π` と、`egh == eg` を確かめた後の `Λ̌_max = 閉形式`。結びの鎖の 3・4 行目（`θ^{(1/2)}` の式と `θ̃` の式）は角が同じ有理数なので一つの値で比べている。
- 中身の検査は、`WP^{(+)} = V^{(+)}P^{(+)}` と `εy = y` を当てる行、`Σ_εQ̌_ε = I`・`V^{(+)}Q̌_ε = Λ̌_εQ̌_ε`・`u^*Q̌_εu = (‖w_ε‖^2)_ℂ` を当てる行、
  ≤ の行、`ε` の成分が実であることを使う `(εq̄)_k` の鎖、固有空間が 1 次元であること、`u_0 ∈ F^{(+)}`、
  Λ̌ を経由せずに作った `c_+` と `Λ̌_max` の一致、独立な経路の `exp(γ(θ̃_μ))` の一致にある。

## 否定コントロール

- `εy = −y` の y では `P^{(+)}y ≠ y`、`Wy ≠ V^{(+)}y`、`u^*Wu ≠ u^*V^{(+)}u`。`W ≠ V^{(+)}`（`F^{(+)}` の上でだけ一致する）。
- `‖2x‖ ≠ 1` の `2x` では ℝ の鎖の最後の行が外れる。
- `1+2i`・`i` を掛けた生成元は実でない（実ベクトルを作る段が要る）。
- `Λ^{(0)}_{M_col} ≠ c_+`。ε の固有値 −1 の側（`(e_k − e_{π(k)})/√2` の張る空間）での `W_ℝ` の上限は `c_+` と違う。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh c_plus_equals_Lambda_half_integer
```

実行ログは `logs/` に保存する。
