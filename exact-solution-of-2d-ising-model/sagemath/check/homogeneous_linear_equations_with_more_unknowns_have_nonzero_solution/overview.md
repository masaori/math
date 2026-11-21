# SageMath Check: homogeneous_linear_equations_with_more_unknowns_have_nonzero_solution

## 対象

**対象ラベル**: `homogeneous_linear_equations_with_more_unknowns_have_nonzero_solution` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/002_linear_space_general.ts`
- ブロック: `linear_space_general_claim_homogeneous_linear_equations_with_more_unknowns_have_nonzero_solution`
- 範囲: 証明の各段・主張

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 証明の各段・主張 | `check_recursive_construction.sage` | 証明の帰納法どおりの再帰で c を作り、q = 0、場合 1 の 7 行の鎖、場合 2 の g_{kj_0} の 5 行・Σ c_i a_ij の 11 行・j = j_0 の 3 行・j ≠ j_0 の 3 行の鎖（δ^q_{j_0} を含む）を確かめる。q = 0, …, 4、p = q+1, …, q+3 の 90 例で q = 0 を 50 回、場合 1 を 40 回、場合 2 を 92 回通した。主張（c ≠ 0 で方程式を満たす）。対照: p ≤ q では 0 でない解が無い例がある | **PASS** | 5452 件 |

## 計算の帰属と範囲

- **厳密**: 係数体は Gauss 有理数体 `K = QQ(i)`。浮動小数点は使わない。線型結合・有限和は本文の定義どおり左から順に足す（`p = 0` の線型結合は零行列）。共通の道具は `sagemath/_shared/linear_algebra_families.sage`。
- 範囲外: 選んだ以外の大きさ・族・係数。点での検算は証明ではなく、式変形の書き間違いの裏取りである。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh homogeneous_linear_equations_with_more_unknowns_have_nonzero_solution
```

実行ログは `logs/` に保存してある（2026-11-21）。
