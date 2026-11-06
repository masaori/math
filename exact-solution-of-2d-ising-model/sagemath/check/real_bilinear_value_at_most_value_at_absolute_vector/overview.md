# SageMath Check: real_bilinear_value_at_most_value_at_absolute_vector

## 対象

**対象ラベル**: `real_bilinear_value_at_most_value_at_absolute_vector` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/011_max_eigenvalue.ts`
- ブロック: `maxeig_claim_real_bilinear_value_at_most_value_at_absolute_vector`（成分が非負の `P` について `x^⊤Px ≤ u^⊤Pu`、`u_k := |x_k|`）
- 範囲: 証明の準備（各 `k` の三角不等式、`|P_kl| = P_kl`）と主張の 9 行の鎖。

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 準備と 9 行の鎖 | `check_proof_lines.sage` | `n = 1, …, 5` で成分が非負の有理数の行列 `P` と負の成分を含む有理数のベクトル `x` を 8 組ずつ（計 40 組、種は固定）取り、準備の不等式と等式、鎖の各行の値と隣り合う行の関係（`≤` か `=`）を確かめる。否定コントロール 1 件（成分が負の `P` では `x^⊤Px > u^⊤Pu` になる例）。2 行目（`def_real_bilinear_value` を開く行）は定義どおりの同じ式なので、検算では恒等的に一致する | **PASS** | 成り立つ |

## 計算の帰属と範囲

- **厳密**: すべて QQ で計算する。浮動小数点は使わない。
- 範囲外: `n ≥ 6`、選んだ以外の `P`・`x`。点での検算は証明ではなく、式変形の書き間違いの裏取りである。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh real_bilinear_value_at_most_value_at_absolute_vector
```

実行ログは `logs/` に保存する。
