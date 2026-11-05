# SageMath Check: transpose_preserves_matrix_limits

## 対象

**対象ラベル**: `transpose_preserves_matrix_limits` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/009_eigenvalues_of_V.ts`
- ブロック: `eigenvalues_of_V_claim_transpose_preserves_matrix_limits`（収束する行列の列の転置は極限の転置へ収束する）
- 範囲: 極限の主張の各 `N` での 2 つの等号。転置・差・ノルムの組み方は `sagemath/check/transpose_preserves_matrix_norm/_prelude.sage` を読み込む

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 極限の主張の `‖A_N^⊤ − A^⊤‖ = ‖(A_N − A)^⊤‖`（`transpose_of_matrix_difference`） | `check_limits.sage` | `A_N, A` の成分を不定元の対に置き、両辺の行列を Sage の `transpose`・差と比べる。具体の列でノルムの値を `AA` で比べる。否定コントロール 1 件（`A^⊤ − A_N^⊤` は `(A_N − A)^⊤` と一致しない） | **PASS** | `n = 1,…,4` の不定元、`N = 0,…,29` |
| 極限の主張の `= ‖A_N − A‖`（`transpose_preserves_matrix_norm`） | 同上 | 具体の列 `A_N := A + C/(N+1)`（成分は `QQ(i)`）で各 `N` の値を `AA` で比べる | **PASS** | `n = 1,…,4`、`N = 0,…,29` で厳密等号 |

## 計算の帰属と範囲

浮動小数点と `RR` / `CC` への脱出はない。

- ℂ は本文 `definition_of_cc` どおり実数の対で持ち（`_shared/complex_as_real_pairs.sage`）、転置・差・ノルムは本文の定め方どおりに成分から組んだ（`../transpose_preserves_matrix_norm/_prelude.sage`）。
  一般の等式は成分を `QQ` 上の多項式環の不定元に置いて確かめた。
- 根号を取る行は、実代数的数 `AA` の中で厳密に平方根を取った。
- 大きさは `n = 1,…,4` である。一般の `n` は検算の範囲外で、人手証明が担う。

## 確かめられない行と理由

- 極限の主張の最後の段（`‖A_N − A‖ → 0` から `‖A_N^⊤ − A^⊤‖ → 0`、`A_N^⊤ → A^⊤`）は `N → ∞` の極限で、`ℝ` への脱出である。有限の計算では確かめられない。
  検算は、各 `N` で二つの数列の項が等しいこと（極限の段が使う事実）を具体の列で確かめるにとどまる。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh transpose_preserves_matrix_limits
```

実行ログは `sagemath/check/transpose_preserves_matrix_limits/logs/` に保存する。
