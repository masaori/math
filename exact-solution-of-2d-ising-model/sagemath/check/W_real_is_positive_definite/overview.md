# SageMath Check: W_real_is_positive_definite

## 対象

**対象ラベル**: `W_real_is_positive_definite` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/thermodynamic_limit_row_limit_and_max_eigenvalue.ts`
- ブロック: `maxeig_claim_W_real_is_positive_definite`（`x ≠ 0` なら `x^⊤W_ℝx > 0`）
- 範囲: `ξ_k := (x_k)_ℂ` の置き方と `ξ ≠ 0`、証明の 10 行の鎖 `r_ℂ = ξ^*Wξ = … = (x^⊤W_ℝx)_ℂ`、`x^⊤W_ℝx = r > 0`

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 置き方、10 行の鎖、主張 | `check_proof_lines.sage` | `W` は `../W_real_is_symmetric/_W_exact.sage` で作る（`M_col = 2, 3`、`x, y ∈ {2, 3}`）。零でない実の `x` 6 本（計 48 組）について、各行を本文の字面どおり（共役・包含・積の括弧）に組んで隣の行と比べ、`ξ^*Wξ` の虚部が 0・実部が正、その実部が `x^⊤W_ℝx` に等しく正であることを確かめる。否定コントロール 1 件（複素の `ξ` では共役を取らない値が `ξ^*Wξ` と外れる） | **PASS** | 成り立つ |

## 計算の帰属と範囲

- **厳密**: QQbar と AA だけで計算した。浮動小数点は使わない。ℝ への脱出は `K_1`・`K_2` の選び方の一点だけ。
- 実の `x` では鎖の 2→3 行（`complex_conjugate_of_real_inclusion`）と 4→8 行（包含が積と和を保つ）は、QQbar の演算で構成上成り立つ。中身は 1 行目の値が正の実数であることと、最後の行との一致にある。
- 範囲外: 選んだ以外の `M_col`・結合定数・`x`。点での検算は証明ではなく、式変形の書き間違いの裏取りである。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh W_real_is_positive_definite
```

実行ログは `logs/` に保存する。
