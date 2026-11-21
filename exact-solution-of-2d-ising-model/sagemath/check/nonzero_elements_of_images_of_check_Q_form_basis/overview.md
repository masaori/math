# SageMath Check: nonzero_elements_of_images_of_check_Q_form_basis

## 対象

**対象ラベル**: `nonzero_elements_of_images_of_check_Q_form_basis` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/eigenvalue_problem_eigenvalues_of_V_plus.ts`
- ブロック: `evenEigen_claim_nonzero_elements_of_images_of_check_Q_form_basis`
- 範囲: 証明の各段・主張

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 証明の各段・主張 | `check_steps.sage` | Jordan–Wigner の模型の ň_μ（M_col = 2, 3。check_joint_eigenspace_decomposition/_number_operators.sage）で Q̌_ε を作り、Step 1 の ε ≠ ε' の 4 行・ε = ε' の 8 行の鎖（全 ε, ε'）、Step 2 の t ≠ t_0 の 3 行と d_{t_0}q の 5 行の鎖（乱数の全単射 π 2 通り・乱数の d）、主張（階数 N）。対照: 同じ像から二つ取ると線型独立でない | **PASS** | 926 件 |

## 計算の帰属と範囲

- **厳密**: 係数体は Gauss 有理数体 `K = QQ(i)`（成分は QQ の模型を K へ移したもの）。浮動小数点は使わない。線型結合・有限和は本文の定義どおり左から順に足す（`p = 0` の線型結合は零行列）。共通の道具は `sagemath/_shared/linear_algebra_families.sage`。
- 範囲外: 選んだ以外の大きさ・族・係数。点での検算は証明ではなく、式変形の書き間違いの裏取りである。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh nonzero_elements_of_images_of_check_Q_form_basis
```

実行ログは `logs/` に保存してある（2026-11-21）。
