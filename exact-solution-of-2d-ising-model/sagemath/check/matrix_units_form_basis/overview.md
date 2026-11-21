# SageMath Check: matrix_units_form_basis

## 対象

**対象ラベル**: `matrix_units_form_basis` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/002_linear_space_general.ts`
- ブロック: `linear_space_general_claim_matrix_units_form_basis`
- 範囲: 証明の各段・主張

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 証明の各段・主張 | `check_steps.sage` | m, n ∈ {1,2,3} と辞書式・乱数の 2 通りの全単射 π で、E の定め方、Step 1 の t ≠ t_0 の 3 行の鎖と (C) の 7 行の鎖（全 (k,l)）、Step 2 の A = Σ b_t F_t、Step 3 の線型独立性（階数 N）、標準基底。対照: 一つ除くと張らない | **PASS** | 1576 件 |

## 計算の帰属と範囲

- **厳密**: 係数体は Gauss 有理数体 `K = QQ(i)`。浮動小数点は使わない。線型結合・有限和は本文の定義どおり左から順に足す（`p = 0` の線型結合は零行列）。共通の道具は `sagemath/_shared/linear_algebra_families.sage`。
- 範囲外: 選んだ以外の大きさ・族・係数。点での検算は証明ではなく、式変形の書き間違いの裏取りである。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh matrix_units_form_basis
```

実行ログは `logs/` に保存してある（2026-11-21）。
