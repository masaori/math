# SageMath Check: first_transfer_matrix_pauli_form

## 対象

**対象ラベル**: `first_transfer_matrix_pauli_form` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/004_transfer_matrix.ts`
  （ブロック `transfer_matrix_claim_first_transfer_matrix_pauli_form`）
- 主張: `def_transfer_matrix` で成分により定めた `V_1`（`(V_1)_{ord(μ),ord(μ')} = δ_{μ=μ'} exp(K_1 Σ_m μ(m)μ(m+1))`）は
  `V_1 = exp(K_1 Σ_{m=1}^{M_col} σ_m^z σ_{m+1}^z)`（`def_site_pauli_periodic_extension` の `σ_{M_col+1}^z := σ_1^z`）
- 範囲: statement と proof の全段（「D の対角成分」「成分の一致」）
- 併せて使う主張: `sigma_z_diagonal_action`、`exp_of_diagonal_matrix`、
  `config_numbering_equals_kronecker_numbering`、`row_configuration_numbering_bijective`

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
|---------|---------|-----------|------|
| check_bond_sum_diagonal_action.sage | `D = Σ_{m<M} σ_m^zσ_{m+1}^z + σ_M^zσ_1^z`（周期端の分割）、`D f_{ι(μ)}` の式変形 5 段、`D` が対角で第 `ord(μ)` 対角成分が `d(μ)`（`M_col = 1..7`、全 μ） | PASS | `ZZ` で全て一致 |
| check_component_equality_exact.sage | `V_1`（成分定義） `= exp(K_1 D)` を行列として、および成分の鎖 5 段を全 `(μ,μ')` で（`M_col = 1..6`、`exp(K_1) ∈ {2, 3/2, 5/4, 7/3}`） | PASS | `QQ` で全て一致 |
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
- `M_col = 1` では `σ_2^z := σ_1^z` により `D = I`、`d(μ) = 1` となる場合も含めている。
- 同じ主張の倍精度での独立な再確認は `043_claim_transfer_matrix_bridge/check_01_V1_bridge.sage`。

## 実行方法

```bash
cd sagemath/check/first_transfer_matrix_pauli_form
for f in check_*.sage; do sage "$f"; done
```

実行ログは `logs/` に保存してある（2026-09-26、SageMath 10.9）。
