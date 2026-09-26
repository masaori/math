# SageMath Check: second_transfer_matrix_pauli_form

## 対象

**対象ラベル**: `second_transfer_matrix_pauli_form` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/004_transfer_matrix.ts`
  （ブロック `transfer_matrix_claim_second_transfer_matrix_pauli_form`）
- 主張: `def_transfer_matrix` で成分により定めた `V_2`（`(V_2)_{ord(μ),ord(μ')} = exp(K_2 Σ_m μ(m)μ'(m))`）は
  `V_2 = (2 sinh 2K_2)^{M_col/2} exp(K_2^* Σ_{m=1}^{M_col} σ_m^x)`
  （`K_2^* = -½ log(tanh K_2)`、前係数は `def_second_transfer_matrix_prefactor`）
- 範囲: statement と proof の全段（「V_2 を A のクロネッカー冪で書く」「1 因子の exp をサイト演算子の exp にする」
  「積にまとめる」「結論」）
- 併せて使う主張・定義: `two_by_two_transfer_identity`、`def_second_transfer_matrix_prefactor`、
  `config_numbering_equals_kronecker_numbering`、`def_kronecker`

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
|---------|---------|-----------|------|
| check_V2_as_kronecker_power_exact.sage | `(V_2)_{ord,ord'} = exp(K_2Σμμ') = Π exp(K_2μ(m)μ'(m)) = Π A_{i_m j_m} = (A^{⊠M})_{ν(ι μ),ν(ι μ')} = (A^{⊠M})_{ord,ord'}` を全 `(μ,μ')` で、および `V_2 = A^{⊠M}`（`M_col = 1..6`） | PASS | Laurent 多項式として一致 |
| check_site_exponential_exact.sage | `(σ_m^x)^p = I⊠…⊠(σ^x)^p⊠…⊠I`（`p = 0..4`）、`exp(K_2^*σ_m^x) = I⊠…⊠exp(K_2^*σ^x)⊠…⊠I`、`σ_m^x` どうしの可換性、`exp(K_2^*Σσ_m^x) = Π_m exp(K_2^*σ_m^x) = exp(K_2^*σ^x)^{⊠M}`（`M_col = 1..5`、`exp(K_2) ∈ {2, 3/2, 5/4}`） | PASS | `AA` で全て一致 |
| check_conclusion_exact.sage | `0 < tanh K_2 < 1`（`K_2^* > 0`）、`A = (2s_2)^{1/2} exp(K_2^*σ^x)`、前係数が正、結論の鎖 5 段と主張そのもの、否定コントロール 2 種（`M_col = 1..5`、`exp(K_2) ∈ {2, 3/2, 5/4, 7/3}`） | PASS | `AA` で全て一致 |
| check_numeric_general_K2.sage | 一般の `K_2 ∈ {0.05, 0.3, 0.4406868, 0.8, 1.1}` で主張（`M_col = 1..6`） | PASS | 相対誤差 最大 3.1e-15 |

## 備考

- **Laurent 多項式版**: `x = exp(K_2)` を不定元とし、`exp(K_2 n) = x^n`（`n ∈ ZZ`）として `ZZ[x, x^{-1}]` で比べる。
  多項式としての一致は任意の `K_2` での一致と同値。ℝ 脱出なし。
- **代数的数版**: `K_2 = log x`（`x ∈ QQ`, `x > 1`）と選ぶと、`2 sinh 2K_2 = x^2 - x^{-2}`、
  `tanh K_2 = (x^2-1)/(x^2+1)` は `QQ`、`exp(K_2^* λ) = (√tanh K_2)^{-λ}` と前係数 `(√(2 sinh 2K_2))^{M_col}` は
  `AA`（実代数的数。等号は決定可能）に住む。行列の指数関数は整数固有値をもつ対称な整数行列
  （`σ^x`、`σ_m^x`、`Σ_m σ_m^x`）のスペクトル射影で計算した（方法は `_shared/row_configurations.sage` の冒頭）。
  ℝ 脱出は `K_2` の選び方の一点だけ（見かけだけの ℝ 脱出）。
- **数値版**は一般の `K_2` を扱うための ℝ 脱出（指数評価・実対数）。`CDF` 行列の `exp` を級数定義の値の
  近似として使い、許容誤差は成分の最大絶対値で正規化した相対誤差 `1e-12`。
- 否定コントロール（check_conclusion_exact.sage 内）: `exp(K_2^*λ)` の代わりに `exp(K_2λ)` を使った右辺、
  前係数の冪を `M_col - 1` にした右辺は、全ケースで `V_2` と一致しないことを確かめている。
- 同じ主張の倍精度での独立な再確認は `043_claim_transfer_matrix_bridge/check_02_V2_bridge.sage`。

## 実行方法

```bash
cd sagemath/check/second_transfer_matrix_pauli_form
for f in check_*.sage; do sage "$f"; done
```

実行ログは `logs/` に保存してある（2026-09-26、SageMath 10.9）。
