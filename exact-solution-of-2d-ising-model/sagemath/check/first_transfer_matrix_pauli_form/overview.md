# SageMath Check: first_transfer_matrix_pauli_form

## 対象

**対象ラベル**: `first_transfer_matrix_pauli_form` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/partition_function_transfer_matrix_representation.ts`
  （ブロック `transfer_matrix_claim_first_transfer_matrix_pauli_form`）
- 主張: `def_transfer_matrix` で成分により定めた `V_1`（`(V_1)_{ord(μ),ord(μ')} = δ_{μ=μ'} exp(K_1 Σ_m μ(m)μ(m+1))`）は
  `V_1 = exp(K_1 Σ_{m=1}^{M_col} σ_m^z σ_{m+1}^z)`（`def_site_pauli_periodic_extension` の `σ_{M_col+1}^z := σ_1^z`）
- 範囲: statement と proof の全段（「D は対角行列」「D の対角成分」「K_1 D」「成分の一致」）
- 併せて使う主張: `finite_sum_of_matrices_entrywise`、`finite_sum_of_complex_zeros`、`complex_times_zero_is_zero`、`def_matrix_scalar_multiple`、`real_inclusion_preserves_product`、`real_inclusion_preserves_finite_sum`、`site_sigma_z_product_is_diagonal`、`site_sigma_z_product_diagonal_entry`、`exp_of_diagonal_matrix`、`complex_exp_of_real_argument`、
  `config_numbering_equals_kronecker_numbering`、`row_configuration_numbering_bijective`

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
|---------|---------|-----------|------|
| check_D_entries_chain.sage | 前半の三つの中間目標の鎖: `D` が対角行列であることの 4 行（`k ≠ l`）、`D` の対角成分の 7 行（`k = ν(ι(μ))`、`m^+` による周期端の付け替え、包含 `r ↦ (r,0)` と対の積、`d(μ)_C`）、`K_1 D` の非対角成分と対角成分の行（`K_1` は `QQ` の不定元）。`M_col = 1..7`、全 μ・全 `k ≠ l` | PASS | `ZZ`・`QQ[K]` で全て一致（21844 成分） |
| check_exp_inclusion_lines.sage | 「成分の一致」の鎖に足した二行 `exp((K_1)_C d(μ)_C) = exp((K_1 d(μ))_C) = (exp(K_1 d(μ)))_C`。第一の等号は対の積で厳密に、第二の等号は `def_scalar_exp` の部分和どうし（`QQ(i)` と `QQ`、`N = 0..30`）を厳密に比べ、補助として極限の値を `ComplexBallField`・`RealBallField`（200 ビット）のボールの重なりで | PASS | `d = -6..6`、有理数の `K_1` の 5 値 |
| check_component_equality_exact.sage | `V_1`（成分定義） `= exp(K_1 D)` を行列として、および「成分の一致」の鎖の 8 項（7 つの等号）を全 `(μ,μ')` で（`exp(K_1 n) = x^n` の模型なので第 3〜5 項は同じ値。その間の二つの等号は `check_exp_inclusion_lines.sage` が確かめる）（`M_col = 1..6`、`exp(K_1) ∈ {2, 3/2, 5/4, 7/3}`） | PASS | `QQ` で全て一致 |
| check_component_equality_numeric.sage | 一般の `K_1 ∈ {0.05, 0.4, 0.4406868, 0.7, 1.3}` で `V_1`（成分定義） `= exp(K_1 D)`（`M_col = 1..6`） | PASS | 相対誤差 0.00e+00（全ケース） |

## 備考

- **厳密版の方法**: `K_1 = log x`（`x ∈ QQ`, `x > 1`）と選ぶと `exp(K_1 n) = x^n ∈ QQ`。
  右辺の行列の指数関数は、整数固有値をもつ `D` のスペクトル射影 `P_λ = Π_{λ'≠λ}(D-λ'I)/(λ-λ')` を
  `QQ` 上で作り、`Σ P_λ = I`・`D P_λ = λ P_λ` を検査したうえで `exp(K_1 D) = Σ_λ x^λ P_λ` とした
  （`D^p = Σ λ^p P_λ` なので `def_exp` の級数の各成分がこの値に等しい）。
  ℝ 脱出は `K_1` の選び方の一点だけ（見かけだけの ℝ 脱出）で、等号の判定はすべて `QQ`。
- 行・列番号 `k` からは `μ = ord^{-1}(k)` を 2 進展開で復元して成分を書き込み、照合側は
  `ord(μ)` の式で番号を引いている（`ord` の両向きを別経路で使う）。
- 数値版は一般の `K_1` を扱うための ℝ 脱出（指数評価）。`CDF` 行列の `exp` を級数定義の値の近似として使い、
  許容誤差は成分の最大絶対値で正規化した相対誤差 `1e-12`。`D` が対角なので実測は 0。
- 2026-11-02: 証明の前半を、固有ベクトルの等式 `D f_{ι(μ)} = d(μ) f_{ι(μ)}` の鎖から、成分の鎖（`D` の非対角成分・対角成分）に書き直したので、旧 `check_bond_sum_diagonal_action.sage` を `check_D_entries_chain.sage` に置き換えた。
- `M_col = 1` では `σ_2^z := σ_1^z` により `D = I`、`d(μ) = 1` となる場合も含めている。
- 同じ主張の倍精度での独立な再確認は `043_claim_transfer_matrix_bridge/check_01_V1_bridge.sage`。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh first_transfer_matrix_pauli_form
```

実行ログは `logs/` に保存してある。
