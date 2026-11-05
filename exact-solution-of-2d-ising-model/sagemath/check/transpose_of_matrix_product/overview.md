# SageMath Check: transpose_of_matrix_product

## 対象

**対象ラベル**: `transpose_of_matrix_product`

- ファイル: `structured-latex/content/002_linear_space_general.ts`
- ブロック: `linear_space_general_claim_transpose_of_matrix_product`（行列の積の転置は転置を逆の順に掛けた積）
- 範囲: 証明の鎖の全行

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 鎖の全行 | `check_entry_chain.sage` | `((AB)^⊤)_{kl} = (AB)_{lk} = Σ_j A_{lj}B_{jk} = Σ_j (A^⊤)_{jl}(B^⊤)_{kj} = Σ_j (B^⊤)_{kj}(A^⊤)_{jl} = (B^⊤A^⊤)_{kl}` の 5 段（`def_matrix_transpose` → `mat_mult` → `def_matrix_transpose` を各項の 2 箇所 → ℂ の積の交換律 → `mat_mult`）を、`A, B` の成分を不定元にして全成分で。否定コントロール 1 件: 右辺を `A^⊤B^⊤` にすると一致しない | **PASS** | 540 段 |

## 計算の帰属と範囲

- **厳密**: `QQ(i)` 係数の多項式環で、浮動小数点と ℝ/ℂ への脱出はない。行列の成分は不定元で代表させる（鎖の各段は多項式の恒等式なので、どの複素数を代入しても成り立つ）。
- 範囲: 行列の大きさ `m, n, p = 1..3`。主張は成分ごとの等式なので、大きさによらず同じ段である。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh transpose_of_matrix_product
```

実行ログは `logs/` に保存する。
