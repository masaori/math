# SageMath Check: transpose_preserves_matrix_norm_and_limits

## 対象

**対象ラベル**: `transpose_preserves_matrix_norm`, `transpose_preserves_matrix_limits`

- ファイル: `structured-latex/content/009_eigenvalues_of_V.ts`
- ブロック: `eigenvalues_of_V_claim_transpose_preserves_matrix_norm`（`‖A^⊤‖ = ‖A‖`）、
  `eigenvalues_of_V_claim_transpose_preserves_matrix_limits`（収束する行列の列の転置は極限の転置へ収束する）
- 範囲: `‖A^⊤‖ = ‖A‖` の鎖の全行、極限の主張の各 `N` での 2 つの等号

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| `‖A^⊤‖ = √(ΣΣ|(A^⊤)_kl|^2)` から `= ‖A‖` までの 4 行 | `check_norm.sage` | 根号の中を不定元の対で厳密に比べ、根号を取った値を具体の `QQ(i)` 行列について `AA` で比べる。両端を Sage の `transpose` と QQbar の `abs` で組んだノルムと比べた。否定コントロール 2 件 | **PASS** | `n = 1,…,4` で厳密等号 |
| 極限の主張の `‖A_N^⊤ − A^⊤‖ = ‖(A_N − A)^⊤‖`（`transpose_of_matrix_difference`） | `check_limits.sage` | `A_N, A` の成分を不定元の対に置き、両辺の行列を Sage の `transpose`・差と比べる。具体の列でノルムの値を `AA` で比べる。否定コントロール 1 件（`A^⊤ − A_N^⊤` は `(A_N − A)^⊤` と一致しない） | **PASS** | `n = 1,…,4` の不定元、`N = 0,…,29` |
| 極限の主張の `= ‖A_N − A‖`（`transpose_preserves_matrix_norm`） | 同上 | 具体の列 `A_N := A + C/(N+1)`（成分は `QQ(i)`）で各 `N` の値を `AA` で比べる | **PASS** | `n = 1,…,4`、`N = 0,…,29` で厳密等号 |

## 計算の帰属と範囲

浮動小数点と `RR` / `CC` への脱出はない。

- ℂ は本文 `definition_of_cc` どおり実数の対で持ち（`_shared/complex_as_real_pairs.sage`）、転置・差・ノルムは本文の定め方どおりに成分から組んだ（`_prelude.sage`）。
  一般の等式は成分を `QQ` 上の多項式環の不定元に置いて確かめた。
- 根号を取る行は、実代数的数 `AA` の中で厳密に平方根を取った。
- 大きさは `n = 1,…,4` である。一般の `n` は検算の範囲外で、人手証明が担う。

## 確かめられない行と理由

- 定義を開く行（`def_matrix_norm`・`def_matrix_transpose` の行）は、検算での組み方そのものが定義なので、隣り合う行の比較は同語反復である。独立な確認は、両端を Sage の値と比べる検査が担う。
- 有限和の順序の入れ替えの行は、検算では何も確かめていない（同語反復）。根号の中を `QQ` 上の多項式環の和で組むと、和の値は項の並べ方によらない正規形になる。この行は `ℝ` の加法の結合法則・交換法則からの有限帰納法として人手証明が担う。
- 極限の主張の最後の段（`‖A_N − A‖ → 0` から `‖A_N^⊤ − A^⊤‖ → 0`、`A_N^⊤ → A^⊤`）は `N → ∞` の極限で、`ℝ` への脱出である。有限の計算では確かめられない。
  検算は、各 `N` で二つの数列の項が等しいこと（極限の段が使う事実）を具体の列で確かめるにとどまる。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh transpose_preserves_matrix_norm_and_limits
```

実行ログは `sagemath/check/transpose_preserves_matrix_norm_and_limits/logs/` に保存する。
