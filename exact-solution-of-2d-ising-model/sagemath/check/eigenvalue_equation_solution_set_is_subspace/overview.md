# SageMath Check: eigenvalue_equation_solution_set_is_subspace

## 対象

**対象ラベル**: `eigenvalue_equation_solution_set_is_subspace` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/002_linear_space_general.ts`
- ブロック: `linear_space_general_claim_eigenvalue_equation_solution_set_is_subspace`
- 範囲: 証明の 3 項

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 証明の 3 項 | `check_closure.sage` | A := PDP^{-1}（重複する固有値を含む）、固有値と固有値でない λ で (i) の 2 行・(ii) の 3 行・(iii) の 5 行の鎖。対照 | **PASS** | 289 件 |

## 計算の帰属と範囲

- **厳密**: 係数体は Gauss 有理数体 `K = QQ(i)`。浮動小数点は使わない。線型結合・有限和は本文の定義どおり左から順に足す（`p = 0` の線型結合は零行列）。共通の道具は `sagemath/_shared/linear_algebra_families.sage`。
- 範囲外: 選んだ以外の大きさ・族・係数。点での検算は証明ではなく、式変形の書き間違いの裏取りである。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh eigenvalue_equation_solution_set_is_subspace
```

実行ログは `logs/` に保存してある（2026-11-21）。
