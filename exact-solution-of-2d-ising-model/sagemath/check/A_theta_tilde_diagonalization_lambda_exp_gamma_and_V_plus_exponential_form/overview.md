# SageMath Check: A_theta_tilde_diagonalization_lambda_exp_gamma_and_V_plus_exponential_form

## 対象

**対象ラベル**: `A_theta_tilde_diagonalization_lambda_exp_gamma_and_V_plus_exponential_form` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/eigenvalue_problem_diagonalization_and_exponential_form.ts`
  （ブロック `diagonalization_and_exponential_form_claim_A_theta_tilde_diagonalization_lambda_exp_gamma_and_V_plus_exponential_form`）
- 主張（`A(θ̃_μ)` の対角化と `V^{(+)}` の指数表示の章の章末の主張）: `K_1, K_2 > 0`、`M_col ≥ 2`、`μ ∈ 𝓜̌` のとき
  (1) `A(θ̃_μ) = P̌_μ diag(λ_{+,μ}, λ_{-,μ}) P̌_μ^{-1}`、(2) `λ_{±,μ} = exp(±γ(θ̃_μ))`、
  (3) `γ(θ) = arccosh(cosh 2K_1 cosh 2K_2^* − sinh 2K_1 sinh 2K_2^* cos θ)`（`θ ∈ ℝ`）、
  (4) `(ψ̌_μ^†, ψ̌_μ) = (Ž_μ, Y̌_μ) P̌_μ`、`ň_μ = ψ̌_μ^† ψ̌_{M+1−μ}`、
  (5) ある `c ∈ ℂ^×` で `V^{(+)} = c exp(Σ_μ γ(θ̃_μ)(ň_μ − I/2))`
- 範囲: 主張の (1)〜(5)。証明は既存の主張と定義を挙げるだけなので、(1)(2)(3)(5) は主張の両辺を別の経路で作って比べる。
  (3) の左辺は `arccosh(γ_1(θ))` で、`γ_1(θ)` は右辺の式を使わずに `B_1(θ) B_2 B_1(θ)`（`def_B1_theta_B2`）の (1,1) 成分として作る。
  (4) は `def_check_fermi`・`def_check_number_operator` の定義の再掲で、049 の `psi_pair` がこの一次結合そのものとして
  定義されているので残差は恒等的に 0 になる（定義どおりに作られていることの確認であって、独立な検査ではない）。
  各主張の式変形の一行ずつの検査は、`048_claim_A_theta_tilde/`（(1)(2)）と
  `V_plus_eq_c_exp_sum_gamma_check_number_operator/`（(5)）が持つ。

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
|---------|---------|-----------|------|
| check_goal.sage | (1) `A(θ̃_μ)` と `P̌_μ diag(λ_+, λ_-) P̌_μ^{-1}`（`λ_± := γ_1 ± \|γ_2\|`）の相対残差、`\|det P̌_μ\| > 0`。否定コントロール: diag の並びを入れ替える。(2) `λ_± = exp(±arccosh(γ_1(θ̃_μ)))`。否定コントロール: 符号を入れ替える。(3) `θ ∈ {θ̃_μ} ∪ {1, π, −2.5}` で `arccosh((B_1(θ)B_2B_1(θ))_{11})` と右辺（`(B_1B_2B_1)_{11}` の虚部が 0 であることも見る）。否定コントロール: 第 2 項の符号を + にする。(4) `psi_pair` が `(Ž_μ, Y̌_μ) P̌_μ` の列ごとの一次結合であること（定義どおりの確認）。(5) `V^{(+)}` と `c exp(Σ γ(θ̃_μ)(ň_μ − I/2))`（`c := ((V')^{-1}V^{(+)})_{11}`）。否定コントロール: `ň_μ` の対の添字を `μ` にする（`M_col ∈ {2,3,4,5}`、臨界点上を含む `FERMI_PARAMS` の 6 組、計 24 組） | PASS | 最大相対残差 6.8e-13（(3) は 2.2e-15）、`min\|det P̌_μ\|` 0.10、否定コントロールの残差 ≥ 8.3e-2 |

## 備考

- **ℝ 脱出（数値評価）**: `K_2^*` と `cosh, sinh, cos, arccosh, exp` の値は超越数を含み、厳密計算できない。倍精度 `RDF`/`CDF` で計算し、
  相対残差が `1e-8` 以下なら一致、否定コントロールは `1e-3` 超を要求した。
- (3) の `θ = 0` は臨界点上で `γ_1(0) = 1` となり、丸めで 1 を下回るので外した。`arccosh` の引数は、同じ理由で 1 を下回る分を 1 に切り上げた。

## 実行方法

```bash
cd sagemath/check/A_theta_tilde_diagonalization_lambda_exp_gamma_and_V_plus_exponential_form
~/micromamba/envs/sage/bin/sage check_goal.sage
```

実行ログは `logs/` に保存してある（2026-10-31）。
