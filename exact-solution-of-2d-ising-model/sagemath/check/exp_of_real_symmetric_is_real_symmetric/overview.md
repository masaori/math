# SageMath Check: exp_of_real_symmetric_is_real_symmetric

## 対象

**対象ラベル**: `exp_of_real_symmetric_is_real_symmetric` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/009_eigenvalues_of_V.ts`
- ブロック: `eigenvalues_of_V_claim_exp_of_real_symmetric_is_real_symmetric`（実対称な複素行列の exp は実対称）

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| `A^* = A`（`real_symmetric_matrix_is_hermitian`）と `A^⊤ = A` | `check_exp_balls.sage` | 実対称な具体の行列（QQ 成分の `C + C^⊤`、`n = 1,…,4`、各 3 個）で厳密に | **PASS** | 全て PASS |
| `exp(A)^* = exp(A)`（`exp_of_hermitian_is_hermitian`）と `exp(A)^⊤ = exp(A)`（`exp_of_symmetric_is_symmetric`） | 同上 | 本文の部分和に尾の評価を足したボールの行列 `exp(A)` と、その共役転置・転置の囲みが重なること。Sage の `exp` の囲みとも重なること | **PASS** | 同上 |
| 結論（`hermitian_and_transpose_invariant_matrix_is_real_symmetric` により `exp(A)` は実対称） | 同上 | `exp(A)` の各成分の虚部の囲みが 0 を含むこと | **PASS** | 同上 |

否定コントロール（2 件）: エルミートだが実でない `[[0, i], [−i, 0]]` では `exp(A)^⊤` と `exp(A)` の囲みが重ならない。転置で不変だが実でない `[[i, 0], [0, 0]]` では `exp(A)^*` と `exp(A)` の囲みが重ならず、虚部の囲みが 0 を含まない成分がある。

## 計算の帰属と範囲

`A` の性質は QQ(i) で厳密に確かめた。`exp(A)` は `ℝ` への脱出（部分和の極限）なので、256 ビットの区間で本文の部分和と尾の上界から囲んだ（`_shared/hermitian_forms_by_definition.sage` の `body_exp_ball`）。

## 確かめられない行と理由

`N → ∞` の極限は有限の計算では確かめられない。ボールの検算は、具体の行列で囲みが重なること（矛盾が無いこと）を確かめるにとどまる。引いた 4 つの主張それぞれの証明の行は、各主張の検算フォルダが確かめる。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh exp_of_real_symmetric_is_real_symmetric
```

実行ログは `sagemath/check/exp_of_real_symmetric_is_real_symmetric/logs/` に保存する。
