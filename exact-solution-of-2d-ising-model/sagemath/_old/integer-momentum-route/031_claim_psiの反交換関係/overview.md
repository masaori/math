# 031 ψ の反交換関係 — SageMath 検証

## 対象

**対象ラベル**: `anticommutator_of_psi` （structured-latex 側の安定識別子。Typst 廃止後はこれで対応付ける）

`_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/031_claim_psiの反交換関係.typ` の Claim:

```
[ψ†_μ, ψ†_ν]_+ = 0
[ψ†_μ, ψ_ν]_+  = δ^M_{μ+ν,0} I
[ψ_μ, ψ_ν]_+   = 0
```

## 検証方針

`#ref(<def_fermi>)` の正規化 `c_μ := 1/(2√M γ_2(-θ_μ))` のもとで反交換子のスカラー係数

```
coeff = c_μ c_ν (∓ sqrt(γγ-)_μ sqrt(γγ-)_ν + γ_2(-θ_μ) γ_2(-θ_ν)) · 2M
```

を ν = -μ (μ+ν=0) で評価。期待値:
- (a) [ψ†_μ, ψ†_ν]_+: coeff = 0
- (b) [ψ†_μ, ψ_ν]_+: coeff = 1
- (c) [ψ_μ, ψ_ν]_+: coeff = 0

## 実行結果

| # | ファイル | 内容 | 結果 |
| --- | --- | --- | --- |
| 01 | check_01_psi_dagger_psi_dagger.sage | (a) [ψ†_μ, ψ†_ν]_+ = 0 with ν=-μ | PASS |
| 02 | check_02_psi_dagger_psi.sage | (b) [ψ†_μ, ψ_ν]_+ = I with ν=-μ | PASS |
| 03 | check_03_psi_psi.sage | (c) [ψ_μ, ψ_ν]_+ = 0 with ν=-μ | PASS |

テストパラメータは `_shared/defs.sage` の `DEFAULT_TEST_PARAMS` (K1, K2 の 7 組み合わせ)、`M = 100`、許容誤差 `1e-10`。各パラメータについて μ ∈ {-M, ..., -1, 1, ..., M} の全 200 個でチェック。
