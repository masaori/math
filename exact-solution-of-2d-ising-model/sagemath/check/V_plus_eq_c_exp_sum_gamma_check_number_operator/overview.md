# SageMath Check: V_plus_eq_c_exp_sum_gamma_check_number_operator

## 対象

**対象ラベル**: `V_plus_eq_c_exp_sum_gamma_check_number_operator` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/eigenvalue_problem_diagonalization_and_exponential_form.ts`
  （ブロック `diagonalization_and_exponential_form_claim_V_plus_eq_c_exp_check_number_operators`）
- 主張: ある `c ∈ ℂ^×` について `V^{(+)} = c exp(Σ_{μ ∈ 𝓜̌} γ(θ̃_μ)(ň_μ − ½I))`
- 範囲: proof の式変形 4 行（`V_plus_eq_c_check_Vprime`、`def_check_Vprime` の `V̌' := exp(X̌)`、
  `def_check_Vprime` の `X̌` の定義、`def_check_number_operator` の `ň_μ := ψ̌_μ^† ψ̌_{M+1−μ}`）

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
|---------|---------|-----------|------|
| check_substitution_chain.sage | 0 行目（`def_V_plus` の `V^{(+)}`）と 1・2・4 行目の値を各行の式どおりに作り、隣どうしの作用素ノルムの相対残差が `1e-8` 以下であること。`c := ((V̌')^{-1}V^{(+)})_{11}` が `|c| > 1e-3` であること。否定コントロール（`ň_μ` の対の添字を `M+1−μ` ではなく `μ` にしたもの）が 0 行目と一致しないこと（`M_col ∈ {2,3,4,5}`、`049_claim_even_sector_fermions` の `FERMI_PARAMS` の 6 組。臨界点上を含む） | PASS | 最大相対残差 6.8e-13、否定コントロールの相対残差 ≥ 0.81 |

## 備考

- **ℝ 脱出（指数評価）**: `V^{(+)}` と `V̌'` は、実数の `K_1, K_2^*` と固有値が一般に無理数の `H_1^{(+)}, H_2, X̌` から
  行列の指数関数で作るので成分が超越数になり、厳密計算できない。倍精度複素数 `CDF` で計算した。
- 主張は `c` の存在だけを言う。検算では `V_plus_eq_c_check_Vprime` の証明の `W := (V̌')^{-1}V^{(+)} = cI` から
  `c` を `W` の (1,1) 成分として取った。
- 2 行目と 3 行目は `X̌` の定義を展開しただけなので、同じ和で作った同じ値である（残差 0 は計算の同一性による）。
  4 行目は `ň_μ` を数演算子として別に作り、`γ(θ̃_μ)` を `arccosh(γ_1(θ̃_μ))` として直接計算した。
- 1 行目の等号（`V_plus_eq_c_check_Vprime`）は `049_claim_even_sector_fermions/check_06_V_eq_cVprime.sage` も確かめている。
  ここでは定義を代入して数演算子の形に着くまでの一続きを確かめる。
- 共通定義（`SpinOps`・`psi_pair`・`V_plus`・`Vprime_check`・`gamma_tilde`・`g1`）は
  `049_claim_even_sector_fermions/_prelude.sage` を使う。

## 実行方法

```bash
cd sagemath/check/V_plus_eq_c_exp_sum_gamma_check_number_operator
sage check_substitution_chain.sage
```

実行ログは `logs/` に保存してある（2026-10-31）。
