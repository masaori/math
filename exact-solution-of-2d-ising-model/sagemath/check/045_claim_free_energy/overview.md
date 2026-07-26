# SageMath Check: 045_claim_free_energy

## 対象

**対象ラベル**: `onsager_free_energy_expression` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/012_free_energy.ts`
- 併せて検証:
  - `limit_of_log_Z_in_N_row`
  - `gamma1_lower_bound_all_theta` / `gamma_is_continuous`
  - `riemann_sum_to_integral`（★実数解析への移行点）
  - `remark_remaining_input_even_sector`（残っている入力の所在）

### 何を確定させるための検証か

012 章は熱力学極限を 2 段で取る。

1. `N_row → ∞`：`|(1/(M N_row)) log Z − (1/M) log c(M)| <= log2 / N_row`（有限の不等式のみ）
2. `M → ∞`：`(1/M) Σ_μ γ(2π(μ−δ)/M) → (1/2π) ∫_0^{2π} γ`（**ここだけ実数解析へ移行する**）

結論は

```
(1/M) log Λ^{(δ)}_M  →  (1/2) log(2 sinh 2K_2) + (1/4π) ∫_0^{2π} γ(θ) dθ     （δ に依らない）
```

これらを数値で確かめる。あわせて、**厳密解へ残っている唯一の入力**——偶セクター `V^{(+)}` の
固有値が半整数運動量で与えられること——が実際にそうなっていること、および
本文の 008 章の議論が `(+)` に使えない理由を数値で固定する。

## 検証の枠組み

`044_claim_max_eigenvalue/_prelude.sage` を土台にして、本ディレクトリの `_prelude.sage` で

| 関数 | 内容 |
|---|---|
| `gamma_fn(K1,K2)` | `γ(θ) = arccosh(cosh2K_1 cosh2K_2^* − sinh2K_1 sinh2K_2^* cos θ)` |
| `gamma1_lower(K1,K2)` | `cosh(2K_1 − 2K_2^*)`（`γ_1` の下限） |
| `theta_family(M,δ)` | `{2π(μ−δ)/M}_{μ=1..M}` |
| `Lambda_delta(M,K1,K2,δ)` | `(2 sinh 2K_2)^{M/2} exp(½ Σ γ)` |
| `onsager_rhs(K1,K2)` | `½ log(2 sinh 2K_2) + (1/4π) ∫ γ` |

`(K1,K2)` は 4 組（`FE_CASES`）で、**臨界点（`sinh 2K_1 sinh 2K_2 = 1`）にほぼ一致する
`(0.4407, 0.4407)` を含む**。

## チェック一覧

| # | ファイル | 検証内容 | ステータス | 結果 |
|---|---------|---------|-----------|------|
| 01 | check_01_limit_in_N_row.sage | `\|(1/(MN))log Z − (1/M)log c\| <= log2/N` | PASS | （run-log.txt 参照） |
| 02 | check_02_riemann_sum.sage | `γ_1 >= cosh(2K_1−2K_2^*) >= 1`、リーマン和 → 積分（`δ=0` と `δ=1/2`）、Onsager 表式 | PASS | （run-log.txt 参照） |
| 03 | check_03_remaining_input.sage | `V^{(−)}` は整数運動量、`V^{(+)}` は半整数運動量。`[H_2, hatZ^{(+)}] ≠ −2 hatY` | PASS | （run-log.txt 参照） |

## 備考

- **収束の速さと臨界点**: `riemann_sum_to_integral` の誤差評価は `γ` の連続度 `ω(2π/M)` で支配される。
  非臨界では `γ` は滑らかで収束が速いが、**臨界点では `γ(θ)` が `θ = 0` の近くで `|θ|` のオーダーでしか
  小さくならず**、連続度が悪くなるため収束が目に見えて遅い。check_02 はその差も出力する。
  本文の証明は連続性しか使っていないので、臨界点でも結論は変わらない。
- **check_03 が固定していること**: `V^{(+)}` の固有値は半整数運動量の `Λ_ε` に一致し（相対誤差 1e-8 以下）、
  整数運動量とは明確に一致しない（相対差 1e-3 以上）。また `[H_2, hatZ_μ^{(-)}] = −2 hatY_μ` は成り立つが
  `[H_2, hatZ_μ^{(+)}] = −2 hatY_μ` は成り立たない。後者が、008 章の議論を `(+)` セクターへ
  そのまま適用できない理由である（`remark_remaining_input_even_sector`）。

## 実行方法

```bash
for f in sagemath/check/045_claim_free_energy/check_*.sage; do sage "$f"; done
```

## 実行ログ

`run-log.txt` に実際の実行出力（全チェックの残差と PASS/FAIL）を保存してある。
