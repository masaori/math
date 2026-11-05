# SageMath Check: matrix_power_exponent_law

## 対象

**対象ラベル**: `matrix_power_exponent_law`

- ファイル: `structured-latex/content/003_exp_linear_map.ts`
- ブロック: `exp_linear_map_claim_matrix_power_exponent_law`（`A^{p+q} = A^pA^q`）
- 範囲: `q = 0` の鎖 3 行、帰納法の段の鎖 5 行、主張そのもの

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス |
|---|---|---|---|
| `q = 0`: `A^{p+0} = A^p = A^pI = A^pA^0` | `check_induction_chains.sage` | 冪は `def_exp` (1) の漸化式、積は `mat_mult` の成分の式、単位行列は `def_identity_matrix` で作り、3 段の等号 | **PASS** |
| 帰納法の段: `A^{p+(q+1)} = A^{(p+q)+1} = A^{p+q}A = (A^pA^q)A = A^p(A^qA) = A^pA^{q+1}` | `check_induction_chains.sage` | 帰納法の仮定 `A^{p+q} = A^pA^q` を確かめたうえで 5 段の等号 | **PASS** |
| 主張 | `check_induction_chains.sage` | Sage の冪 `A**k` と行列積 `*`（別の経路）で `A^{p+q+1} = A^pA^{q+1}`、`def_exp` (1) の冪と Sage の冪の一致 | **PASS** |

成分を QQ 上の不定元にした `n = 1..3` の行列（`p, q ≤ 3`、`n = 3` は `≤ 2`）と、`QQ(i)` の具体の行列 `n = 1..5`（`p, q ≤ 5`）。1473 段。

## 計算の帰属と範囲

- **厳密**: QQ 上の多項式環と `QQ(i)`。浮動小数点と ℝ/ℂ への脱出はない。不定元の行は多項式の恒等式なので、どの複素数の成分を代入しても成り立つ。

## 否定コントロール（1 件）

- 指数を 1 ずらした `A^{p+q} = A^pA^{q+1}` は `A = [[1,1],[0,1]]`、`p = q = 1` で外れる。

## 構成上かならず一致する比較

- `A^pI = A^pA^0`（`A^0` と `I` をどちらも `body_identity` で作る）、`A^{p+0} = A^p`・`A^{p+(q+1)} = A^{(p+q)+1}`・`A^{p+q}A`・`A^qA = A^{q+1}` は冪を漸化式で作るので構成上一致する。中身は、帰納法の仮定の行・結合則の行と、Sage の冪・積との比較にある。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh matrix_power_exponent_law
```
