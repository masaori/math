# SageMath Check: power_of_real_symmetric_complex_matrix_is_real_symmetric

## 対象

**対象ラベル**: `power_of_real_symmetric_complex_matrix_is_real_symmetric`

- ファイル: `structured-latex/content/009_eigenvalues_of_V.ts`
- ブロック: `eigenvalues_of_V_claim_power_of_real_symmetric_complex_matrix_is_real_symmetric`（実対称な複素行列の冪は実対称）
- 範囲: 準備 `A^1 = A` の鎖 4 行、`p = 0` の単位行列の成分の鎖 3 行と転置の鎖 4 行、帰納法の段の成分の実数性と転置の鎖 11 行、主張そのもの

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス |
|---|---|---|---|
| 準備 `A^1 = A^{0+1} = A^0A = IA = A` | `check_induction_chains.sage` | 冪は `def_exp` (1)、積は `mat_mult`、単位行列は `def_identity_matrix` と `def_kronecker_delta` で作り、4 段 | **PASS** |
| `p = 0`: `I_kl = δ_kl = {1_C, 0_C} = {ι(1), ι(0)}`、`(I^⊤)_kl = I_lk = δ_lk = δ_kl = I_kl` | `check_induction_chains.sage` | 全成分で各段。`δ_kl` を実数の組 `(1,0)`・`(0,0)` で持ち、それが ℂ の積・和の単位元であること（一般の元 `(x, y)` で）と `ι(1)`・`ι(0)` との一致、虚部 0 | **PASS** |
| 帰納法の段の成分が実（`product_of_real_entry_matrices_has_real_entries`） | `check_induction_chains.sage` | `(A^pA)_kl` を実数の組で組んだ ℂ の積の和として作り、虚部が 0 で `A^{p+1}` の成分と一致 | **PASS** |
| 帰納法の段の転置の鎖（`def_matrix_transpose` → `def_exp` (1) → `mat_mult` → 転置 2 箇所 → 帰納法の仮定 → 仮定 `A^⊤ = A` → 可換則 → `mat_mult` → `A^1 = A` → `matrix_power_exponent_law` → 加法の可換則） | `check_induction_chains.sage` | 帰納法の仮定 `(A^p)^⊤ = A^p` を確かめたうえで 11 段 | **PASS** |
| 主張 | `check_induction_chains.sage` | Sage の冪と転置（別の経路）で `(A^{p+1})^⊤ = A^{p+1}` | **PASS** |

成分 `a_kl = a_lk` を QQ 上の不定元にした実対称行列 `n = 1..3`（`p ≤ 3`、`n = 3` は `≤ 2`）と、QQ の具体の対称行列 `n = 1..5`（`p ≤ 5`）。5267 段。

## 計算の帰属と範囲

- **厳密**: QQ 上の多項式環と QQ。浮動小数点と ℝ/ℂ への脱出はない。不定元・有理数の成分は実数を代表し、成分が実であることは実数の組で組んだ積の虚部で確かめる。

## 否定コントロール（2 件）

- 対称でない `[[1,1],[0,1]]` の 2 乗は対称でない（仮定 `A^⊤ = A` が効いている）。
- 異なる対称行列 `diag(1,2)` と `[[0,1],[1,0]]` の積は対称でない（同じ `A` の冪であることが効いている）。

## 構成上かならず一致する比較

- `A^{0+1}`・`A^0A`・`(A^{p+1})_lk = (A^pA)_lk`・`(A^{1+p}) = (A^{p+1})` は冪を漸化式で作るので構成上一致する。
- `((A^{p+1})^⊤)_kl = (A^{p+1})_lk`・`Σ(A^p)_ljA_jk = Σ((A^p)^⊤)_jl(A^⊤)_kj` は転置を `def_matrix_transpose` の式で作るので、`(A^pA)_lk = Σ…`・`ΣA_kj(A^p)_jl = (AA^p)_kl` は積を `mat_mult` の式で作るので、`p = 0` の `I_kl = δ_kl`・`(I^⊤)_kl = I_lk`・`I_lk = δ_lk` は単位行列を δ から作るので、いずれも構成上一致する。`p = 0` の `δ_lk = δ_kl`・`δ_kl = ι(1)` または `ι(0)` の行も、δ と `ι` を同じ `k == l` の分岐と `(r, 0)` で作るので構成上一致する（略記を開く行なので避けられない）。構成上一致しないのは、`(1, 0)`・`(0, 0)` が ℂ の積・和の単位元であること（ℂ の一般の元 `(x, y)`、`x, y` は QQ 上の不定元で確かめる）だけである。中身は、転置と仮定の行・可換則の行・`A^1A^p = A^{1+p}` の行（別々に作った冪の積）と、Sage の冪・転置との比較にある。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh power_of_real_symmetric_complex_matrix_is_real_symmetric
```
