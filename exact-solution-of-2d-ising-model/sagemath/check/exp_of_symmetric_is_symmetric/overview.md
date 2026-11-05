# SageMath Check: exp_of_symmetric_is_symmetric

## 対象

**対象ラベル**: `exp_of_symmetric_is_symmetric` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/009_eigenvalues_of_V.ts`
- ブロック: `eigenvalues_of_V_claim_exp_of_symmetric_is_symmetric`（転置で不変な行列の exp は転置で不変）

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 冒頭の `(I^⊤)_kl` の 4 行 | `check_powers.sage` | `n = 1, 2, 3` の全成分で、`def_matrix_transpose`・`def_identity_matrix`・`def_kronecker_delta` を成分から組んで確かめた | **PASS** | 全て PASS |
| 準備 `SS^m = S^mS` の帰納法（`m = 0` の 4 行、`m → m+1` の 4 行） | 同上 | 一般の `S` の成分を不定元の対に置き、`m = 0,…,4`（帰納の段は `m → m+1` の `m = 0,…,4`）、`n = 1, 2, 3` で確かめた | **PASS** | 同上 |
| 準備 `(S^m)^⊤ = S^m` の帰納法（`m = 0` の 3 行、`m → m+1` の 6 行） | 同上 | `S` を転置で不変な不定元の表（`S_lk := S_kl`、共役は取らない）に置き、`m = 0,…,4` で確かめた。`S^6` を Sage の冪・転置と比べた。仮定が要ることの確認として、一般の `S`（`n = 2, 3`）では `(S^2)^⊤ ≠ S^2` であることも確かめた | **PASS** | 同上 |
| 部分和の成分の式と `((E_N)^⊤)_kl` の 5 行 | `check_partial_sums_and_limit.sage` | `S` を転置で不変な不定元の表に置き、`N = 0,…,5`、`n = 1, 2, 3` の全成分で確かめた | **PASS** | 同上 |
| 極限の段と主張 | 同上 | 転置で不変な具体の `QQ(i)` の行列（`C + C^⊤`、実対称に限らない。`n = 1,…,4`、各 3 個）で、本文の部分和に尾の評価を足したボールの行列 `exp(S)` と、その転置が重なること、Sage の `exp` と重なることを確かめた。転置で不変でない `S`（`n = 2, 3, 4`）では重ならないことも確かめた | **PASS** | 同上 |

## 計算の帰属と範囲

冒頭の鎖、準備と部分和の鎖は不定元で厳密に確かめた。極限の段は `ℝ` への脱出なので、256 ビットの区間で本文の部分和と尾の上界から `exp(S)` を囲んだ（`_shared/hermitian_forms_by_definition.sage` の `body_exp_ball`）。

本文の部分和のボールを Sage 組み込みの `ComplexBallField` の `exp` と比べ、冪を Sage の行列の冪と比べた。

## 確かめられない行と理由

冒頭の `(I^⊤)_{kl}` の鎖と、部分和の鎖の `def_matrix_transpose` の 2 行は、検算での組み方そのものが定義なので、隣り合う行の比較は同語反復である。独立な確認は、`S^6` を Sage の冪・転置と比べる検査と、ボールの `exp` を Sage の `exp` と比べる検査が担う。

`N → ∞` の極限、`transpose_preserves_matrix_limits` の適用と極限の一意性は有限の計算では確かめられない。ボールの検算は、具体の行列で `exp(S)^⊤` と `exp(S)` の囲みが重なること（矛盾が無いこと）を確かめるにとどまる。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh exp_of_symmetric_is_symmetric
```

実行ログは `sagemath/check/exp_of_symmetric_is_symmetric/logs/` に保存する。
