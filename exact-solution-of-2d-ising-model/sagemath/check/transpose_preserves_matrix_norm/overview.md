# SageMath Check: transpose_preserves_matrix_norm

## 対象

**対象ラベル**: `transpose_preserves_matrix_norm`

- ファイル: `structured-latex/content/009_eigenvalues_of_V.ts`
- ブロック: `eigenvalues_of_V_claim_transpose_preserves_matrix_norm`（`‖A^⊤‖ = ‖A‖`）
- 範囲: `‖A^⊤‖ = ‖A‖` の鎖の全行。極限の主張 `transpose_preserves_matrix_limits` の検算は `sagemath/check/transpose_preserves_matrix_limits/` にあり、この `_prelude.sage` を読み込む

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| `‖A^⊤‖ = √(ΣΣ|(A^⊤)_kl|^2)` から `= ‖A‖` までの 4 行 | `check_norm.sage` | 根号の中を不定元の対で厳密に比べ、根号を取った値を具体の `QQ(i)` 行列について `AA` で比べる。両端を Sage の `transpose` と QQbar の `abs` で組んだノルムと比べた。否定コントロール 2 件 | **PASS** | `n = 1,…,4` で厳密等号 |

## 計算の帰属と範囲

浮動小数点と `RR` / `CC` への脱出はない。

- ℂ は本文 `definition_of_cc` どおり実数の対で持ち（`_shared/complex_as_real_pairs.sage`）、転置・差・ノルムは本文の定め方どおりに成分から組んだ（`_prelude.sage`）。
  一般の等式は成分を `QQ` 上の多項式環の不定元に置いて確かめた。
- 根号を取る行は、実代数的数 `AA` の中で厳密に平方根を取った。
- 大きさは `n = 1,…,4` である。一般の `n` は検算の範囲外で、人手証明が担う。

## 確かめられない行と理由

- 定義を開く行（`def_matrix_norm`・`def_matrix_transpose` の行）は、検算での組み方そのものが定義なので、隣り合う行の比較は同語反復である。独立な確認は、両端を Sage の値と比べる検査が担う。
- 有限和の順序の入れ替えの行は、検算では何も確かめていない（同語反復）。根号の中を `QQ` 上の多項式環の和で組むと、和の値は項の並べ方によらない正規形になる。この行は `ℝ` の加法の結合法則・交換法則からの有限帰納法として人手証明が担う。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh transpose_preserves_matrix_norm
```

実行ログは `sagemath/check/transpose_preserves_matrix_norm/logs/` に保存する。
