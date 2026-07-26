# SageMath Check: 042_claim_constant_c_and_eigenvalues_of_V

## 対象

**対象ラベル**: `constant_c_value` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/009_eigenvalues_of_V.mjs`
- 併せて検証:
  - `iH_is_real_symmetric`（`i K_1 H_1^{(±)}`、`i K_2^* H_2` が実対称であること）
  - `sign_flip_conjugation`（符号反転共役 `U`）
  - `number_operator_idempotent` / `number_operators_commute` / `trace_of_number_operator_product`
  - `joint_eigenspace_decomposition`（同時固有空間分解）
  - `eigenvalues_of_Vprime` / `trace_of_Vprime`
  - `eigenvalues_of_V`

### 何を確定させるための検証か

`V_eq_Vprime`（008 章）は「ある `c ∈ C^×` が存在して `V = cV'`」までしか言っておらず、
**`c` の値は未決定だった**。009 章はこれを

```
c = (2 sinh 2K_2)^{M/2}
```

と決定する。この値は本文の証明とは独立に、行列を明示的に構成して数値的に確かめられる
（`V'^{-1}V` がスカラー行列になり、そのスカラーが `(2 s_2)^{M/2}` に一致すること）。
本文の証明が使う中間命題も、同じ枠組みで一つずつ確認する。

## 検証の枠組み

`sagemath/_shared/spin_ops.sage` の演算子構成（`Z_m, Y_m, H_1^{(±)}, H_2, hatZ, hatY` を
`Mat(2,C)^{⊗M}` の明示的な複素行列として構成）に、本ディレクトリの `_prelude.sage` で

| 記号 | 構成 |
|---|---|
| `S_1^{(±)}` | `i K_1 H_1^{(±)}` |
| `S_2` | `i K_2^* H_2` |
| `V` | `exp(S_1/2) · (2 s_2)^{M/2} exp(S_2) · exp(S_1/2)` |
| `ψ_μ†, ψ_μ` | `def_fermi` の定義式（本プロジェクト定義の `sqrt`、偏角 `[0,2π)`） |
| `n_μ` | `ψ_μ† ψ_{-μ}` |
| `V'` | `exp( Σ_{μ∈I} γ(θ_μ)(n_μ − I/2) )` |
| `U` | `(Π_{m odd} σ^x_m)(Π_m σ^z_m)` |

を追加して構成する。`γ(θ_μ) = arccosh(γ_1(θ_μ))`、
`I = { μ ∈ {1..M} | γ_2(θ_μ) ≠ 0 }`、`m = |I|`。

パラメータは `M = 2,3,4,5`、`(K1,K2)` は `_prelude.sage` の `TEST_CASES`（10 組）。
`iH_is_real_symmetric` と `sign_flip_conjugation` は `H_1^{(+)}`、`H_1^{(-)}` の両符号で検証する。

## チェック一覧

| # | ファイル | 検証内容 | ステータス | 結果 |
|---|---------|---------|-----------|------|
| 01 | check_01_real_symmetric.sage | `S_1^{(±)}`, `S_2` の実対称性と σ 表示 | PASS | 全 20 ケース残差 **0.00e+00**（厳密に一致） |
| 02 | check_02_sign_flip_conjugation.sage | `U S U^{-1} = -S` と `tr(e^{S_1}e^{S_2}) = tr(e^{-S_1}e^{-S_2})` | PASS | 共役は残差 **0.00e+00**、トレース比は相対 1e-16 以下 |
| 03 | check_03_number_operators.sage | 数演算子の冪等性・可換性・トレース・同時固有空間分解 | PASS | 最大残差 5.4e-15 |
| 04 | check_04_constant_c.sage | `V'^{-1}V = cI` と `c = (2 sinh 2K_2)^{M/2}` | PASS | `c` の相対誤差 最大 7.6e-15、`V'^{-1}V - cI` 最大 1.2e-12 |
| 05 | check_05_eigenvalues_of_V.sage | `V` の固有値（`VQ_ε = Λ_ε Q_ε`、スペクトル一致、`Λ_max`, `Λ_min`） | PASS | 相対残差 最大 9.2e-13（スペクトル一致は 2.6e-14） |

（実測値は `run-log.txt` を参照。）

## 検証した式

check_01（`iH_is_real_symmetric`）:

```
S_1^{(±)} = K_1 Σ_{m=1}^{M-1} σ^z_m σ^z_{m+1}  ∓ K_1 G,   G = σ^y_1 σ^x_2 ⋯ σ^x_{M-1} σ^y_M
S_2       = K_2^* Σ_{m=1}^{M} σ^x_m
S^T = S,  conj(S) = S   （実対称）
```

check_02（`sign_flip_conjugation`）:

```
U S_1^{(±)} U^{-1} = −S_1^{(±)},   U S_2 U^{-1} = −S_2
⟹ tr(exp(S_1) exp(S_2)) = tr(exp(−S_1) exp(−S_2))
```

check_03（`joint_eigenspace_decomposition` ほか）:

```
n_μ² = n_μ,   ψ_{-μ} ψ_μ† = I − n_μ,   n_μ n_ν = n_ν n_μ
tr(n_μ) = 2^{M-1},   tr(n_μ n_ν) = 2^{M-2}
Q_ε := Π_μ ( n_μ or I − n_μ ),   Σ_ε Q_ε = I,  Q_ε Q_ε' = δ Q_ε,
n_ν Q_ε = ε_ν Q_ε,   tr(Q_ε) = 2^{M-m}
```

check_04（`constant_c_value`）:

```
V'^{-1} V = c I,   c = (2 sinh 2K_2)^{M/2}
tr(V') = tr(V'^{-1}) = 2^{M-m} Π_{μ∈I} 2cosh(γ(θ_μ)/2) > 0
tr(V) > 0,  tr(V^{-1}) > 0,   tr(V)/tr(V^{-1}) = c²
```

check_05（`eigenvalues_of_V`）:

```
V Q_ε = Λ_ε Q_ε,  Λ_ε = (2 s_2)^{M/2} exp( Σ_{μ∈I} γ(θ_μ)(ε_μ − 1/2) )
{Λ_ε（重複度 2^{M-m}）} が V の固有値の多重集合に一致
Λ_max = (2 s_2)^{M/2} exp(+½ Σ γ),  Λ_min = (2 s_2)^{M/2} exp(−½ Σ γ)
Λ_max · Λ_min = (2 s_2)^M = c²
```

## 備考

- **証明経路の独立性**: check_04 は `V` と `V'` を定義から独立に構成して `V'^{-1}V` を直接計算しており、
  本文の証明（トレース比と符号反転共役）を再現しているわけではない。したがって本文の証明が
  誤っていても、結論 `c = (2 sinh 2K_2)^{M/2}` の正しさはここで独立に担保される。
  そのうえで check_02 は本文の証明で鍵になる等式を個別に確認している。
- **`M = 2` を含める理由**: `G` の中間の `σ^x` が消える境界ケース（`G = σ^y_1 σ^y_2`）を
  本文が別扱いしているので、その場合も確認するため。
- **臨界点**: `TEST_CASES` の `(K1,K2)` はいずれも `sinh 2K_1 sinh 2K_2 ≠ 1` なので
  `m = M`（`I = {1,…,M}`）になる。臨界点（`m = M−1`）の場合は本文では扱えているが、
  数値検証では `γ_2(θ_M) = 0` の判定が浮動小数で不安定になるため含めていない。
  この点は未検証として明記しておく。

## 実行方法

```bash
for f in sagemath/check/042_claim_constant_c_and_eigenvalues_of_V/check_*.sage; do sage "$f"; done
```

## 実行ログ

`run-log.txt` に実際の実行出力（全チェックの残差と PASS/FAIL）を保存してある。
